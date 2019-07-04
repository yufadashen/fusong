package com.intehel.service;

public interface ReconciliationService {
    String selectAll(String startTime, String endTime);

    String selectAllMZ(String startTime, String endTime);

    String selectAllZY(String startTime, String endTime);

    String selectAllTJ(String startTime, String endTime);
}
