package com.lend.shareservice.domain.board;

import com.lend.shareservice.web.board.dto.PostRegistrationDTO;

import java.text.ParseException;

public interface BoardService {

    // 글 저장
    void savePost(PostRegistrationDTO postRegistrationDTO) throws ParseException;
}
