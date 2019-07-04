package com.intehel.dao;

import com.intehel.model.Reconciliation;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;
import java.util.List;

public interface ReconciliationMapper   extends Mapper<Reconciliation> {

    @Select("SELECT a.\"id\",a.\"RegNo\",a.\"RecipeNos\",a.\"TotalFee\",a.\"OutpatientId\",a.\"PaymentWay\",a.\"SettleDate\",a.\"TradeSerialNumber\",a.\"ifFee\",a.\"isactive\",a.\"created\",a.\"update\",a.\"pay\",a.\"InpatientSeriNo\",a.\"outTradeNo\",a.\"addr\" FROM TB_PAY_FOR_RECIPES a " +
            "WHERE a.\"update\"  BETWEEN" +
            "       TO_DATE(#{startTimes}, 'yyyy-mm-dd hh24:mi:ss') AND " +
            "       TO_DATE(#{endTimes}, 'yyyy-mm-dd hh24:mi:ss') " +
            "   AND a.\"ifFee\"=1 AND a.\"pay\"=1" )
    List<Reconciliation> selectAlls(@Param("startTimes") String startTimes,@Param("endTimes") String endTimes);

    @Select("SELECT a.\"id\",a.\"RegNo\",a.\"RecipeNos\",a.\"TotalFee\",a.\"OutpatientId\",a.\"PaymentWay\",a.\"SettleDate\",a.\"TradeSerialNumber\",a.\"ifFee\",a.\"isactive\",a.\"created\",a.\"update\",a.\"pay\",a.\"InpatientSeriNo\",a.\"outTradeNo\",a.\"addr\" FROM TB_PAY_FOR_RECIPES a " +
            "WHERE a.\"update\"  BETWEEN" +
            "       TO_DATE(#{startTimes}, 'yyyy-mm-dd hh24:mi:ss') AND " +
            "       TO_DATE(#{endTimes}, 'yyyy-mm-dd hh24:mi:ss') " +
            "   AND a.\"ifFee\"=1 AND a.\"pay\"=2" )
    List<Reconciliation> selectAllMZ(@Param("startTimes") String startTimes,@Param("endTimes") String endTimes);

    @Select("SELECT a.\"id\",a.\"RegNo\",a.\"RecipeNos\",a.\"TotalFee\",a.\"OutpatientId\",a.\"PaymentWay\",a.\"SettleDate\",a.\"TradeSerialNumber\",a.\"ifFee\",a.\"isactive\",a.\"created\",a.\"update\",a.\"pay\",a.\"InpatientSeriNo\",a.\"outTradeNo\",a.\"addr\" FROM TB_PAY_FOR_RECIPES a " +
            "WHERE a.\"update\"  BETWEEN" +
            "       TO_DATE(#{startTimes}, 'yyyy-mm-dd hh24:mi:ss') AND " +
            "       TO_DATE(#{endTimes}, 'yyyy-mm-dd hh24:mi:ss') " +
            "   AND a.\"ifFee\"=1 AND a.\"pay\"=3" )
    List<Reconciliation> selectAllZY(@Param("startTimes") String startTimes,@Param("endTimes") String endTimes);

    @Select("select  COUNT(a.\"TotalFee\") count, sum(a.\"TotalFee\") sum \n" +
            "FROM\n" +
            "\tYUFA.TB_PAY_FOR_RECIPES a \n" +
            "WHERE\n" +
            "\ta.\"update\" BETWEEN TO_DATE( #{startTimes}, 'yyyy-mm-dd hh24:mi:ss' ) \n" +
            "\tAND TO_DATE( #{endTimes}, 'yyyy-mm-dd hh24:mi:ss' ) \n" +
            "\tAND a.\"ifFee\" = 1 \n" +
            "\tAND a.\"pay\" =#{pay}")
    Reconciliation selectAllTJ(@Param("startTimes") String startTimes,@Param("endTimes") String endTimes,@Param("pay") String pay);
    @Select("select  COUNT(a.\"TotalFee\") count, sum(a.\"TotalFee\") sum \n" +
            "FROM\n" +
            "\tYUFA.TB_PAY_FOR_RECIPES a \n" +
            "WHERE\n" +
            "\ta.\"update\" BETWEEN TO_DATE( #{startTimes}, 'yyyy-mm-dd hh24:mi:ss' ) \n" +
            "\tAND TO_DATE( #{endTimes}, 'yyyy-mm-dd hh24:mi:ss' ) \n" +
            "\tAND a.\"ifFee\" = 1 ")
    Reconciliation selectAllTJs(@Param("startTimes") String startTimes,@Param("endTimes") String endTimes);
}
