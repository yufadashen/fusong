package com.intehel.controller.html;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MzghController {

    @RequestMapping(value = "/mzgh/ghkebie.html",method = RequestMethod.GET)
    public String ghkebie() {
        return "templates/mzgh/ghkebie";
    }


    @RequestMapping(value = "/mzgh/ghdoctor2.html",method = RequestMethod.GET)
    public String ghdoctor2() {
        return "templates/mzgh/ghdoctor2";
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
