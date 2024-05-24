package com.lend.shareservice.domain.notification;

import com.lend.shareservice.domain.auction.AuctionMapper;
import com.lend.shareservice.entity.Notification;
import com.lend.shareservice.web.notification.dto.NotificationDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationServiceImpl implements NotificationService{

    private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;
    private final NotificationMapper notificationMapper;
    private final EmitterRepository emitterRepository;
    private final AuctionMapper auctionMapper;

    public SseEmitter subscribe(String userId) {
        SseEmitter emitter = createEmitter(userId);

        sendToClient(userId, "first message");
        return emitter;
    }
    @Override
    public void noti(String id, Object data) {
        sendToClient(id, data);
    }

    private SseEmitter createEmitter(String userId) {
        SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
        emitterRepository.save(userId, emitter);

        // Emitter가 완료될 때(모든 데이터가 성공적으로 전송된 상태) Emitter를 삭제한다.
        emitter.onCompletion(() -> emitterRepository.deleteById(userId));
        // Emitter가 타임아웃 되었을 때(지정된 시간동안 어떠한 이벤트도 전송되지 않았을 때) Emitter를 삭제한다.
        emitter.onTimeout(() -> emitterRepository.deleteById(userId));

        return emitter;
    }

    public void sendToClient(String id, Object data) {
        SseEmitter emitter = emitterRepository.get(id);
        log.info("emitter = {}", emitter);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().id(String.valueOf(id)).name("auction").data(data));
            } catch (IOException exception) {
                emitterRepository.deleteById(id);
                emitter.completeWithError(exception);
            }
        }
    }
    @Override
    public List<NotificationDTO> findNotificationByUserId(String userId) {

        List<Notification> findNotifications = notificationMapper.selectNotificationsByUserId(userId);

        List<NotificationDTO> findNotificationDTOS = new ArrayList<>();
        for (Notification findNotification : findNotifications) {
            findNotificationDTOS.add(new NotificationDTO(findNotification.getNotiId(), findNotification.getUserId(), findNotification.getContent(), findNotification.getNotiRegDate(), findNotification.getBoardId()));
        }

        return findNotificationDTOS;
    }


    // 특정 경매방에 있는 유저들에게 특정 메세지를 보냄
    public void sendMessageAuctionUsers(Integer auctionId, String message) {

        List<String> auctionMembers = auctionMapper.selectIdsByAuctionId(auctionId);

        // 특정 경매방에 참여자들에게 실시간 메시지를 보냄
        for (String auctionMember : auctionMembers) {
            sendToClient(auctionMember, message);

            // 알림 저장
            Integer boardId = auctionMapper.selectBoardId(auctionId);
            Notification notification = new Notification(auctionMember, message, false, boardId);
            insertNotification(notification);
        }

    }

    // 알림 삭제
    @Override
    public int deleteNotification(Integer notiId) {
        return notificationMapper.deleteNotification(notiId);
    }

    // 알림 등록
    @Override
    public int insertNotification(Notification notification) {
        return notificationMapper.insertNotification(notification);
    }
}
