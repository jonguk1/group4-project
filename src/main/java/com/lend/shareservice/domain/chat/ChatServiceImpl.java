package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.*;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {

    private final ChatMapper chatMapper;
    // 채팅 저장을 위한
    private final RedisTemplate<String, ChatDTO> redisTemplateChat;

    // 채팅(topic)에 발행되는 메시지 처리하는 리스너
    private final RedisMessageListenerContainer redisMessageListener;

    // 구독 처리 서비스
    private final RedisSubscriber redisSubscriber;

    // 1. redis
    private static final String Message_Rooms = "MESSAGE_ROOM";
    private final RedisTemplate<String, Object> redisTemplate;
    private HashOperations<String, String, ChatRoomDTO> opsHashMessageRoom;

    // 2. 채팅의 대화 메시지 발행을 위한 redis topic(채팅) 정보
    private Map<String, ChannelTopic> topics;

    // 3. redis 의 Hash 데이터 다루기 위함
    @PostConstruct
    private void init() {
        //Redis에서 채팅방 정보를 저장하기 위한 해시맵의 키, 이걸로 채팅방 정보를 redis에서 조회 및 저장
        opsHashMessageRoom = redisTemplate.opsForHash();
        topics = new HashMap<>();
    }

    // redis 채널에서 쪽지방 조회
    @Override
    public ChannelTopic getTopic(int chatId) {
        String roomId = String.valueOf(chatId);
        if (topics.containsKey(roomId)) {
            return topics.get(roomId);
        } else {
            // 채팅 ID에 해당하는 토픽이 없는 경우에 대한 처리
            return null;
        }
    }

    //레디스를 위한 채팅방 입장 메소드
    @Override
    public void enterChatRoom(int chatId) {

        String roomId = String.valueOf(chatId); // chatId를 String으로 변환
        ChannelTopic topic = topics.get(roomId); // topics 맵에서 roomId에 해당하는 토픽을 가져옴

        if (topic == null) {
            topic = new ChannelTopic(roomId);
            redisMessageListener.addMessageListener(redisSubscriber, topic);
            topics.put(roomId, topic);
        }

    }

    //채팅방 내역 갖고오기 또는 채팅방 생성하기
    @Override
    public Integer getOrCreateChatRoom(String userId, Integer boardId, ChatItemDTO chatItem, String time) {
        boolean isSeller = chatItem.getWriter().equals(userId);
        log.info("로그인한 사람과 글쓴이가 같은가? " + chatItem.getWriter().equals(userId));
        Integer ChatId = null;

//        // 채팅방 아이디 전달하기
        if (!isSeller) {//로그인한 사람과 글쓴이가 같지않다면 채팅방 번호 갖고오기 메서드 찾아가기
            ChatId = selectChatRoom(userId, boardId, chatItem.getWriter());
        }
        //채팅방 번호 없고 로그인한 사람과 글쓴이가 다르면 채팅방 생성 메소드 찾아가기
        if (ChatId == null && !userId.equals(chatItem.getWriter())) {
            createRoom(userId, boardId, chatItem.getWriter(), time);
            ChatId = selectChatRoom(userId, boardId, chatItem.getWriter());
        }
        return ChatId;
    }

    //채팅 저장하기
    @Override
    public void saveMessage(ChatDTO chatDTO) {
        //DB저장
        Message message = new Message();
        message.setChatId(chatDTO.getChatId());
        message.setFrom(chatDTO.getFrom());
        message.setTo(chatDTO.getTo());
        message.setContent(chatDTO.getContent());
        message.setSendTime(new Date());

        log.info(message.toString());

        chatMapper.insertChat(message);

        // 1. 직렬화 - Message객체를 JSON형식으로 직렬화
        // redisTemplateChat.setValueSerializer(new Jackson2JsonRedisSerializer<>(Message.class));
        // 2. redis 저장 - chatDTO 객체를 채팅방 ID를 Key로 하여 리스트에 추가
        //  redisTemplateChat.opsForList().rightPush(String.valueOf(chatDTO.getChatId()), chatDTO);
        // 3. expire 을 이용해서, 채팅방 ID를 Key로 하는 데이터가 5분 후 만료되도록 설정
        // redisTemplateChat.expire(String.valueOf(chatDTO.getChatId()), 5, TimeUnit.MINUTES);
    }

    //현재 유저 채팅 리스트에 뿌려줄 아이템 갖고오기
    @Override
    public List<ChatListItemDTO> findChatList(String userId) {

        List<ChatListItemDTO> messageList = chatMapper.findChatList(userId);
//        log.info("서비스임플 채팅리스트를 찾아라 : " + messageList.toString());

        for (ChatListItemDTO message : messageList) {
            Integer boardId = message.getBoardId();
            if (boardId != null) {
                ChatItemDTO chatItemDTO = selectItem(boardId);
                message.setChatItemDTO(chatItemDTO);  // 메시지에 ChatItemDTO 설정
                log.info("상세글 정보: " + chatItemDTO.toString());
            }
        }

        return messageList;

    }

    @Override
    public ReservLatiLongDTO reservLoadList(Integer chatId) {
        ReservLatiLongDTO reservLoadList = chatMapper.reservLoadList(chatId);
        log.info("이거 되나요 제발 진심 : " + reservLoadList.toString());
        return reservLoadList;
    }

    //약속 정보 가져오기
    @Override
    public Message loadReserv(Integer chatId) {
        return chatMapper.loadReserv(chatId);
    }

    //약속 수정하기
    @Override
    public void updateReserv(Double reservLat, Double reservLong, Integer chatId,
                             String from, String to, String newSendTime, String content, Integer messageId) {
        Message message = new Message();
        message.setLatitude(reservLat);
        message.setLongitude(reservLong);
        message.setChatId(chatId);
        message.setFrom(from);
        message.setTo(to);
        message.setSendTime(new Date());
        message.setContent(content);
        message.setMessageId(messageId);

        chatMapper.updateReserv(message);
    }

    //채팅 내역 갖고오기
    @Override
    public List<ChatDTO> loadMessage(int chatId) {
        List<ChatDTO> messageList = chatMapper.loadMessage(chatId);
        log.info("채팅 리스트: " + messageList.toString());

        return messageList;
    }


    //채팅방 정보 뿌려주기 위한 메서드
    @Override
    public ChatRoomDTO getChatRoom(Integer chatId) {
        return chatMapper.getChatRoomById(chatId);
    }

    //약속하기 위한 메소드
    @Override
    public void saveReserv(Double reservLat, Double reservLong, Integer chatId,
                           String from, String to, String time, String content) {
        Message message = new Message();
        message.setLatitude(reservLat);
        message.setLongitude(reservLong);
        message.setChatId(chatId);
        message.setFrom(from);
        message.setTo(to);
        message.setSendTime(new Date());
        message.setContent(content);

//        log.info("여기는 예약하기 임플 : " + message.toString());

        chatMapper.saveReserv(message);
    }

    //채팅방에 상세글 정보 넘겨주기 위한 메소드
    @Override
    public ChatItemDTO selectItem(Integer boardId) {
        Board board = chatMapper.selectItem(boardId);

        ChatItemDTO chatItemDTO = new ChatItemDTO();

        chatItemDTO.setBoardId(board.getBoardId());
        chatItemDTO.setWriter(board.getWriter());
        chatItemDTO.setTitle(board.getTitle());
        chatItemDTO.setImages("/postimage/" + board.getItemImage1());

        return chatItemDTO;
    }

    //채팅방 생성
    @Override
    public void createRoom(String userId, Integer boardId, String writer, String time) {

        Chatroom chatroom = new Chatroom();
        chatroom.setBoardId(boardId);
        chatroom.setLendy(userId);
        chatroom.setLender(writer);
        chatroom.setChatDate(new Date());

        chatMapper.createRoom(chatroom);
    }

    //채팅방 번호 갖고오기
    @Override
    public Integer selectChatRoom(String userId, Integer boardId, String writer) {
        Chatroom chatroom = new Chatroom();
        chatroom.setLender(writer);
        chatroom.setLendy(userId);
        chatroom.setBoardId(boardId);

        Integer chatId = chatMapper.selectChatId(chatroom);

        return chatId;
    }


}
