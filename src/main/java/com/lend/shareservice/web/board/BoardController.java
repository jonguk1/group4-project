package com.lend.shareservice.web.board;

import com.lend.shareservice.domain.board.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
}
