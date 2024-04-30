package com.lend.shareservice.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public String test() {
        return "/test";
    }

    @GetMapping("/chatRoom")
    public String newProj(){
        return "/chatRoom";
    }

}
