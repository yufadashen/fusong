package com.intehel.controller.dept;

import com.intehel.common.util.GetHttpString;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class GetDeptsMain {

    private static final Log log = LogFactory.getLog(GetDeptsMain.class);

    /**
     * 获取科室信息
     * @param UpdateDateStart  更新时间，可不传
     * @param UpdateDateEnd 结束时间，可不传
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetDepts",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetDepts(String UpdateDateStart,String UpdateDateEnd) {

        String str=GetHttpString.xmlJson0("GetDepts","DeptsRequest",UpdateDateStart,UpdateDateEnd);
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));


        return JsonUtil.toString(map);
    }

    /**
     * 根基可是id查询医生信息
     * @param DeptId    科室id 必传
     * @param UpdateDateStart
     * @param UpdateDateEnd
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetEmployees",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetEmployees(String DeptId,String UpdateDateStart,String UpdateDateEnd) {

        String str=GetHttpString.xmlJson1("GetEmployees","EmployeesRequest","DeptId",DeptId ,UpdateDateStart,UpdateDateEnd);
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 查询午别信息
     * @param UpdateDateStart
     * @param UpdateDateEnd
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetNoonInfos",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetNoonInfos(String UpdateDateStart,String UpdateDateEnd) {
                String str=GetHttpString.xmlJson0("GetNoonInfos","UpdateDateStart" ,UpdateDateStart,UpdateDateEnd);
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     *2.4 查询就诊卡类型
     * @param UpdateDateStart
     * @param UpdateDateEnd
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetCardTypes",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetCardTypes(String UpdateDateStart,String UpdateDateEnd) {
        String str=GetHttpString.xmlJson0("GetCardTypes","CardTypesRequest" ,UpdateDateStart,UpdateDateEnd);
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

}
