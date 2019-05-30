package com.intehel.common.util;

import java.lang.reflect.Field;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.intehel.entity.User;

public class MappingResults {
	
	public static void main(String[] args) {

		String resultStr = getResultsStr(User.class);
		System.out.println(resultStr);
		
	}
	
	
	/**
     * 1.用于获取结果集的映射关系
     */
    public static String getResultsStr(Class origin) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("@Results({\n");
        for (Field field : origin.getDeclaredFields()) {
            String property = field.getName();
            //映射关系：对象属性(驼峰)->数据库字段(下划线)
            String column = new PropertyNamingStrategy.SnakeCaseStrategy().translate(field.getName()).toUpperCase();
            stringBuilder.append(String.format("@Result(property = \"%s\", column = \"%s_\"),\n", property, column));
        }
        stringBuilder.append("})");
        return stringBuilder.toString();
    }
	
	
	

}
