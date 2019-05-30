package com.intehel.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name = "TB_VIEW")
public class PxView {
	@Id
    @Column(name = "ID")
	private Integer id;
	@Column(name = "Requisition_ID")
	private String requisitionId;
	@Column(name = "PTN_ID")
	private String ptnId;
	@Column(name = "Patient_ID")
	private String patientId;
	@Column(name = "PTN_NAME")
	private String ptnName;
	@Column(name = "SEX")
	private String sex;
	@Column(name = "Emergency_ID")
	private String emergencyId;
	@Column(name = "Req_Department")
	private String reqDepartment;
	@Column(name = "sections_Id")
	private String sectionsId;
	@Column(name = "created")
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
	public String getPtnId() {
		return ptnId;
	}
	public void setPtnId(String ptnId) {
		this.ptnId = ptnId;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getPtnName() {
		return ptnName;
	}
	public void setPtnName(String ptnName) {
		this.ptnName = ptnName;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmergencyId() {
		return emergencyId;
	}
	public void setEmergencyId(String emergencyId) {
		this.emergencyId = emergencyId;
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
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	
	
	
	
	
	
}
