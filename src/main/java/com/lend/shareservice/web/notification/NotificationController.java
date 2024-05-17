package com.lend.shareservice.web.notification;

import com.lend.shareservice.domain.notification.NotificationService;
import com.lend.shareservice.web.notification.dto.NotificationDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class NotificationController {

    private final NotificationService notificationService;
    private static int cnt = 1;
    @GetMapping(value = "/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe(HttpServletRequest request) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        return notificationService.subscribe(userId);
    }

    @PostMapping("/send-data")
    public void sendData() {

    }

    @GetMapping("/notification")
    public ResponseEntity<List<NotificationDTO>> getNotifications(HttpServletRequest request) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        List<NotificationDTO> notifications = notificationService.findNotificationByUserId(userId);
        log.info("notifications = {}", notifications);
        return ResponseEntity.ok(notifications);
    }
}
