package com.lend.shareservice.web.chat;

import com.lend.shareservice.domain.chat.ChatService;
import com.lend.shareservice.web.chat.dto.ChatDTO;
import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.OutputMessageVo;
import com.lend.shareservice.web.chat.dto.ReservDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;
// 채팅방 전체적으로 조회, 생성, 입장 관리하는 Controller
@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatRoomController {
//    @GetMapping("/chatRoom")
//    public String chatRoom(){
//        return "/chat/chatRoom";
//    }

    private final ChatService chatService;

    //상세 글 번호 가지고 채팅방으로 이동
    @PostMapping("/chat2")
    public String chatRoom2(@RequestParam("boardId2") Integer boardId, Model model){
       //log.info("되나요");
       //log.info("boardid : "+ boardId);
        //chatRoom2에 글상세번호 전달하기 위함
        model.addAttribute("boardId", boardId);
        //글 상세번호에 맞는 작성자, 제목, 사진 등 정보 가져오기 위함
        ChatItemDTO chatItem = chatService.selectItem(boardId);

        model.addAttribute("chatItem",chatItem);

        return "/chat/chatRoom2";
    }

    @PostMapping("/reserv")
    public void reservation(@RequestParam("chatId") String chatId,
                            @RequestParam(value = "datetimeInput")LocalDateTime reservDate) {
        log.info(String.valueOf(reservDate));
        log.info(chatId);

        Timestamp timestamp = Timestamp.valueOf(reservDate);
        System.out.println(timestamp);//2024-05-25 20:40:00.0

    }




    //소켓 연결 하는 아주아주 중요한 코드
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