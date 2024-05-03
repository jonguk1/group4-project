package com.lend.shareservice.web.board.dto;

import lombok.Data;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Data
public class PostRegistrationDTO {

    private Integer board_category_id;
    private String title;
    private String item_name;
    private String price;
    private Integer item_category_id;
    private List<MultipartFile> fileInput;
    private String content;
    private Boolean isMegaphone;
    private Boolean isAuction;
    private LocalDate returnDate;
    private LocalDate deadline;
    private Double latitude;
    private Double longitude;
    private String writer;

}
