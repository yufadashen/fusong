package com.intehel;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.intehel.common.alipay.AliPayUtil;
import com.intehel.common.util.GetHttpString;
import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.dom4j.*;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

public class test {

    public static void main(String[] argss) throws Exception {
        String orderId="12546789";//订单号
        String orderMoney="12546789";//金额
        String orderName="抚松县人民医院";//标题
       System.err.println( AliPayUtil.pay(orderId,orderMoney,orderName));
//        System.err.println((""+v+"").split(".")[0]);





















//String Fee="302";
//{RecipeSeq:1,RecipeDrId:009999,FeeType:PCZ,PackageName:"",ItemSpec:10ml*10支,ItemNum:10,MedicalType:"",Fee
//        Fee=String.valueOf(Double.parseDouble(Fee)/100);
//        Fee=String.valueOf(Integer.parseInt(Fee,2)/100);
//[{RecipeSeq:1, RecipeDrId:009999, FeeType:PCZ, PackageName:

    }


}
