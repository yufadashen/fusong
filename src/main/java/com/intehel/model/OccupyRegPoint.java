package com.intehel.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "TB_OCCUPY_REG_POINT")
public class OccupyRegPoint {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "ScheduleId")
    private String ScheduleId;

    @Column(name = "ScheduleTime")
    private String ScheduleTime;

    @Column(name = "OutpatientId")
    private String OutpatientId;

    @Column(name = "RegLevelId")
    private String RegLevelId;

    @Column(name = "DeptId")
    private String DeptId;

    @Column(name = "RegNo")
    private String RegNo;

    @Column(name = "TotalFee")
    private Double TotalFee;

    @Column(name = "DiagnoseFee")
    private Double DiagnoseFee;

    @Column(name = "RegFee")
    private Double RegFee;

    @Column(name = "InspectFee")
    private Double InspectFee;

    @Column(name = "SpclFee")
    private Double SpclFee;

    @Column(name = "CouponInfo")
    private String CouponInfo;

    @Column(name = "RmngNum")
    private Double RmngNum;

    @Column(name = "IfFee")
    private Integer IfFee;

    @Column(name = "isactive")
    private Integer isactive;

    @Column(name = "update")
    private Date update;

    @Column(name = "updatebdy")
    private String updatebdy;

    @Column(name = "created")
    private Date created;

    @Column(name = "createdby")
    private String createdby;

    @Column(name = "Fee")
    private Double Fee;

    @Column(name = "SettleDate")
    private String SettleDate;

    @Column(name = "TradeSerialNumber")
    private String TradeSerialNumber;

    @Column(name = "VisitTime")
    private String VisitTime;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getScheduleId() {
        return ScheduleId;
    }

    public void setScheduleId(String scheduleId) {
        ScheduleId = scheduleId;
    }

    public String getScheduleTime() {
        return ScheduleTime;
    }

    public void setScheduleTime(String scheduleTime) {
        ScheduleTime = scheduleTime;
    }

    public String getOutpatientId() {
        return OutpatientId;
    }

    public void setOutpatientId(String outpatientId) {
        OutpatientId = outpatientId;
    }

    public String getRegLevelId() {
        return RegLevelId;
    }

    public void setRegLevelId(String regLevelId) {
        RegLevelId = regLevelId;
    }

    public String getDeptId() {
        return DeptId;
    }

    public void setDeptId(String deptId) {
        DeptId = deptId;
    }

    public String getRegNo() {
        return RegNo;
    }

    public void setRegNo(String regNo) {
        RegNo = regNo;
    }

    public Double getTotalFee() {
        return TotalFee;
    }

    public void setTotalFee(Double totalFee) {
        TotalFee = totalFee;
    }

    public Double getDiagnoseFee() {
        return DiagnoseFee;
    }

    public void setDiagnoseFee(Double diagnoseFee) {
        DiagnoseFee = diagnoseFee;
    }

    public Double getRegFee() {
        return RegFee;
    }

    public void setRegFee(Double regFee) {
        RegFee = regFee;
    }

    public Double getInspectFee() {
        return InspectFee;
    }

    public void setInspectFee(Double inspectFee) {
        InspectFee = inspectFee;
    }

    public Double getSpclFee() {
        return SpclFee;
    }

    public void setSpclFee(Double spclFee) {
        SpclFee = spclFee;
    }

    public String getCouponInfo() {
        return CouponInfo;
    }

    public void setCouponInfo(String couponInfo) {
        CouponInfo = couponInfo;
    }

    public Double getRmngNum() {
        return RmngNum;
    }

    public void setRmngNum(Double rmngNum) {
        RmngNum = rmngNum;
    }

    public Integer getIfFee() {
        return IfFee;
    }

    public void setIfFee(Integer ifFee) {
        IfFee = ifFee;
    }

    public Integer getIsactive() {
        return isactive;
    }

    public void setIsactive(Integer isactive) {
        this.isactive = isactive;
    }

    public Date getUpdate() {
        return update;
    }

    public void setUpdate(Date update) {
        this.update = update;
    }

    public String getUpdatebdy() {
        return updatebdy;
    }

    public void setUpdatebdy(String updatebdy) {
        this.updatebdy = updatebdy;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public String getCreatedby() {
        return createdby;
    }

    public void setCreatedby(String createdby) {
        this.createdby = createdby;
    }

    public Double getFee() {
        return Fee;
    }

    public void setFee(Double fee) {
        Fee = fee;
    }

    public String getSettleDate() {
        return SettleDate;
    }

    public void setSettleDate(String settleDate) {
        SettleDate = settleDate;
    }

    public String getTradeSerialNumber() {
        return TradeSerialNumber;
    }

    public void setTradeSerialNumber(String tradeSerialNumber) {
        TradeSerialNumber = tradeSerialNumber;
    }

    public String getVisitTime() {
        return VisitTime;
    }

    public void setVisitTime(String visitTime) {
        VisitTime = visitTime;
    }
}
