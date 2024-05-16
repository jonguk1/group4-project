package com.lend.shareservice.entity;


import lombok.*;

import jakarta.validation.constraints.*;

// 회원


@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor

public class User {

    // 아이디 (Id)

    @NotBlank

    @NotBlank

    private String userId;

    // 이름
    @NotBlank
    private String name;

    // 비밀번호
    @NotBlank
    private String pw;

   // 전화번호
    @NotNull
    @Pattern(regexp="^\\d{3}-\\d{3,4}-\\d{4}$", message="올바른 전화번호 형식이 아닙니다.")
    private String phoneNumber;

    // 포인트 (default = 0)
    @NotNull
    @PositiveOrZero
    private Integer point;

    // 권한 여부 (관리자 = true, 일반 = false, dafalut = false)
    @NotNull
    private Boolean authorization;

    // 위도
    private Double latitude;

    // 경도
    private Double longitude;

    // 프로필 사진
    @Size(max = 50, message = "파일명 50자 초과")
    private String profile;

    // 보유한 돈 (defalut = 0)
    @NotNull
    @PositiveOrZero
    private Integer money;

    // 주소
    @NotNull
    private String address;

    // 정지 여부
    @NotNull
    private Boolean ban;

}
