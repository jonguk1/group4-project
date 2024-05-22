package com.lend.shareservice.domain.user;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyDetailDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import com.lend.shareservice.web.user.dto.UpdateUserAddressDTO;
import com.lend.shareservice.web.user.dto.UpdateUserDTO;
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
    public User findUserById(String userId) {
        return userMapper.selectUserById(userId);
    }

    @Override
    public int deleteUser(String userId) {
        return userMapper.deleteUser(userId);
    }


    @Override
    public int blockUser(String userId) {
        Block block = new Block();
        block.setBlockedUserId(userId);
        return userMapper.blockUser(block);
    }

    @Override
    public int updateUser(String userId,UpdateUserDTO updateUserDTO) {
        updateUserDTO.setUserId(userId);
        return userMapper.updateUser(updateUserDTO);
    }

    @Override

    public boolean idCheck(String userId) {
        int n=userMapper.idCheck(userId);

        return (n>0)? false: true;
    }

    public int updateUserAddress(String userId, Double latitude, Double longitude) {
        UpdateUserAddressDTO updateUserAddressDTO = new UpdateUserAddressDTO();
        updateUserAddressDTO.setUserId(userId);
        updateUserAddressDTO.setLatitude(latitude);
        updateUserAddressDTO.setLongitude(longitude);
        return userMapper.updateUserAddress(updateUserAddressDTO);

    }


    @Override
    public MyDetailDTO findByUserDetail(String userId) {
        return userMapper.findByUserDetail(userId);
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