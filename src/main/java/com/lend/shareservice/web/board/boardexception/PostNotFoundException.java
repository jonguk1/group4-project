package com.lend.shareservice.web.board.boardexception;

public class PostNotFoundException extends RuntimeException {

    public PostNotFoundException() {
        super("해당 글이 존재하지 않습니다.");
    }

    public PostNotFoundException(String message) {
        super(message);
    }
}
