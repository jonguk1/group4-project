package com.lend.shareservice.domain.user;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{

    private final UserMapper userMapper;


    @Override
    public List<User> userList() {
        return userMapper.userList();
    }

    @Override
    public String getUserId(String userId) {
        return userMapper.getUserId(userId);
    }

    @Override
    public int blockUser(String userId) {
        Block block = new Block();
        block.setBlockedUserId(userId);
        return userMapper.blockUser(block);
    }
}
