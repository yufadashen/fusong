package com.intehel.service.impl;

import com.intehel.common.util.JsonUtil;
import com.intehel.dao.ReconciliationMapper;
import com.intehel.model.Reconciliation;
import com.intehel.service.ReconciliationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ReconciliationService")
public class ReconciliationServiceImpl  extends BaseServiceImpl<Reconciliation> implements ReconciliationService {




    @Autowired
    ReconciliationMapper reconciliationMapper;

    @Override
    public String selectAll(String startTime, String endTime) {
        System.err.println("开始时间="+startTime+"    结束时候="+endTime);
        List<Reconciliation> list=reconciliationMapper.selectAlls(startTime,endTime);
        Map<String,List> map=new HashMap<>();

        map.put("list",list);
        return JsonUtil.toString(map);
//        return "";
    }
}
