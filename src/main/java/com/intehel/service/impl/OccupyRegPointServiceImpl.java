package com.intehel.service.impl;

import com.alibaba.fastjson.JSON;
import com.intehel.dao.OccupyRegPointMapper;
import com.intehel.dao.PayForRecipesMapper;
import com.intehel.service.OccupyRegPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;

@Service("OccupyRegPointService")
public class OccupyRegPointServiceImpl  implements OccupyRegPointService {


    @Autowired
    OccupyRegPointMapper occupyRegPointMapper;
    @Autowired
    PayForRecipesMapper payForRecipesMapper;
    /**
     * 患者占号点信息入库
     * @param maps
     * @param scheduleTime
     * @param scheduleId
     * @param outpatientId
     * @param regLevelId
     * @param deptId
     */
    @Transactional
    @Override
    public void createReg(Map<String, Object> maps, String scheduleTime, String scheduleId, String outpatientId, String regLevelId, String deptId) {
        Object departments = maps.get("Departments");
        String str=departments.toString().replace("{","").replace("}","").
                replace("[","{").replace("]","}").replace("=",":");
        Map map = (Map)JSON.parse(str);
        occupyRegPointMapper.createReg(scheduleId,scheduleTime,outpatientId,regLevelId,deptId,
                map.get("RegNo").toString(),map.get("TotalFee").toString(),map.get("DiagnoseFee").toString(),map.get("RegFee").toString(),
                map.get("InspectFee").toString(),map.get("SpclFee").toString(),map.get("CouponInfo")==null?"":map.get("CouponInfo").toString(),
                map.get("RmngNum").toString(),new Date());

        //查询支付表是是否已存在
        int a=Integer.parseInt(map.get("TotalFee").toString())*100;
        boolean b = payForRecipesMapper.selectPat(outpatientId, map.get("RegNo").toString(),a+"") == 0;
        System.err.println("支付表是是否已存在"+b);
        if (b){
            payForRecipesMapper.createPat(outpatientId,map.get("RegNo").toString(),"",a+"","1");
        }

        System.err.println("占号点入库成功");

    }

    /**
     * 支付结果入库
     * @param regNo
     * @param paymentWay
     * @param fee
     * @param settleDate
     * @param tradeSerialNumber
     */
    @Override
    public void updateReg(String regNo, String paymentWay, String fee, String settleDate, String tradeSerialNumber) {
        occupyRegPointMapper.updateReg(regNo,paymentWay,fee,settleDate,tradeSerialNumber,new Date());

    }

    /**
     * 查询是否已支付
     * @param regNo
     * @param fee
     * @return
     */
    @Override
    public int selectGH(String regNo, String fee) {
        int a=occupyRegPointMapper.selectGH(regNo,fee);
        return a;
    }
}
