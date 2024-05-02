package com.lend.shareservice.web.chat;
// 채팅 컨트롤러 구현
import com.lend.shareservice.domain.chat.ChatRoomDTO;
import com.lend.shareservice.domain.chat.ChatServiceImpl;
import com.lend.shareservice.entity.Chatroom;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

    private final ChatServiceImpl chatService;

    @PostMapping
    public ChatRoomDTO createRoom(@RequestParam String name){
        return chatService.createRoom(name);
    }

    @GetMapping
    public List<ChatRoomDTO> findAllRoom(){
        return chatService.findAllRoom();
    }

    @GetMapping("/chatRoom")
    public String chatRoom(){
        return "/chat/chatRoom";
    }

}
