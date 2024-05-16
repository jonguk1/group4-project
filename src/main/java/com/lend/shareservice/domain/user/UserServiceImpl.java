package com.lend.shareservice.domain.user;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public boolean idCheck(String userId) {
        int n=userMapper.idCheck(userId);

        return (n>0)? false: true;
    }


    @Override
    public List<MyLenderAndMyLendyDTO> lenders(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return userMapper.lenders(map);
    }

    @Override
    public List<MyLenderAndMyLendyDTO> lendys(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return userMapper.lendys(map);
    }

    @Override
    public int getLenderCount(String userId) {
        return userMapper.getLenderCount(userId);
    }

    @Override
    public int getLendyCount(String userId) {
        return userMapper.getLendyCount(userId);
    }

}
