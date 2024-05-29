package com.lend.shareservice;


import com.lend.shareservice.domain.block.BlockMapper;
import com.lend.shareservice.domain.block.BlockService;
import com.lend.shareservice.domain.block.BlockServiceImpl;
import com.lend.shareservice.interceptor.AdminCheckImterceptor;
import com.lend.shareservice.interceptor.BanUserCheckInterceptor;
import com.lend.shareservice.interceptor.LoginCheckInterceptor;
import com.lend.shareservice.web.board.interceptor.BlockedUserInterceptor;
import lombok.RequiredArgsConstructor;

import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.interceptor.AdminCheckImterceptor;
import com.lend.shareservice.interceptor.BanUserCheckInterceptor;
import com.lend.shareservice.interceptor.LoginCheckInterceptor;
import com.lend.shareservice.interceptor.LoginPatternCheckInterceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {
    private final BlockService blockService;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**")
                .addResourceLocations("file:src/main/resources/static/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns("/user/**", "/review/**", "/auction/**", "/favorite/**", "/board/boardForm",
                        "/chat/**", "/chatList/**", "/user/signup", "/board/editForm")
                .excludePathPatterns("/user/signup", "/user/idCheck");
        registry.addInterceptor(new LoginPatternCheckInterceptor())
                .addPathPatterns("/user/**", "/review/**", "/auction/**", "/favorite/**", "/chatList/**")
                .excludePathPatterns("/user/signup", "/user/{userId}", "/user/idCheck");

        registry.addInterceptor(new BanUserCheckInterceptor())
                .addPathPatterns("/user/**", "/board/**", "/chat/**");

        registry.addInterceptor(new AdminCheckImterceptor())
                .addPathPatterns("/report/**");

        registry.addInterceptor(new BlockedUserInterceptor(blockService))
                .addPathPatterns("/board");

    }
}