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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
public class GetDeptsMain {

    private static final Log log = LogFactory.getLog(GetDeptsMain.class);
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    /**
     * 获取科室信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetDepts",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetDepts() {
        String str=GetHttpString.xmlJson0("GetDepts","DeptsRequest","20120101020202",df.format(new Date()));
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 根基可是id查询医生信息
     * @param DeptId    科室id 必传
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetEmployees",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetEmployees(String DeptId) {
        String str=GetHttpString.xmlJson1("GetEmployees","EmployeesRequest","DeptId",DeptId ,"20120101020202",df.format(new Date()));
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 查询午别信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetNoonInfos",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetNoonInfos() {
                String str=GetHttpString.xmlJson0("GetNoonInfos","UpdateDateStart" ,"20120101020202",df.format(new Date()));
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     *2.4 查询就诊卡类型
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetCardTypes",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetCardTypes() {
        String str=GetHttpString.xmlJson0("GetCardTypes","CardTypesRequest" ,"20120101020202",df.format(new Date()));
        System.err.println(str);
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

}
