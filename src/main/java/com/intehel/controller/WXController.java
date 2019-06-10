package com.intehel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class WXController {
    //http://boyi.natapp1.cc/WXtest


    @ResponseBody
    @RequestMapping(value = "/WXtest",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetNoonInfos(HttpServletRequest request, HttpServletResponse response) {
        String authType = request.getAuthType();
        System.err.println("微信回调成功："+authType);

        return null;
    }


}
