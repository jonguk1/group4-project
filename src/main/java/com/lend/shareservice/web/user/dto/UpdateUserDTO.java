package com.lend.shareservice.web.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class UpdateUserDTO {

    @NotBlank
    private String userId;

    @NotBlank(message = "이름은 필수 입력 항목입니다.")
    private String name;

    @NotBlank(message = "비밀번호는 필수 입력 항목입니다.")
    private String pw;

    @NotNull(message = "전화번호는 필수 입력 항목입니다.")
    @Pattern(regexp="^\\d{3}-\\d{3,4}-\\d{4}$", message="올바른 전화번호 형식이 아닙니다.")
    private String phoneNumber;

    private Double latitude;

    private Double longitude;

    private String address;
}
