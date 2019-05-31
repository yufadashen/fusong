package com.intehel.common.util;



import java.net.URLEncoder;

/**
 * 拼接xml参数
 */
public class GetHttpString {

    /**
     *  输入参数，拼接成xml字符串
     * @param method    方法名
     * @param head    请求头
     * @param UpdateDateStart   时间段开始   20120101020202
     * @param UpdateDateEnd 时间段结束   20190718020202
     * @return
     */
    public static String xmlJson0(String method,String head,String UpdateDateStart,String UpdateDateEnd){
        UpdateDateEnd=UpdateDateEnd==null?"20190718020202":UpdateDateEnd;
        UpdateDateStart=UpdateDateStart==null?"20120101020202":UpdateDateStart;
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/"+method+"?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><"+head+"> <UpdateDateStart>"+
                            UpdateDateStart+"</UpdateDateStart><UpdateDateEnd>"+
                            UpdateDateEnd+" </UpdateDateEnd></"+
                            head+">","utf-8");
             str = HttpUtils.httpGet(strURL);
            System.err.println(str);

        }catch (Exception e){
            e.printStackTrace();
        }
        return str;
    }
    public static String xmlJson1(String method,String head,String body1Name,String body1Value,String UpdateDateStart,String UpdateDateEnd){
        UpdateDateEnd=UpdateDateEnd==null?"20190718020202":UpdateDateEnd;
        UpdateDateStart=UpdateDateStart==null?"20120101020202":UpdateDateStart;
        String str="";
        try {
//            "</UpdateDateStart><UpdateDateEnd>20190718020202 </UpdateDateEnd><EmplType></EmplType><DeptId>7936</DeptId></EmployeesRequest> "
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/"+method+"?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><"+head+"> <UpdateDateStart>"+
                            UpdateDateStart+"</UpdateDateStart><UpdateDateEnd>"+
                            UpdateDateEnd+" </UpdateDateEnd><EmplType></EmplType><"+body1Name+">"+body1Value+"</"+body1Name+"></"+
                            head+">","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);

        }catch (Exception e){
            e.printStackTrace();
        }
        return str;
    }

}
