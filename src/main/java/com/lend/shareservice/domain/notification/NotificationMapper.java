package com.lend.shareservice.domain.notification;

import com.lend.shareservice.entity.Notification;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NotificationMapper {
    void insertNotification(Notification notification);
}
