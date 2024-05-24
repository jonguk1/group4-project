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
@RequestMapping("/chat")
public class ChatRoomController {
//    @GetMapping("/chatRoom")
//    public String chatRoom(){
//        return "/chat/chatRoom";
//    }

    private final RedisPublisher redisPublisher;
    private final ChatService chatService;

    //상세 글 번호 가지고 채팅방으로 이동
    @PostMapping("/chat2")
    public String chatRoom2(@RequestParam("boardId2") Integer boardId,
                            HttpServletRequest request,
                                    Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");//로그인한 아이디 (hong) 판매자일경우
        //chatRoom2에 글상세번호 전달하기 위함
        model.addAttribute("boardId", boardId);

        //글 상세번호에 맞는 작성자, 제목, 사진 등 정보 가져오기 위함
        ChatItemDTO chatItem = chatService.selectItem(boardId);
        boolean isSeller = chatItem.getWriter().equals(userId);
        log.info("로그인한 사람과 글쓴이가 같은가? " + chatItem.getWriter().equals(userId));

        model.addAttribute("chatItem", chatItem);

        String time = new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new Date());
        Integer ChatId = null;
//        // 채팅방 아이디 전달하기
        if (!isSeller) {//로그인한 사람과 글쓴이가 같지않다면
            ChatId = chatService.selectChatRoom(userId, boardId, chatItem.getWriter());
        }
        if (ChatId == null) {//만약 채팅방번호가 없다면
            if (userId.equals(chatItem.getWriter())) {//현재 유저 아이디랑 글쓴이가 같다면 예외처리
                //throw new RuntimeException("테스트 예외");//

            } else {
                // 채팅방 생성
                chatService.createRoom(userId, boardId, chatItem.getWriter(), time);
                // 채팅방 번호 한번 더 갖고오기
                ChatId = chatService.selectChatRoom(userId, boardId, chatItem.getWriter());
            }
        }
        model.addAttribute("chatId", ChatId);
        model.addAttribute("time", time);

        return "/chat/chatRoom2";
    }

    //소켓 연결 하는 아주아주 중요한 코드
    @MessageMapping("/chat/{chatId}")
    @SendTo("/topic/messages/{chatId}")
    public List<ChatDTO> sendChat(@DestinationVariable String chatId, ChatDTO chatDTO) {

        log.info("서버가 받은 정보: chatId: " + chatId + chatDTO.toString());
//        String lender = chatDTO.getLender();
//        log.info("랜더 : " + lender);
//        String lendy = chatDTO.getLendy();
//        log.info("랜디 : " + lendy);
        if (chatDTO != null && chatDTO.getContent() != null && !chatDTO.getContent().startsWith("#100")) {//입장 메시지가 아니라면 redis에 저
            // DB & Redis 에 대화 저장
            chatService.saveMessage(chatDTO);
        }
        // 클라이언트의 채팅방 입장 및 대화를 위해 리스너와 연동, Redis구독을 위한 메소드
        chatService.enterChatRoom(chatDTO.getChatId());
        // Websocket 에 발행된 메시지를 redis 로 발행. 해당 쪽지방을 구독한 클라이언트에게 메시지가 실시간 전송됨 (1:N, 1:1 에서 사용 가능)
       // redisPublisher.publish    (chatService.getTopic(chatDTO.getChatId()), chatDTO);
        if (chatDTO.getContent().equals("#100")) {
            // 대화 조회
            List<ChatDTO> chatList = chatService.loadMessage(chatDTO.getChatId());
            log.info("대화 조회: " + chatList);
            return chatList;
        }
//        model.addAttribute("loadMessage", chatList);
        List<ChatDTO> chatList = new ArrayList<>();
        chatList.add(chatDTO);
        //OutputMessageVo outputMessageVo = new OutputMessageVo(chatDTO.getLendy(),chatDTO.getLender(),chatDTO.getContent(),chatDTO.getSendTime());
        return chatList;
    }

    //예약하기를 위한 채팅방 아이디와 날짜 갖고오기
    @PostMapping("/reserv")
    public void reservation(@RequestParam("chatId") String chatId,
                            @RequestParam(value = "datetimeInput") LocalDateTime reservDate) {
        log.info(String.valueOf(reservDate));
        log.info(chatId);

        Timestamp timestamp = Timestamp.valueOf(reservDate);
        System.out.println(timestamp);//2024-05-25 20:40:00.0

    }

    //현재 유저의 채팅리스트로 가기
    @GetMapping("/chatList/{userId}")
    public String chatList(HttpServletRequest request,
                           Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        //채팅리스트 갖고오기

        List<Message> chatRoomList = chatService.findChatList(userId);

        model.addAttribute("chatList", chatRoomList);
        return "/chat/chatList";
    }

}