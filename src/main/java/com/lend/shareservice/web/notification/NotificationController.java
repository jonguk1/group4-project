package com.lend.shareservice.web.notification;

import com.lend.shareservice.domain.notification.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
}
