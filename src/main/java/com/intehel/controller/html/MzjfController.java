package com.intehel.controller.html;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MzjfController {

    @RequestMapping(value = "/mzjf/mzjf2.html",method = RequestMethod.GET)
    public String mzjf2() {
        return "templates/mzjf/mzjf2";
    }

//    @RequestMapping(value = "/main/main.html",method = RequestMethod.GET)
//    public String mains() {
//        System.err.println(123);
//        return "templates/main/main";
//    }
//
//    @RequestMapping(value = "/main/readcard.html",method = RequestMethod.GET)
//    public String readcard() {
//        System.err.println(123);
//        return "templates/main/readcard";
//    }

}
