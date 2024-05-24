package com.lend.shareservice.domain.user;




import com.lend.shareservice.entity.User;

import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyBoardDTO;
import com.lend.shareservice.web.user.dto.MyDetailDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import com.lend.shareservice.web.user.dto.UpdateUserDTO;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public interface UserService {

    MyDetailDTO findByUserDetail(String userId);

    List<MyLenderAndMyLendyDTO> findByLender(PagingDTO page, String userId);

    List<MyLenderAndMyLendyDTO> findByLendy(PagingDTO page, String userId);

    int getLenderCount(String userId);

    int getLendyCount(String userId);

    int blockUser(String userId, String writer);

    int updateUser(String userId,UpdateUserDTO updateUserDTO);

    boolean idCheck(String userId);

    User findUserById(String userId);

    int updateUserAddress(String userId, Double latitude, Double longitude);

    int deleteUser(String userId);

    int updateMoney(String userId,Integer money);


    List<MyBoardDTO> findByMyBoard(PagingDTO page, String userId);

    int getMyBoardCount(String userId);

}
