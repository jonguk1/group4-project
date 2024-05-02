package com.lend.shareservice.domain.board;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.web.board.dto.PostRegistrationDTO;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Date;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;

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

            if (board.getItem_image1() == null) {
                board.setItem_image1(fileUUID + ext);
            } else if (board.getItem_image2() == null) {
                board.setItem_image2(fileUUID + ext);
            } else if (board.getItem_image3() == null) {
                board.setItem_image3(fileUUID + ext);
            }
        }

        board.setHits(0);
        board.setContent(postRegistrationDTO.getContent());
        board.setBoard_category_id(postRegistrationDTO.getBoard_category_id());
        board.setTitle(postRegistrationDTO.getTitle());
        board.setPrice(Integer.valueOf(NumberFormat.getInstance(Locale.KOREA).parse(postRegistrationDTO.getPrice()).intValue()));
        board.setDeadline(Date.valueOf(postRegistrationDTO.getDeadline()));

        if (!postRegistrationDTO.getIsAuction()) {
            board.setIsAuction(null);
        } else {
            board.setIsAuction("0");
        }

        board.setIsLend("0");
        board.setInterestCnt(0);
        board.setHits(0);
        board.setReturnDate(Date.valueOf(postRegistrationDTO.getReturnDate()));
        board.setItem_name(postRegistrationDTO.getItem_name());
        board.setItem_category_id(postRegistrationDTO.getItem_category_id());
        board.setLatitude(postRegistrationDTO.getLatitude());
        board.setLongitude(postRegistrationDTO.getLongitude());
        board.setIsMegaphone(postRegistrationDTO.getIsMegaphone());
        board.setWriter(postRegistrationDTO.getWriter());
        boardMapper.insertBoard(board);
    }
}
