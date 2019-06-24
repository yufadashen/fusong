package com.intehel;

import org.springframework.boot.web.servlet.ServletComponentScan;

import javax.servlet.annotation.WebServlet;

public class test01 {

//    @ServletComponentScan
//    @WebServlet(urlPatterns = "*.jsp",name = "JspServlet")
//    public class JspServlet extends org.apache.jasper.servlet.JspServlet{
//    }
public static void main(String[] args) {
   int a=1;
   if(a==0){
        System.out.println(0);
   }else  if(a==1){
       System.out.println(1);
   }else  if(a==2){
       System.out.println(2);
   }else {
       System.out.println(3);
   }
   System.out.println(4);
}

}
