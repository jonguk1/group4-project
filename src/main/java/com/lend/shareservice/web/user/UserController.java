package com.lend.shareservice.web.user;

import com.lend.shareservice.domain.user.UserService;

import com.lend.shareservice.domain.user.service.UserSignupService;
import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.User;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;


import java.util.List;

@Controller
@Slf4j
@AllArgsConstructor
public class UserController {


    private final UserService userService;

    private final UserSignupService userSignupService;



    @GetMapping("/user")
    public String userList(Model model){

        List<User> userList = userService.userList();

        model.addAttribute("userList",userList);

        return "jspp/myDetail";

    }

    @GetMapping("/test")
    public String test(@SessionAttribute(name="userId", required = false)String userId, Model model) {

        UserVo user = userSignupService.getUserAccount(userId);

        if(user ==null){
            return "redirect:/login";
        }

        model.addAttribute("user",user);


        return "jspp/logintest";
    }

    @GetMapping("/login")
    public String loginForm(){
        return "jspp/login";
    }

    @PostMapping("/login")
    @ResponseBody
    public UserVo login(HttpServletRequest request, Model model) {

        model.addAttribute("loginType", "session-login");
        model.addAttribute("pageName", "세션 로그인");
        //1.회원정보 조회
        String userId =request.getParameter("userId");
        String pw =request.getParameter("pw");
        UserVo user = userSignupService.logiin(userId,pw);

        //2. 세션에 회원정보 저장 , 세션 유지 시간 설정
        if(user != null){
            request.getSession().invalidate();
            HttpSession session = request.getSession(true);  // Session이 없으면 생성
            // 세션에 userId를 넣어줌
            session.setAttribute("userId", user.getUserId());
            session.setMaxInactiveInterval(1800); // Session이 30분동안 유지
        }

        return user;

    }
    //로그아웃
    @PostMapping("/logout")
    public String logout(HttpServletRequest request, Model model){
        model.addAttribute("loginType", "session-login");
        model.addAttribute("pageName", "세션 로그인");

        HttpSession session = request.getSession(false);  // Session이 없으면 null return
        if(session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }




    //회원가입 페이지 출력
    @GetMapping("/user/signup")
    public String userSignupForm(){
        return "jspp/signup";
    }




    //회원가입 진행
    @PostMapping("/user/signup")
    public String signup(UserVo userVo){
        System.out.println("userVo = " + userVo);
        userSignupService.joinUser(userVo);


        return "redirect:/login";
    }




}


