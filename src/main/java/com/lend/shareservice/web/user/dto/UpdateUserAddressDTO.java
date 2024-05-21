package com.lend.shareservice.web.user.dto;

import lombok.Data;

@Data
public class UpdateUserAddressDTO {

    private String userId;
    private Double latitude;
    private Double longitude;
    private String address;
}
