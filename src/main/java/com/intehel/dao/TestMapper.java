package com.intehel.dao;

import com.intehel.model.Test;
import tk.mybatis.mapper.common.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

//@Mapper
public interface TestMapper  extends Mapper<Test> {

    @Select("SELECT * FROM YUFA.\"tb_test\"")
    List<Test> test();
}
