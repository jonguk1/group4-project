package com.lend.shareservice.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LoginPatternCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception{

        String userId = extractUserIdFromRequest(request.getRequestURI());

        HttpSession session = request.getSession();
        String sessionUserId = (String) session.getAttribute("userId");

        if (userId != null && !userId.equals(sessionUserId)) {
            response.setContentType("text/html; charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_OK);
            PrintWriter out = response.getWriter();
            out.write(
                    "<script>" +
                            "alert('회원만 입장 가능합니다.');" +
                            "window.location.href = '/login';" +
                            "</script>"
            );
            out.flush();
            out.close();
            return false;
        }
        return true;
    }

    private String extractUserIdFromRequest(String requestUri) {
        // 요청된 URL에서 / 다음에 오는 문자열을 userId로 간주하여 추출
        Pattern pattern = Pattern.compile("/[^/]+/([^/]+?)(?:/|$)");
        Matcher matcher = pattern.matcher(requestUri);

        if (matcher.find()) {
            // 세션 문자열을 디코딩하여 추출
            String sessionString = matcher.group(1);
            try {
                String decodedSessionString = URLDecoder.decode(sessionString, "UTF-8");
                return decodedSessionString;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        } else {
            return null;
        }
    }
}
