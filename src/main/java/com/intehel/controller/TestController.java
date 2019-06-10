package com.intehel.controller;

import com.intehel.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

    @Autowired
    TestService testService;
    @ResponseBody
    @RequestMapping(value = "/Test01",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String Test01(){

        String str=testService.test();
        return null;
    }

}
