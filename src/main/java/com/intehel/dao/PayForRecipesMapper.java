package com.intehel.dao;

import com.intehel.model.PatientFee;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;

public interface PayForRecipesMapper  extends Mapper<PatientFee> {

    @Select("SELECT COUNT(a.\"RegNo\") FROM TB_PAY_FOR_RECIPES a WHERE a.\"RegNo\"=#{regNo} AND a.\"TotalFee\"=#{db} AND a.\"OutpatientId\"=#{outpatientId}")
    int selectPat(@Param("outpatientId") String outpatientId, @Param("regNo") String regNo,@Param("db")  String db);

    @Insert("INSERT INTO TB_PAY_FOR_RECIPES a (a.\"id\",a.\"RegNo\",a.\"RecipeNos\",a.\"TotalFee\", a.\"OutpatientId\",a.\"created\",a.\"pay\") VALUES " +
            "((select rawtohex(sys_guid()) from dual),#{regNo},#{RecipeNos},#{TotalFee},#{outpatientId},(SELECT sysdate FROM dual),#{pay})")
    void createPat(@Param("outpatientId") String outpatientId, @Param("regNo") String regNo, @Param("RecipeNos") String RecipeNos,@Param("TotalFee")  String db,@Param("pay") String pay);


    @Update("UPDATE TB_PAY_FOR_RECIPES a set a.\"PaymentWay\"=#{paymentWay},a.\"TotalFee\"=#{fee},a.\"update\"=#{update},a.\"SettleDate\"=#{settleDate},a.\"TradeSerialNumber\"=#{tradeSerialNumber},a.\"ifFee\"='1',a.\"outTradeNo\"=#{outTradeNo} where  a.\"RegNo\"=#{regNo} AND a.\"pay\"=#{pay}")
    void updatePat(@Param("regNo")  String regNo,@Param("paymentWay")   String paymentWay, @Param("fee")  String fee, @Param("settleDate")  String settleDate,@Param("tradeSerialNumber")   String tradeSerialNumber,@Param("update") Date update,@Param("pay") String pay,@Param("outTradeNo") String outTradeNo);

    @Insert("INSERT INTO TB_PAY_FOR_RECIPES a (a.\"id\",a.\"inpatientSeriNo\",a.\"paymentWay\",a.\"totalFee\",a.\"settleDate\",a.\"tradeSerialNumber\",a.\"date\",a.\"pay\",a.\"outTradeNo\")VALUES(" +
            "((select rawtohex(sys_guid()) from dual),#{inpatientSeriNo},#{paymentWay},#{totalFee},#{settleDate},#{tradeSerialNumber},#{date},#{pay},#{outTradeNo})")
    void createInpatient(@Param("inpatientSeriNo") String inpatientSeriNo,@Param("paymentWay")  String paymentWay,@Param("totalFee")  String totalFee,@Param("settleDate")  String settleDate,
                         @Param("tradeSerialNumber")  String tradeSerialNumber,@Param("date")  Date date,@Param("pay")  String pay, @Param("outTradeNo")  String outTradeNo);
}
