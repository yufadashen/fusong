package com.intehel.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "TB_PAY_FOR_RECIPES")
public class Reconciliation {

    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "RegNo")
    private String RegNo;

    @Column(name = "RecipeNos")
    private String RecipeNos;

    @Column(name = "TotalFee")
    private String TotalFee;

    @Column(name = "OutpatientId")
    private String OutpatientId;

    @Column(name = "PaymentWay")
    private String PaymentWay;

    @Column(name = "SettleDate")
    private String SettleDate;

    @Column(name = "TradeSerialNumber")
    private String TradeSerialNumber;

    @Column(name = "ifFee")
    private String ifFee;

    @Column(name = "isactive")
    private String isactive;

    @Column(name = "created")
    private Date created;

    @Column(name = "update")
    private Date update;

    @Column(name = "pay")
    private String pay;

    @Column(name = "InpatientSeriNo")
    private String InpatientSeriNo;

    @Column(name = "outTradeNo")
    private String outTradeNo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRegNo() {
        return RegNo;
    }

    public void setRegNo(String regNo) {
        RegNo = regNo;
    }

    public String getRecipeNos() {
        return RecipeNos;
    }

    public void setRecipeNos(String recipeNos) {
        RecipeNos = recipeNos;
    }

    public String getTotalFee() {
        return TotalFee;
    }

    public void setTotalFee(String totalFee) {
        TotalFee = totalFee;
    }

    public String getOutpatientId() {
        return OutpatientId;
    }

    public void setOutpatientId(String outpatientId) {
        OutpatientId = outpatientId;
    }

    public String getPaymentWay() {
        return PaymentWay;
    }

    public void setPaymentWay(String paymentWay) {
        PaymentWay = paymentWay;
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

    public String getIfFee() {
        return ifFee;
    }

    public void setIfFee(String ifFee) {
        this.ifFee = ifFee;
    }

    public String getIsactive() {
        return isactive;
    }

    public void setIsactive(String isactive) {
        this.isactive = isactive;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdate() {
        return update;
    }

    public void setUpdate(Date update) {
        this.update = update;
    }

    public String getPay() {
        return pay;
    }

    public void setPay(String pay) {
        this.pay = pay;
    }

    public String getInpatientSeriNo() {
        return InpatientSeriNo;
    }

    public void setInpatientSeriNo(String inpatientSeriNo) {
        InpatientSeriNo = inpatientSeriNo;
    }

    public String getOutTradeNo() {
        return outTradeNo;
    }

    public void setOutTradeNo(String outTradeNo) {
        this.outTradeNo = outTradeNo;
    }
}
