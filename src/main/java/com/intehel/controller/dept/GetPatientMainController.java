package com.intehel.controller.dept;


import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSON;
import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import com.intehel.service.GetPatientMainService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Value;
import java.net.URLEncoder;
import java.util.*;

@Controller
public class GetPatientMainController {
    Logger logger = Logger.getLogger(this.getClass().getName());
    @Autowired
    GetPatientMainService getPatientMainService;

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

    @Value("${hisUrl}")
    private String hisUrl="http://192.9.10.42:10110";
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/FindPatient",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String FindPatient(String Name,String PapersNo,String PapersType,String PhoneNo,String Gender,
                              String BirthDate) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/FindPatient?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?> <PatientRequest><Create>1</Create> <PatientInfo> <Name>" +
                            Name +"</Name>  <PapersNo>" +
                            PapersNo +"</PapersNo> <PapersType>" +
                            PapersType +"</PapersType><PhoneNo>" +
                            PhoneNo +"</PhoneNo> <Gender>" +
                            Gender +"</Gender><BirthDate>" +
                            BirthDate +"</BirthDate></PatientInfo></PatientRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            logger.info("获取患者门诊信息"+str);
            System.err.println(strURL);
//            System.err.println("123"+str);
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
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        //插入数据库
        System.err.println(map.get("Code").toString());
        if (map.get("Code").equals("0")){
            getPatientMainService.createUser(map,Name);
        }
        System.err.println(JSONUtils.toJSONString(map));

//        return
//        return JsonUtil.toString(map);
        return JSON.toJSONString(map);

//        return "11";
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
    @CrossOrigin
    @RequestMapping(value = "/GetOutpatientCardInfos",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetOutpatientCardInfos(String CardType,String CardNo,String Password,String Name,String PapersNo,String PapersType,String PhoneNo,int Gender,
                              String BirthDate) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetOutpatientCardInfos?xmltxt="+
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
