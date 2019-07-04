package com.intehel.controller.sys;

import com.intehel.service.ReconciliationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ReconciliationController {


    @Autowired
    ReconciliationService reconciliationService;
    /**
     * 根据时间查询挂号接口对账
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @return
     */
//    @RequestMapping("ReconciliationGH")
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReconciliationGH",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReconciliationGH(String startTime,String endTime) {

        String str = reconciliationService.selectAll(startTime,endTime);
        System.out.println(str);
        return str;
    }
    /**
     * 根据时间查询门诊接口对账
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @return
     */
//    @RequestMapping("ReconciliationGH")
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReconciliationMZ",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReconciliationMZ(String startTime,String endTime) {

        String str = reconciliationService.selectAllMZ(startTime,endTime);
        System.out.println(str);
        return str;
    }

    /**
     * 根据时间查询住院接口对账
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReconciliationZY",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReconciliationZY(String startTime,String endTime) {

        String str = reconciliationService.selectAllZY(startTime,endTime);
        System.out.println(str);
        return str;
    }


    /**
     * 根据时间统计对账数据
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/ReconciliationTJ",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String ReconciliationTJ(String startTime,String endTime) {

        String str = reconciliationService.selectAllTJ(startTime,endTime);
        System.out.println(str);
        return str;
    }
}
