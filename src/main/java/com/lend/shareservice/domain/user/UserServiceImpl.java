package com.lend.shareservice.domain.user;

import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService{

    private final UserMapper userMapper;


    @Override
    public List<User> userList() {
        return userMapper.userList();
    }

    @Override
    public String getUserId(String userId)
    {
        return userMapper.getUserId(userId);
    }

    @Override
    public UserVo login(String userId, String pw){
        log.info("============ user login service");
        UserVo readUser = userMapper.getUserAccount(userId);

        if(readUser !=null){
            if(readUser.getPw().equals(pw)){
                return readUser;
            }
        }

        return null;
    }

    @Override
    public UserVo get(String param){
        log.info("============= member get service");
        UserVo readUser = userMapper.getUserAccount(param);
        if(readUser !=null){
            return readUser;
        }
        return null;
    }



}
