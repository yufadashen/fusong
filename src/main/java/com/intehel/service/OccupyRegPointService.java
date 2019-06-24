package com.intehel.service;

import java.util.Map;

public interface OccupyRegPointService {
    void createReg(Map<String,Object> map, String scheduleTime, String scheduleId, String outpatientId, String regLevelId, String deptId);

    void updateReg(String regNo, String paymentWay, String fee, String settleDate, String tradeSerialNumber);
}
