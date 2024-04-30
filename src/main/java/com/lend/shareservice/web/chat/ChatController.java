package com.lend.shareservice.web.chat;

import com.lend.shareservice.domain.chat.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class ChatController {

    private final ChatService chatService;
}
