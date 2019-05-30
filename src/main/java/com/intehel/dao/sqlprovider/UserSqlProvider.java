package com.intehel.dao.sqlprovider;

import org.apache.ibatis.annotations.Param;

public class UserSqlProvider {

	public String list222() {
        return "select * from t_user" ;
    }
	
	public String listByUsernameAndId(@Param("id")String id,
    		@Param("username")String username) {
        return "select * from t_user where user_id=#{id} and username =#{username}";
    }

	
}
