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


}
