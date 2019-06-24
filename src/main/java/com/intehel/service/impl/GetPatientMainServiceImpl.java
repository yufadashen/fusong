package com.intehel.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.intehel.dao.FindPatientMapper;
import com.intehel.model.FindPatient;
import com.intehel.service.GetPatientMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
@Service("GetPatientMainService")
public class GetPatientMainServiceImpl     implements GetPatientMainService {



    @Autowired
    FindPatientMapper findPatientMapper;

    /**
     * 患者信息插入数据库
     * @param maps
     */
    @Transactional
    @Override
    public void createUser(Map<String, Object> maps,String Name) {
        Object departments = maps.get("Departments");
        String str = departments.toString().replace("[","").replace("]","").replace("=",":").replace(":,",":\"\",");
//        System.err.println(str);
        Map map = (Map)JSON.parse(str);

        //查询是否有数据SELECT COUNT("id") FROM TB_FIND_PATIENT  a WHERE  a."id"='122';
        int a = findPatientMapper.findUserId(map.get("OutpatientId").toString());
//        System.err.println("数据库数据查询成功"+a);
        Boolean bool=Boolean.valueOf(map.get("Enable").toString());
        if (a==0){
//            System.err.println(Boolean.valueOf(map.get("Enable").toString())+"数据类型不一致: 应为 BLOB, 但却获得 NUMBER");
            //插入
            findPatientMapper.createUser(map.get("OutpatientId").toString(),bool==false?0:1,map.get("Limit").
                    toString(),map.get("Balance").toString(),new Date(),Name);
        }else {
            //更新
            findPatientMapper.updateUser(map.get("OutpatientId").toString(),bool==false?0:1,map.get("Limit").
                    toString(),map.get("Balance").toString(),new Date(),Name);
        }

    }
}
