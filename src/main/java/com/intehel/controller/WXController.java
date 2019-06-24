package com.intehel.controller;

import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.StringUtils;
import com.intehel.common.util.XmlJsonUtils;
import com.intehel.common.wxpay.sdk.MyConfig;
import com.intehel.common.wxpay.sdk.WXPay;
import com.intehel.common.wxpay.sdk.WXPayConstants;
import com.intehel.common.wxpay.sdk.WXPayUtil;
import com.intehel.dao.PayForRecipesMapper;
import com.intehel.service.OccupyRegPointService;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.util.*;

@Controller
public class WXController {
    //http://boyi.natapp1.cc/WXtest


    @ResponseBody
    @RequestMapping(value = "/WXtest",produces = {"text/html;charset=utf-8"})
    public String GetNoonInfos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.err.println("执行微信支付回调");
        BufferedReader reader = null;

        reader = request.getReader();
        String line = "";
        String xmlString = null;
        StringBuffer inputString = new StringBuffer();

        while ((line = reader.readLine()) != null) {
            inputString.append(line);
        }
        xmlString = inputString.toString();
        request.getReader().close();
        System.out.println("----接收到的数据如下：---" + xmlString);

        Map<String, String> notifyMap = WXPayUtil.xmlToMap(xmlString);  // 转换成map
        //支付挂号费
        System.err.println("attach="+notifyMap.get("attach"));
        String[] str=notifyMap.get("attach").split("zheshiyigegeng");
//        boolean equals = str[0].equals("支付挂号费");
        System.err.println(str[0]+str[0].equals("支付挂号费"));
        if (str[0].equals("支付挂号费")) {
            //挂号信息入库
            PayForAppointment(str[1], notifyMap.get("total_fee"), notifyMap.get("time_end"), notifyMap.get("transaction_id"), "1","12");
            System.err.println(notifyMap.get("out_trade_no") + notifyMap.get("total_fee") + notifyMap.get("transaction_id") + notifyMap.get("time_end")+ str[0].equals("支付挂号费")+"12");
            System.err.println("挂号缴费成功");
        }else if (str[0].equals("支付门诊费")){
            //门诊信息入库
            System.err.println("门诊信息回调+"+notifyMap.get("total_fee"));

            PayForRecipes(str[1],str[2], notifyMap.get("total_fee"), notifyMap.get("time_end"), notifyMap.get("transaction_id"),"2","12");
            System.err.println("门诊缴费成功");
        }else if (str[0].equals("支付住院费")){
            //门诊信息入库
            System.err.println("门诊信息回调+"+ notifyMap.get("total_fee"));

            //住院流水号，支付方式ID,第三方清算日期，支付费用总额，第三方交易流水号
            InpatientFeePrepay(str[1],"13",  notifyMap.get("time_end"), notifyMap.get("total_fee"), notifyMap.get("transaction_id"),   "3");
            System.err.println("门诊缴费成功");
            return "success";
        }else{
            System.out.println("信息有误");
            return returnXML("FAIL");
        }
        Map<String, String> map = new HashMap<String, String>();
        String result_code = "";
        map = this.doXMLParse(xmlString);
        result_code = map.get("result_code");
        if (checkSign(xmlString)) {
            System.err.println("返回数据1="+returnXML(result_code));
            return returnXML(result_code);
        } else {
            return returnXML("FAIL");
        }


    }

    /**
     * 支付挂号费
     * @param RegNo 挂号流水号
     * @param Fee   金额
     * @return
     */
    @ResponseBody
    @RequestMapping("/WxPayGH")
    public String WxPayGH(String RegNo,String Fee,String pay)  {
        String url=null;
        Fee=String.valueOf(Integer.parseInt(Fee));
//        System.err.println(RegNo+Fee);
        try {
            //获取本机的ip地址
            InetAddress addr = null;
            addr = InetAddress.getLocalHost();
            String spbill_create_ip = addr.getHostAddress();
            MyConfig config = new MyConfig();
            WXPay wxpay = new WXPay(config);
            Map<String,String> data = new HashMap<>();
            data.put("appid",config.getAppID());
            data.put("mch_id",config.getMchID());         //商户号
            data.put("trade_type","NATIVE");                         //支付场景 APP 微信app支付 JSAPI 公众号支付  NATIVE 扫码支付
            data.put("notify_url","http://boyi.natapp1.cc/WXtest");                     //回调地址
            data.put("spbill_create_ip",spbill_create_ip);             //终端ip
            data.put("total_fee",Fee);       //订单总金额
            data.put("fee_type","CNY");//默认人民币
            String st=WXPayUtil.generateNonceStr();
            data.put("out_trade_no",RegNo+WXPayUtil.generateNonceStr8());   //交易号
            data.put("body","支付挂号费");
            data.put("attach","支付挂号费zheshiyigegeng"+RegNo);
            data.put("nonce_str",st);   // 随机字符串小于32位
            String s = WXPayUtil.generateSignature(data,config.getKey(), WXPayConstants.SignType.MD5);  //签名
            data.put("sign",s);

            Map<String, String> resp = wxpay.unifiedOrder(data);
            System.out.println(resp);
            url=resp.get("code_url");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

    /**
     * weixin支付门诊费
     * @param RegNo 挂号流水号
     * @param Fee   金额
     * @return
     */
    @ResponseBody
    @RequestMapping("/WxPayMZ")
    public String WxPayMZ(String RegNo,String RecipeNos,String Fee)  {
        String url=null;
        Fee=String.valueOf(Integer.parseInt(Fee));
        System.err.println(Fee);
//        System.err.println(RegNo+Fee);
        try {
            //获取本机的ip地址
            InetAddress addr = null;
            addr = InetAddress.getLocalHost();
            String spbill_create_ip = addr.getHostAddress();
            MyConfig config = new MyConfig();
            WXPay wxpay = new WXPay(config);
            Map<String,String> data = new HashMap<>();
            data.put("appid",config.getAppID());
            data.put("mch_id",config.getMchID());         //商户号
            data.put("trade_type","NATIVE");                         //支付场景 APP 微信app支付 JSAPI 公众号支付  NATIVE 扫码支付
            data.put("notify_url","http://boyi.natapp1.cc/WXtest");                     //回调地址
            data.put("spbill_create_ip",spbill_create_ip);             //终端ip
            data.put("total_fee",Fee);       //订单总金额
            data.put("fee_type","CNY");                           //默认人民币
            data.put("attach","支付门诊费zheshiyigegeng"+RegNo+"zheshiyigegeng"+RecipeNos);
            String st=WXPayUtil.generateNonceStr();
            data.put("out_trade_no",WXPayUtil.generateNonceStr());   //交易号
            data.put("body","支付门诊费");
            data.put("nonce_str",st);   // 随机字符串小于32位
            String s = WXPayUtil.generateSignature(data,config.getKey(), WXPayConstants.SignType.MD5);  //签名
            data.put("sign",s);
            Map<String, String> resp = wxpay.unifiedOrder(data);
            System.out.println(resp);
            url=resp.get("code_url");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }



    /**
     * 微信支付住院预交费
     * @param InpatientSeriNo 挂号流水号
     * @param Fee   金额
     * @return
     */
    @ResponseBody
    @RequestMapping("/WxPayZY")
    public String WxPayZY(String InpatientSeriNo,String Fee)  {
        String url=null;
        Fee=String.valueOf(Integer.parseInt(Fee));
        System.err.println(Fee);
//        System.err.println(RegNo+Fee);
        try {
            //获取本机的ip地址
            InetAddress addr = null;
            addr = InetAddress.getLocalHost();
            String spbill_create_ip = addr.getHostAddress();
            MyConfig config = new MyConfig();
            WXPay wxpay = new WXPay(config);
            Map<String,String> data = new HashMap<>();
            data.put("appid",config.getAppID());
            data.put("mch_id",config.getMchID());         //商户号
            data.put("trade_type","NATIVE");                         //支付场景 APP 微信app支付 JSAPI 公众号支付  NATIVE 扫码支付
            data.put("notify_url","http://boyi.natapp1.cc/WXtest");                     //回调地址
            data.put("spbill_create_ip",spbill_create_ip);             //终端ip
            data.put("total_fee",Fee);       //订单总金额
            data.put("fee_type","CNY");                           //默认人民币
            data.put("attach","支付住院费zheshiyigegeng"+InpatientSeriNo);
            String st=WXPayUtil.generateNonceStr();
            data.put("out_trade_no",WXPayUtil.generateNonceStr());   //交易号
            data.put("body","缴纳住院预交金");
            data.put("nonce_str",st);   // 随机字符串小于32位
            String s = WXPayUtil.generateSignature(data,config.getKey(), WXPayConstants.SignType.MD5);  //签名
            data.put("sign",s);
            Map<String, String> resp = wxpay.unifiedOrder(data);
            System.out.println(resp);
            url=resp.get("code_url");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }
    @GetMapping("/wxpay.html")
    public String hehe(ModelMap model) {
        return "wxpay";
    }




    private boolean checkSign(String xmlString) {
        Map<String, String> map = null;
        try {
            map = this.doXMLParse(xmlString);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String signFromAPIResponse = map.get("sign").toString();
        if (signFromAPIResponse == "" || signFromAPIResponse == null) {
            System.out.println("API返回的数据签名数据不存在，有可能被第三方篡改!!!");
            return false;
        }
        System.out.println("服务器回包里面的签名是:" + signFromAPIResponse);
        //清掉返回数据对象里面的Sign数据（不能把这个数据也加进去进行签名），然后用签名算法进行签名
        map.put("sign", "");
        System.out.println("恭喜，API返回的数据签名验证通过!!!");
        return true;
    }
    private String returnXML(String return_code) {
        return "<xml><return_code><![CDATA["
                + return_code
                + "]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
    }

    public Map doXMLParse(String strxml) throws JDOMException, IOException {
        strxml = strxml.replaceFirst("encoding=\".*\"", "encoding=\"UTF-8\"");
        if(null == strxml || "".equals(strxml)) {
            return null;
        }
        Map m = new HashMap();
        InputStream in = new ByteArrayInputStream(strxml.getBytes("UTF-8"));
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(in);
        Element root = doc.getRootElement();
        List list = root.getChildren();
        Iterator it = list.iterator();
        while(it.hasNext()) {
            Element e = (Element) it.next();
            String k = e.getName();
            String v = "";
            List children = e.getChildren();
            if(children.isEmpty()) {
                v = e.getTextNormalize();
            } else {
                v = this.getChildrenText(children);
            }

            m.put(k, v);
        }

        //关闭流
        in.close();

        return m;
    }
    /**
     * 获取子结点的xml
     * @param children
     * @return String
     */
    public String getChildrenText(List children) {
        StringBuffer sb = new StringBuffer();
        if(!children.isEmpty()) {
            Iterator it = children.iterator();
            while(it.hasNext()) {
                Element e = (Element) it.next();
                String name = e.getName();
                String value = e.getTextNormalize();
                List list = e.getChildren();
                sb.append("<" + name + ">");
                if(!list.isEmpty()) {
                    sb.append(this.getChildrenText(list));
                }
                sb.append(value);
                sb.append("</" + name + ">");
            }
        }

        return sb.toString();
    }

    @Autowired
    OccupyRegPointService occupyRegPointService;
    @Autowired
    PayForRecipesMapper payForRecipesMapper;

    public String PayForAppointment(String RegNo,String Fee,String SettleDate,String TradeSerialNumber,String pay,String paymenyWay) {
        System.err.println("执行挂号支付入库"+RegNo+Fee);
        Fee=String.valueOf(Integer.parseInt(Fee)/100);
        String str="";

        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/PayForAppointment?xmltxt="+
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
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        if (map.get("Code").toString().equals("0")){
            System.err.println("支付结果入库");
            payForRecipesMapper.updatePat(RegNo,paymenyWay,Fee,SettleDate,TradeSerialNumber,new Date(),pay);
//            occupyRegPointService.updateReg(RegNo,"12",Fee,SettleDate,TradeSerialNumber);
        }
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


//    @ResponseBody
//    @RequestMapping(value = "/PayForRecipes",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    @Transactional
    public String PayForRecipes(String RegNo,String RecipeNos,String TotalFee,String SettleDate,String TradeSerialNumber,String pay,
                                String PaymentWay) {
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
        if (map.get("Code").equals("0")){
            payForRecipesMapper.updatePat(RegNo,PaymentWay,TotalFee,SettleDate,TradeSerialNumber,new Date(),pay);
//            patientFee.updatePay(RegNo,RecipeNos,TotalFee,TradeSerialNumber,PaymentWay,SettleDate,pay);
        }
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 住院入库
     * @param InpatientSeriNo
     * @param PaymentWay
     * @param SettleDate
     * @param TotalFee
     * @param TradeSerialNumber
     * @param pay
     * @return
     */
    @Transactional
    public String InpatientFeePrepay(String InpatientSeriNo,String PaymentWay,String SettleDate,String TotalFee,String TradeSerialNumber,String pay) {
        String str="";
        try {
            String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/InpatientFeePrepay?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<InpatientFeePrepayRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId/>" +
                            "<AppId>100734</AppId>"+
                            "<InpatientSeriNo>" +InpatientSeriNo+"</InpatientSeriNo>" +
                            "<PaymentWay>"+PaymentWay+"</PaymentWay>" +
                            "<SettleDate>" +SettleDate+ "</SettleDate>" +
                            "<TermialType>自助机支付住院费</TermialType>" +
                            "<TotalFee>"+TotalFee+"</TotalFee>" +
                            "<TradeSerialNumber>"+TradeSerialNumber +"</TradeSerialNumber>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key>x</Key>" +
                            "<Value/>" +
                            "</ExtItem>" +
                            "</ExtParams>" +
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
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        if (map.get("Code").equals("0")){
            payForRecipesMapper.createInpatient(InpatientSeriNo,PaymentWay,TotalFee,SettleDate,TradeSerialNumber,new Date(),pay);
//            patientFee.updatePay(RegNo,RecipeNos,TotalFee,TradeSerialNumber,PaymentWay,SettleDate,pay);
        }
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

}

