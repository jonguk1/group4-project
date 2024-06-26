package com.lend.shareservice.domain.user;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.Review;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    public int updateMoney(String userId,Integer money) {
        User user = new User();
        user.setUserId(userId);
        user.setMoney(money);
        return userMapper.updateMoney(user);
    }

    @Override
    public List<MyBoardDTO> findByMyBoard(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return userMapper.findByMyBoard(map);
    }

    @Override
    public int getMyBoardCount(String userId) {
        return userMapper.getMyBoardCount(userId);
    }


    @Override
    public int blockUser(String userId, String writer) {
        Block block = new Block(userId, writer);
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

    @Override
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
    public List<MyLenderAndMyLendyDTO> findByLender(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return userMapper.findByLender(map);
    }

    @Override
    public List<MyLenderAndMyLendyDTO> findByLendy(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return userMapper.findByLendy(map);
    }

    @Override
    public int getLenderCount(String userId) {
        return userMapper.getLenderCount(userId);
    }

    @Override
    public int getLendyCount(String userId) {
        return userMapper.getLendyCount(userId);
    }

    @Override
    public List<ReviewDTO> getReviewsByUserId(String userId) {

        List<Review> reviews = userMapper.selectReviewsByUserId(userId);
        List<ReviewDTO> reviewDTOS = new ArrayList<>();
        for (Review review : reviews) {
            reviewDTOS.add(new ReviewDTO(review.getReviewee()));
        }

        return reviewDTOS;
    }
}