package com.intehel.controller;

import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradeCancelRequest;
import com.alipay.api.request.AlipayTradePrecreateRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeCancelResponse;
import com.alipay.api.response.AlipayTradePrecreateResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.intehel.common.AlipayConfig;
import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.StringUtils;
import com.intehel.common.util.XmlJsonUtils;
import com.intehel.common.wxpay.sdk.WXPayUtil;
import com.intehel.dao.PayForRecipesMapper;
import com.intehel.service.OccupyRegPointService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


@Controller
public class AlipayZFController {

    Logger logger = Logger.getLogger(this.getClass().getName());


    /**
     * 支付宝下单
     * @param RegNo 流水号
     * @param Fee 金额
     * @param ipAddress 终端编号
     * @return
     * @throws AlipayApiException
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/AlipayZF",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String AlipayZF(String RegNo,String Fee,String ipAddress) throws AlipayApiException {
        System.err.println("支付宝下单");
        if (ipAddress==null){ipAddress="001";}
        String outTradeNo=null;
        outTradeNo=RegNo+WXPayUtil.generateNonceStr8();
        AlipayClient alipayClient = new DefaultAlipayClient(
                AlipayConfig.gatewayUrl,
                AlipayConfig.app_id, AlipayConfig.merchant_private_key, "JSON", AlipayConfig.charset,
                AlipayConfig.alipay_public_key, "RSA2");
        AlipayTradePrecreateRequest request = new AlipayTradePrecreateRequest();
        request.setBizContent("{" +
                "    \"out_trade_no\":\""+outTradeNo+"\"," +
                "    \"total_amount\":\""+Fee+"\"," +
                "    \"subject\":\"支付挂号费\"," +
                "    \"qr_code_timeout_express\":\"2m\"," +
                "    \"store_id\":\""+ipAddress +"\""+
                "    }");
//通过alipayClient调用API，获得对应的response类
        AlipayTradePrecreateResponse response = alipayClient.execute(request);
        System.out.print(response.getBody());
        Map<String , Object> maps = (Map)JSON.parse(response.getBody());
        Map<String,String> map=(Map)maps.get("alipay_trade_precreate_response");
        System.out.print("二维码串"+map.get("qr_code"));
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        Map<String , Object> mapq=new HashMap();
        Map<String , String> map1=new HashMap();
        mapq.put("Message","成功");
        mapq.put("Code","0");
        map1.put("url",map.get("qr_code"));
        map1.put("outTradeNo",outTradeNo);
        mapq.put("retBody",map1);
        logger.info("支付宝支付订单生成成功+"+map1);
        return JSON.toJSONString(mapq);

    }


    /**
     * 支付宝下单查询
     * @param RegNo 流水号
     * @return
     * @throws AlipayApiException
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/AlipayCX",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String AlipayCX(String outTradeNo,String RegNo,Integer opType,String RecipeNos,String InpatientSeriNo) throws AlipayApiException {
        String url=null;
        AlipayClient alipayClient = new DefaultAlipayClient(
                AlipayConfig.gatewayUrl,
                AlipayConfig.app_id, AlipayConfig.merchant_private_key, "JSON", AlipayConfig.charset,
                AlipayConfig.alipay_public_key, "RSA2");
        AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
        request.setBizContent("{" +
                "    \"out_trade_no\":\""+outTradeNo+"\""+
                "    }");
        //通过alipayClient调用API，获得对应的response类
        AlipayTradeQueryResponse response = alipayClient.execute(request);
        System.out.print(response.getBody());
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
            Map<String , Object> map01=new HashMap();
            Map<String , String> map02=new HashMap();
            map02.put("trade_status","WAIT_BUYER_PAY");
            map01.put("Message","订单未扫码");
            map01.put("Code","0");
            map01.put("retBody",map02);
            logger.info("支付宝查询");
            return JSON.toJSONString(map01);

        }
        //解析返回值
        Map<String , Object> Alipaymap = (Map)JSON.parse(response.getBody());
        Map<String,String> map=(Map)Alipaymap.get("alipay_trade_query_response");
        System.out.print("支付状态"+map.get("trade_status"));

        if(map.get("trade_status").equals("TRADE_SUCCESS")){
            map.put("total_amount",""+((int)(Double.parseDouble(map.get("total_amount"))*100)));
            map.put("send_pay_date",map.get("send_pay_date").replace(" ","").replace("-","").replace(":",""));
            //支付成功
            if (opType==1) {
                //挂号信息入库
                try {
                    Map<String,Object> maps= PayForAppointment(RegNo, map.get("total_amount"), map.get("send_pay_date"), map.get("trade_no"), "1","13",map.get("out_trade_no"));
                    if (maps.get("Code").toString().equals("0")){
                        map.put("trade_status","TRADE_SUCCESS");
                    }else{
                        map.put("trade_status","HISFAIL");
                    }

                }catch (Exception e){
                    map.put("trade_status","HISFAIL");
                    e.printStackTrace();
                    logger.info("支付成功+"+url);
                }finally {
                    Map<String , Object> map01=new HashMap();
                    map01.put("Message","成功");
                    map01.put("Code","0");
                    map01.put("retBody",map);
                    url=JSON.toJSONString(map01);
                    logger.info("支付宝挂号缴费成功+outTradeNo="+outTradeNo +"  金额=" +map.get("total_amount") +"  支付宝订单号=" + map.get("trade_no") +"  支付宝支付时间=" + map.get("send_pay_date")+ "支付挂号费"+"13");
                    System.err.println("挂号缴费成功");
                    return url;
                }


            }else if (opType==2){
                //门诊信息入库
                try {
//                    System.err.println("门诊信息回调+"+resp.get("total_fee"));

                    Map s1 = PayForRecipes(RegNo, RecipeNos, map.get("total_amount"), map.get("send_pay_date"), map.get("trade_no"), "2", "13",map.get("out_trade_no"));
//                    System.err.println("门诊缴费成功");
                    if (s1.get("Code").toString().equals("0")){
                        map.put("trade_status","TRADE_SUCCESS");
                    }else{
                        map.put("trade_status","HISFAIL");
                    }

                }catch (Exception e){
                    map.put("trade_status","HISFAIL");
                    e.printStackTrace();
                    logger.info("his执行失败+"+url);
                }finally {
                    Map<String , Object> map01=new HashMap();
                    map01.put("Message","成功");
                    map01.put("Code","0");
                    map01.put("retBody",map);
                    url=JSON.toJSONString(map01);
                    logger.info("门诊缴费成功+outTradeNo="+outTradeNo +"  金额=" +map.get("total_amount") +"  支付宝订单号=" + map.get("trade_no") +"  支付宝支付时间=" + map.get("send_pay_date")+ "支付挂号费"+"13");
                    System.err.println("门诊缴费成功");
                    return url;
                }

            }else if (opType==3){
                try{
                    //门诊信息入库
                    System.err.println("住院信息回调+"+ map.get("total_fee"));

                    //住院流水号，支付方式ID,第三方清算日期，支付费用总额，第三方交易流水号
                    Map  maps =   InpatientFeePrepay(InpatientSeriNo,"12",  map.get("send_pay_date"), map.get("total_amount"), map.get("trade_no"),   "3",map.get("out_trade_no"));
                    if (maps.get("Code").toString().equals("0")){
                        map.put("trade_status","TRADE_SUCCESS");
                    }else{
                        map.put("trade_status","HISFAIL");
                    }

                }catch (Exception e){
                    map.put("trade_status","HISFAIL");
                    e.printStackTrace();
                    logger.info("his执行失败+"+url);
                }finally {
                    Map<String , Object> map01=new HashMap();
                    map01.put("Message","成功");
                    map01.put("Code","0");
                    map01.put("retBody",map);
                    url=JSON.toJSONString(map01);
                    logger.info("支付宝住院缴费成功+outTradeNo="+outTradeNo +"  金额=" +map.get("total_fee") +"  支付宝订单号=" + map.get("transaction_id") +"  支付宝支付时间=" + map.get("time_end")+ "支付挂号费"+"12");
                    System.err.println("挂号缴费查询");
                    return url;
                }
            }
        }
        Map<String , Object> mapZ=new HashMap();
        mapZ.put("Message","成功");
        mapZ.put("Code","0");
        mapZ.put("retBody",map);
        url=JSON.toJSONString(mapZ);
        logger.info("挂号缴费查询+outTradeNo="+outTradeNo +"  金额=" +map.get("total_amount") +"  支付宝订单号=" + map.get("trade_no") +"  支付宝支付时间=" + map.get("send_pay_date")+ "支付挂号费"+"13");
        System.err.println("挂号缴费查询");
        return url;
    }

    /**
     * 支付宝撤销订单

     * @return
     * @throws AlipayApiException
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/AlipayQX",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String AlipayQX(String outTradeNo) throws AlipayApiException {
        System.err.println("支付宝撤销定单");
        AlipayClient alipayClient = new DefaultAlipayClient(
                AlipayConfig.gatewayUrl,
                AlipayConfig.app_id, AlipayConfig.merchant_private_key, "JSON", AlipayConfig.charset,
                AlipayConfig.alipay_public_key, "RSA2");
        AlipayTradeCancelRequest request = new AlipayTradeCancelRequest();
        request.setBizContent("{"+
                "    \"out_trade_no\":\""+outTradeNo+"\"," +
                "    }");
//通过alipayClient调用API，获得对应的response类
        AlipayTradeCancelResponse response = alipayClient.execute(request);
        System.out.print(response.getBody());
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        Map<String , Object> maps = (Map)JSON.parse(response.getBody());
        Map<String,String> map=(Map)maps.get("alipay_trade_cancel_response");
        Map<String , Object> mapq=new HashMap();
        mapq.put("Message","成功");
        mapq.put("Code","0");
        mapq.put("retBody",map);
        logger.info("支付宝撤销订单成功+"+map);
        return JSON.toJSONString(mapq);

    }

    /**
     * 支付宝退费

     * @return
     * @throws AlipayApiException
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/AlipayTF",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String AlipayTF(String outTradeNo,String Fee) throws AlipayApiException {
        System.err.println("支付宝退款");
        AlipayClient alipayClient = new DefaultAlipayClient(
                AlipayConfig.gatewayUrl,
                AlipayConfig.app_id, AlipayConfig.merchant_private_key, "JSON", AlipayConfig.charset,
                AlipayConfig.alipay_public_key, "RSA2");
        AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        request.setBizContent("{"+
                "    \"out_trade_no\":\""+outTradeNo+"\"," +
                "    \"refund_amount\":\""+Fee+"\"" +
                "    }");
//通过alipayClient调用API，获得对应的response类
        AlipayTradeRefundResponse response = alipayClient.execute(request);
        System.out.print(response.getBody());
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        Map<String , Object> maps = (Map)JSON.parse(response.getBody());
        Map<String,String> map=(Map)maps.get("alipay_trade_refund_response");
        Map<String , Object> mapq=new HashMap();
        mapq.put("Message","成功");
        mapq.put("Code","0");
        mapq.put("retBody",map);
        logger.info("支付宝退款成功+"+map);
        return JSON.toJSONString(mapq);

    }





    //支付宝异步回调
    @RequestMapping(value = "/notify_url",produces = {"text/html;charset=utf-8"})
    public String Alipay(HttpServletRequest request, HttpServletResponse response) throws AlipayApiException    {
//        request.getParameter("");
        System.out.println("进入支付宝回调");
        return "success";
    }
//    {
//        Map<String,String> params = new HashMap<String,String>();
//        Map<String,String[]> requestParams = request.getParameterMap();
//        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
//            String name = (String) iter.next();
//            String[] values = (String[]) requestParams.get(name);
//            String valueStr = "";
//            for (int i = 0; i < values.length; i++) {
//                valueStr = (i == values.length - 1) ? valueStr + values[i]
//                        : valueStr + values[i] + ",";
//            }
//            //乱码解决，这段代码在出现乱码时使用
////            valueStr = new String(valueStr.getBytes("utf-8"), "utf-8");
//            params.put(name, valueStr);
//        }
//
//        boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名
//
//        //——请在这里编写您的程序（以下代码仅作参考）——
//
//	/** 实际验证过程建议商户务必添加以下校验：
//	1、需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
//	2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
//	3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email）
//	4、验证app_id是否为该商户本身。
//	*/
//        if(signVerified) {//验证成功
//            //商户订单号
//            String out_trade_no = new String(request.getParameter("out_trade_no"));
//
//            //支付宝交易号
//            String trade_no = new String(request.getParameter("trade_no"));
//
//            //交易状态
//            String trade_status = new String(request.getParameter("trade_status"));
//            String total_amount = new String(request.getParameter("total_amount"));
//            String gmt_payment = new String(request.getParameter("gmt_payment")).replace("-","").replace(" ","").replace(":","");
//            String passback_params = new String(request.getParameter("passback_params"));
//
//            System.err.println("商户订单号"+out_trade_no);
//            System.err.println("支付宝交易号"+trade_no);
//            System.err.println("自定义回传"+passback_params);
//            System.err.println("交易时间"+gmt_payment);
//            System.err.println("金额"+total_amount);
//            if(trade_status.equals("TRADE_FINISHED")){
//                //判断该笔订单是否在商户网站中已经做过处理
//                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
//                //如果有做过处理，不执行商户的业务程序
//
//                //注意：
//                //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
//            }else if (trade_status.equals("TRADE_SUCCESS")){
//                /**
//                 * 业务代码
//                 */
//                int total_amounts=(int)(Double.parseDouble(total_amount)*100);
//                String[] str=passback_params.split("zheshiyigegeng");
//                boolean equals = str[0].equals("支付挂号费");
//                System.err.println(str[0]+equals);
//                if (str[0].equals("支付挂号费")) {
//                    //挂号信息入库
//                    //挂号流水号，金额，支付时间，支付宝流水号，pay 1 为挂号费 2为门诊费，自定义订单号
//                    PayForAppointment(str[1], ""+total_amounts, gmt_payment,trade_no, "1","13",out_trade_no);
//                    System.err.println(str[1]+ total_amounts+ gmt_payment+trade_no+ (str[0].equals("支付挂号费") ? "1" : "2")+"13");
//                    System.err.println("挂号缴费成功");
//                    return "success";
//                }else if (str[0].equals("支付门诊费")){
//                    //门诊信息入库
//                    System.err.println("门诊信息回调+"+total_amount);
//
//                    PayForRecipes(str[1],str[2], ""+total_amounts, gmt_payment, trade_no, "2","13",out_trade_no);
//                    System.err.println("门诊缴费成功");
//                    return "success";
//                }else if (str[0].equals("支付住院费")){
//                    //门诊信息入库
//                    System.err.println("门诊信息回调+"+total_amount);
//
//                    //患者id，住院流水号，支付方式ID,第三方清算日期，支付费用总额，第三方交易流水号
//                    InpatientFeePrepay(str[1],"13", gmt_payment,""+total_amounts,trade_no,   "3",out_trade_no);
//                    System.err.println("门诊缴费成功");
//                    return "success";
//                }else{
//                    System.out.println("信息有误");
//                    return "fail";
//                }
//            }
//            System.out.println("success");
//            return "success";
//        }else {//验证失败
//            System.out.println("fail");
//            return "fail";
//        }
//    }



    @Autowired
    OccupyRegPointService occupyRegPointService;
    @Autowired
    PayForRecipesMapper payForRecipesMapper;

    @Transactional
    public Map<String,Object> PayForAppointment(String RegNo,String Fee,String SettleDate,String TradeSerialNumber,String pay,String paymenyWay,String outTradeNo) throws UnsupportedEncodingException {
        System.err.println("执行挂号支付入库"+RegNo+Fee);
        Fee=String.valueOf(Integer.parseInt(Fee)/100);
        String str="";
        String strURL="http://192.9.10.42:10110/ServiceForXml.asmx/PayForAppointment?xmltxt="+
                URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                        "<RegPaymentRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                        "<HospId/>" +
                        "<AppId>100734</AppId>"+
                        "<Fee>"+Fee+"</Fee>"+
                        "<PaymentWay>"+paymenyWay+"</PaymentWay>" +
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

        // 解析XML
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        if (map.get("Code").toString().equals("0")){
            try {
                System.err.println("支付结果入库");
                Fee=""+(Integer.parseInt(Fee)*100);
                payForRecipesMapper.updatePat(RegNo,paymenyWay,Fee,SettleDate,TradeSerialNumber,new Date(),pay,outTradeNo);
                logger.info("支付结果成功+RegNo="+RegNo+"  paymenyWay="+paymenyWay+"  Fee"+Fee+"  SettleDate"+SettleDate+"  TradeSerialNumber"+TradeSerialNumber+"  交易时间"+new Date()+" pay"+pay);
            }finally {
                return map;
            }


        }
        System.err.println(JsonUtil.toString(map));
        return map;
    }


    //    @ResponseBody
//    @RequestMapping(value = "/PayForRecipes",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    @Transactional
    public Map<String,Object> PayForRecipes(String RegNo,String RecipeNos,String TotalFee,String SettleDate,String TradeSerialNumber,String pay,
                                            String PaymentWay,String outTradeNo) throws UnsupportedEncodingException {
        System.err.println("进入接口"+RegNo);
        Double Fee=Double.parseDouble(TotalFee)/100;
        String str="";

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

        // 解析XML
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        if (map.get("Code").equals("0")){
            payForRecipesMapper.updatePat(RegNo,PaymentWay,TotalFee,SettleDate,TradeSerialNumber,new Date(),pay,outTradeNo);
//            patientFee.updatePay(RegNo,RecipeNos,TotalFee,TradeSerialNumber,PaymentWay,SettleDate,pay);
        }
        System.err.println(JsonUtil.toString(map));
        return map;
    }


    @Transactional
    public Map<String,Object> InpatientFeePrepay(String InpatientSeriNo,String PaymentWay,String SettleDate,String TotalFee,
                                                 String TradeSerialNumber,String pay ,String outTradeNo) throws UnsupportedEncodingException {
        String str="";

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

        // 解析XML
        Map<String,Object> map=XmlJsonUtils.readStringXmlOut(str);
        if (map.get("Code").equals("0")){
            payForRecipesMapper.createInpatient(InpatientSeriNo,PaymentWay,TotalFee,SettleDate,TradeSerialNumber,new Date(),pay,outTradeNo);
//            patientFee.updatePay(RegNo,RecipeNos,TotalFee,TradeSerialNumber,PaymentWay,SettleDate,pay);
        }
        System.err.println(JsonUtil.toString(map));
        return map;
    }

}



