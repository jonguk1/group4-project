package com.lend.shareservice.domain.user;

import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.user.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {

    UserVo getUserAccount(String userId);

    void saveUser(UserVo userVo);

    int blockUser(Block block);

    List<MyLenderAndMyLendyDTO> findByLender(Map<String, Object> map);

    List<MyLenderAndMyLendyDTO> findByLendy(Map<String, Object> map);

    int getLenderCount(String userId);

    int getLendyCount(String userId);

    MyDetailDTO findByUserDetail(String userId);

    int updateUser(UpdateUserDTO updateUserDTO);

    int updateUserAddress(UpdateUserAddressDTO updateUserAddressDTO);

    int updateMoney(User user);

    int deleteUser(String userId);

    List<MyBoardDTO> findByMyBoard(Map<String, Object> map);

    int getMyBoardCount(String userId);

    int idCheck(String userId);

    User selectUserById(String userId);
}
