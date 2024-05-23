package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.ChatDTO;
import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.ChatRoomDTO;
import com.lend.shareservice.web.chat.dto.ReservDTO;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public interface ChatService {
    ChatItemDTO selectItem(Integer boardId);

    void createRoom(String userId, Integer boardId, String writer, String time);

    Integer selectChatRoom(String userId, Integer boardId, String writer);

    ChannelTopic getTopic(int chatId);

    void enterChatRoom(int chatId);

    void saveMessage(ChatDTO chatDTO);

    List<Message> findChatList(String userId);

    List<ChatDTO> loadMessage(int chatId);
}
