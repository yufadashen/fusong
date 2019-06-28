package com.intehel.dao;

import com.intehel.model.OccupyRegPoint;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;

public interface OccupyRegPointMapper extends Mapper<OccupyRegPoint> {

    @Insert("INSERT INTO TB_OCCUPY_REG_POINT a " +
            "(a.\"id\",a.\"ScheduleId\",a.\"ScheduleTime\",a.\"OutpatientId\"," +
            "a.\"RegLevelId\",a.\"DeptId\",a.\"RegNo\",a.\"TotalFee\",a.\"DiagnoseFee\",a.\"RegFee\",a.\"InspectFee\",a.\"SpclFee\",a.\"CouponInfo\",a.\"RmngNum\",a.\"IfFee\",a.\"created\")" +
            "VALUES " +
            "( (select rawtohex(sys_guid()) from dual),#{scheduleId},#{scheduleTime},#{outpatientId},#{regLevelId},#{deptId},#{regNo},#{totalFee},#{diagnoseFee},#{regFee},#{inspectFee},#{spclFee},#{couponInfo},#{rmngNum},0,#{created})")
    void createReg(@Param("scheduleId") String scheduleId,@Param("scheduleTime")  String scheduleTime, @Param("outpatientId") String outpatientId,
                   @Param("regLevelId") String regLevelId, @Param("deptId") String deptId,@Param("regNo")  String regNo,@Param("totalFee")  String totalFee,
                   @Param("diagnoseFee") String diagnoseFee,@Param("regFee")  String regFee,@Param("inspectFee")  String inspectFee, @Param("spclFee") String spclFee,
                   @Param("couponInfo")  String couponInfo, @Param("rmngNum") String rmngNum, @Param("created") Date created);

    @Update("UPDATE YUFA.TB_OCCUPY_REG_POINT a set a.\"PaymentWay\"=#{paymentWay},a.\"Fee\"=#{fee},a.\"update\"=#{update},a.\"SettleDate\"=#{settleDate},a.\"TradeSerialNumber\"=#{tradeSerialNumber},a.\"IfFee\"=1 where  a.\"RegNo\"=#{regNo}")
    void updateReg(@Param("regNo")  String regNo,@Param("paymentWay")   String paymentWay, @Param("fee")  String fee, @Param("settleDate")  String settleDate,@Param("tradeSerialNumber")   String tradeSerialNumber,@Param("update")  Date update);

    @Select("")
    int selectGH(@Param("regNo") String regNo, @Param("fee") String fee);
}
