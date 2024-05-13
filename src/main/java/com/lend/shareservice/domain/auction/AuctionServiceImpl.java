package com.lend.shareservice.domain.auction;


import com.lend.shareservice.domain.notification.EmitterRepository;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.domain.board.BoardService;
import com.lend.shareservice.domain.notification.NotificationMapper;
import com.lend.shareservice.domain.notification.NotificationService;
import com.lend.shareservice.entity.Auction;
import com.lend.shareservice.entity.Notification;
import com.lend.shareservice.entity.Participant_Auction;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuctionServiceImpl implements AuctionService{

    private final AuctionMapper auctionMapper;

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

    private final NotificationMapper notificationMapper;
    private final NotificationService notificationService;
    private final BoardService boardService;

    @Override
    @Transactional
    public int paticipateAuction(String userId, Integer boardId) {


        Auction findAuction = auctionMapper.selectAuctionByBoardId(boardId);
        log.info("findAuction = {}", findAuction);
        // 아직 생성된 적 없음 -> 생성
        if (findAuction == null) {

            Auction auction = new Auction();
            auction.setBoardId(boardId);
            auction.setCurrentPrice(0);
            // 경매방 생성
            Auction findMaxPrice = auctionMapper.selectMaxPrice(auction);
            auction.setMaxPrice(findMaxPrice.getMaxPrice());
            auctionMapper.insertAuction(auction);

            Auction findAuctionId = auctionMapper.selectAuctionId(auction);
            Participant_Auction participantAuction = new Participant_Auction();
            participantAuction.setAuctionId(findAuctionId.getAuctionId());
            participantAuction.setUserId(userId);
            // 경매방_참여 등록
            return auctionMapper.insertAuctionParticipant(participantAuction);

        } else {
            Auction auction = new Auction();
            auction.setBoardId(boardId);

            Auction findAuctionId = auctionMapper.selectAuctionId(auction);

            int findParticipantCnt = auctionMapper.selectParticipantCnt(findAuctionId);

            if (findParticipantCnt == 1) {
                // 글쓴이에게 전달
                notificationService.sendToClient(boardService.findPostById(boardId).getWriter(), "경매가 시작되었습니다");

                Notification notification = new Notification();
                notification.setContent("경매가 시작되었습니다");
                notification.setUserId(boardService.findPostById(boardId).getWriter());
                notification.setIsRead(false);
                notificationMapper.insertNotification(notification);


                List<String> ids = auctionMapper.selectIdsByAuctionId(findAuctionId.getAuctionId());

                // 경매 참여자에게 전달
                for (String id : ids) {
                    notification.setUserId(id);
                    notificationMapper.insertNotification(notification);
                    notificationService.sendToClient(id, "경매가 시작되었습니다^^");
                }
            } else if (findParticipantCnt > 1) {
                // 글쓴이에게 전달
                notificationService.sendToClient(boardService.findPostById(boardId).getWriter(), userId + "님이 경매에 참여하였습니다.");

                List<String> ids = auctionMapper.selectIdsByAuctionId(findAuctionId.getAuctionId());

                // 경매 참여자에게 전달
                for (String id : ids) {
                    notificationService.sendToClient(id, userId + "님이 경매에 참여하였습니다.");
                }
            }

            Participant_Auction participantAuction = new Participant_Auction();
            participantAuction.setAuctionId(findAuctionId.getAuctionId());
            participantAuction.setUserId(userId);

            return auctionMapper.insertAuctionParticipant(participantAuction);
        }

    }

    @Override
    public boolean findCurrentAuctionState(String userId) {
        int cnt = auctionMapper.selectIsAuctionById(userId);

        if (cnt >= 1) {
            return true;
        }

        return false;
    }

}
