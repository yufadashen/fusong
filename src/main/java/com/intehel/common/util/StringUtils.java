package com.intehel.common.util;

public class StringUtils {

    private static String str="";
    public static String stringArrar(String arrar){
        String[] strings=arrar.replace("{","").replace("}","").replace("[","").replace("]","").split(",");
        for (String st:strings) {
            str=str+"<string>"+st+"</string>";
        }
        return str;
    }

   /* public static void main(String[] args) {
        String[] s={"1","2","3","4"};
        System.err.println(stringArrar(s));
    }*/
}
