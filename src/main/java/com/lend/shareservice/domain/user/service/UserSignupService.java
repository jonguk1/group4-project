package com.lend.shareservice.domain.user.service;

import com.lend.shareservice.domain.user.UserMapper;
import com.lend.shareservice.domain.user.vo.UserVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserSignupService {

    private final UserMapper userMapper;


    @Transactional
    public void joinUser(UserVo userVo) {
        userMapper.saveUser(userVo);
    }


    public UserVo logiin(final String userId, final String pw) {


        UserVo readUser = userMapper.getUserAccount(userId);

        if (readUser != null) {
            if (readUser.getPw().equals(pw)) {
                return readUser;
            }
        }

        return null;
    }

    public UserVo getUserAccount(String userId) {
        return userMapper.getUserAccount(userId);
    }
}
