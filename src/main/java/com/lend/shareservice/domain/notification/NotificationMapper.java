package com.lend.shareservice.domain.notification;

import com.lend.shareservice.entity.Notification;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NotificationMapper {
    void insertNotification(Notification notification);

    List<Notification> selectNotificationsByUserId(String userId);

    int deleteNotification(Integer notiId);
}
