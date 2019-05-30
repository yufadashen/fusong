package com.intehel.common.Enum;

import java.util.ArrayList;
import java.util.List;


public enum NmCallEnum {
	
	sw_bjgd("bjgd","办结归档（机要员）"),
	sw_js("js","结束")
	;
	
	/** 编码 */
	private String code;
	/** 名称 */
	private String name;
	/** 规则 */
	private String rule;
	private NmCallEnum(String code,String name){
		this.code=code;
		this.name=name;
	}
	private NmCallEnum(String code,String name,String rule){
		this.code=code;
		this.name=name;
		this.rule=rule;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}
	
}

