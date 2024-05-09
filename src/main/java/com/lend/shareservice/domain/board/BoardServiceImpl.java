package com.lend.shareservice.domain.board;

import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.web.board.dto.*;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;
    private final AddressService addressService;
    // 해당 상품 카테고리와 아이템 카테고리 글들 추출
    @Value("${file-url}")
    private String url;

    @Value("${file-relative-url}")
    private String relativeUrl;
    @Override
    public List<PostDTO> findAllPostsByCategorys(ItemAndBoardCategoryDTO itemAndBoardCategoryDTO) {

        List<Board> getBoard = boardMapper.selectAllPostsByCategorys(itemAndBoardCategoryDTO);

        List<PostDTO> posts = getPostDTOS(getBoard);

        return posts;
    }

    private List<PostDTO> getPostDTOS(List<Board> getBoard) {
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
            postDTO.setIsAuction(board.IsAuction(board.getIsAuction()));
            postDTO.setIsLend(board.IsLend(board.getIsLend()));
            postDTO.setHits(board.getHits());
            postDTO.setInterestCnt(board.getInterestCnt());
            postDTO.setLendDate(board.getLendDate());
            postDTO.setReturnDate(board.getReturnDate());
            postDTO.setItemName(board.getItemName());

            if (board.getItemImage1() != null) {
                postDTO.setImgSrc(relativeUrl + board.getItemImage1());
            } else if (board.getItemImage2() != null) {
                postDTO.setImgSrc(relativeUrl + board.getItemImage2());
            } else if (board.getItemImage3() != null) {
                postDTO.setImgSrc(relativeUrl +  board.getItemImage3());
            }

            postDTO.setItemCategoryId(board.getItemCategoryId());
            postDTO.setLatitude(board.getLatitude());
            postDTO.setLongitude(board.getLongitude());
            postDTO.setIsMegaphone(board.IsMegaphone(board.getIsMegaphone()));
            postDTO.setAddress(addressService.getAddressFromLatLng(board.getLatitude(), board.getLongitude()));

            posts.add(postDTO);
        }
        return posts;
    }

    // 상품 카테고리 긁어오기
    @Override
    public List<ItemCategoryDTO> findAllItemCategory() {

        return boardMapper.selectAllItemCategory();
    }


    // 글 저장
    @Override
    public void savePost(PostRegistrationDTO postRegistrationDTO) throws ParseException {

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

            try {
                byte[] bytes = multipartFile.getBytes();
                String fileName = multipartFile.getOriginalFilename();
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(new File(url + fileUUID + "." + ext)));
                stream.write(bytes);
                stream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (board.getItemImage1() == null) {
                board.setItemImage1(fileUUID + "." + ext);
            } else if (board.getItemImage2() == null) {
                board.setItemImage2(fileUUID + "." + ext);
            } else if (board.getItemImage3() == null) {
                board.setItemImage3(fileUUID + "." + ext);
            }
        }

        board.setHits(0);
        board.setContent(postRegistrationDTO.getContent());
        board.setBoardCategoryId(postRegistrationDTO.getBoardCategoryId());
        board.setTitle(postRegistrationDTO.getTitle());
        board.setPrice(Integer.valueOf(NumberFormat.getInstance(Locale.KOREA).parse(postRegistrationDTO.getPrice()).intValue()));
        board.setMaxPrice(Integer.valueOf(NumberFormat.getInstance(Locale.KOREA).parse(postRegistrationDTO.getMaxPrice()).intValue()));

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
        List<String> itemImages = new ArrayList<>();
        if (board.getItemImage1() != null) {
            itemImages.add(relativeUrl + board.getItemImage1());
        }
        if (board.getItemImage2() != null) {
            itemImages.add(relativeUrl + board.getItemImage2());
        }
        if (board.getItemImage3() != null) {
            itemImages.add(relativeUrl + board.getItemImage3());
        }
        itemDetailDTO.setItemImage(itemImages);
        itemDetailDTO.setBoardCategoryId(board.getBoardCategoryId());
        itemDetailDTO.setItemCategoryId(board.getItemCategoryId());
        itemDetailDTO.setLatitude(board.getLatitude());
        itemDetailDTO.setLongitude(board.getLongitude());
        itemDetailDTO.setIsMegaphone(board.IsMegaphone(board.getIsMegaphone()));

        return itemDetailDTO;
    }

    @Override
    public List<PostDTO> findPostsBySearchTerm(String searchTerm) {

        List<Board> postDTOS = boardMapper.selectPostsBySearchTerm(searchTerm);
        List<PostDTO> postDTOS1 = getPostDTOS(postDTOS);
        return postDTOS1;
    }

    // 조회수 1 증가
    public void incrementingViewCount(Integer boarId) {

        boardMapper.incrementingViewCount(boarId);
    }

    // 인기글 찾기
    public List<PostDTO> findInterestPosts() {
        List<Board> board = boardMapper.selectAllPostsInOrderOfInterest();

        List<PostDTO> postDTOInOrderOfInterest = getPostDTOS(board);

        return postDTOInOrderOfInterest;
    }

    // 조회순으로 정렬
    @Override
    public List<PostDTO> sortForHits(List<PostDTO> postDTOS) {
        return postDTOS.stream()
                .sorted(Comparator.comparingInt(PostDTO::getHits).reversed())
                .collect(Collectors.toList());
    }

    // 관심순으로 정렬
    @Override
    public List<PostDTO> sortForInterest(List<PostDTO> postDTOS) {
        return postDTOS.stream()
                .sorted(Comparator.comparingInt(PostDTO::getInterestCnt).reversed())
                .collect(Collectors.toList());
    }

    // 가격 낮은순으로 정렬
    @Override
    public List<PostDTO> sortForLowPrice(List<PostDTO> postDTOS) throws ParseException {
        return postDTOS.stream()
                .sorted(Comparator.comparingDouble(dto -> Double.parseDouble(dto.getPrice().replace(",", ""))))
                .collect(Collectors.toList());
    }

    // 관심글 등록
    @Override
    public boolean registerInterestPost(String userId, Integer boardId) {
        Favorite favorite = new Favorite();
        favorite.setBoardId(boardId);
        favorite.setUserId(userId);
        log.info("haha");
        if (boardMapper.insertFavorite(favorite) > 0 && boardMapper.incrementInterest(favorite) > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteInterestPost(String userId, Integer boardId) {
        Favorite favorite = new Favorite();
        favorite.setBoardId(boardId);
        favorite.setUserId(userId);
        if (boardMapper.deleteFavorite(favorite) > 0 && boardMapper.decreaseInterest(favorite) > 0) {
            return true;
        }

        return false;
    }


}
