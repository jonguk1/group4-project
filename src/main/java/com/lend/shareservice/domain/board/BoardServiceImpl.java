package com.lend.shareservice.domain.board;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.web.board.dto.*;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;

    // 해당 상품 카테고리와 아이템 카테고리 글들 추출
    @Override
    public List<PostDTO> findAllPostsByCategorys(ItemAndBoardCategoryDTO itemAndBoardCategoryDTO) {

        List<Board> getBoard = boardMapper.selectAllPostsByCategorys(itemAndBoardCategoryDTO);
        List<PostDTO> posts = new ArrayList<>();
        for (Board board : getBoard) {

            PostDTO postDTO = new PostDTO();
            postDTO.setBoardId(board.getBoardId());
            postDTO.setBoardCategoryId(board.getBoardCategoryId());
            postDTO.setItemCategoryId(board.getItemCategoryId());
            postDTO.setWriter(board.getWriter());
            postDTO.setTitle(board.getTitle());
            postDTO.setContent(board.getContent());
            postDTO.setRegDate(board.getRegDate());
            postDTO.setPrice(new DecimalFormat("#,###").format(board.getPrice()));
            postDTO.setDeadline(board.getDeadline());
            postDTO.setIsAuction(board.getIsAuction());
            postDTO.setIsLend(board.getIsLend());
            postDTO.setHits(board.getHits());
            postDTO.setInterestCnt(board.getInterestCnt());
            postDTO.setLendDate(board.getLendDate());
            postDTO.setReturnDate(board.getReturnDate());
            postDTO.setItemName(board.getItemName());
            postDTO.setItemImage1(board.getItemImage1());
            postDTO.setItemImage2(board.getItemImage2());
            postDTO.setItemImage3(board.getItemImage3());
            postDTO.setItemCategoryId(board.getItemCategoryId());
            postDTO.setLatitude(board.getLatitude());
            postDTO.setLongitude(board.getLongitude());
            postDTO.setIsMegaphone(board.getIsMegaphone());
            posts.add(postDTO);
        }

        return posts;
    }


    // 상품 카테고리 긁어오기
    @Override
    public List<ItemCategoryDTO> findAllItemCategory() {

        return boardMapper.selectAllItemCategory();
    }

    @Value("${file-url}")
    private String url;

    // 글 저장
    @Override
    public void savePost(PostRegistrationDTO postRegistrationDTO) throws ParseException {
        log.info("url = {}", url);
        List<MultipartFile> fileInput = postRegistrationDTO.getFileInput();

        Board board = new Board();

        for (MultipartFile multipartFile : fileInput) {
            if (multipartFile.getOriginalFilename().isEmpty()) {
                continue;
            }
            String fileUUID = UUID.randomUUID().toString();
            String originalFilename = multipartFile.getOriginalFilename();
            String[] split = originalFilename.split("\\.");
            String ext = split[1];

            if (board.getItemImage1() == null) {
                board.setItemImage1(fileUUID + ext);
            } else if (board.getItemImage2() == null) {
                board.setItemImage2(fileUUID + ext);
            } else if (board.getItemImage3() == null) {
                board.setItemImage3(fileUUID + ext);
            }
        }

        board.setHits(0);
        board.setContent(postRegistrationDTO.getContent());
        board.setBoardCategoryId(postRegistrationDTO.getBoardCategoryId());
        board.setTitle(postRegistrationDTO.getTitle());
        board.setPrice(Integer.valueOf(NumberFormat.getInstance(Locale.KOREA).parse(postRegistrationDTO.getPrice()).intValue()));

        if (postRegistrationDTO.getDeadline() == null) {
            board.setDeadline(null);
        } else {
            board.setDeadline(Date.valueOf(postRegistrationDTO.getDeadline()));
        }

        if (postRegistrationDTO.getIsAuction() == null || !postRegistrationDTO.getIsAuction()) {
            board.setIsAuction(null);
        } else {
            board.setIsAuction("0");
        }

        board.setIsLend("0");
        board.setInterestCnt(0);
        board.setHits(0);

        if (postRegistrationDTO.getReturnDate() == null) {
            board.setDeadline(null);
        } else {
            board.setReturnDate(Date.valueOf(postRegistrationDTO.getReturnDate()));
        }

        board.setItemName(postRegistrationDTO.getItemName());
        board.setItemCategoryId(postRegistrationDTO.getItemCategoryId());
        board.setLatitude(postRegistrationDTO.getLatitude());
        board.setLongitude(postRegistrationDTO.getLongitude());

        if (postRegistrationDTO.getIsMegaphone() == null) {
            board.setIsMegaphone(false);
        } else {
            board.setIsMegaphone(postRegistrationDTO.getIsMegaphone());
        }
        board.setWriter(postRegistrationDTO.getWriter());
        board.setLendDate(null);
        boardMapper.insertBoard(board);
    }


    // 글 상세 보기를 위한 boardID로 글 찾기
    @Override
    public ItemDetailDTO findPostById(Integer boardId) {

        Board board = boardMapper.selectPostById(boardId);
        log.info("board = {}", board);

        ItemDetailDTO itemDetailDTO = new ItemDetailDTO();

        itemDetailDTO.setBoardId(board.getBoardId());
        itemDetailDTO.setWriter(board.getWriter());
        itemDetailDTO.setTitle(board.getTitle());
        itemDetailDTO.setContent(board.getContent());
        itemDetailDTO.setRegDate(board.getRegDate());
        itemDetailDTO.setDeadline(board.getDeadline());
        itemDetailDTO.setLendDate(board.getLendDate());
        itemDetailDTO.setReturnDate(board.getReturnDate());
        itemDetailDTO.setPrice(new DecimalFormat("#,###").format(board.getPrice()));
        itemDetailDTO.setIsAuction(board.IsAuction(board.getIsAuction()));
        itemDetailDTO.setIsLend(board.IsLend(board.getIsLend()));
        itemDetailDTO.setInterestCnt(board.getInterestCnt());
        itemDetailDTO.setHits(board.getHits());
        itemDetailDTO.setItemName(board.getItemName());
        itemDetailDTO.setItemImage1(board.getItemImage1());
        itemDetailDTO.setItemImage2(board.getItemImage2());
        itemDetailDTO.setItemImage3(board.getItemImage3());
        itemDetailDTO.setBoardCategory(board.getBoardCategoryId());
        itemDetailDTO.setItemCategoryId(board.getItemCategoryId());
        itemDetailDTO.setLatitude(board.getLatitude());
        itemDetailDTO.setLongitude(board.getLongitude());
        itemDetailDTO.setIsMegaphone(board.IsMegaphone(board.getIsMegaphone()));

        return itemDetailDTO;
    }
}
