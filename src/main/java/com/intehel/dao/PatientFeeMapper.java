package com.intehel.dao;

import com.intehel.model.FindPatient;
import com.intehel.model.PatientFee;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;

public interface PatientFeeMapper extends Mapper<PatientFee> {

    @Insert("INSERT INTO TB_PATIENT_FEE a (a.\"id\", a.\"OutpatientId\",a.\"RegNo\",a.\"RegDate\",a.\"RecipeNo\",a.\"SysType\",a.\"ItemName\", a.\"ItemSpec\",a.\"DosageSpec\",a.\"ItemNum\",a.\"TotalCost\",\"PaymentStatus\",a.\"OperDate\",a.\"CancelFlag\", a.\"RecipeDrName\",a.\"FeeDate\",a.\"created\") VALUES ((select rawtohex(sys_guid()) from dual),#{outpatientId},#{regNo},#{regDate},#{recipeNo},#{sysType},#{itemName},#{itemSpec},#{dosageSpec},#{itemNum},#{totalCost},#{paymentStatus},#{operDate},#{cancelFlag},#{recipeDrName},#{feeDate},#{created})")
    void createPatient(@Param("outpatientId") String outpatientId, @Param("regNo")  String regNo, @Param("regDate")  String regDate, @Param("recipeNo")  String recipeNo,
                       @Param("sysType")  String sysType, @Param("itemName")  String itemName,
                       @Param("itemSpec")  String itemSpec, @Param("dosageSpec")  String dosageSpec, @Param("itemNum")  String itemNum,
                       @Param("totalCost")  String totalCost, @Param("paymentStatus")  String paymentStatus, @Param("operDate")  String operDate,
                       @Param("cancelFlag")  String cancelFlag, @Param("recipeDrName")  String recipeDrName, @Param("feeDate")  String feeDate, @Param("created")Date created);

    @Select("SELECT COUNT(\"RecipeNo\") FROM TB_PATIENT_FEE a WHERE a.\"RegNo\"=#{regNo} AND a.\"RecipeNo\"=#{recipeNo}")
    int selectReg(@Param("regNo")String regNo, @Param("recipeNo")String recipeNo);
}
