package com.lend.shareservice.web.block;

import com.lend.shareservice.domain.block.BlockService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class BlockController {

    private final BlockService blockService;


}
