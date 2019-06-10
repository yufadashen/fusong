package com.intehel;

import com.intehel.common.wxpay.sdk.*;

import java.util.HashMap;
import java.util.Map;

public class WXtest {
    public static void main(String[] args) throws Exception {
        MyConfig config = new MyConfig();
        WXPay wxpay = new WXPay(config);
        String st=WXPayUtil.generateNonceStr();
        Map map=new HashMap();
        map.put("appid","wx8565264272b020b6");
        map.put("body","test");
        map.put("mch_id","1532622521");
        map.put("nonce_str","192006250b4c09247ec02edce69f6a2b");
        map.put("notify_url","http://boyi.natapp1.cc/WXtest");
        map.put("out_trade_no",st);
        map.put("product_id","20190610987654");
        map.put("spbill_create_ip","0.0.0.0");
        map.put("total_fee","1");
        map.put("trade_type","NATIVE");
        String s = WXPayUtil.generateSignedXml(map, "192006250b4c09247ec02edce69f6a2a", WXPayConstants.SignType.MD5);
System.err.println(s);
        Map maps=new HashMap();
        maps.put("appid","wx8565264272b020b6");
        maps.put("body","test");
        maps.put("mch_id","1532622521");
        maps.put("nonce_str","192006250b4c09247ec02edce69f6a2b");
        maps.put("notify_url","http://boyi.natapp1.cc/WXtest");
        maps.put("out_trade_no",st);
        maps.put("product_id","20190610987654");
        maps.put("spbill_create_ip","0.0.0.0");
        maps.put("total_fee","1");
        maps.put("trade_type","NATIVE");
        maps.put("sign",s);
        try {
            Map<String, String> resp = wxpay.unifiedOrder(maps);
            System.out.println(resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
