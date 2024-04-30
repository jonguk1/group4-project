package com.lend.shareservice.domain.auction;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuctionServiceImpl implements AuctionService{

    private final AuctionMapper auctionMapper;


}
