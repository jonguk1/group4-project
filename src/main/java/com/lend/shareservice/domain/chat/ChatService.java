package com.lend.shareservice.domain.chat;

import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import org.springframework.stereotype.Service;

public interface ChatService {
    ChatItemDTO selectItem(Integer boardId);
}
