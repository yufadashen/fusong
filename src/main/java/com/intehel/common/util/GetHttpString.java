//package com.intehel.common.util;
//
//
//
//import org.springframework.beans.factory.annotation.Value;
//
//import java.net.URLEncoder;
//
///**
// * 拼接xml参数
// */
//public class GetHttpString {
//    @Value("${hisUrl}")
//    private  String hisUrl="http://172.9.10.42:10110";
//    /**
//     *  输入参数，拼接成xml字符串
//     * @param method    方法名
//     * @param head    请求头
//     * @param UpdateDateStart   时间段开始   20120101020202
//     * @param UpdateDateEnd 时间段结束   20190718020202
//     * @return
//     */
//    public static String xmlJson0(String method,String head,String UpdateDateStart,String UpdateDateEnd){
//        GetHttpString getHttpString=new GetHttpString();
//        UpdateDateEnd=UpdateDateEnd==null?"20190718020202":UpdateDateEnd;
//        UpdateDateStart=UpdateDateStart==null?"20120101020202":UpdateDateStart;
//        String str="";
//
//        try {
//            String strURL=getHttpString.hisUrl+"/ServiceForXml.asmx/"+method+"?xmltxt="+
//                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><"+head+"> <UpdateDateStart>"+
//                            UpdateDateStart+"</UpdateDateStart><UpdateDateEnd>"+
//                            UpdateDateEnd+" </UpdateDateEnd></"+
//                            head+">","utf-8");
//            System.err.println(str);
//            System.err.println(strURL);
//             str = HttpUtils.httpGet(strURL);
//
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return str;
//    }
//
//}
