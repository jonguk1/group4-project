package com.lend.shareservice.interceptor;

import com.lend.shareservice.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AdminCheckImterceptor implements HandlerInterceptor {


    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler, ModelAndView modelAndView) throws Exception{

        //1. 세션에 회원정보 조회
        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("userId");
        Boolean authorization = (Boolean)session.getAttribute("authorization");

//        if(userId !=null && !authorization){
//            session.removeAttribute("userId");
//            response.sendRedirect("/login");
//        }

    }
}
