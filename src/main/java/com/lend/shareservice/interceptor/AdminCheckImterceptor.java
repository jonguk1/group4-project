package com.lend.shareservice.interceptor;

import com.lend.shareservice.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;

public class AdminCheckImterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception{

        //1. 세션에 회원정보 조회
        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("userId");
        Boolean authorization = (Boolean)session.getAttribute("authorization");

        if (userId == null || authorization == null || !authorization) {
            response.setContentType("text/html; charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_OK); // 상태 코드를 명시적으로 설정
            PrintWriter out = response.getWriter();
            out.write(
                    "<script>" +
                            "alert('관리자 권한만 입장 가능합니다.');" +
                            "window.location.href = '/login';" +
                            "</script>"
            );
            out.flush();
            out.close(); // 스트림을 닫아 데이터를 모두 전송

            return false; // 요청 처리를 중단하고 리디렉션
        }
        return true;

    }


}
