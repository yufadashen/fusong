package com.intehel.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name = "TB_STATION")
public class Station {
	@Id
    @Column(name = "ID")
	private Integer id;
	@Column(name = "NAME")
	private String name;
	@Column(name = "TYPE")
	private String type;
	@Column(name = "IP_ADDRESS")
	private String ipAddress;
	@Column(name = "HIS_CODE")
	private String hisCode;
	@Column(name = "SCREEN_ADDRESS")
	private String screenAddress;
	@Column(name = "BIG_SCREEN_IP")
	private String bigScreenIp;
	@Column(name = "BIG_SCREEN_WIDTH")
	private Integer bigScreenWidth;
	@Column(name = "BIG_SCREEN_HEIGHT")
	private Integer bigScreenHeight;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getHisCode() {
		return hisCode;
	}
	public void setHisCode(String hisCode) {
		this.hisCode = hisCode;
	}
	public String getScreenAddress() {
		return screenAddress;
	}
	public void setScreenAddress(String screenAddress) {
		this.screenAddress = screenAddress;
	}
	public String getBigScreenIp() {
		return bigScreenIp;
	}
	public void setBigScreenIp(String bigScreenIp) {
		this.bigScreenIp = bigScreenIp;
	}
	public Integer getBigScreenWidth() {
		return bigScreenWidth;
	}
	public void setBigScreenWidth(Integer bigScreenWidth) {
		this.bigScreenWidth = bigScreenWidth;
	}
	public Integer getBigScreenHeight() {
		return bigScreenHeight;
	}
	public void setBigScreenHeight(Integer bigScreenHeight) {
		this.bigScreenHeight = bigScreenHeight;
	}
	
	
	
	
	
	
}
