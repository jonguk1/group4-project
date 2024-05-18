package com.lend.shareservice.web.user;

import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.domain.user.UserService;

import com.lend.shareservice.domain.user.service.UserSignupService;
import com.lend.shareservice.domain.user.util.CommonUtil;
import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.user.dto.MyDetailDTO;
import com.lend.shareservice.web.user.dto.UpdateUserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.user.dto.MyLenderAndMyLendyDTO;
import lombok.AllArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.bind.annotation.RequestParam;




import java.util.List;

@Controller
@AllArgsConstructor
public class UserController {


    private final UserService userService;

    private final UserSignupService userSignupService;

    private final AddressService addressService;

    @Autowired
    private CommonUtil util;



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
        String userId = request.getParameter("userId");
        String pw = request.getParameter("pw");
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
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, Model model){
        model.addAttribute("loginType", "session-login");
        model.addAttribute("pageName", "세션 로그인");

        HttpSession session = request.getSession(false);  // Session이 없으면 null return
        if(session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }



    @GetMapping("/user/{userId}/lender")
    public String lenderList(Model model,
                             PagingDTO page,
                             @PathVariable("userId") String userId,
                             @RequestParam(defaultValue = "1") int pageNum) {

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

    @GetMapping("/user/{userId}/lendy")
    public String lendyList(Model model,
                             PagingDTO page,
                             @PathVariable("userId") String userId,
                             @RequestParam(defaultValue = "1") int pageNum) {

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
    @GetMapping("/user/idCheck")
    public String idCheckForm(){

        return "jspp/idCheck";
    }

    @PostMapping("/user/idCheck")
    public String idCheckEnd(Model model, @RequestParam(defaultValue = "")String userId){
        if(userId.isBlank()){
            return util.addMsgBack(model,"아이디를 입력해야 해요");
        }
        boolean isUse=userService.idCheck(userId);
        String msg=(isUse)? userId+"는 사용 가능합니다":userId+"는 이미 사용 중 입니다";
        String result=(isUse)?"ok":"fail";
        model.addAttribute("msg",msg);
        model.addAttribute("result",result);
        model.addAttribute("uid",userId);

        return "jspp/idCheckResult";
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

    //내 정보
    @GetMapping("/user/{userId}")
    public String myDetail(Model model,
                           @PathVariable("userId")String userId){



        MyDetailDTO details=userService.findByUserDetail(userId);

        if(details.getLatitude()!=null && details.getLongitude()!=null){
            details.setAddress(addressService.getAddressFromLatLng(details.getLatitude(),details.getLongitude()));
        }else{
            details.setAddress("");
        }

        model.addAttribute("details",details);

        return "jspp/myDetail";
    }

    //내 정보 수정페이지 이동
    @GetMapping("/user/{userId}/edit")
    public String editUser(Model model,
                           @PathVariable("userId")String userId){

        MyDetailDTO edit = userService.findByUserDetail(userId);

        if(edit.getLatitude()!=null && edit.getLongitude()!=null){
            edit.setAddress(addressService.getAddressFromLatLng(edit.getLatitude(),edit.getLongitude()));
        }else{
            edit.setAddress("");
        }

        model.addAttribute("edit",edit);

        return "jspp/editUser";
    }

    @PutMapping("/user/{userId}")
    public ResponseEntity<String> updateUser(@PathVariable("userId") String userId,
                                             @Valid @RequestBody UpdateUserDTO updateUserDTO,
                                             BindingResult bindingResult){
        // 만약 유효성 검사에서 오류가 발생한 경우
        if (bindingResult.hasErrors()) {
            // 각 필드에 대한 오류 메시지를 응답으로 반환
            StringBuilder errorMessage = new StringBuilder("입력한 데이터가 유효하지 않습니다:\n");
            for (FieldError error : bindingResult.getFieldErrors()) {
                errorMessage.append(error.getDefaultMessage()).append("\n");
            }
            return ResponseEntity.badRequest().body(errorMessage.toString());
        }
        System.out.println(updateUserDTO.getName());


        int n=userService.updateUser(userId,updateUserDTO);

        if(n>0){
            return ResponseEntity.ok("ok");
        }

        return ResponseEntity.ok("no");
    }

}


