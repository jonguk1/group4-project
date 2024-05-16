package com.lend.shareservice.domain.user;




import com.lend.shareservice.entity.User;

import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public interface UserService {

    List<User> userList();

    String getUserId(String userId);

    List<MyLenderAndMyLendyDTO> lenders(PagingDTO page, String userId);

    List<MyLenderAndMyLendyDTO> lendys(PagingDTO page, String userId);

    int getLenderCount(String userId);

    int getLendyCount(String userId);

    int blockUser(String userId);
}
