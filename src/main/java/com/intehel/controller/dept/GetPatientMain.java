package com.intehel.controller.dept;

import com.intehel.common.util.GetHttpString;
import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.util.Map;

@Controller
public class GetPatientMain {


    @ResponseBody
    @RequestMapping(value = "/FindPatient",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String FindPatient(String Create,String Name,String PapersNo,String PapersType,String PhoneNo,String Gender,
            String BirthDate) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/FindPatient?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?> <PatientRequest><Create>" +
                            Create +"</Create> <PatientInfo> <Name>" +
                            Name +"</Name>  <PapersNo>" +
                            PapersNo +"</PapersNo> <PapersType>" +
                            PapersType +"</PapersType><PhoneNo>" +
                            PhoneNo +"</PhoneNo> <Gender>" +
                            Gender +"</Gender><BirthDate>" +
                            BirthDate +"</BirthDate></PatientInfo></PatientRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
        }
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }
}
