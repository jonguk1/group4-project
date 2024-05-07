package com.lend.shareservice.web.board;

import com.lend.shareservice.domain.board.BoardService;
import com.lend.shareservice.web.board.dto.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/board")
public class BoardController {
    private final BoardService boardService;


    @GetMapping("/boardForm")
    public String test() {

        return "jspp/writingRegisterForm";
    }

    @PostMapping
    public String postRegister(@Valid @ModelAttribute PostRegistrationDTO postRegistrationDTO, BindingResult bindingResult, Model model) throws ParseException {
        model.addAttribute("bindingResult", bindingResult);
        if (bindingResult.hasErrors()) {
            log.info("bindingResult = {}", bindingResult);

            return "jspp/writingRegisterForm";
        }

        boardService.savePost(postRegistrationDTO);
        return "redirect:/board/boardForm";
    }


    // 상품의 모든 카테고리 요청
    @GetMapping("/board-category")
    @ResponseBody
    public ResponseEntity<List<ItemCategoryDTO>> getItemCategory() {

        List<ItemCategoryDTO> allItemCategory = boardService.findAllItemCategory();
        log.info("allItemCategory = {}", allItemCategory);
        return ResponseEntity.ok(allItemCategory);
    }

    @GetMapping()
    public String getPostsByCategory(Model model, @RequestParam("boardCategoryId") Integer boardCategoryId
    , @RequestParam("itemCategoryId") Integer itemCategoryId) {

        log.info("board_category_id = {}", boardCategoryId);
        log.info("item_category_id = {}", itemCategoryId);

        List<PostDTO> allPostsByCategorys = boardService.findAllPostsByCategorys(new ItemAndBoardCategoryDTO(itemCategoryId, boardCategoryId));
        log.info("allPostByCategorys = {}", allPostsByCategorys);

        model.addAttribute("allPostsByCategorys", allPostsByCategorys);
        return "jspp/itemList";
    }

    @GetMapping("/itemList")
    public String itemListForm() {
        return "jspp/itemList";
    }

    @GetMapping("/itemDetail")
    public String itemDetail() {
        return "jspp/itemDetail";
    }

    @GetMapping("/{boardId}")
    public String boardDetail(@PathVariable("boardId") Integer boardId, Model model) {

        ItemDetailDTO postById = boardService.findPostById(boardId);

        log.info("postById = {}", postById);
        model.addAttribute("postById", postById);
        return "jspp/itemDetail";
    }



}
