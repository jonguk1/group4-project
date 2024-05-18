package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.ChatRoomDTO;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

    private final ChatMapper chatMapper;
//    private final RedisTemplate<Integer, ChatDTO> redisTemplateChat;

    // 쪽지방(topic)에 발행되는 메시지 처리하는 리스너
    private final RedisMessageListenerContainer redisMessageListener;

    // 구독 처리 서비스
    private final RedisSubscriber redisSubscriber;

    // 1. redis
    private static final String Message_Rooms = "MESSAGE_ROOM";
    private final RedisTemplate<String, Object> redisTemplate;
    private HashOperations<String, Integer, ChatRoomDTO> opsHashMessageRoom;

    // 2. 쪽지방의 대화 메시지 발행을 위한 redis topic(쪽지방) 정보
    private Map<Integer, ChannelTopic> topics;

    // 3. redis 의 Hash 데이터 다루기 위함
    @PostConstruct
    private void init() {
        //Redis에서 채팅방 정보를 저장하기 위한 해시맵의 키, 이걸로 채팅방 정보를 redis에서 조회 및 저장
        opsHashMessageRoom = redisTemplate.opsForHash();
        topics = new HashMap<>();
    }

    @Override
    public ChatItemDTO selectItem(Integer boardId) {
        Board board = chatMapper.selectItem(boardId);
        log.info("board={}",board);

        ChatItemDTO chatItemDTO = new ChatItemDTO();

        chatItemDTO.setBoardId(board.getBoardId());
        chatItemDTO.setWriter(board.getWriter());
        chatItemDTO.setTitle(board.getTitle());
        chatItemDTO.setImages("/postimage/" + board.getItemImage1());

        return chatItemDTO;
    }
    //채팅방입장

    @Override
    public void enterChatRoom(int chatId) {
        ChannelTopic topic = topics.get(chatId);

        if(topic ==null){
            topic = new ChannelTopic(String.valueOf(chatId));
            redisMessageListener.addMessageListener(redisSubscriber, topic);// pub/sub 통신을 위해 리스너를 설정. 대화가 가능해진다
            topics.put(chatId, topic);
        }
    }
    // redis 채널에서 쪽지방 조회

    @Override
    public ChannelTopic getTopic(int chatId) {
        return topics.get(chatId);
    }

    @Override
    public void createRoom(String userId, Integer boardId, String writer,String time) {
        Chatroom chatroom = new Chatroom();
        chatroom.setBoardId(boardId);
        chatroom.setLendy(userId);
        chatroom.setLender(writer);
        chatroom.setChatDate(new Date());

        chatMapper.createRoom(chatroom);

    }
    //대화 저장

//    @Override
//    public void saveMessage(ChatDTO chatDTO) {
//        //DB저장
//        Message message = chatMapper.insertChat(chatDTO);
//        // 1. 직렬화
//        redisTemplateChat.setValueSerializer(new Jackson2JsonRedisSerializer<>(Message.class));
//        // 2. redis 저장
//        redisTemplateChat.opsForList().rightPush(chatDTO.getChatId(), chatDTO);
//        // 3. expire 을 이용해서, Key 를 만료시킬 수 있음
//        redisTemplateChat.expire(chatDTO.getChatId(), 1, TimeUnit.MINUTES);
//
//    }

}
