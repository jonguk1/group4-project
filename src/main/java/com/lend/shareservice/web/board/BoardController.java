package com.lend.shareservice.web.board;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.domain.board.BoardService;
import com.lend.shareservice.web.board.dto.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
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
    private final AddressService addressService;
    private final ObjectMapper objectMapper;
    @GetMapping("/boardForm")
    public String test() {

        return "jspp/writingRegisterForm";
    }

    // 글 등록 요청
    @PostMapping
    public String postRegister(@Valid @ModelAttribute PostRegistrationDTO postRegistrationDTO, BindingResult bindingResult, Model model) throws ParseException {

        if (postRegistrationDTO.getFileInput().get(0).getSize() == 0 &&
                postRegistrationDTO.getFileInput().get(1).getSize() == 0 &&
        postRegistrationDTO.getFileInput().get(2).getSize() == 0) {
            bindingResult.rejectValue("fileInput", "error.fileInput", "상품 이미지를 최소 하나를 등록해야합니다.");
        }
        if (bindingResult.hasErrors()) {
            log.info("bindingResult = {}", bindingResult);

            model.addAttribute("postRegistrationBindingResult", bindingResult);

            return "jspp/writingRegisterForm";
        }

        boardService.savePost(postRegistrationDTO);

        return "redirect:/board?boardCategoryId=" +  postRegistrationDTO.getBoardCategoryId() + "&itemCategoryId=" + postRegistrationDTO.getItemCategoryId() ;
    }


    // 상품의 모든 카테고리 요청
    @GetMapping("/board-category")
    @ResponseBody
    public ResponseEntity<List<ItemCategoryDTO>> getItemCategory() {

        List<ItemCategoryDTO> allItemCategory = boardService.findAllItemCategory();
        log.info("allItemCategory = {}", allItemCategory);
        return ResponseEntity.ok(allItemCategory);
    }

    // 글 카테고리 + 물건 카테고리에 해당하는 글들 응답 -> 메뉴에서 선택하면 나오는 글들
    @GetMapping()
    public String getPostsByCategory(Model model, @RequestParam("boardCategoryId") Integer boardCategoryId
            , @RequestParam("itemCategoryId") Integer itemCategoryId) {

        List<PostDTO> allPostsByCategorys = boardService.findAllPostsByCategorys(new ItemAndBoardCategoryDTO(itemCategoryId, boardCategoryId));

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(allPostsByCategorys);
        } catch (JsonProcessingException e) {

        }

        model.addAttribute("allPostsByCategorys", allPostsByCategorysJson);

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


    // 글의 사진을 클릭하면 나오는 글 상세
    @GetMapping("/{boardId}")
    public String boardDetail(@PathVariable("boardId") Integer boardId, Model model) {

        // 조회수 1증가
        boardService.incrementingViewCount(boardId);

        ItemDetailDTO postById = boardService.findPostById(boardId);
        postById.setAddress(addressService.getAddressFromLatLng(postById.getLatitude(), postById.getLongitude()));
        List<PostDTO> postsBySearchTerm = boardService.findPostsBySearchTerm(postById.getItemName());
        List<PostDTO> interestPosts = boardService.findInterestPosts();

        String userId = "hong";
        model.addAttribute("postById", postById);
        model.addAttribute("postsBySearchTerm", postsBySearchTerm);
        model.addAttribute("interestPosts", interestPosts);
        model.addAttribute("userId", userId);
        return "jspp/itemDetail";
    }

    @GetMapping("/search")
    public String postsBySearchTerm(Model model, @RequestParam("searchTerm") String searchTerm) {

        List<PostDTO> postsBySearchTerm = boardService.findPostsBySearchTerm(searchTerm);
        log.info("postsBySearchTerm = {}", postsBySearchTerm);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(postsBySearchTerm);
        } catch (JsonProcessingException e) {

        }
        model.addAttribute("allPostsByCategorys", allPostsByCategorysJson);
        return "jspp/itemList";
    }

    @PostMapping("/hits")
    @ResponseBody
    public ResponseEntity<String> postsByHits(@RequestBody List<PostDTO> postDTOS) {

        List<PostDTO> hitPosts = boardService.sortForHits(postDTOS);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(hitPosts);

        } catch (JsonProcessingException e) {

        }
        return ResponseEntity.ok(allPostsByCategorysJson);
    }


    @PostMapping("/recent")
    @ResponseBody
    public ResponseEntity<String> postsByRecent(@RequestBody List<PostDTO> postDTOS) {

        List<PostDTO> recentPosts = boardService.sortForRecent(postDTOS);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(recentPosts);
        } catch (JsonProcessingException e) {

        }

        return ResponseEntity.ok(allPostsByCategorysJson);
    }

    @PostMapping("/interest")
    @ResponseBody
    public ResponseEntity<String> postsByInterest(@RequestBody List<PostDTO> postDTOS) {

        List<PostDTO> interestPosts = boardService.sortForInterest(postDTOS);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(interestPosts);
        } catch (JsonProcessingException e) {

        }

        return ResponseEntity.ok(allPostsByCategorysJson);
    }

    @PostMapping("/price")
    @ResponseBody
    public ResponseEntity<String> postsByLowPrice(@RequestBody List<PostDTO> postDTOS) throws ParseException {
        log.info("haha = {}", postDTOS);
        List<PostDTO> lowPricePosts = boardService.sortForLowPrice(postDTOS);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(lowPricePosts);
        } catch (JsonProcessingException e) {

        }

        return ResponseEntity.ok(allPostsByCategorysJson);
    }

    // 제목 + 내용으로 검색하는 요청
    @PostMapping("/titleAndContent")
    public ResponseEntity<String> postsByTitleAndContent(@RequestBody SearchByTitleAndContentDTO searchByTitleAndContentDTO) throws ParseException {
        log.info("searchByTitleAndContentDTO = {}", searchByTitleAndContentDTO);
        List<PostDTO> posts = boardService.findAllPostsByCategorys(new ItemAndBoardCategoryDTO(searchByTitleAndContentDTO.getBoardCategoryId(), searchByTitleAndContentDTO.getItemCategoryId()));
        List<PostDTO> postsByTitleAndContent = boardService.getPostsByTitleAndContent(posts, searchByTitleAndContentDTO.getSearchTermDetail());
        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(postsByTitleAndContent);
        } catch (JsonProcessingException e) {

        }

        return ResponseEntity.ok(allPostsByCategorysJson);
    }


    // 관심글 등록
    @PostMapping("/{boardId}/favorite")
    public ResponseEntity<String> registerInterestPost(@PathVariable("boardId") Integer boardId) {
        String userId = "hong";
        int interestCnt = boardService.registerInterestPost(userId, boardId);
        if (interestCnt > 0) {
            return ResponseEntity.ok(String.valueOf(interestCnt));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to register interest.");
        }
    }

    // 관심글 삭제
    @DeleteMapping("/{boardId}/favorite")
    public ResponseEntity<String> deleteInterestPost(@PathVariable("boardId") Integer boardId) {
        String userId = "hong";
        int interestCnt = boardService.deleteInterestPost(userId, boardId);
        if (interestCnt >= 0) {
            return ResponseEntity.ok(String.valueOf(interestCnt));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to register interest.");
        }
    }


}
