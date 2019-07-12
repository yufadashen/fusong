package com.intehel.controller.html;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CxymController {

    @RequestMapping(value = "/cxym/cxzyInfo_b.html",method = RequestMethod.GET)
    public String cxzyInfo_b() {
        return "templates/cxym/cxzyInfo_b";
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
