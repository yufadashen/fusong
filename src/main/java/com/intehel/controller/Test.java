package com.intehel.controller;

import com.intehel.entity.User;
import com.intehel.service.CallerService;
import com.intehel.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class Test {
    @Autowired
    TestService testService;

    @GetMapping("/test")
    public String test(Model model){
        List list = testService.getuser();
        model.addAttribute("list",list);
        return "index";
    }
    @GetMapping("/add")
    public String add(Model model, User user){
        user.setUserId("mysq.nextval");
        user.setUsername("aaa");
        user.setPassword("aaa");
        user.setCreated(new Date());
        testService.adduser(user);
        return "";
    }
}
