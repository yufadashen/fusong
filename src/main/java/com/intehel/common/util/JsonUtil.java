package com.intehel.common.util;


import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhuxiaomeng
 * @date 2017/12/15.
 * @email 154040976@qq.com
 * ajax 回执
 */
public class JsonUtil {

  //默认成功
  private boolean flag=true;
  private String msg;
  private JSONObject josnObj;

  private static ObjectMapper mapper = new ObjectMapper();

  public static String toString(Object obj){
    return toJson(obj);
  }

  public static String toJson(Object obj){
    try{
      StringWriter writer = new StringWriter();
      mapper.writeValue(writer, obj);
      return writer.toString();
    }catch(Exception e){
      throw new RuntimeException("序列化对象【"+obj+"】时出错", e);
    }
  }

  public static <T> T toBean(Class<T> entityClass, String jsonString){
    try {
      return mapper.readValue(jsonString, entityClass);
    } catch (Exception e) {
      throw new RuntimeException("JSON【"+jsonString+"】转对象时出错", e);
    }
  }

  /**
   * 用于对象通过其他工具已转为JSON的字符形式，这里不需要再加上引号
   * @param obj
//   * @param isObject
   */
  public static String getJsonSuccess(Object obj){
    String jsonString = null;
    if(obj == null){
      jsonString = "{\"success\":true}";
    }else{
      jsonString = "{\"success\":true,\"data\":"+toJson(obj)+"}";
    }
    return jsonString;
  }

	/*public static String getJsonSuccess(Object obj){
		return getJsonSuccess(obj, null);
	}*/

  public static String getJsonSuccess(Object obj, String message) {
    if(obj == null){
      return "{\"success\":true,\"message\":\""+message+"\"}";
    }else{
      try{
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("success", true);
        return "{\"success\":true,"+toString(obj)+",\"message\":\""+message+"\"}";
      }catch(Exception e){
        throw new RuntimeException("序列化对象【"+obj+"】时出错", e);
      }
    }
  }

  public static String getJsonError(Object obj){
    return getJsonError(obj, null);
  }

  public static String getJsonError(Object obj, String message) {
    if(obj == null){
      return "{\"success\":false,\"message\":\""+message+"\"}";
    }else{
      try{
        obj = parseIfException(obj);
        return "{\"success\":false,\"data\":"+toString(obj)+",\"message\":\""+message+"\"}";
      }catch(Exception e){
        throw new RuntimeException("序列化对象【"+obj+"】时出错", e);
      }
    }
  }

  public static Object parseIfException(Object obj){
    if(obj instanceof Exception){
      return getErrorMessage((Exception) obj, null);
    }
    return obj;
  }

  public static String getErrorMessage(Exception e, String defaultMessage){
    return defaultMessage != null ? defaultMessage : null;
  }

  public static ObjectMapper getMapper() {
    return mapper;
  }


  public boolean isFlag() {
    return flag;
  }

  public void setFlag(boolean flag) {
    this.flag = flag;
  }

  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public JSONObject getJosnObj() {
    return josnObj;
  }

  public void setJosnObj(JSONObject josnObj) {
    this.josnObj = josnObj;
  }


  public JsonUtil() {
  }

  public JsonUtil(boolean flag, String msg) {
    this.flag = flag;
    this.msg = msg;
  }

  /**restful 返回*/
  public static JsonUtil error(String msg){
    return new JsonUtil(false,msg);
  }
  public  static JsonUtil sucess(String msg){
    return new JsonUtil(true,msg);
  }


}
