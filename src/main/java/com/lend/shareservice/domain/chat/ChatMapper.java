package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChatMapper {

    Board selectItem(Integer boardId);

    void insertChat(Message message);

    void createRoom(Chatroom chatroom);

    Integer selectChatId(Chatroom chatroom);

    List<ChatDTO> loadMessage(int chatId);

    ChatRoomDTO getChatRoomById(Integer chatId);

    List<ChatListItemDTO> findChatList(String userId);

    ReservLatiLongDTO reservLoadList(Integer chatId);

    int countChatByBoardId(Integer boardId);

    void updateReserv(ChatReservUpdateDTO chatReservUpdateDTO);

    void saveReserv(ChatReservDTO chatReservDTO);

    Message loadReserv(Integer chatId);

    void deleteChatRoom(Integer chatId);

}
