package com.lend.shareservice.web.chat.dto;
//채팅방 구현을 위한 DTO
import lombok.Getter;
import lombok.Setter;

// pub/sub 방식을 사용하면 알아서 구독자 관리가 되므로 웹소켓 세션 관리가 필요 없어진다.
// 발송의 구현도 알아서 해결되므로 일일이 클라이언트에게 메세지를 발송하는 구현 또한 필요 없어짐
@Getter
@Setter
public class ChatRoomDTO {

    private int chatId;//채팅방번호
    private String lastMessage;//최근메세지
    private String sendTime;//메세지 보낸 시간
    private String target; //메세지 받는 사람
    private int boardId;//상세글번호


}