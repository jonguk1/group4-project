package com.lend.shareservice;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
public class CustomInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }


    // 로그인 상태에 따른 처리를 하기 위함
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (modelAndView != null) {
            if (userId != null) {
                // 로그인한 경우
                modelAndView.addObject("userId", userId);
                modelAndView.addObject("loggedIn", true);
            } else {
                // 로그인하지 않은 경우
                modelAndView.addObject("loggedIn", false);
            }
        }
    }

}
