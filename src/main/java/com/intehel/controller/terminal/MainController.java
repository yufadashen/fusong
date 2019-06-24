package com.intehel.controller.terminal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {


    //进入终端页面
    @RequestMapping("tbmain")
    public String toLogin() {
        return "jsp/main/main";
    }


}
