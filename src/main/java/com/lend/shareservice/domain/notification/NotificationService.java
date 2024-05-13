package com.lend.shareservice.domain.notification;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

public interface NotificationService {
    SseEmitter subscribe(String id);

    void noti(String id, Object data);

    public void sendToClient(String id, Object data);
}
