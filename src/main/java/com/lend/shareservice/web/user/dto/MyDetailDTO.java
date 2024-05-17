package com.lend.shareservice.web.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;

import java.sql.Date;

@Data
public class MyDetailDTO {

    @NotBlank
    private String userId;

    @NotBlank
    private String name;

    @NotBlank
    private String pw;

    @NotNull
    private String phoneNumber;

    @NotNull
    @PositiveOrZero
    private Integer point;

    private Double latitude;

    private Double longitude;

    @NotNull
    @PositiveOrZero
    private Integer money;

    private Date regDate;

    private String address;
}
