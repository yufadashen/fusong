package com.intehel.dao;

import com.intehel.model.Reconciliation;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;
import java.util.List;

public interface ReconciliationMapper   extends Mapper<Reconciliation> {

    @Select("SELECT a.\"id\",a.\"RegNo\",a.\"RecipeNos\",a.\"TotalFee\",a.\"OutpatientId\",a.\"PaymentWay\",a.\"SettleDate\",a.\"TradeSerialNumber\",a.\"ifFee\",a.\"isactive\",a.\"created\",a.\"update\",a.\"pay\",a.\"InpatientSeriNo\",a.\"outTradeNo\" FROM TB_PAY_FOR_RECIPES a " +
            "WHERE a.\"update\"  BETWEEN\n" +
            "       TO_DATE(#{startTimes}, 'yyyy-mm-dd hh24:mi:ss') AND " +
            "       TO_DATE(#{endTimes}, 'yyyy-mm-dd hh24:mi:ss') " +
            "   AND a.\"ifFee\"=1")
    List<Reconciliation> selectAlls(@Param("startTimes") String startTimes,@Param("endTimes") String endTimes);
}
