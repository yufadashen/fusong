package com.intehel.dao;

import com.intehel.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface TestMapper {
    @Select("select * from tb_user")
    List<User> getuser();

    @Insert("insert into tb_user(userId,username,password,created) values(mysq.nextval,#{username},#{password},#{created})")
    void adduser(User user);
}
