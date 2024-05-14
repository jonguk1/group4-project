package com.lend.shareservice.domain.user.service;

import com.lend.shareservice.domain.user.UserMapper;
import com.lend.shareservice.domain.user.vo.UserVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserSignupService {


    @Autowired
    UserMapper userMapper;

    @Transactional
    public void joinUser(UserVo userVo) {


        userMapper.saveUser(userVo);


    }
}
