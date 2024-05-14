package com.lend.shareservice.domain.user;




import com.lend.shareservice.entity.User;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public interface UserService {

    List<User> userList();

    String getUserId(String userId);



}
