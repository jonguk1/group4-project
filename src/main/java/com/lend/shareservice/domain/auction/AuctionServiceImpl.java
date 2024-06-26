package com.lend.shareservice.domain.auction;


import com.lend.shareservice.domain.board.dto.BoardAuctionStateDTO;
import com.lend.shareservice.domain.notification.EmitterRepository;
import com.lend.shareservice.domain.user.UserMapper;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.auction.dto.AuctionBoardDTO;
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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
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
    private final NotificationService notificationService;
    private final NotificationMapper notificationMapper;
    private final BoardService boardService;

    @Override
    public int getAuctionCount(String userId) {
        return auctionMapper.getAuctionCount(userId);
    }

    @Override
    public int getCompleteAuctionCount(String userId) {
        return auctionMapper.getAuctionCount(userId);
    }

    @Override
    public List<AuctionDTO> findByAuctionList(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return auctionMapper.findByAuctionList(map);
    }

    @Override
    public List<AuctionDTO> findByCompleteAuctionList(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return auctionMapper.findByCompleteAuctionList(map);
    }

    @Override
    @Transactional
    public String updateCurrentPrice(int auctionId, int currentPrice, String userId) {
        // 현재 가격이 0일 경우
        if (currentPrice == 0) {
            return "emptyCurrentPrice";
        }

        // 최대 가격, 현재 가격, 마감일, 현재 시각, 사용자 돈 조회
        int maxPrice = auctionMapper.getMaxPrice(auctionId);
        int getCurrentPrice = auctionMapper.getCurrentPrice(auctionId);
        Date deadline = auctionMapper.getDeadline(auctionId);
        Instant currentInstant = Instant.now();
        Instant deadlineInstant = (deadline != null) ? deadline.toInstant() : null;
        int money = auctionMapper.findByMoney(userId);

        // 경매 마감 여부 확인
        if (deadlineInstant != null && currentInstant.isAfter(deadlineInstant)) {
            return "overDate";
        }

        // 현재 가격이 최대 가격보다 크거나 같은 경우
        if (currentPrice > maxPrice) {
            return "maxCurrentPrice";
        }

        // 현재 가격이 이미 최고 가격보다 낮은 경우
        if (currentPrice <= getCurrentPrice) {
            return "lowCurrentPrice";
        }


        // 사용자의 돈이 현재 가격보다 적은 경우
        if (money < currentPrice) {
            return "noMoney";
        }

        // 중복 입찰 여부 확인
        String duplicateUserId = auctionMapper.findByAuctionUserId(userId, auctionId);
        if (duplicateUserId != null) {
            return "duplicateUserId";
        }

        auctionMapper.lockAuction(auctionId);

        Map<String, Object> map = new HashMap<>();
        map.put("currentPrice", currentPrice);
        map.put("auctionId", auctionId);
        map.put("userId", userId);
        int updateResult = auctionMapper.updateCurrentPrice(map);

        // 업데이트 결과에 따른 처리
        if (updateResult > 0) {

            String message = userId + "님이 " + currentPrice + "원으로 입찰가를 올렸습니다";
            // 실시간 알림 메시지 전달

            notificationService.sendMessageAuctionUsers(auctionId, message);
            return "ok";
        } else {
            return "no";
        }
    }

    @Override
    @Transactional
    public int paticipateAuction(String userId, Integer boardId) {

        Auction findAuction = auctionMapper.selectAuctionByBoardId(boardId);

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
                notification.setBoardId(boardId);

                notificationMapper.insertNotification(notification);


                List<String> ids = auctionMapper.selectIdsByAuctionId(findAuctionId.getAuctionId());

                // 경매 참여자에게 전달
                for (String id : ids) {

                    log.info("start = {}", id);
                    notification.setUserId(id);
                    notificationMapper.insertNotification(notification);
                    notificationService.sendToClient(id, "경매가 시작되었습니다");
                }

                boardService.updateIsAuction(new BoardAuctionStateDTO(boardId, AuctionState.PROGRESS.getState()));

                notificationService.sendToClient(userId, "경매가 시작되었습니다");
                notification.setUserId(userId);
                notificationMapper.insertNotification(notification);
            } else if (findParticipantCnt > 1) {
                // 글쓴이에게 전달
                notificationService.sendToClient(boardService.findPostById(boardId).getWriter(), userId + "님이 경매에 참여하였습니다.");

                Notification notification = new Notification();
                notification.setContent(userId + "님이 경매에 참여하였습니다.");
                notification.setUserId(boardService.findPostById(boardId).getWriter());
                notification.setIsRead(false);
                notification.setBoardId(boardId);
                notificationMapper.insertNotification(notification);

                List<String> ids = auctionMapper.selectIdsByAuctionId(findAuctionId.getAuctionId());

                // 경매 참여자에게 전달
                for (String id : ids) {

                    notification.setUserId(id);
                    notificationMapper.insertNotification(notification);
                    notificationService.sendToClient(id, userId + "님이 경매에 참여하였습니다.");
                }

                // 본인에게 전달
                notificationService.sendToClient(userId, userId + "님이 경매에 참여하였습니다.");
                notification.setUserId(userId);
                notificationMapper.insertNotification(notification);
            }

            Participant_Auction participantAuction = new Participant_Auction();
            participantAuction.setAuctionId(findAuctionId.getAuctionId());
            participantAuction.setUserId(userId);

            return auctionMapper.insertAuctionParticipant(participantAuction);
        }
    }

    @Override
    public boolean findCurrentAuctionState(String userId, Integer boardId) {

        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("boardId", boardId);
        int cnt = auctionMapper.selectIsAuctionById(map);

        if (cnt >= 1) {
            return true;
        }

        return false;
    }

    @Override
    public int updateIsAuction(int auctionId) {
        return auctionMapper.updateIsAuction(auctionId);
    }

    @Override
    public List<AuctionDTO> getDeadlineList() {
        return auctionMapper.getDeadlineList();
    }

    @Override
    @Transactional
    public String auctionCancel(String userId, int auctionId) {
        try {
            Auction auction = new Auction();
            auction.setAuctionId(auctionId);
            auction.setUserId(userId);

            Participant_Auction participant = new Participant_Auction();
            participant.setAuctionId(auctionId);
            participant.setUserId(userId);

            auctionMapper.lockParticipant(participant);

            int n = auctionMapper.deleteParticipant(participant);

            if (n > 0) {
                int k = auctionMapper.selectParticipantCnt(auction);
                updateBeforeIsAuctionIfNeeded(k, auction);
                return "ok";
            } else {
                return "no";
            }
        } catch (Exception e) {
            System.err.println("경매 취소 중 오류 발생: " + e.getMessage());
            throw e;
        }
    }

    private void updateBeforeIsAuctionIfNeeded(int participantCount, Auction auction) {
        if (participantCount == 0) {
            auctionMapper.deleteAuction(auction);
        } else {
            auctionMapper.auctionCancel(auction);
            if (participantCount == 1) {
                String message = "경매전으로 변경되었습니다";
                notificationService.sendMessageAuctionUsers(auction.getAuctionId(), message);
                auctionMapper.updateBeforeIsAuction(auction);
            }
        }
    }

}
