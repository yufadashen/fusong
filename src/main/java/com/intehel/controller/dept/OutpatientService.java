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
public class OutpatientService {



//<?xml version="1.0" encoding="utf-8"?><OutpatientFeeRequest><RegNos></RegNos><RecipeNos></RecipeNos><OutpatientIds></OutpatientIds><VisitDateStart></VisitDateStart><VisitDateEnd></VisitDateEnd><UpdateDateStart></UpdateDateStart><UpdateDateEnd></UpdateDateEnd><InvoiceNo></InvoiceNo><ExecStatus>0</ExecStatus><SysType>0</SysType><PaymentStatus></PaymentStatus></OutpatientFeeRequest>

    /**
     * 查询门诊费用
     * @param RegNos    挂号流水号集合
     * @param RecipeNos 处方号集合
     * @param OutpatientIds 患者门诊ID集合
     * @param VisitDateStart 就诊日期开始（闭区间）
     * @param VisitDateEnd  就诊日期结束（闭区间）
     * @param UpdateDateStart   根据最后更新时间查询数据，时间段开始
     * @param UpdateDateEnd 根据最后更新时间查询数据，时间段结束
     * @param InvoiceNo 发票号
     * @param ExecStatus    执行状态    0 未执行 1 已执行 null 查询全部
     * @param SysType   费用大类    0 非药品 1 药品 null 查询全部
     * @param PaymentStatus 支付状态    0: "未支付"; 1: "已支付";2: "已退费"; 3: "部分退费"; 4: "金额错误";5: ”已取消” null 查询全部
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetOutpatientFeeList",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetOutpatientFeeList(String RegNos,String RecipeNos,String OutpatientIds,String VisitDateStart,String VisitDateEnd,
                                       String UpdateDateStart,String UpdateDateEnd,String InvoiceNo,String ExecStatus,String SysType,String PaymentStatus) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetOutpatientFeeList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><OutpatientFeeRequest>" +
                            "<RegNos><string>"+RegNos+"</string></RegNos>" +
                            "<RecipeNos><string>"+RecipeNos+"</string></RecipeNos>" +
                            "<OutpatientIds><string>"+OutpatientIds+"</string></OutpatientIds>" +
                            "<VisitDateStart>"+VisitDateStart+"</VisitDateStart>" +
                            "<VisitDateEnd>"+VisitDateEnd+"</VisitDateEnd>" +
                            "<UpdateDateStart>"+UpdateDateStart+"</UpdateDateStart>" +
                            "<UpdateDateEnd>"+UpdateDateEnd+"</UpdateDateEnd>" +
                            "<InvoiceNo>"+InvoiceNo+"</InvoiceNo>" +
                            "<ExecStatus>"+ExecStatus+"</ExecStatus>" +
                            "<SysType>"+SysType+"</SysType>" +
                            "<PaymentStatus>"+PaymentStatus+"</PaymentStatus>" +
                            "</OutpatientFeeRequest>","utf-8");

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


    /**
     * 根据门诊id查询门诊费用
     * @param RegNos    挂号流水号集合
     * @param RecipeNos 处方号集合
     * @param OutpatientIds 患者门诊ID集合
     * @param VisitDateStart 就诊日期开始（闭区间）
     * @param VisitDateEnd  就诊日期结束（闭区间）
     * @param UpdateDateStart   根据最后更新时间查询数据，时间段开始
     * @param UpdateDateEnd 根据最后更新时间查询数据，时间段结束
     * @param InvoiceNo 发票号
     * @param ExecStatus    执行状态    0 未执行 1 已执行 null 查询全部
     * @param SysType   费用大类    0 非药品 1 药品 null 查询全部
     * @param PaymentStatus 支付状态    0: "未支付"; 1: "已支付";2: "已退费"; 3: "部分退费"; 4: "金额错误";5: ”已取消” null 查询全部
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetOutpatientIdFeeList",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetOutpatientIdFeeList(String RegNos,String RecipeNos,String OutpatientIds,String VisitDateStart,String VisitDateEnd,
                                       String UpdateDateStart,String UpdateDateEnd,String InvoiceNo,String ExecStatus,String SysType,String PaymentStatus) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/GetOutpatientIdFeeList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><OutpatientFeeRequest>" +
                            "<RegNos>"+RegNos+"</RegNos>" +
                            "<RecipeNos>"+RecipeNos+"</RecipeNos>" +
                            "<OutpatientIds>"+OutpatientIds+"</OutpatientIds>" +
                            "<VisitDateStart>"+VisitDateStart+"</VisitDateStart>" +
                            "<VisitDateEnd>"+VisitDateEnd+"</VisitDateEnd>" +
                            "<UpdateDateStart>"+UpdateDateStart+"</UpdateDateStart>" +
                            "<UpdateDateEnd>"+UpdateDateEnd+"</UpdateDateEnd>" +
                            "<InvoiceNo>"+InvoiceNo+"</InvoiceNo>" +
                            "<ExecStatus>"+ExecStatus+"</ExecStatus>" +
                            "<SysType>"+SysType+"</SysType>" +
                            "<PaymentStatus>"+PaymentStatus+"</PaymentStatus>" +
                            "</OutpatientFeeRequest>","utf-8");
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


    @ResponseBody
    @RequestMapping(value = "/PayForRecipes",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String PayForRecipes(String AppId,String RegNo,String RecipeNo,String VisitDateStart,String VisitDateEnd,
                                         String UpdateDateStart,String UpdateDateEnd,String InvoiceNo,String ExecStatus,String SysType,String PaymentStatus) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/PayForRecipes?xmltxt="+
                    URLEncoder.encode("<PayForRecipesRequest>" +
                            "<AppId>"+AppId+"</AppId>" +
                            "<RegNo>"+RegNo+"</RegNo>" +
                            "<RecipeNos><RecipeDatail>" +
                                "<RecipeNo>"+RecipeNo+"</RecipeNo>" +
                                "<OWN_COST>0</OWN_COST>" +
                                "<PUB_COST>0</PUB_COST>" +
                                "<PAY_COST>0</PAY_COST>" +
                                "<TOTAL>45.12</TOTAL>" +
                            "</RecipeDatail></RecipeNos>" +
                            "<TotalFee>45.12</TotalFee>" +
                            "<TermialType>12</TermialType>" +
                            "<SettleDate>20180201183400</SettleDate>" +
                            "<TradeSerialNumber>1040108855</TradeSerialNumber>" +
                            "<PaymentWay>12</PaymentWay>" +
                            "<PactCode>02</PactCode>" +
                            "<PactName>市医保</PactName>" +
                            "<PaykindCode>2</PaykindCode>" +
                            "<TRANSNO>业务周期号</TRANSNO>" +
                            "<SiInmainifoList>16332.84#0.0#0.0#0.0#0.0#0.0#0.0#0.0#0.00#0.00#0.00#0.00#0.00#0.00####0.0#0.0#0.0#1.0#0.0#0.00#0.00#0.00#0.00###1.0#0.0#1.0#0.0#0.00#0.0#0.00#0.0#0.0#0.0#0.0#0.0#0.0#0.7#^11#11#0#0#0#0#11#^11.00^11.00^0.00^0.00^0.00^0.00^0.00^11.0^0.0^0.00^0.00^0.00^0.0^0.0^0.0^0.0^0.0^0.00^0.0^0.0^0.0^0.0^0.0^0.00^^^0.0</SiInmainifoList>" +
                            "</PayForRecipesRequest>","utf-8");
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


    /**
     * 门诊支付对账
     * 功能：门诊费用支付状态检查，对账
     * @param RegNo 挂号流水号
     * @param RecipeNos 处方号，支持多个处方批量支付
     * @param TotalFee  处方费用总额
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/ReconRecipes",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
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
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

}
