package com.intehel.common.web;

import org.springframework.ui.ModelMap;


/**
 * 值对象:VO(Value Object)
 * 1)封装控制层相关方法返回的数据
 * 2)统一服务端相关方法返回的数据格式
 */
public class JsonResult {
   public static final int SUCCESS=1;
   public static final int ERROR=0;
   /**状态:(SUCCESS,ERROR)*/
   private int state;
   /**状态信息*/
   private String message;
   /**具体数据*/
   private Object data;
   
   
   public JsonResult(){
	   state=SUCCESS;
   }
   public JsonResult(String message){
	   this();
	   this.message=message;
   }
   public JsonResult(Object data){
	   this();
	   this.data=data;
   }
   public JsonResult(Throwable exp){
	   state=ERROR;
	   this.message=exp.getMessage();
   }
    public int getState() {
		return state;
    }
	public String getMessage() {
		return message;
	}
	public Object getData() {
	    return data;	
	}
	
	
	 /**
     * 返回操作成功的json
     * 
     * @param model {@link }
     * @param re 分页结果
     */
    public static void fyWeb(ModelMap model, FyPageObject re) {
        model.addAttribute("total", re.getTotal());
        model.addAttribute("perPageNum", re.getPerPageNum());
        model.addAttribute("prePageNumber", re.getPageNumber());
        model.addAttribute("rows", re.getRows());
    }
	
	
}









