package com.intehel.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    /**
     * date格式化yyyyMMddHHmmss
     * 返回当前时间
     */
    public static String ymdhms(){
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式

        return df.format(new Date());
    }
    /**
     * date格式化yyyyMMddHHmmss
     * 入参yyyyMMddHHmmss或yyyy-MM-dd HH:mm:ss
     * 返回指定时间时间
     */
    public static String ymdhms1(String date){
        date=date.replace("-","").replace(":","").replace(" ","");
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
        return df.format(date);
    }
    /**
     * date格式化yyyyMMdd
     * 返回当前时间yyyyMMdd
     */
    public static String ymd(){
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
        return df.format(new Date());
    }
    /**
     * date格式化yyyyMMdd
     * 入参yyyyMMdd或yyyy-MM-dd
     * 返回当前时间yyyyMMdd
     */
    public static String ymd1(String date){
        date=date.replace("-","");
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
        return df.format(date);
    }
}
