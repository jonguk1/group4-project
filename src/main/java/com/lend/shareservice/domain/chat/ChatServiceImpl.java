package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.ChatDTO;
import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.ChatRoomDTO;
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
public class ChatServiceImpl implements ChatService{

    private final ChatMapper chatMapper;
    // 채팅 저장을 위한
    private final RedisTemplate<String,ChatDTO> redisTemplateChat;

    // 채팅(topic)에 발행되는 메시지 처리하는 리스너
    private final RedisMessageListenerContainer redisMessageListener;

    // 구독 처리 서비스
    private final RedisSubscriber redisSubscriber;

    // 1. redis
    private static final String Message_Rooms = "MESSAGE_ROOM";
    private final RedisTemplate<String, Object> redisTemplate;
    private HashOperations<String, String, ChatRoomDTO> opsHashMessageRoom;

    // 2. 채팅의 대화 메시지 발행을 위한 redis topic(채팅) 정보
    private Map<String , ChannelTopic> topics;

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

    @Override
    public void saveMessage(ChatDTO chatDTO) {
        //DB저장
        Message message = new Message();
        message.setChatId(chatDTO.getChatId());
        message.setLendy(chatDTO.getLendy());
        message.setLender(chatDTO.getLender());
        message.setContent(chatDTO.getContent());
        message.setSendTime(new Date());

        chatMapper.insertChat(message);

        // 1. 직렬화 - Message객체를 JSON형식으로 직렬화
       // redisTemplateChat.setValueSerializer(new Jackson2JsonRedisSerializer<>(Message.class));
        // 2. redis 저장 - chatDTO 객체를 채팅방 ID를 Key로 하여 리스트에 추가
      //  redisTemplateChat.opsForList().rightPush(String.valueOf(chatDTO.getChatId()), chatDTO);
        // 3. expire 을 이용해서, 채팅방 ID를 Key로 하는 데이터가 5분 후 만료되도록 설정
       // redisTemplateChat.expire(String.valueOf(chatDTO.getChatId()), 5, TimeUnit.MINUTES);
    }

    @Override
    public List<Message> findChatList(String userId) {
//        log.info(userId);

        List<Message> messageList = chatMapper.findChatList(userId);

        log.info(messageList.toString());

        return  messageList;

    }

    @Override
    public List<ChatDTO> loadMessage(int chatId) {
        List<ChatDTO> messageList = chatMapper.loadMessage(chatId);
        log.info("채팅 리스트: " + messageList.toString());

        return messageList;    }

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
    public void createRoom(String userId, Integer boardId, String writer,String time) {

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
