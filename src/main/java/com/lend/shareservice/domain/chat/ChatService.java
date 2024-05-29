package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.*;
import org.springframework.data.redis.listener.ChannelTopic;

import java.util.Date;
import java.util.List;

public interface ChatService {
    ChatItemDTO selectItem(Integer boardId);

    void createRoom(String userId, Integer boardId, String writer, String time);

    Integer selectChatRoom(String userId, Integer boardId, String writer);

    ChannelTopic getTopic(int chatId);

    void enterChatRoom(int chatId);

    void saveMessage(ChatDTO chatDTO);

    List<ChatDTO> loadMessage(int chatId);

    Integer getOrCreateChatRoom(String userId, Integer boardId, ChatItemDTO chatItem, String time);

    ChatRoomDTO getChatRoom(Integer chatId);

    void saveReserv(Double reservLat, Double reservLong, Integer chatId, String from, String to, String time, String content, Date selectedDateTime);

    List<ChatListItemDTO> findChatList(String userId);

    ReservLatiLongDTO reservLoadList(Integer chatId);

    void updateReserv(Double reservLat, Double reservLong, Integer chatId, String from, String to, String sendTime, String content, Integer messageId, Date selectedDateTime);

    Message loadReserv(Integer chatId);

    void deleteChatRoom(Integer chatId);
}
