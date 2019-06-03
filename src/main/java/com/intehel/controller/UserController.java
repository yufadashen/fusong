package com.intehel.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.intehel.model.User;

@Controller
public class UserController {

	@GetMapping("/")
    public String index(Model model) {
        model.addAttribute("info", "user/list");
        return "index";
    }

    @GetMapping("/user")
    public String hehe(Model model) {
        model.addAttribute("user", new User(UUID.randomUUID().toString(), "yizhiwazi", "20170928",new Date()));
        return "user";
    }

    @GetMapping("/user/list")
    public String userlist(Model model) {
        List<User> userList = new ArrayList<>();
        User u = new User();
        u.setUserId("123");
        u.setUsername("zs");
        u.setPassword("asd");
        u.setCreated(new Date());
        userList.add(u);
        
//        userList.add(new User(UUID.randomUUID().toString(), "yizhiwazi", "20170928",new Date()));
//        userList.add(new User(UUID.randomUUID().toString(), "kumamon", "123456",new Date()));
//        userList.add(new User(UUID.randomUUID().toString(), "admin", "admin",new Date()));
        model.addAttribute("userList", userList);
        return "userList";
    }
	
	
}
