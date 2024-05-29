package com.lend.shareservice.interceptor;

import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.domain.user.vo.UserVo;
import com.lend.shareservice.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LoginCheckInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                                Object handler) throws Exception{
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
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

}
