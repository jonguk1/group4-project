package com.lend.shareservice.web.chat;

import com.lend.shareservice.domain.chat.ChatRepository;
import com.lend.shareservice.domain.chat.ChatRoomDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


// 채팅방 전체적으로 조회, 생성, 입장 관리하는 Controller

@Controller
@Slf4j
public class ChatRoomController {

    // ChatRepository Bean 가져오기
    @Autowired
    private ChatRepository chatRepository;

    // 채팅 리스트 화면
    // /로 요청이 들어오면 전체 채팅룸 리스트를 담아서 return
    @GetMapping("/chatList")
    public String goChatRoom(Model model)
    {
        model.addAttribute("list", chatRepository.findAllRoom());
//        model.addAttribute("user", "hey");
        log.info("SHOW ALL ChatList {}", chatRepository.findAllRoom());
        return "roomlist";
    }

    // 채팅방 생성
    // 채팅방 생성 후 다시 /로 return
    @PostMapping("/chat/createroom")
    public String createRoom(@RequestParam String name, RedirectAttributes rttr)
    {
        ChatRoomDTO room = chatRepository.createChatRoom(name);
        log.info("CREATE Chat Room {}", room);
        rttr.addFlashAttribute("roomName", room);
        return "redirect:/";
    }

    // 채팅방 입장 화면
    // 파라미터로 넘어오는 roomId를 확인 후 해당 roomId를 기준으로 채팅방 찾아서 클라이언트를 chatroom으로 보냄
    @GetMapping("/chat/room")
    public String roomDetail(Model model, String roomId)
    {
        log.info("roomId {}", roomId);
        model.addAttribute("room", chatRepository.findRoomById(roomId));
        return "chatroom";
    }

}
