package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Chatroom;
import com.lend.shareservice.web.chat.dto.ChatItemDTO;
import com.lend.shareservice.web.chat.dto.ReservDTO;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

    private static final Logger log = LoggerFactory.getLogger(ChatServiceImpl.class);
    private final ChatMapper chatMapper;

    @Override
    public ChatItemDTO selectItem(Integer boardId) {
        Board board = chatMapper.selectItem(boardId);
        log.info("board={}",board);

        ChatItemDTO chatItemDTO = new ChatItemDTO();

        chatItemDTO.setBoardId(board.getBoardId());
        chatItemDTO.setWriter(board.getWriter());
        chatItemDTO.setTitle(board.getTitle());
        chatItemDTO.setImages("/postimage/" + board.getItemImage1());

        return chatItemDTO;
    }

}
