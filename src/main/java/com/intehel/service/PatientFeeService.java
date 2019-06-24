package com.intehel.service;

import java.util.Map;

public interface PatientFeeService {
    void createPatient(Map<String,Object> map);

    void updatePay(String regNo, String recipeNos, String totalFee, String tradeSerialNumber, String paymentWay, String settleDate, String pay);
}
