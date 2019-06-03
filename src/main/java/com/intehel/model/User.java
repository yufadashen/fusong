package com.intehel.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.alibaba.fastjson.annotation.JSONField;

@Table(name = "TB_USER")
public class User {
	@Id
    @Column(name = "USERID")
	private String userId;
	@Column(name = "USERNAME")
	private String username;
	@Column(name = "PASSWORD")
	private String password;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	@Column(name = "CREATED")
	private Date created;
	
	@Transient
    private String other; //跟数据库无关的字段使用@Transient标记或移至VO类。
	
	public User( String userId, String username, String password,Date created){
        this.userId=userId;
        this.username=username;
        this.password=password;
        this.created=created;
    }

	
	
	public User() {
		// TODO Auto-generated constructor stub
	}



	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	
	
	
	
	
}
