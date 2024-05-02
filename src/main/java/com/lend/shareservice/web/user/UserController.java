package com.lend.shareservice.web.user;

import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/user")
    public String userList(Model model){

        List<User> userList = userService.userList();

        model.addAttribute("userList",userList);

        return "jspp/myDetail";

    }

}
