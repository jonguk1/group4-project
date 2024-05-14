package com.lend.shareservice.interceptor;

import com.lend.shareservice.domain.user.vo.UserVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{

        //1. 세션에 회원정보 조회
        HttpSession session = request.getSession();
        UserVo user = (UserVo) session.getAttribute("loginUser");
        
        //2. 회원 정보 체크
        if(user == null){
            response.sendRedirect("/login");
            return false;

        }

        return HandlerInterceptor.super.preHandle(request, response, handler);
        
    }
}
