package com.intehel.controller.dept;

import com.intehel.common.util.*;
import com.intehel.service.OccupyRegPointService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;


@Controller
public class GetRegistrationController {
    Logger logger = Logger.getLogger(this.getClass().getName());
    @Value("${hisUrl}")
    private String hisUrl="http://192.9.10.42:10110";

    /**
     * 微信查询是否已支付
     * @param RegNo 挂号流水号
     * @param Fee   金额
     * @param RecipeNos 门诊号集合
     * @param InpatientSeriNo 住院流水号
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/WxIsFee",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String WxIsFee(String RegNo,String RecipeNos,String InpatientSeriNo,String Fee) {
        //挂号
        if (RegNo!=null||RecipeNos==null){
           int a= occupyRegPointService.selectGH(RegNo,Fee);
        }else if (RegNo!=null||RecipeNos!=null){

            //门诊
        }else if (InpatientSeriNo!=null){

            //住院
        }
        return "";
    }




    /**
     * 查询排班数据
     * @param OperatorType  坐诊类型    0:科室； 1:医生；空值：查询全部
     * @param DeptId    科室ID
//     * @param DrId  医生ID
     * @param day   查询天数
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetSchedules",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetSchedules(String OperatorType,String DeptId,Integer day) {
        //获取当前时间
        logger.info("查询排班信息");
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
        Date date=new Date();
        String DateStart=df.format(date)+"000000";// new Date()为获取当前系统时间
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, day);//获取day天的排班信息
        String DateEnd = df.format(cal.getTime())+"000000";
        String str="";
        System.err.println(DateStart);
        System.err.println(DateEnd);
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetSchedules?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><ScheduleRequest>" +
                            "<OperatorType>"+OperatorType+"</OperatorType>" +
                            "<DeptId>"+DeptId+"</DeptId>" +
                            "<DrId></DrId><RegLevel></RegLevel>" +
                            "<DateStart>"+DateStart+"</DateStart>" +
                            "<DateEnd>"+DateEnd+"</DateEnd></ScheduleRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            logger.info("查询排班信息"+str);
            System.err.println(strURL);
//            System.err.println(str);
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
        logger.info("查询排班信息");
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


    /**
     * 占用号点
     * 功能：患者占用HIS系统中的号点。
     //* @param ScheduleTime  号点时间
     * @param ScheduleId    号点Id
     * @param OutpatientId  患者ID
     * @param RegLevelId    挂号级别
     * @param DeptId    科室Id
     * @param VisitTime 期望看诊时间
//     * @param PresentHistory    现病史
//     * @param PastMedHistory    既往史
//     * @param AllergicHistory   过敏史
//     * @param InfectiousDisease 传染病及流行病学史
//     * @param GeneticDisease    个人及遗传病家族史
     * @return
     */
    @Autowired
    OccupyRegPointService occupyRegPointService;

    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/OccupyRegPoint",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String OccupyRegPoint(String ScheduleTime,String ScheduleId,String OutpatientId,String RegLevelId,String DeptId,
                                 String VisitTime) {
        if (VisitTime==null){VisitTime="";}
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/OccupyRegPoint?xmltxt=" +
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><AppointmentRequest>" +
                    "<ScheduleTime>"+ScheduleTime+"</ScheduleTime>" +
                    "<ScheduleId>"+ScheduleId+"</ScheduleId>" +
                    "<OutpatientId>"+OutpatientId+"</OutpatientId>" +
                    "<RegLevelId>"+RegLevelId+"</RegLevelId>" +
                    "<DeptId>"+DeptId+"</DeptId>" +
                    "<VisitTime>"+VisitTime+"</VisitTime>" +
                    "<PresentHistory></PresentHistory>" +
                    "<PastMedHistory></PastMedHistory>" +
                    "<AllergicHistory></AllergicHistory>" +
                    "<InfectiousDisease></InfectiousDisease>" +
                    "<GeneticDisease></GeneticDisease>" +
                    "</AppointmentRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(str);
            System.err.println(strURL);
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
        if (map.get("Code").toString().equals("0")) {
            occupyRegPointService.createReg(map, ScheduleTime, ScheduleId, OutpatientId, RegLevelId, DeptId);
        }
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 释放号点
     * @param RegNo 挂号流水号
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReleaseRegPoint",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReleaseRegPoint(String RegNo) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/ReleaseRegPoint?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><ReleaseRegRequest>" +
                            "<RegNo>"+RegNo+"</RegNo></ReleaseRegRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
//            System.err.println(str);
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
     * 支付挂号费
     * 功能：支付成功后，更新挂号的支付状态。
     * @param RegNo 挂号流水号
//     * @param TermialType   终端ID
   //  * @param AppId     操作员编号
     * @param SettleDate    第三方清算日期
     * @param TradeSerialNumber 第三方交易流水号
//     * @param PaymentWay    支付类型ID
//     * @param PactCode
//     * @param PactName
//     * @param PaykindCode
//     * @param CardNo
//     * @param TRANSNO
//     * @param SiInmainifoList
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/PayForAppointment",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String PayForAppointment(String RegNo,String Fee,String SettleDate,String TradeSerialNumber) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/PayForAppointment?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                    "<RegPaymentRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                    "<HospId/>" +
                            "<AppId>100734</AppId>"+
                            "<Fee>"+Fee+"</Fee>"+
                            "<PaymentWay>12</PaymentWay>" +
                            "<RegNo>"+RegNo+"</RegNo>" +
                            "<SettleDate>"+SettleDate+"</SettleDate>" +
                            "<TermialType>自助机支付</TermialType>" +
                            "<TradeSerialNumber>"+TradeSerialNumber+"</TradeSerialNumber>" +
                    "<ExtParams>" +
                    "        <ExtItem>" +
                    "            <Key></Key>" +
                    "            <Value />" +
                    "        </ExtItem>" +
                    "    </ExtParams>" +
                    "</RegPaymentRequest>","utf-8");

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
     * 查询看诊状态
     * 功能：门诊挂号看诊信息表，主要用于APP端进行患者爽约等判断，增加患者挂号的黑名单等。
     * 暂时没有功能，待修改
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetPatientIsSee",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetPatientIsSee(String RegNos) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetPatientIsSee?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
                            "<VisitInfoRequest>" +
                            "<RegNos>" +
                                    StringUtils.stringArrar(RegNos)+
                            "</RegNos>" +
                            "</VisitInfoRequest> ","utf-8");
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
     * 查询挂号信息
     * @param RegNos    挂号流水号
     * @param OutpatientIds 患者id
     * @param RegDateStart 挂号日期开始（闭区间）
     * @param RegDateEnd    挂号日期结束（闭区间）
     * @param IsNiox    是否从大象就医挂号
     * @param IsSee 是否已就诊
     * @param UpdateDateStart
     * @param UpdateDateEnd
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetRegInfos",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetRegInfos(String RegNos,String OutpatientIds,String RegDateStart,String RegDateEnd,String IsNiox,String IsSee,String UpdateDateStart,String UpdateDateEnd) {
        String str="";
        if (IsNiox==null){IsNiox="";}
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetRegInfos?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                    "<RegInfosRequest>" +
                    "<HospId/>" +
                    "<IsSee>"+IsSee +"</IsSee>"+
                    "<IsNiox>"+IsNiox +"</IsNiox>" +
                    "<OutpatientIds>"+StringUtils.stringArrar(OutpatientIds)+"</OutpatientIds>" +
                    "<RegNos>"+StringUtils.stringArrar(RegNos)+"</RegNos>"+
                            "<UpdateDateStart>20120101</UpdateDateStart>" +
                            "<UpdateDateEnd>"+DateUtil.ymd() +"</UpdateDateEnd>" +
                            "<RegDateStart>"+RegDateStart+"</RegDateStart>" +
                            "<RegDateEnd>"+RegDateEnd+"</RegDateEnd>" +
                    "<ExtParams>" +
                    "<ExtItem>" +
                    "<Key></Key>" +
                    "<Value/>" +
                    "</ExtItem>" +
                    "</ExtParams>" +
                    "</RegInfosRequest>","utf-8");

            System.err.println(strURL);
            str = HttpUtils.httpGet(strURL);

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
     * 挂号支付对账
     * 功能：挂号支付对账,查询门诊流水号的支付状态
     * @param RegNo 挂号流水号
     * @param Fee   支付金额
     * @return
     */
//<?xml version="1.0" encoding="utf-8"?><RegInfosRequest><RegNos>6118003</RegNos><OutpatientIds>0051522299</OutpatientIds><RegDateStart>20190602</RegDateStart><RegDateEnd>20190606</RegDateEnd><IsNiox></IsNiox><IsSee>false</IsSee><UpdateDateStart>20120101</UpdateDateStart><UpdateDateEnd>20190605</UpdateDateEnd></RegInfosRequest>
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReconReg",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReconReg(String RegNo,int Fee) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/ReconReg?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
                            "<ReconRegRequest>" +
                            "<RegNo>"+RegNo+"</RegNo>" +
                            "<Fee>"+Fee+"</Fee>" +
                            "</ReconRegRequest>","utf-8");
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
     * 退号
     * @param RegNo
     * @return
     */
   @ResponseBody
   @CrossOrigin
    @RequestMapping(value = "/AbortReg",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String AbortReg(String RegNo) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/AbortReg?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
                            "<AbortRegRequest><RegNo>"+RegNo+"</RegNo></AbortRegRequest>","utf-8");
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
}
