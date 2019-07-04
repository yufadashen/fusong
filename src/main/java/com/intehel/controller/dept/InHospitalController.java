package com.intehel.controller.dept;


import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 住院
 */
@Controller
public class InHospitalController {

    @Value("${hisUrl}")
    private String hisUrl="http://192.9.10.42:10110";
    /**
     * 查询住院流水号
     * @param InpatientNo   住院号
//     * @param Name  患者姓名
//     * @param BirthDate 出生日期
//     * @param PapersType    证件类型
//     * @param PapersNo  证件号
//     * @param PhoneNo   电话号
//     * @param Gender    性别
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetInPatientSeriNos",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetInPatientSeriNos(String InpatientNo) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetInPatientSeriNos?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<GetInpatientSeriNoRequest>" +
                            "<HospId/>" +
                            "<InpatientNo>" +InpatientNo+"</InpatientNo>" +
                            "<PatientInfo>" +
                            "<BirthDate></BirthDate>" +
                            "<Gender>0</Gender>" +
                            "<Name></Name>" +
                            "<PapersNo></PapersNo>" +
                            "<PapersType>1</PapersType>" +
                            "<PhoneNo></PhoneNo>" +
                            "</PatientInfo>" +
                            "</GetInpatientSeriNoRequest>","utf-8");
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
     * 查询住院费用明细列表
     * @param InpatientSeriNo   住院流水号
     * @param UpdateDateStart   时间段开始
     * @param UpdateDateEnd 时间段结束
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetInpatientFeeList",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetInpatientFeeList(String InpatientSeriNo,String UpdateDateStart,String UpdateDateEnd) {
        System.err.println("123InpatientSeriNo="+InpatientSeriNo+"   UpdateDateStart="+UpdateDateStart+"   UpdateDateEnd"+UpdateDateEnd);

        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetInpatientFeeList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                            "<InpatientFeesRequest>\n" +
                            "<HospId/>" +
                            "<InpatientSeriNo>" +InpatientSeriNo+"</InpatientSeriNo>"+
                            "<UpdateDateStart>" +UpdateDateStart+"</UpdateDateStart>" +
                            "<UpdateDateEnd>"+UpdateDateEnd +"</UpdateDateEnd>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key>x</Key>" +
                            "<Value/>" +
                            "</ExtItem>" +
                            "</ExtParams>" +
                            "</InpatientFeesRequest>","utf-8");
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
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str.replace("xsi:nil=\"true\"",""));


        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


    /**
     *  缴纳住院预交金（住院押金）
     * @param InpatientSeriNo   住院流水号
     * @param PaymentWay    支付方式ID
     * @param SettleDate    第三方清算日期
     * @param TotalFee  支付费用总额
     * @param TradeSerialNumber 第三方交易流水号
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/InpatientFeePrepay",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String InpatientFeePrepay(String InpatientSeriNo,String PaymentWay,String SettleDate,String TotalFee,String TradeSerialNumber) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/InpatientFeePrepay?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<InpatientFeePrepayRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId/>" +
                            "<AppId>100734</AppId>"+
                            "<InpatientSeriNo>" +InpatientSeriNo+"</InpatientSeriNo>" +
                            "<PaymentWay>"+PaymentWay+"</PaymentWay>" +
                            "<SettleDate>" +SettleDate+ "</SettleDate>" +
                            "<TermialType>1</TermialType>" +
                            "<TotalFee>"+TotalFee+"</TotalFee>" +
                            "<TradeSerialNumber>"+TradeSerialNumber +"</TradeSerialNumber>" +
                            "</InpatientFeePrepayRequest>","utf-8");
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
     * 查询缴纳住院预交金历史
     * @param InpatientSeriNo   住院流水号
     * @param InpatientNo   住院号
     * @param DateStart 查询日期开始(闭区间) 格式 yyyyMMdd
     * @param DateEnd   查询日期结束(闭区间) 格式 yyyyMMdd
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetFeePrepayRecord",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetFeePrepayRecord(String InpatientSeriNo,String InpatientNo,String DateStart,String DateEnd) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetFeePrepayRecord?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                            "<FeePrepayRecordRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId/>" +
                            "<DateEnd/>" +
                            "<DateStart/>" +
                            "<InpatientNo/>" +
                            "<InpatientSeriNo/>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key>x</Key>" +
                            "<Value />" +
                            "</ExtItem>" +
                            "</ExtParams>" +
                            "</FeePrepayRecordRequest>","utf-8");
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
     * 获取住院信息
     * @param InpatientSeriNos  住院流水号集合
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetInpatientDetail",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetInpatientDetail(String InpatientSeriNos) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetInpatientDetail?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                            "<InpatientDetailRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId/>" +
                            "<InpatientSeriNos>" +
                            "<string>"+InpatientSeriNos+"</string>" +
                            "</InpatientSeriNos>" +
                            "</InpatientDetailRequest>","utf-8");
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






}
