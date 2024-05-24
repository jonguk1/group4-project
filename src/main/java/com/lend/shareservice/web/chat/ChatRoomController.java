package com.lend.shareservice.web.chat;

import com.lend.shareservice.domain.chat.ChatService;
import com.lend.shareservice.domain.chat.RedisPublisher;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.DestinationVariable;
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
public class ChatRoomController {

    private final RedisPublisher redisPublisher;
    private final ChatService chatService;

    //상세 글 번호 가지고 채팅방으로 이동
    //최초의 채팅방 생성시
    @PostMapping("/chat")
    public String chatRoom2(@RequestParam("boardId2") Integer boardId,
                            HttpServletRequest request,
                            Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        //chatRoom2에 글상세번호 전달하기 위함
        model.addAttribute("boardId", boardId);

        //글 상세번호에 맞는 작성자, 제목, 사진 등 정보 가져오기 위함
        ChatItemDTO chatItem = chatService.selectItem(boardId);
        model.addAttribute("chatItem", chatItem);

        String time = new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new Date());
        Integer ChatId = chatService.getOrCreateChatRoom(userId, boardId, chatItem, time);;
//
        model.addAttribute("chatId", ChatId);
        model.addAttribute("time", time);

        return "/chat/chatRoom";
    }

    //채팅리스트에서 채팅 입장시
    @GetMapping("/chat/{chatId}")
    public String getChatRoom(@PathVariable("chatId") Integer chatId,
                              HttpServletRequest request,
                              Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        //기존 채팅방 정보 뿌려주기
        ChatRoomDTO chatRoomDTO = chatService.getChatRoom(chatId);

        Integer boardId = chatRoomDTO.getBoardId();

        //글 상세번호에 맞는 작성자, 제목, 사진 등 정보 가져오기 위함
        ChatItemDTO chatItem = chatService.selectItem(boardId);

        model.addAttribute("chatItem", chatItem);
        model.addAttribute("chatRoomDTO", chatRoomDTO);
        return "/chat/chatRoom";
    }

    //소켓 연결 하는 아주아주 중요한 코드
    @MessageMapping("/chatCon/{chatId}")
    @SendTo("/topic/messages/{chatId}")
    public List<ChatDTO> sendChat(@DestinationVariable String chatId, ChatDTO chatDTO) {

        log.info("서버가 받은 정보: chatId: " + chatId + chatDTO.toString());
        String from = chatDTO.getFrom();
        log.info("from : " + from);
        String to = chatDTO.getTo();
        log.info("to : " + to);
        if (chatDTO != null && chatDTO.getContent() != null && !chatDTO.getContent().startsWith("#100")) {//입장 메시지가 아니라면 redis에 저
            // DB & Redis 에 대화 저장
            chatService.saveMessage(chatDTO);
        }
        // 클라이언트의 채팅방 입장 및 대화를 위해 리스너와 연동, Redis구독을 위한 메소드
        chatService.enterChatRoom(chatDTO.getChatId());
        // Websocket 에 발행된 메시지를 redis 로 발행. 해당 쪽지방을 구독한 클라이언트에게 메시지가 실시간 전송됨 (1:N, 1:1 에서 사용 가능)
        // redisPublisher.publish(chatService.getTopic(chatDTO.getChatId()), chatDTO);
        if (chatDTO.getContent().startsWith("#100")) {
            log.info("아무거나 한번만");
            // 대화 조회
            List<ChatDTO> chatList = chatService.loadMessage(chatDTO.getChatId());
            if(chatList.size()==0){
                //db에 저장된 내용이 없다면 받은 내용 그냥 보내보자.
                log.info("그렇다면 여기는??");
                return Arrays.asList(chatDTO);//#100을 그냥 전송
            }else{//DB에서 가져올때
                //chatList[되나요, 잘되요]
                chatList.add(0, chatDTO);//삽
                //chatList[#100, 되나요, 잘되요]
            }
            log.info("대화 조회: " + chatList);

            return chatList;
        }
//        model.addAttribute("loadMessage", chatList);
        List<ChatDTO> chatList = new ArrayList<>();
        chatList.add(chatDTO);
        //OutputMessageVo outputMessageVo = new OutputMessageVo(chatDTO.getLendy(),chatDTO.getLender(),chatDTO.getContent(),chatDTO.getSendTime());
        return chatList;
    }

    //현재 유저의 채팅리스트로 가기
    @GetMapping("/chatList/{userId}")
    public String chatList(HttpServletRequest request,
                           Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        log.info("여기는 채팅리스트: "+ userId);
        //채팅리스트 갖고오기

        List<Message> chatRoomList = chatService.findChatList(userId);

        model.addAttribute("chatList", chatRoomList);
        return "/chat/chatList";
    }

    //예약하기를 위한 채팅방 아이디와 날짜 갖고오기
    @PostMapping("/chat/reserv")
    public void reservation(@RequestParam("chatId") Integer chatId,
                            @RequestParam(value = "datetimeInput") LocalDateTime reservDate) {
        log.info(String.valueOf(reservDate));
        log.info(String.valueOf(chatId));

        Timestamp timestamp = Timestamp.valueOf(reservDate);
        System.out.println(timestamp);//2024-05-25 20:40:00.0

    }
}