package com.lend.shareservice.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public String test() {
        return "/test";
    }

    @GetMapping("/itemDetail")
    public String itemDetail() {
        return "/jspp/itemDetail";
    }

    @GetMapping("/itemList")
    public String itemList() {
        return "/jspp/itemList";
    }

    @GetMapping("/myAuction")
    public String myAuction() {
        return "/jspp/myAuction";
    }

    @GetMapping("/myDetail")
    public String myDetail() {
        return "/jspp/myDetail";
    }

    @GetMapping("/myInterest")
    public String myInterest() {
        return "/jspp/myInterest";
    }

    @GetMapping("/chatRoom")
    public String newProj(){
        return "/Chatting/chatRoom";
    }
}
