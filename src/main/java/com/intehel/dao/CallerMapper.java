package com.intehel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.intehel.model.Caller;
import com.intehel.model.PxView;

import tk.mybatis.mapper.common.Mapper;

public interface CallerMapper extends Mapper<Caller>{

//	@Select("select * from tb_caller t where  to_days(CREATED_)=to_days(now()) and t.SECTIONS_ID_=#{sectionsId} and t.STATE_='0' order by REQUISITION_ID_ ")
	@Select("select * from tb_view t where  to_days(CREATED)=to_days(now()) and t.sections_Id=#{sectionsId} AND t.ptn_id NOT IN ( SELECT c.PATIENT_ID_  FROM tb_caller c WHERE to_days(c.CREATED_) = to_days(now()) AND c.SECTIONS_ID_ = #{sectionsId} ) order by Requisition_ID ")
	List<PxView> getCallerList(@Param("sectionsId")String sectionsId);
	
	@Select("select count(*) from tb_view ")
	int getRowCount();
	
}
