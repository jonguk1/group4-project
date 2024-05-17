package com.lend.shareservice.domain.board;

import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.domain.user.UserMapper;
import com.lend.shareservice.domain.user.vo.UserVo;
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
    private final UserMapper userMapper;
    private static final double EARTH_RADIUS_KM = 6371;
    // 해당 상품 카테고리와 아이템 카테고리 글들 추출
    @Value("${file-url}")
    private String url;

    @Value("${file-relative-url}")
    private String relativeUrl;
    @Override
    public List<PostDTO> findAllPostsByCategorys(String userId, ItemAndBoardCategoryDTO itemAndBoardCategoryDTO) {

        List<Board> getBoard = boardMapper.selectAllPostsByCategorys(itemAndBoardCategoryDTO);


        List<PostDTO> posts = getPostDTOS(userId, getBoard);

        return posts;
    }

    private double toRadians(double degrees) {
        return Math.toRadians(degrees);
    }

    public int calculateRoundedDistance(double lat1, double lon1, double lat2, double lon2) {
        double distance = calculateDistance(lat1, lon1, lat2, lon2);
        // 거리를 반올림하여 정수로 변환하여 반환
        return (int) Math.round(distance);
    }
    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {

        double dLat = toRadians(lat2 - lat1);
        double dLon = toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
                        Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return EARTH_RADIUS_KM * c; // 거리를 킬로미터 단위로 반환
    }

    private List<PostDTO> getPostDTOS(String userId, List<Board> getBoard) {
        List<PostDTO> posts = new ArrayList<>();

        // 위도, 경도값을 받아오기위한 user정보
        UserVo userAccount = userMapper.getUserAccount(userId);

        for (Board board : getBoard) {

            PostDTO postDTO = new PostDTO();

            if (userAccount != null) {
                int distance = calculateRoundedDistance(userAccount.getLatitude(), userAccount.getLongitude(), board.getLatitude(), board.getLongitude());
                postDTO.setDistance(distance);
            }

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

        if (!postRegistrationDTO.getMaxPrice().isEmpty()) {
            board.setMaxPrice(Integer.valueOf(NumberFormat.getInstance(Locale.KOREA).parse(postRegistrationDTO.getMaxPrice()).intValue()));
        } else {
            board.setMaxPrice(null);
        }

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
            board.setReturnDate(null);
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
        log.info("save!!! = {}", board);
        boardMapper.insertBoard(board);
    }


    // 글 상세 보기를 위한 boardID로 글 찾기
    @Override
    public ItemDetailDTO findPostById(Integer boardId) {

        Board board = boardMapper.selectPostById(boardId);

        // 해당 ID의 글이 없는 경우
        if (board == null) {
            return null;
        }

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
    public List<PostDTO> findPostsBySearchTerm(String userId, String searchTerm) {

        List<Board> postDTOS = boardMapper.selectPostsBySearchTerm(searchTerm);
        List<PostDTO> postDTOS1 = getPostDTOS(userId, postDTOS);
        return postDTOS1;
    }

    // 조회수 1 증가
    public int incrementingViewCount(Integer boarId) {
        return boardMapper.incrementingViewCount(boarId);
    }

    // 인기글 찾기
    public List<PostDTO> findInterestPosts(String userId) {
        List<Board> board = boardMapper.selectAllPostsInOrderOfInterest();

        List<PostDTO> postDTOInOrderOfInterest = getPostDTOS(userId, board);

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

    // 최신순으로 정렬
    @Override
    public List<PostDTO> sortForRecent(List<PostDTO> postDTOS) {
        Collections.sort(postDTOS, Comparator.comparing(PostDTO::getRegDate).reversed());
        return postDTOS;
    }

    // 거리순으로 정렬
    @Override
    public List<PostDTO> sortForDistance(List<PostDTO> postDTOS) {
        return postDTOS.stream()
                .sorted(Comparator.comparingInt(PostDTO::getDistance))
                .collect(Collectors.toList());
    }

    // 제목 + 내용으로 검색
    @Override
    public List<PostDTO> getPostsByTitleAndContent(List<PostDTO> postDTOS, String searchTermDetail) {

        List<PostDTO> postsToRemove = new ArrayList<>(); // 삭제할 요소를 저장할 리스트

        for (PostDTO postDTO : postDTOS) {
            if (!postDTO.getTitle().contains(searchTermDetail) && !postDTO.getContent().contains(searchTermDetail)) {
                postsToRemove.add(postDTO);
            }
        }
        postDTOS.removeAll(postsToRemove);

        return postDTOS;
    }

    // 관심글 등록
    @Override
    public int registerInterestPost(String userId, Integer boardId) {
        Favorite favorite = new Favorite();
        favorite.setBoardId(boardId);
        favorite.setUserId(userId);

        if (boardMapper.insertFavorite(favorite) > 0 && boardMapper.incrementInterest(favorite) > 0) {
            return boardMapper.getInterestCnt(favorite);
        }
        return 0;
    }

    @Override
    public int deleteInterestPost(String userId, Integer boardId) {
        Favorite favorite = new Favorite();
        favorite.setBoardId(boardId);
        favorite.setUserId(userId);
        if (boardMapper.deleteFavorite(favorite) > 0 && boardMapper.decreaseInterest(favorite) > 0) {
            return boardMapper.getInterestCnt(favorite);
        }

        return -1;
    }


}
