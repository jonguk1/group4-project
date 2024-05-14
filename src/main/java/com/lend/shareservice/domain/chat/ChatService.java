package com.lend.shareservice.domain.chat;

import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.ReservDTO;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

public interface ChatService {
    ChatItemDTO selectItem(Integer boardId);

}
