package com.lend.shareservice.domain.user;

import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.user.dto.MyDetailDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import com.lend.shareservice.web.user.dto.UpdateUserAddressDTO;
import com.lend.shareservice.web.user.dto.UpdateUserDTO;
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

    int idCheck(String userId);

    int updateUserAddress(UpdateUserAddressDTO updateUserAddressDTO);

    int updateMoney(User user);

    int deleteUser(String userId);

    User selectUserById(String userId);
}
