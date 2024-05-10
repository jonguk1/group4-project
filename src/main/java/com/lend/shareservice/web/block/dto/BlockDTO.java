package com.lend.shareservice.web.block.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class BlockDTO {

    @NotNull
    private String blockedUserId;
}
