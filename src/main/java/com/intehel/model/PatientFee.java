package com.intehel.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "TB_PATIENT_FEE")
public class PatientFee {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "OutpatientId")
    private String OutpatientId;

    @Column(name = "RegNo")
    private String RegNo;

    @Column(name = "RegDate")
    private String RegDate;

    @Column(name = "RecipeNo")
    private String RecipeNo;

    @Column(name = "SysType")
    private String SysType;

    @Column(name = "ItemName")
    private String ItemName;

    @Column(name = "ItemSpec")
    private String ItemSpec;

    @Column(name = "DosageSpec")
    private String DosageSpec;

    @Column(name = "ItemNum")
    private String ItemNum;

    @Column(name = "TotalCost")
    private String TotalCost;

    @Column(name = "PaymentStatus")
    private String PaymentStatus;

    @Column(name = "OperDate")
    private String OperDate;

    @Column(name = "CancelFlag")
    private String CancelFlag;

    @Column(name = "RecipeDrName")
    private String RecipeDrName;

    @Column(name = "FeeDate")
    private String FeeDate;

    @Column(name = "created")
    private Date created;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOutpatientId() {
        return OutpatientId;
    }

    public void setOutpatientId(String outpatientId) {
        OutpatientId = outpatientId;
    }

    public String getRegNo() {
        return RegNo;
    }

    public void setRegNo(String regNo) {
        RegNo = regNo;
    }

    public String getRegDate() {
        return RegDate;
    }

    public void setRegDate(String regDate) {
        RegDate = regDate;
    }

    public String getRecipeNo() {
        return RecipeNo;
    }

    public void setRecipeNo(String recipeNo) {
        RecipeNo = recipeNo;
    }

    public String getSysType() {
        return SysType;
    }

    public void setSysType(String sysType) {
        SysType = sysType;
    }

    public String getItemName() {
        return ItemName;
    }

    public void setItemName(String itemName) {
        ItemName = itemName;
    }

    public String getItemSpec() {
        return ItemSpec;
    }

    public void setItemSpec(String itemSpec) {
        ItemSpec = itemSpec;
    }

    public String getDosageSpec() {
        return DosageSpec;
    }

    public void setDosageSpec(String dosageSpec) {
        DosageSpec = dosageSpec;
    }

    public String getItemNum() {
        return ItemNum;
    }

    public void setItemNum(String itemNum) {
        ItemNum = itemNum;
    }

    public String getTotalCost() {
        return TotalCost;
    }

    public void setTotalCost(String totalCost) {
        TotalCost = totalCost;
    }

    public String getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        PaymentStatus = paymentStatus;
    }

    public String getOperDate() {
        return OperDate;
    }

    public void setOperDate(String operDate) {
        OperDate = operDate;
    }

    public String getCancelFlag() {
        return CancelFlag;
    }

    public void setCancelFlag(String cancelFlag) {
        CancelFlag = cancelFlag;
    }

    public String getRecipeDrName() {
        return RecipeDrName;
    }

    public void setRecipeDrName(String recipeDrName) {
        RecipeDrName = recipeDrName;
    }

    public String getFeeDate() {
        return FeeDate;
    }

    public void setFeeDate(String feeDate) {
        FeeDate = feeDate;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }
}
