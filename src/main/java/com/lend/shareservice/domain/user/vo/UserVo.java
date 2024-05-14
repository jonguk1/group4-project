package com.lend.shareservice.domain.user.vo;

import lombok.Data;



import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Data
public class UserVo  {


    //유저 id
    private String userId;

    // 이름

    private String name;

    // 비밀번호

    private String pw;

    // 전화번호

    private String phoneNumber;

    // 위도
    private Double latitude;

    // 경도
    private Double longitude;

    // 주소
    private String address;








}
