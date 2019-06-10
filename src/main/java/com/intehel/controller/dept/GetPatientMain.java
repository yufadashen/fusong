package com.intehel.controller.dept;


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


    /**
     * 获取患者门诊信息
//     * @param Create 是否自动创建 默认false  查询无结果的话是否自动创建并返回新创建的outpatientId
     * @param Name  患者姓名
     * @param PapersNo 证件号
     * @param PapersType    证件类型
     * @param PhoneNo 电话号
     * @param Gender    性别
     * @param BirthDate 出生日期
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/FindPatient",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String FindPatient(String Name,String PapersNo,String PapersType,String PhoneNo,int Gender,
                              String BirthDate) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/FindPatient?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?> <PatientRequest><Create>1</Create> <PatientInfo> <Name>" +
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
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (str==null){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }else if (str.length()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 绑定就诊实体卡卡号
     * @param CardType  实体卡类型
     * @param CardNo    实体卡号
     * @param Password  卡密码
     * @param Name  患者姓名
     * @param PapersNo  证件号
     * @param PapersType    证件类型
     * @param PhoneNo   电话号
     * @param Gender    性别
     * @param BirthDate 出生日期
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetOutpatientCardInfos",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetOutpatientCardInfos(String CardType,String CardNo,String Password,String Name,String PapersNo,String PapersType,String PhoneNo,int Gender,
                              String BirthDate) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetOutpatientCardInfos?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><OutpatientCardRequest>" +
                            "<CardType>"+CardType+"</CardType> " +
                            "<CardNo>"+CardNo+"</CardNo>" +
                            "<Password>"+Password+" </Password> <PatientInfo>" +
                            "<Name>"+Name+"</Name>" +
                            "<PapersNo>"+PapersNo+"</PapersNo>" +
                            "<PapersType>"+PapersType+"</PapersType>" +
                            "<PhoneNo>"+PhoneNo+"</PhoneNo>" +
                            "<Gender>"+Gender+"</Gender>" +
                            "<BirthDate>"+BirthDate+"</BirthDate> </PatientInfo></OutpatientCardRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (str==null){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }else if (str.length()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }
    //<?xml version="1.0" encoding="utf-8"?><OutpatientCardRequest><CardType>99</CardType> <CardNo>0051186435</CardNo><Password> </Password> <PatientInfo><Name>李兴家3</Name><PapersNo>211422199304273536</PapersNo><PapersType>1</PapersType><PhoneNo>15140245620</PhoneNo><Gender>2</Gender><BirthDate>19930427</BirthDate> </PatientInfo></OutpatientCardRequest>
}
