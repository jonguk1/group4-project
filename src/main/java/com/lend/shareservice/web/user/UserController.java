package com.lend.shareservice.web.user;

import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.domain.user.service.UserSignupService;
import com.lend.shareservice.entity.User;
import lombok.AllArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


import java.util.List;

@Controller
@AllArgsConstructor
public class UserController {


    private final UserService userService;
    @Autowired
    UserSignupService userSignupService;



    @GetMapping("/user")
    public String userList(Model model){

        List<User> userList = userService.userList();

        model.addAttribute("userList",userList);

        return "jspp/myDetail";

    }



    //회원가입 페이지 출력
    @GetMapping("/user/signup")
    public String userSignupForm(){
        return "jspp/signup";
    }
    //회원가입 진행
    @PostMapping("/user/signup")
    public String signup(UserVo userVo){

        System.out.println("UserController.signup");
        System.out.println("userVo = " + userVo);
        userSignupService.joinUser(userVo);






        return "test";
    }

}

}

