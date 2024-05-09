package com.lend.shareservice.web.notification;

import com.lend.shareservice.domain.notification.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
    private static int cnt = 1;
    @GetMapping(value = "/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe() {
        String id;
        if (cnt == 1) {
            id = "hong";

        } else {
            id = "hang";
        }
        cnt++;
        return notificationService.subscribe(id);
    }

    @PostMapping("/send-data")
    public void sendData() {
        notificationService.noti("hong", "경매 버튼을 눌렀습니다 ㅋㅋ");
        notificationService.noti("hang", "경매 버튼을 눌렀습니다 ㅋㅋ");
    }
}
