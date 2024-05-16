package com.lend.shareservice.domain.notification;

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

    public SseEmitter subscribe(String userId) {
        SseEmitter emitter = createEmitter(userId);

        sendToClient(userId, "EventStream Created. [userId=" + userId + "]");
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
            findNotificationDTOS.add(new NotificationDTO(findNotification.getNotiId(), findNotification.getUserId(), findNotification.getContent(), findNotification.getNotiRegDate()));
        }

        return findNotificationDTOS;
    }
}
