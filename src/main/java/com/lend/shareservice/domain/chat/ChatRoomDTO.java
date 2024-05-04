package com.lend.shareservice.domain.chat;
//채팅방 구현을 위한 DTO
import lombok.Data;

import java.util.HashMap;
import java.util.UUID; // 유일한 식별자 개별하기

// Stomp을 통해 pub/sub를 사용하면 구독자 관리가 알아서 됨
// 따라서 따로 세션 관리를 작성할 필요 X
// 메시지를 다른 세션의 클라이언트에게 발송할 구현도 필요 X

@Data
public class ChatRoomDTO {
    private String roomId; // 채팅방 아이디
    private String roomName; // 채팅방 이름
    private long userCount; // 채팅방 인원수

    private HashMap<String, String> userlist = new HashMap<String, String>();

    // 채팅방 만들기
    public ChatRoomDTO create(String roomName)
    {
        ChatRoomDTO chatRoomDTO = new ChatRoomDTO();
        chatRoomDTO.roomId = UUID.randomUUID().toString();
        chatRoomDTO.roomName = roomName;

        return chatRoomDTO;
    }

    // 채팅방에 저장
//    public void put(String roomId, ChatRoomDTO chatRoomDTO) {
//        userlist.put(roomId, roomName);
//    }
}