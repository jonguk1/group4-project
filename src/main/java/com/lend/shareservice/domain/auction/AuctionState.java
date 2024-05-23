package com.lend.shareservice.domain.auction;

import lombok.Getter;

@Getter
public enum AuctionState {
    BEFORE("0"), PROGRESS("1"), AFTER("2");

    private final String state;

    AuctionState(String state) {
        this.state = state;
    }
}

