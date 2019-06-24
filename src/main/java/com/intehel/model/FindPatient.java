package com.intehel.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 患者信息
 */

@Table(name = "TB_FIND_PATIENT")
public class FindPatient {
    @Id
    @Column(name = "ID")
    private String OutpatientId;
    @Column(name = "CardType")
    private String CardType;
    @Column(name = "CardNo")
    private String CardNo;
    @Column(name = "Balance")
    private Double Balance;
    @Column(name = "Limit")
    private String Limit;
    @Column(name = "CreateTime")
    private String CreateTime;
    @Column(name = "CardName")
    private String CardName;
    @Column(name = "Enable")
    private Boolean Enable;
    @Column(name = "isactive")
    private String isactive;
    @Column(name = "update")
    private Date update;
    @Column(name = "updatebdy")
    private String updatebdy;
    @Column(name = "created")
    private Date created;
    @Column(name = "createdby")
    private String createdby;

    public String getOutpatientId() {
        return OutpatientId;
    }

    public void setOutpatientId(String id) {
        this.OutpatientId = id;
    }

    public String getCardType() {
        return CardType;
    }

    public void setCardType(String cardType) {
        CardType = cardType;
    }

    public String getCardNo() {
        return CardNo;
    }

    public void setCardNo(String cardNo) {
        CardNo = cardNo;
    }

    public Double getBalance() {
        return Balance;
    }

    public void setBalance(Double balance) {
        Balance = balance;
    }

    public String getLimit() {
        return Limit;
    }

    public void setLimit(String limit) {
        Limit = limit;
    }

    public String getCreateTime() {
        return CreateTime;
    }

    public void setCreateTime(String createTime) {
        CreateTime = createTime;
    }

    public String getCardName() {
        return CardName;
    }

    public void setCardName(String cardName) {
        CardName = cardName;
    }

    public Boolean getEnable() {
        return Enable;
    }

    public void setEnable(Boolean enable) {
        Enable = enable;
    }

    public String getIsactive() {
        return isactive;
    }

    public void setIsactive(String isactive) {
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
}
