package com.intehel.dao;

import com.intehel.model.FindPatient;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import org.apache.ibatis.annotations.Update;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;

public interface FindPatientMapper extends Mapper<FindPatient> {

    @Select("SELECT COUNT(\"id\") FROM TB_FIND_PATIENT  a WHERE  a.\"id\"=#{id}")
    Integer findUserId(@Param("id")String outpatientId);
    @Insert("INSERT INTO TB_FIND_PATIENT a (a.\"id\",a.\"Enable\",a.\"Limit\",a.\"Balance\",a.\"created\",a.\"createdby\") VALUES(#{id},#{Enable},#{Limit},#{Balance},#{created},#{createdby})")
    Integer createUser(@Param("id")String outpatientId,@Param("Enable")Integer Enable,@Param("Limit")String Limit,@Param("Balance")String Balance,@Param("created")Date created,@Param("createdby")String createdby);
    @Update("UPDATE YUFA.TB_FIND_PATIENT a set a.\"Enable\"=#{Enable},a.\"Limit\"=#{Limit},a.\"Balance\"=#{Balance},a.\"update\"=#{update},a.\"updatebdy\"=#{updatebdy} where  a.\"id\"=#{id}")
    void updateUser(@Param("id")String outpatientId,@Param("Enable")Integer Enable,@Param("Limit")String Limit,@Param("Balance")String Balance,@Param("update")Date update,@Param("updatebdy")String createdby);
}
