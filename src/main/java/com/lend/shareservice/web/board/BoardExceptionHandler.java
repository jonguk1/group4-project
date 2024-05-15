package com.lend.shareservice.web.board;


import com.lend.shareservice.web.board.boardexception.PostNotFoundException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class BoardExceptionHandler {

    @ExceptionHandler(PostNotFoundException.class)
    public ModelAndView handlePostNotFoundException(PostNotFoundException ex) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("error/postNotFoundError");
        return modelAndView;
    }
}
