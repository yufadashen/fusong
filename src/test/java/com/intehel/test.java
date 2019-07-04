package com.intehel;


import com.intehel.common.alipay.AliPayUtil;

public class test {

    public static void main(String[] argss) throws Exception {
        String orderId="12546789";//订单号
        String orderMoney="12546789";//金额
        String orderName="抚松县人民医院";//标题
       System.err.println( AliPayUtil.pay(orderId,orderMoney,orderName));





















//String Fee="302";
//{RecipeSeq:1,RecipeDrId:009999,FeeType:PCZ,PackageName:"",ItemSpec:10ml*10支,ItemNum:10,MedicalType:"",Fee
//        Fee=String.valueOf(Double.parseDouble(Fee)/100);
//        Fee=String.valueOf(Integer.parseInt(Fee,2)/100);
//[{RecipeSeq:1, RecipeDrId:009999, FeeType:PCZ, PackageName:

    }


}
