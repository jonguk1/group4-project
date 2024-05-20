package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.entity.Message;
import com.lend.shareservice.web.chat.dto.ChatDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {

    Board selectItem(Integer boardId);

    void insertChat(Message message);

    void createRoom(Chatroom chatroom);

    Integer selectChatId(Chatroom chatroom);
}
