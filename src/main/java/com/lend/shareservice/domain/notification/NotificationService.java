package com.lend.shareservice.domain.notification;

import com.lend.shareservice.web.notification.dto.NotificationDTO;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

public interface NotificationService {
    SseEmitter subscribe(String id);

    void noti(String id, Object data);

    public void sendToClient(String id, Object data);

    List<NotificationDTO> findNotificationByUserId(String userId);
}
