package com.intehel.controller.dept;

import com.intehel.common.util.GetHttpString;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
public class GetDeptsMainController {

    Logger logger = Logger.getLogger(this.getClass().getName());
    private static final Log log = LogFactory.getLog(GetDeptsMainController.class);
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
    /**
     * 获取科室信息
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetDepts",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetDepts() {
        Map<String,Map> map=null;
        try {
        String str=GetHttpString.xmlJson0("GetDepts","DeptsRequest","20120101020202",df.format(new Date()));
        // 解析XML
            logger.info("获取科室信息"+str);
        map=XmlJsonUtils.readStringXmlOut(str);
    }catch (Exception e){
        e.printStackTrace();
        return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
    }
        if (map.size()<1){
        return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
    }
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 根基可是id查询医生信息
     * @param DeptId    科室id 必传
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetEmployees",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetEmployees(String DeptId) {
        Map<String,Map> map=null;
        try {
        String str=GetHttpString.xmlJson1("GetEmployees","EmployeesRequest","DeptId",DeptId ,"20120101020202",df.format(new Date()));
        // 解析XML
         map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
    }catch (Exception e){
        e.printStackTrace();
        return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
    }
        if (map.size()<1){
        return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
    }
        return JsonUtil.toString(map);
    }

    /**
     * 查询午别信息
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetNoonInfos",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetNoonInfos() {
        Map<String,Map> map=null;
        try {
                String str=GetHttpString.xmlJson0("GetNoonInfos","UpdateDateStart" ,"20120101020202",df.format(new Date()));
        System.err.println(str);
        // 解析XML
        map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        }catch (Exception e){
            e.printStackTrace();
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (map.size()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        return JsonUtil.toString(map);
    }

    /**
     *2.4 查询就诊卡类型
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetCardTypes",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetCardTypes() {
        Map<String,Map> map=null;
        try {
        String str=GetHttpString.xmlJson0("GetCardTypes","CardTypesRequest" ,"20120101020202",df.format(new Date()));
        System.err.println(str);
        // 解析XML
         map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
    }catch (Exception e){
        e.printStackTrace();
        return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
    }
        if (map.size()<1){
        return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
    }
        return JsonUtil.toString(map);
    }

}
