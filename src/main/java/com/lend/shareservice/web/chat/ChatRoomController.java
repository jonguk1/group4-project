package com.lend.shareservice.web.chat;

import com.lend.shareservice.domain.chat.ChatService;
import com.lend.shareservice.domain.chat.RedisPublisher;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.board.dto.LatiLongDTO;
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

import java.text.SimpleDateFormat;
import java.util.*;

// 채팅방 전체적으로 조회, 생성, 입장 관리하는 Controller
@Controller
@Slf4j
@RequiredArgsConstructor
public class ChatRoomController {

    private final RedisPublisher redisPublisher;
    private final ChatService chatService;
    private final UserService userService;

    //상세 글 번호 가지고 채팅방으로 이동
    //최초의 채팅방 생성시
    @PostMapping("/chat")
    public String chatRoom2(@RequestParam("boardId2") Integer boardId,
                            HttpServletRequest request,
                            Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        //유저 정보 가져와서 위도 경도 뿌리기
        User userById = userService.findUserById(userId);
        LatiLongDTO latiLongDTO = new LatiLongDTO(userById.getLatitude(), userById.getLongitude());

        //chatRoom2에 글상세번호 전달하기 위함
        model.addAttribute("boardId", boardId);

        //글 상세번호에 맞는 작성자, 제목, 사진 등 정보 가져오기 위함
        ChatItemDTO chatItem = chatService.selectItem(boardId);
        model.addAttribute("chatItem", chatItem);

        String time = new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new Date());
        Integer ChatId = chatService.getOrCreateChatRoom(userId, boardId, chatItem, time);
        model.addAttribute("chatId", ChatId);

        if (ChatId != null) {
            Message messageByChatId = chatService.loadReserv(ChatId);
            if (messageByChatId != null && messageByChatId.getLatitude() != null && messageByChatId.getLongitude() != null) {
                ReservLatiLongDTO reservLatiLongDTO = new ReservLatiLongDTO(messageByChatId.getLatitude(), messageByChatId.getLongitude(),
                        messageByChatId.getMessageId(), String.valueOf(messageByChatId.getReservation()));
                model.addAttribute("reservList", reservLatiLongDTO);
            } else {
                model.addAttribute("reservList", new ReservLatiLongDTO(0, 0, 0, null));
            }
        }

        log.info("ChatId: {} ", ChatId);

        model.addAttribute("latiAndLong", latiLongDTO);

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

        //유저 정보 가져와서 위도 경도 뿌리기
        User userById = userService.findUserById(userId);
        LatiLongDTO latiLongDTO = new LatiLongDTO(userById.getLatitude(), userById.getLongitude());

        Integer boardId = chatRoomDTO.getBoardId();

        if (chatId != null) {
            Message messageByChatId = chatService.loadReserv(chatId);
            if (messageByChatId != null && messageByChatId.getLatitude() != null && messageByChatId.getLongitude() != null) {
                ReservLatiLongDTO reservLatiLongDTO = new ReservLatiLongDTO(messageByChatId.getLatitude(), messageByChatId.getLongitude(),
                        messageByChatId.getMessageId(), String.valueOf(messageByChatId.getReservation()));
                model.addAttribute("reservList", reservLatiLongDTO);
            } else {
                model.addAttribute("reservList", new ReservLatiLongDTO(0, 0, 0, null));
            }
        }

        //글 상세번호에 맞는 작성자, 제목, 사진 등 정보 가져오기 위함
        ChatItemDTO chatItem = chatService.selectItem(boardId);

        model.addAttribute("chatRoomDTO", chatRoomDTO);
        model.addAttribute("latiAndLong", latiLongDTO);
        model.addAttribute("chatItem", chatItem);

        return "/chat/chatRoom";
    }

    //소켓 연결 하는 아주아주 중요한 코드
    @MessageMapping("/chatCon/{chatId}")
    @SendTo("/topic/messages/{chatId}")
    public List<ChatDTO> sendChat(@DestinationVariable String chatId, ChatDTO chatDTO) {

        String from = chatDTO.getFrom();
        String to = chatDTO.getTo();
        if (chatDTO != null && chatDTO.getContent() != null && !chatDTO.getContent().startsWith("#100")) {//입장 메시지가 아니라면 redis에 저
            // DB & Redis 에 대화 저장
            chatService.saveMessage(chatDTO);
        }
        // 클라이언트의 채팅방 입장 및 대화를 위해 리스너와 연동, Redis구독을 위한 메소드
        chatService.enterChatRoom(chatDTO.getChatId());
        // Websocket 에 발행된 메시지를 redis 로 발행. 해당 쪽지방을 구독한 클라이언트에게 메시지가 실시간 전송됨 (1:N, 1:1 에서 사용 가능)

        // redisPublisher.publish(chatService.getTopic(chatDTO.getChatId()), chatDTO);
        if (chatDTO.getContent().startsWith("#100")) {

            // 대화 조회
            List<ChatDTO> chatList = chatService.loadMessage(chatDTO.getChatId());
            if (chatList.size() == 0) {
                //db에 저장된 내용이 없다면 받은 내용 그냥 보내보자.
                return Arrays.asList(chatDTO);//#100을 그냥 전송
            } else {//DB에서 가져올때
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

        return chatList;
    }

    //현재 유저의 채팅리스트로 가기
    @GetMapping("/chatList/{userId}")
    public String chatList(HttpServletRequest request,
                           Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        //채팅리스트 갖고오기
        List<ChatListItemDTO> chatRoomList = chatService.findChatList(userId);

        model.addAttribute("chatList", chatRoomList);
        return "/chat/chatList";
    }

    //약속하기를 위한 채팅방 아이디와 날짜 갖고오기
    @ResponseBody
    @PostMapping("/chat/{chatId}/appointed-place-date")
    public String reservation(Double reservLat,
                              Double reservLong,
                              Integer chatId,
                              String from,
                              String to,
                              String content,
                              String sendTime,
                              Date selectedDateTime) {
        chatService.saveReserv(reservLat, reservLong, chatId, from, to, sendTime, content, selectedDateTime);

        return "/chat/chatRoom";
    }

    @GetMapping("/chat/{chatId}/appointed-place-date")
    @ResponseBody
    public ReservLatiLongDTO reservLoadList(@PathVariable("chatId") Integer chatId) {
        ReservLatiLongDTO reservLoadList = chatService.reservLoadList(chatId);
        return reservLoadList;
    }


    //약속 수정하기
    @ResponseBody
    @PutMapping("/chat/{chatId}/appointed-place-date")
    public String updateReservation(Double reservLat,
                                    Double reservLong,
                                    Integer chatId,
                                    String from,
                                    String to,
                                    String content,
                                    String sendTime,
                                    Integer messageId,
                                    Date selectedDateTime) {
        chatService.updateReserv(reservLat, reservLong, chatId, from, to, sendTime, content, messageId, selectedDateTime);

        return "/chat/chatRoom";
    }

    @ResponseBody
    @DeleteMapping("/chat/{chatId}")
    public String deleteChatRoom(@PathVariable("chatId") Integer chatId) {
        chatService.deleteChatRoom(chatId);
        return "/chat/chatRoom";
    }


}