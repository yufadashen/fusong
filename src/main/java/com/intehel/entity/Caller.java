package com.intehel.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name = "TB_CALLER")
public class Caller {
	@Id
    @Column(name = "ID_")
	private Integer id;
	@Column(name = "REQUISITION_ID_")
	private String requisitionId;
	@Column(name = "PATIENT_ID_")
	private String patienId;
	@Column(name = "NAME_")
	private String name;
	@Column(name = "SEX_")
	private String sex;
	@Column(name = "EMERGENCY_")
	private String emergency;
	@Column(name = "REQ_DEPARTMENT_")
	private String reqDepartment;
	@Column(name = "SECTIONS_ID_")
	private String sectionsId;
	@Column(name = "STATE_")
	private String state;
	@Column(name = "CREATED_")
	private Date created;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRequisitionId() {
		return requisitionId;
	}
	public void setRequisitionId(String requisitionId) {
		this.requisitionId = requisitionId;
	}
	public String getPatienId() {
		return patienId;
	}
	public void setPatienId(String patienId) {
		this.patienId = patienId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmergency() {
		return emergency;
	}
	public void setEmergency(String emergency) {
		this.emergency = emergency;
	}
	public String getReqDepartment() {
		return reqDepartment;
	}
	public void setReqDepartment(String reqDepartment) {
		this.reqDepartment = reqDepartment;
	}
	public String getSectionsId() {
		return sectionsId;
	}
	public void setSectionsId(String sectionsId) {
		this.sectionsId = sectionsId;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	
	
	
	
	
}
