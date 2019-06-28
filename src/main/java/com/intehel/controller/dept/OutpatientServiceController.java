package com.intehel.controller.dept;

import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.StringUtils;
import com.intehel.common.util.XmlJsonUtils;
import com.intehel.dao.PayForRecipesMapper;
import com.intehel.service.PatientFeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class OutpatientServiceController {



    @Autowired
    PatientFeeService patientFee;

    /**
     * 查询门诊费用
     * @param RegNos    挂号流水号集合
//     * @param RecipeNos 处方号集合
     * @param OutpatientIds 患者门诊ID集合
//     * @param VisitDateStart 就诊日期开始（闭区间）
//     * @param VisitDateEnd  就诊日期结束（闭区间）
//     * @param UpdateDateStart   根据最后更新时间查询数据，时间段开始
//     * @param UpdateDateEnd 根据最后更新时间查询数据，时间段结束
//     * @param InvoiceNo 发票号
//     * @param ExecStatus    执行状态    0 未执行 1 已执行 null 查询全部
//     * @param SysType   费用大类    0 非药品 1 药品 null 查询全部
     * @param PaymentStatus 支付状态    0: "未支付"; 1: "已支付";2: "已退费"; 3: "部分退费"; 4: "金额错误";5: ”已取消” null 查询全部
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetOutpatientFeeList",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetOutpatientFeeList(String RegNos,String OutpatientIds,
                                       String PaymentStatus) {
        //获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
        Date date=new Date();
        String DateStart=df.format(date)+"000000";// new Date()为获取当前系统时间
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, 1);//获取day天的排班信息
        String DateEnd = df.format(cal.getTime())+"000000";
        String str="";
        System.err.println(DateStart);
        System.err.println(DateEnd);
        if(PaymentStatus==null){PaymentStatus="";}

        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetOutpatientFeeList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><OutpatientFeeRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><HospId />" +
                            "<RegNos><string>"+RegNos+"</string></RegNos>" +
                            "<RecipeNos><string></string></RecipeNos>" +
                            "<OutpatientIds><string>"+OutpatientIds+"</string></OutpatientIds>" +
                            "<VisitDateStart>"+df.format(date)+"</VisitDateStart>" +
                            "<VisitDateEnd>"+df.format(cal.getTime())+"</VisitDateEnd>" +
                            "<UpdateDateStart>"+DateStart+"</UpdateDateStart>" +
                            "<UpdateDateEnd>"+DateEnd+"</UpdateDateEnd>" +
                            "<InvoiceNo /><ExecStatus>0</ExecStatus><SysType xsi:nil=\"true\" />" +
                            "<PaymentStatus>"+PaymentStatus+"</PaymentStatus></OutpatientFeeRequest>","utf-8");
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
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        if (!map.get("Departments").equals("[]")){
        patientFee.createPatient(map);}
        return JsonUtil.toString(map);
    }

    /**
     * 根据门诊id查询门诊费用
     * @param RegNos    挂号流水号集合
//     * @param RecipeNos 处方号集合
     * @param OutpatientIds 患者门诊ID集合
//     * @param VisitDateStart 就诊日期开始（闭区间）
//     * @param VisitDateEnd  就诊日期结束（闭区间）
//     * @param UpdateDateStart   根据最后更新时间查询数据，时间段开始
//     * @param UpdateDateEnd 根据最后更新时间查询数据，时间段结束
//     * @param InvoiceNo 发票号
//     * @param ExecStatus    执行状态    0 未执行 1 已执行 null 查询全部
//     * @param SysType   费用大类    0 非药品 1 药品 null 查询全部
     * @param PaymentStatus 支付状态    0: "未支付"; 1: "已支付";2: "已退费"; 3: "部分退费"; 4: "金额错误";5: ”已取消” null 查询全部
     * @return
     */

    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetOutpatientIdFeeList",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetOutpatientIdFeeList(String OutpatientIds,String PaymentStatus) {
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
        Date date=new Date();
        String DateStart=df.format(date)+"000000";// new Date()为获取当前系统时间
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, 1);//获取day天的排班信息
        String DateEnd = df.format(cal.getTime())+"000000";
        String str="";
        System.err.println(DateStart);
        System.err.println(DateEnd);
        if(PaymentStatus==null){PaymentStatus="";}
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetOutpatientIdFeeList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><OutpatientIdFeeRequest>" +
                            "<OutpatientIds><string>"+OutpatientIds+"</string></OutpatientIds>" +
                            "<VisitDateStart>"+df.format(date)+"</VisitDateStart>" +
                            "<VisitDateEnd>"+df.format(cal.getTime())+"</VisitDateEnd>" +
                            "<UpdateDateStart>"+DateStart+"</UpdateDateStart>" +
                            "<UpdateDateEnd>"+DateEnd+"</UpdateDateEnd>" +
                                    "<InvoiceNo /><ExecStatus>0</ExecStatus><SysType>0</SysType>" +
                                    "<PaymentStatus>"+PaymentStatus+"</PaymentStatus>"+
                            "</OutpatientIdFeeRequest>","utf-8");
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
        Object departments = map.get("Departments");
        List<Map> listUser = (List<Map>)departments;
        Set<String> set=new HashSet();
        for (Map map1:listUser) {
            set.add(map1.get("RegNo").toString());
        }
        Map<String,Object> map2 = new HashMap<>();
        for (String st:set) {
            List list = new ArrayList();
            System.out.println(st);
            for (Map map1:listUser) {
                if (map1.get("RegNo").toString().equals(st)){
                    System.out.println(map1.get("RegNo"));
                    list.add(map1);
                }
                map2.put(st,list);
            }
        }
        map.put("Departments",map2);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }
//<?xml version="1.0" encoding="utf-8"?><OutpatientIdFeeRequest><RegNos><string></string></RegNos><RecipeNos><string></string></RecipeNos><OutpatientIds><string>0051522340</string></OutpatientIds><VisitDateStart>20190625</VisitDateStart><VisitDateEnd>20190626</VisitDateEnd><UpdateDateStart>20190625000000</UpdateDateStart><UpdateDateEnd>20190626000000</UpdateDateEnd><InvoiceNo /><ExecStatus>0</ExecStatus><SysType>1</SysType><PaymentStatus>0</PaymentStatus></OutpatientIdFeeRequest>

    /**
     * 支付门诊费
     //* @param AppId
     * @param RegNo 挂号流水号
     * @param RecipeNos  处方号，支持多个处方批量支付
     * @param TotalFee  处方费用总额
     * @param TradeSerialNumber 第三方交易流水号
     * @param PaymentWay    支付类型ID
     * @param SettleDate    第三方清算日期
     * @return
     */
    @Autowired
    PayForRecipesMapper payForRecipesMapper;
    @ResponseBody
    @CrossOrigin

    @RequestMapping(value = "/PayForRecipes",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String PayForRecipes(String RegNo,String RecipeNos,String TotalFee,String TradeSerialNumber,
                                         String PaymentWay,String SettleDate,String pay,String outTradeNo) {
        System.err.println("进入接口"+RegNo);
        Double Fee=Double.parseDouble(TotalFee)/100;
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/PayForRecipes?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?><PayForRecipesRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><AppId>100734</AppId><HospId/>" +
                            "<PaymentWay>" +PaymentWay+"</PaymentWay>" +
                                "<RecipeNos>"+StringUtils.stringArrar(RecipeNos)+"</RecipeNos>" +
                            "<RegNo>"+RegNo+"</RegNo>" +
                            "<SettleDate>" +SettleDate+"</SettleDate>" +
                            "<TermialType/>" +
                            "<TotalFee>" +Fee+"</TotalFee>" +
                            "<TradeSerialNumber>"+TradeSerialNumber +"</TradeSerialNumber>" +
                            "<ExtParams><ExtItem><Key>x</Key><Value /></ExtItem></ExtParams></PayForRecipesRequest>","utf-8");
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
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        if (map.get("Code").equals("0")){
            payForRecipesMapper.updatePat(RegNo,"12",TotalFee,SettleDate,TradeSerialNumber,new Date(),pay,outTradeNo);
//            patientFee.updatePay(RegNo,RecipeNos,TotalFee,TradeSerialNumber,PaymentWay,SettleDate,pay);
        }

        return JsonUtil.toString(map);
    }


    /**
     * 门诊支付对账
     * 功能：门诊费用支付状态检查，对账
     * @param RegNo 挂号流水号
     * @param RecipeNos 处方号，支持多个处方批量支付
     * @param TotalFee  处方费用总额
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReconRecipes",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReconRecipes(String RegNo,String RecipeNos,String TotalFee) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/ReconRecipes?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
                            "<ReconRecipesRequest>" +
                            "<RegNo>"+RegNo+"</RegNo>" +
                            "<RecipeNos>"+RecipeNos+"</RecipeNos>" +
                            "<TotalFee>"+TotalFee+"</TotalFee>" +
                            "</ReconRecipesRequest>","utf-8");
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
     * 没用
     * 获取门诊队列排队信息
     * @param OutpatientIds 患者门诊ID集合
     * @param SeqNos    患者手中的流水号集合（挂号流水号、处方流水号等）
     * @param ExecDeptId    执行科室ID
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetQueueInfo",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetQueueInfo(String OutpatientIds,String SeqNos,String ExecDeptId) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetQueueInfo?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
                            "<QueInfoRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
                            "<HospId/>" +
                            "<OutpatientIds>" +
                            StringUtils.stringArrar(OutpatientIds) +
                            "</OutpatientIds>" +
                            "<SeqNos>" +
                            StringUtils.stringArrar(SeqNos) +
                            "</SeqNos>" +
                            "<ExecDeptId>"+ ExecDeptId+"</ExecDeptId>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key></Key>"+
                            "<Value />" +
                            "</ExtItem>" +
                            "</ExtParams>" +
                            "</QueInfoRequest>","utf-8");

            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


}
