package com.intehel.service.impl;

import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.Result;
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

    @Override
    public String selectAllMZ(String startTime, String endTime) {
        System.err.println("开始时间="+startTime+"    结束时候="+endTime);
        List<Reconciliation> list=reconciliationMapper.selectAllMZ(startTime,endTime);
        Map<String,List> map=new HashMap<>();

        map.put("list",list);
        return JsonUtil.toString(map);
    }

    @Override
    public String selectAllZY(String startTime, String endTime) {
        System.err.println("开始时间="+startTime+"    结束时候="+endTime);
        List<Reconciliation> list=reconciliationMapper.selectAllZY(startTime,endTime);
        Map<String,List> map=new HashMap<>();

        map.put("list",list);
        return JsonUtil.toString(map);
    }

    @Override
    public String selectAllTJ(String startTime, String endTime) {
        //查询挂号统计
        Map<String,String> map1=new HashMap<>();
        Reconciliation re1= reconciliationMapper.selectAllTJ(startTime,endTime,"1");
        map1.put("ghCount", re1.getCount());
        map1.put("ghSum", re1.getSum()==null?"0":re1.getSum());
        //查询门诊统计
        Map<String,String> map2=new HashMap<>();
        Reconciliation re2= reconciliationMapper.selectAllTJ(startTime,endTime,"2");
        map2.put("mzCount", re2.getCount());
        map2.put("mzSum", re2.getSum()==null?"0":re2.getSum());
        //查询住院统计
        Map<String,String> map3=new HashMap<>();
        Reconciliation re3= reconciliationMapper.selectAllTJ(startTime,endTime,"3");
        map3.put("zyCount", re3.getCount());
        map3.put("zySum", re3.getSum()==null?"0":re3.getSum());
        //合计
        Map<String,String> map4=new HashMap<>();
        Reconciliation re4= reconciliationMapper.selectAllTJs(startTime,endTime);
        map4.put("count", re4.getCount());
        map4.put("sum", re4.getSum()==null?"0":re4.getSum());

        Map<String,Map> map=new HashMap<>();
        map.put("gh1",map1);
        map.put("mz2",map2);
        map.put("zy3",map3);
        map.put("hj",map4);
        return Result.success(map);
    }
}
