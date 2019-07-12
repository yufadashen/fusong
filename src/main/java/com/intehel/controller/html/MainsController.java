package com.intehel.controller.html;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class MainsController {

    @RequestMapping(value = "/homePage.html",method = RequestMethod.GET)
    public String tohomePage() {
        System.err.println(123);
        return "templates/main/homePage";
    }

    @RequestMapping(value = "/main/main.html",method = RequestMethod.GET)
    public String mains() {
        System.err.println(123);
        return "templates/main/main";
    }

    @RequestMapping(value = "/main/readcard.html",method = RequestMethod.GET)
    public String readcard() {
        System.err.println(123);
        return "templates/main/readcard";
    }
 @RequestMapping(value = "/main/error.html",method = RequestMethod.GET)
    public String error() {
        System.err.println(123);
        return "templates/main/error";
    }

}
