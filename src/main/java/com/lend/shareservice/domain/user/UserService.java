package com.lend.shareservice.domain.user;


import com.lend.shareservice.entity.User;

import java.util.List;

public interface UserService {

    List<User> userList();

    String getUserId(String userId);

}
