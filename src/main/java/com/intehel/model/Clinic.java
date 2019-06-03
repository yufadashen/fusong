package com.intehel.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "TB_CLINIC")
public class Clinic {
	@Id
    @Column(name = "ID")
	private Integer id;
	@Column(name = "SECTIONS_ID")
	private Integer his_code;
	@Column(name = "hisCode")
	private Integer sectionsId;
	@Column(name = "clinic_no")
	private Integer clinicNo;
	@Column(name = "station_id")
	private Integer stationId;
	@Column(name = "total_num")
	private Integer totalNum;
	@Column(name = "nscreen_address")
	private String nscreenAddress;
	@Column(name = "bscreen_address")
	private String bscreenAddress;
	@Column(name = "clinic_name")
	private String clinicName;
	@Column(name = "clinic_service_ip")
	private String clinicServiceIp;
	@Column(name = "bscreen_address_two")
	private String bscreenAddressTwo;
	@Column(name = "clinic_no_two")
	private Integer clinicNoTwo;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getHis_code() {
		return his_code;
	}
	public void setHis_code(Integer his_code) {
		this.his_code = his_code;
	}
	public Integer getSectionsId() {
		return sectionsId;
	}
	public void setSectionsId(Integer sectionsId) {
		this.sectionsId = sectionsId;
	}
	public Integer getClinicNo() {
		return clinicNo;
	}
	public void setClinicNo(Integer clinicNo) {
		this.clinicNo = clinicNo;
	}
	public Integer getStationId() {
		return stationId;
	}
	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public String getNscreenAddress() {
		return nscreenAddress;
	}
	public void setNscreenAddress(String nscreenAddress) {
		this.nscreenAddress = nscreenAddress;
	}
	public String getBscreenAddress() {
		return bscreenAddress;
	}
	public void setBscreenAddress(String bscreenAddress) {
		this.bscreenAddress = bscreenAddress;
	}
	public String getClinicName() {
		return clinicName;
	}
	public void setClinicName(String clinicName) {
		this.clinicName = clinicName;
	}
	public String getClinicServiceIp() {
		return clinicServiceIp;
	}
	public void setClinicServiceIp(String clinicServiceIp) {
		this.clinicServiceIp = clinicServiceIp;
	}
	public String getBscreenAddressTwo() {
		return bscreenAddressTwo;
	}
	public void setBscreenAddressTwo(String bscreenAddressTwo) {
		this.bscreenAddressTwo = bscreenAddressTwo;
	}
	public Integer getClinicNoTwo() {
		return clinicNoTwo;
	}
	public void setClinicNoTwo(Integer clinicNoTwo) {
		this.clinicNoTwo = clinicNoTwo;
	}
	
	
	
	
	
	
	
}
