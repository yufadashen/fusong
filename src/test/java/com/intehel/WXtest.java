package com.intehel;

import com.intehel.common.wxpay.sdk.*;

import java.util.HashMap;
import java.util.Map;

public class WXtest {
    public static void main(String[] args) throws Exception {

        String notifyData = "<xml><appid><![CDATA[wx8565264272b020b6]]></appid><bank_type><![CDATA[CFT]]></bank_type><cash_fee><![CDATA[1]]></cash_fee><fee_type><![CDATA[CNY]]></fee_type><is_subscribe><![CDATA[N]]></is_subscribe><mch_id><![CDATA[1532622521]]></mch_id><nonce_str><![CDATA[oKsQOHSJRtxSlz16XHfgcfaWR6bb4uLU]]></nonce_str><openid><![CDATA[okfZ6wL-XXcP7jrINQK01gT7h-Hw]]></openid><out_trade_no><![CDATA[6118052]]></out_trade_no><result_code><![CDATA[SUCCESS]]></result_code><return_code><![CDATA[SUCCESS]]></return_code><sign><![CDATA[AE7232D42A2E4EFCEF740A503F45018E075E943E9F24BB2C3BB8866F7E61380E]]></sign><time_end><![CDATA[20190611162213]]></time_end><total_fee>1</total_fee><trade_type><![CDATA[NATIVE]]></trade_type><transaction_id><![CDATA[4200000316201906113447315940]]></transaction_id></xml>"; // 支付结果通知的xml格式数据

        MyConfig config = new MyConfig();
        WXPay wxpay = new WXPay(config);

        Map<String, String> notifyMap = WXPayUtil.xmlToMap(notifyData);  // 转换成map
        System.err.println(notifyMap.get("out_trade_no"));
        System.err.println(notifyMap.get("total_fee"));
        System.err.println(notifyMap.get("transaction_id"));
        System.err.println(notifyMap.get("time_end"));

    }


}
