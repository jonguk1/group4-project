package com.lend.shareservice.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;

public class BanUserCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 세션에서 회원정보 조회
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        Boolean ban = (Boolean) session.getAttribute("ban");

        // 회원 정보 체크 및 리다이렉션 수행
        if (userId != null && ban) {
            session.invalidate();

            response.setContentType("text/html; charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_OK); // 상태 코드를 명시적으로 설정
            PrintWriter out = response.getWriter();
            out.write(
                    "<script>" +
                            "alert('영구정지를 당하였습니다.');" +
                            "window.location.href = '/login';" +
                            "</script>"
            );
            out.flush();
            out.close(); // 스트림을 닫아 데이터를 모두 전송
            return false; // 요청 처리 중지
        }

        return true; // 요청 계속 처리
    }
}
