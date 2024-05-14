package com.lend.shareservice.web.user;

import com.lend.shareservice.domain.user.UserService;

import com.lend.shareservice.domain.user.service.UserSignupService;
import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.User;



import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

import lombok.extern.slf4j.Slf4j;


import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import lombok.AllArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.bind.annotation.RequestParam;




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



    @GetMapping("/user/{user_id}/lender")
    public String lenderList(Model model,
                             PagingDTO page,
                             @PathVariable("user_id") String userId,
                             @RequestParam(defaultValue = "1") int pageNum) {

        userId=userService.getUserId(userId);

        int totalCount = userService.getLenderCount(userId);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<MyLenderAndMyLendyDTO> lenders= userService.lenders(page,userId);

        String loc ="/user/"+userId+"/lender";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("lenders",lenders);
        model.addAttribute("userId",userId);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);


        return "jspp/myLender";
    }

    @GetMapping("/user/{user_id}/lendy")
    public String lendyList(Model model,
                             PagingDTO page,
                             @PathVariable("user_id") String userId,
                             @RequestParam(defaultValue = "1") int pageNum) {

        userId=userService.getUserId(userId);


        int totalCount = userService.getLendyCount(userId);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<MyLenderAndMyLendyDTO> lendys= userService.lendys(page,userId);

        String loc ="/user/"+userId+"/lendy";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("lendys",lendys);
        model.addAttribute("userId",userId);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);


        return "jspp/myLendy";
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


        return "test";
    }


    // 차단 등록
    @PostMapping("/user/{userId}/block")
    @ResponseBody
    public ResponseEntity<String> blockUser(@PathVariable("userId") String userId) {
        if (userService.blockUser(userId) > 0) {
            return ResponseEntity.ok("ok");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to block user.");
        }
    }
}


