package com.lend.shareservice.config;

import com.lend.shareservice.interceptor.LoggerInterceptor;
import com.lend.shareservice.interceptor.LoginCheckInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(new LoggerInterceptor())
                .excludePathPatterns("/css/**", "/images/**", "/js/**");

        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns("/test")
                .excludePathPatterns("/log*");

    }
}
