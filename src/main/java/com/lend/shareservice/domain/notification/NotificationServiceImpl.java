package com.lend.shareservice.domain.notification;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;

@Service
@RequiredArgsConstructor
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

    private SseEmitter createEmitter(String id) {
        SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
        emitterRepository.save(id, emitter);

        // Emitter가 완료될 때(모든 데이터가 성공적으로 전송된 상태) Emitter를 삭제한다.
        emitter.onCompletion(() -> emitterRepository.deleteById(id));
        // Emitter가 타임아웃 되었을 때(지정된 시간동안 어떠한 이벤트도 전송되지 않았을 때) Emitter를 삭제한다.
        emitter.onTimeout(() -> emitterRepository.deleteById(id));

        return emitter;
    }



    private void sendToClient(String id, Object data) {
        SseEmitter emitter = emitterRepository.get(id);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().id(String.valueOf(id)).name("sse").data(data));
            } catch (IOException exception) {
                emitterRepository.deleteById(id);
                emitter.completeWithError(exception);
            }
        }
    }



}
