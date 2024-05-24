package com.lend.shareservice.interceptor;

import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                                Object handler) throws Exception{

        //1. 세션에 회원정보 조회
        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("userId");
        Boolean ban = (Boolean)session.getAttribute("ban");

        //2. 회원 정보 체크
        if(userId == null){
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }


}
