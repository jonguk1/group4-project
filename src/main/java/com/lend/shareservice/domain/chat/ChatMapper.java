package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.ChatDTO;
import com.lend.shareservice.web.chat.dto.ChatListItemDTO;
import com.lend.shareservice.web.chat.dto.ChatRoomDTO;
import com.lend.shareservice.web.chat.dto.ReservLatiLongDTO;
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

    void saveReserv(Message message);

    List<ChatListItemDTO> findChatList(String userId);

    Message loadReserv(Integer chatId);

    ReservLatiLongDTO reservLoadList(Integer chatId);

    void updateReserv(Message message);

    int countChatByBoardId(Integer boardId);
}
