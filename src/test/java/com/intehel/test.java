package com.intehel;


import com.alibaba.fastjson.JSONObject;
import com.intehel.common.util.GetHttpString;
import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.dom4j.*;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

public class test {

    public static void main(String[] args) throws Exception {
      /*  String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetDepts?xmltxt="+
               URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><DeptsRequest> <UpdateDateStart>20160521094932</UpdateDateStart><UpdateDateEnd>20190718020202 </UpdateDateEnd></DeptsRequest>","utf-8");
//        String str = HttpUtils.httpGet(strURL);//
        String str=GetHttpString.xmlJson0("GetDepts","DeptsRequest","20160521094932","20190718020202");
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));*/

        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
        System.out.println(df.format(new Date()));
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, 7);
        System.err.println(df.format(cal.getTime()));

    }




}
