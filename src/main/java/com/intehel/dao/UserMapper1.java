package com.intehel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;

import com.intehel.dao.sqlprovider.UserSqlProvider;
import com.intehel.model.User;

public interface UserMapper1 {
	
	 /**
     *  @Results 用于填写结果集的多个字段的映射关系.
	 *	@Result 用于填写结果集的单个字段的映射关系.
	 *	@ResultMap 根据ID关联XML里面<resultMap>.
     */
	@Select("select * from t_user where 1=1")
    List<User> list();

    @Select("select * from t_user where username like #{username}")
    List<User> findByUsername(String username);

    @Select("select * from t_user where user_id like #{userId}")
    User getOne(String userId);

    @Delete("delete from t_user where user_id like #{userId}")
    int delete(String userId);
   
    /**
     *  @SelectProvider
	 *	@InsertProvider
	 *	@UpdateProvider
	 *	@DeleteProvider
	 *
             *   无论什么方式,如果涉及多个参数,则必须加上@Param注解,否则无法使用EL表达式获取参数。
     */
    @SelectProvider(type = UserSqlProvider.class, method = "listByUsernameAndId")
    User listByUsernameAndId(@Param("id")String id,
    		@Param("username")String username);
    
}
