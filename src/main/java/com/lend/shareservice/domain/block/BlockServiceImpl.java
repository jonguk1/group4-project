package com.lend.shareservice.domain.block;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BlockServiceImpl implements BlockService{

    private final BlockMapper blockMapper;
}
