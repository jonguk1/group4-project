package com.lend.shareservice.domain.chat;

import com.lend.shareservice.web.chat.dto.ChatDTO;
import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.ChatRoomDTO;
import com.lend.shareservice.web.chat.dto.ReservDTO;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;

public interface ChatService {
    ChatItemDTO selectItem(Integer boardId);

    void enterChatRoom(int chatId);

    ChannelTopic getTopic(int chatId);

    void createRoom(String userId, Integer boardId, String writer, String time);

//    void saveMessage(ChatDTO chatDTO);

   
}
