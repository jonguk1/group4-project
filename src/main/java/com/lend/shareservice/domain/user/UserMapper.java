package com.lend.shareservice.domain.user;

import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {

    UserVo getUserAccount(String userId);

    void saveUser(UserVo userVo);

    List<User> userList();

    String getUserId(String userId);


    int blockUser(Block block);

    List<MyLenderAndMyLendyDTO> lenders(Map<String, Object> map);

    List<MyLenderAndMyLendyDTO> lendys(Map<String, Object> map);

    int getLenderCount(String userId);

    int getLendyCount(String userId);

}
