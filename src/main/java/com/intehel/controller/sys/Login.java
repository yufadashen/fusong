package com.intehel.controller.sys;

import com.intehel.common.util.VerifyUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

@Controller
public class Login {
    //进入登陆页面
    @RequestMapping("tologin")
    public String toLogin() {
        return "sys/login";
    }


    //生成验证码
    @RequestMapping(value = "/getImg", method = {RequestMethod.POST, RequestMethod.GET})
    protected void createImg(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //1.生成随机的验证码及图片
        Object[] objs = VerifyUtil.createImage();
        //2.将验证码存入session
        String imgcode = (String) objs[0];
        HttpSession session = req.getSession();
        session.setAttribute("imgcode", imgcode);
        //3.将图片输出给浏览器
        BufferedImage img = (BufferedImage) objs[1];
        res.setContentType("image/png");
        //服务器自动创建输出流，目标指向浏览器
        OutputStream os = res.getOutputStream();
        ImageIO.write(img, "png", os);
        os.close();
    }

    //验证密码是否正确
    @RequestMapping("login")
    @ResponseBody
    public int Login(HttpServletRequest req,String username, String password, String captcha) {
        HttpSession   session   =   req.getSession();

        if (!username.equals("admin")){
            return 1;
        }else if (!password.equals("123456")){
            return 2;
        }else if (!captcha.toLowerCase().equals(session.getAttribute("imgcode").toString().toLowerCase())){
            return 3;
        }
        return 0;
    }

    //进入登陆页面
    @RequestMapping("tomain")
    public String toMain() {
        System.out.println();
        return "sys/main";
    }
}