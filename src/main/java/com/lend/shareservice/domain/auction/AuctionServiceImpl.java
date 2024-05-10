package com.lend.shareservice.domain.auction;


import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuctionServiceImpl implements AuctionService{

    private final AuctionMapper auctionMapper;

    @Override
    public long calculateDaysUntilDeadline(Date deadline) {
        LocalDate currentDate = LocalDate.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate deadlineDate = deadline.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        // 두 날짜 간의 일수 차이 계산
        return ChronoUnit.DAYS.between(currentDate, deadlineDate);
    }

    @Override
    public int getAuctionCount(String userId) {
        return auctionMapper.getAuctionCount(userId);
    }

    @Override
    public List<AuctionDTO> auctions(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return auctionMapper.auctions(map);
    }


}
