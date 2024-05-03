package com.lend.shareservice.web.board;

import com.lend.shareservice.domain.board.BoardService;
import com.lend.shareservice.web.board.dto.PostRegistrationDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.text.ParseException;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {
    private final BoardService boardService;

    @GetMapping("/")
    public String test() {
        return "jspp/writingRegisterForm";
    }

    @PostMapping("/board")
    public String postRegister(@ModelAttribute PostRegistrationDTO postRegistrationDTO) throws ParseException {


        log.info("dto = {}", postRegistrationDTO);

        List<MultipartFile> temp = postRegistrationDTO.getFileInput();

        for (MultipartFile multipartFile : temp) {
            log.info("multipartFile = {}", multipartFile.getOriginalFilename());
        }

        boardService.savePost(postRegistrationDTO);


        return "redirect:/";
    }
}
