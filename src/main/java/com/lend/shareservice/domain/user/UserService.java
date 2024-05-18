package com.lend.shareservice.domain.user;




import com.lend.shareservice.entity.User;

import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyDetailDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import com.lend.shareservice.web.user.dto.UpdateUserDTO;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public interface UserService {

    MyDetailDTO findByUserDetail(String userId);

    List<MyLenderAndMyLendyDTO> lenders(PagingDTO page, String userId);

    List<MyLenderAndMyLendyDTO> lendys(PagingDTO page, String userId);

    int getLenderCount(String userId);

    int getLendyCount(String userId);

    int blockUser(String userId);

    int updateUser(String userId,UpdateUserDTO updateUserDTO);

    int updateUserAddress(String userId, Double latitude, Double longitude);

    User findUserById(String userId);

    int deleteUser(String userId);

}
