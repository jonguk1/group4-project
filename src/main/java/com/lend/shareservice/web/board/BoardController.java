package com.lend.shareservice.web.board;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.domain.board.BoardService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.board.boardexception.PostNotFoundException;
import com.lend.shareservice.web.board.dto.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
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
    private final UserService userService;
    @GetMapping("/boardForm")
    public String boardForm(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        User userById = userService.findUserById(userId);
        LatiLongDTO latiLongDTO = new LatiLongDTO(userById.getLatitude(), userById.getLongitude());
        model.addAttribute("latiAndLong", latiLongDTO);
        return "jspp/writingRegisterForm";
    }

    // 글 등록 요청
    @PostMapping
    public String postRegister(HttpServletRequest request, @Valid @ModelAttribute PostRegistrationDTO postRegistrationDTO, BindingResult bindingResult, Model model) throws ParseException {

        if (postRegistrationDTO.getFileInput().get(0).getSize() == 0 &&
                postRegistrationDTO.getFileInput().get(1).getSize() == 0 &&
        postRegistrationDTO.getFileInput().get(2).getSize() == 0) {
            bindingResult.rejectValue("fileInput", "error.fileInput", "상품 이미지를 최소 하나를 등록해야합니다.");
        }
        if (bindingResult.hasErrors()) {

            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");
            User userById = userService.findUserById(userId);
            log.info("userById = {}", userById);
            LatiLongDTO latiLongDTO = new LatiLongDTO(userById.getLatitude(), userById.getLongitude());
            model.addAttribute("postRegistrationBindingResult", bindingResult);
            model.addAttribute("latiAndLong", latiLongDTO);
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

        return ResponseEntity.ok(allItemCategory);
    }

    // 글 카테고리 + 물건 카테고리에 해당하는 글들 응답 -> 메뉴에서 선택하면 나오는 글들
    @GetMapping()
    public String getPostsByCategory(HttpServletRequest request, Model model, @RequestParam("boardCategoryId") Integer boardCategoryId
            , @RequestParam("itemCategoryId") Integer itemCategoryId) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        List<PostDTO> allPostsByCategorys = boardService.findAllPostsByCategorys(userId, new ItemAndBoardCategoryDTO(itemCategoryId, boardCategoryId));

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
    public String boardDetail(HttpServletRequest request, @PathVariable("boardId") Integer boardId, Model model)  {

        if (boardId >= Integer.MAX_VALUE) {
            throw new PostNotFoundException("해당 글이 존재하지 않습니다.");
        }
        // 조회수 1증가
        if (boardService.incrementingViewCount(boardId) <= 0) {
            throw new PostNotFoundException("해당 글이 존재하지 않습니다.");
        }

        ItemDetailDTO postById = boardService.findPostById(boardId);

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId != null) {
            User userById = userService.findUserById(userId);
            int distance = boardService.calculateRoundedDistance(userById.getLatitude(), userById.getLongitude(), postById.getLatitude(), postById.getLongitude());
            postById.setDistance(distance);
        }

        if (postById == null) {
            throw new PostNotFoundException("해당 글이 존재하지 않습니다.");
        }

        postById.setAddress(addressService.getAddressFromLatLng(postById.getLatitude(), postById.getLongitude()));
        List<PostDTO> postsBySearchTerm = boardService.findPostsBySearchTerm(userId, postById.getItemName());
        List<PostDTO> interestPosts = boardService.findInterestPosts(userId);

        model.addAttribute("postById", postById);
        model.addAttribute("postsBySearchTerm", postsBySearchTerm);
        model.addAttribute("interestPosts", interestPosts);

        return "jspp/itemDetail";
    }

    @GetMapping("/search")
    public String postsBySearchTerm(HttpServletRequest request, Model model, @RequestParam("searchTerm") String searchTerm) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        List<PostDTO> postsBySearchTerm = boardService.findPostsBySearchTerm(userId, searchTerm);


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
    public ResponseEntity<String> postsByDistance(@RequestBody List<PostDTO> postDTOS) throws ParseException {

        List<PostDTO> lowDistancePosts = boardService.sortForLowPrice(postDTOS);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(lowDistancePosts);
        } catch (JsonProcessingException e) {

        }

        return ResponseEntity.ok(allPostsByCategorysJson);
    }

    @PostMapping("/distance")
    @ResponseBody
    public ResponseEntity<String> postsByLowPrice(@RequestBody List<PostDTO> postDTOS) throws ParseException {

        List<PostDTO> lowPricePosts = boardService.sortForDistance(postDTOS);

        String allPostsByCategorysJson = null;
        try {
            allPostsByCategorysJson = objectMapper.writeValueAsString(lowPricePosts);
        } catch (JsonProcessingException e) {

        }

        return ResponseEntity.ok(allPostsByCategorysJson);
    }

    // 제목 + 내용으로 검색하는 요청
    @PostMapping("/titleAndContent")
    public ResponseEntity<String> postsByTitleAndContent(HttpServletRequest request, @RequestBody SearchByTitleAndContentDTO searchByTitleAndContentDTO) throws ParseException {


        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        List<PostDTO> posts = boardService.findAllPostsByCategorys(userId, new ItemAndBoardCategoryDTO(searchByTitleAndContentDTO.getBoardCategoryId(), searchByTitleAndContentDTO.getItemCategoryId()));
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
    public ResponseEntity<String> registerInterestPost(HttpServletRequest request, @PathVariable("boardId") Integer boardId) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        int interestCnt = boardService.registerInterestPost(userId, boardId);
        if (interestCnt > 0) {
            return ResponseEntity.ok(String.valueOf(interestCnt));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to register interest.");
        }
    }

    // 관심글 삭제
    @DeleteMapping("/{boardId}/favorite")
    public ResponseEntity<String> deleteInterestPost(HttpServletRequest request, @PathVariable("boardId") Integer boardId) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        int interestCnt = boardService.deleteInterestPost(userId, boardId);
        if (interestCnt >= 0) {
            return ResponseEntity.ok(String.valueOf(interestCnt));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to register interest.");
        }
    }

    @GetMapping("/editForm")
    public String editForm(@RequestParam("boardId") Integer boardId, Model model) {

        ItemDetailDTO postById = boardService.findPostById(boardId);
        model.addAttribute("postById", postById);

        return "jspp/writingEditForm";
    }

    @PostMapping("/edit")
    public ResponseEntity<String> editPost(Model model, @Valid @ModelAttribute PostEditDTO postEditDTO, BindingResult bindingResult) {
        log.info("postEditDTO = {}", postEditDTO);
        // 에러 체크
        if (bindingResult.hasErrors()) {
            // 에러가 있는 경우
            JSONObject errorJson = new JSONObject();
            errorJson.put("status", "error");
            errorJson.put("message", "Validation failed");

            // 필드 에러 추가
            JSONArray fieldErrors = new JSONArray();
            for (FieldError fieldError : bindingResult.getFieldErrors()) {
                JSONObject fieldErrorJson = new JSONObject();
                fieldErrorJson.put("field", fieldError.getField());
                fieldErrorJson.put("message", fieldError.getDefaultMessage());
                fieldErrors.put(fieldErrorJson);
            }
            errorJson.put("errors", fieldErrors);

            // JSON 형식의 응답 반환
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorJson.toString());
        } else {
            // 에러가 없는 경우
            int editNum = boardService.editPost(postEditDTO);

            if (editNum > 0) {
                // 성공 응답 반환
                return ResponseEntity.ok("{\"status\": \"ok\"}");
            } else {
                // 실패 응답 반환
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"status\": \"error\", \"message\": \"Failed to edit post\"}");
            }
        }
    }
}
