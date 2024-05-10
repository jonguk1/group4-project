package com.lend.shareservice.web.chat;

import com.lend.shareservice.web.chat.dto.ChatDTO;
import com.lend.shareservice.web.chat.dto.OutputMessageVo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.text.SimpleDateFormat;
import java.util.*;
// 채팅방 전체적으로 조회, 생성, 입장 관리하는 Controller
@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatRoomController {
    @GetMapping("/chatRoom")
    public String chatRoom(){
        return "/chat/chatRoom";
    }
    @GetMapping("/chat2")
    public String chatRoom2(){
        log.info("되나요");
        return "/chat/chatRoom2";
    }
    @MessageMapping("/chat")
    @SendTo("/topic/messages")
    public OutputMessageVo send(ChatDTO chatDTO){
        log.info("서버가 받은 정보: "+ chatDTO.toString());
        String time = new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new Date());
        log.info("time: " + time);
        OutputMessageVo message = new OutputMessageVo(chatDTO.getSender(), chatDTO.getTarget(), chatDTO.getContent(), time);
        return message;
    }
}