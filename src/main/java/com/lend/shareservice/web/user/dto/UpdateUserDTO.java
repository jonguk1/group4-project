package com.lend.shareservice.web.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateUserDTO {

    @NotBlank
    private String userId;

    @NotBlank(message = "이름을 입력해주세요.")
    @Size(max=5, message = "5자리 이하로 입력하세요")
    private String name;

    @NotBlank(message = "비밀번호를 입력해주세요.")
    @Size(min=8, max=20, message ="비밀번호 8자리에서 20자리 사이로 입력하세요")
    private String pw;

    @NotNull(message = "전화번호를 입력해주세요.")
    @Pattern(regexp="^\\d{3}-\\d{3,4}-\\d{4}$", message="올바른 전화번호 형식으로 입력해주세요.")
    private String phoneNumber;

    private Double latitude;

    private Double longitude;

    private String address;
}
