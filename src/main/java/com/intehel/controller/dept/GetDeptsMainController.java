package com.intehel.controller.dept;

import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
public class GetDeptsMainController {


    @Value("${hisUrl}")
    private String hisUrl="http://172.9.10.42:10110";
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
        String str=xmlJson0("GetDepts","DeptsRequest","20120101020202",df.format(new Date()));
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
        String str=xmlJson1("GetEmployees","EmployeesRequest","DeptId",DeptId ,"20120101020202",df.format(new Date()));
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
                String str=xmlJson0("GetNoonInfos","UpdateDateStart" ,"20120101020202",df.format(new Date()));
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
        String str=xmlJson0("GetCardTypes","CardTypesRequest" ,"20120101020202",df.format(new Date()));
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










    public  String xmlJson1(String method,String head,String body1Name,String body1Value,String UpdateDateStart,String UpdateDateEnd){
        UpdateDateEnd=UpdateDateEnd==null?"20190718020202":UpdateDateEnd;
        UpdateDateStart=UpdateDateStart==null?"20120101020202":UpdateDateStart;
        String str="";
        try {
//            "</UpdateDateStart><UpdateDateEnd>20190718020202 </UpdateDateEnd><EmplType></EmplType><DeptId>7936</DeptId></EmployeesRequest> "
            String strURL=hisUrl+"/ServiceForXml/"+method+"?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><"+head+"> <UpdateDateStart>"+
                            UpdateDateStart+"</UpdateDateStart><UpdateDateEnd>"+
                            UpdateDateEnd+" </UpdateDateEnd><EmplType></EmplType><"+body1Name+">"+body1Value+"</"+body1Name+"></"+
                            head+">","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);

        }catch (Exception e){
            e.printStackTrace();
        }
        return str;
    }

    public  String xmlJson0(String method,String head,String UpdateDateStart,String UpdateDateEnd){
        UpdateDateEnd=UpdateDateEnd==null?"20190718020202":UpdateDateEnd;
        UpdateDateStart=UpdateDateStart==null?"20120101020202":UpdateDateStart;
        String str="";

        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/"+method+"?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?><"+head+"> <UpdateDateStart>"+
                            UpdateDateStart+"</UpdateDateStart><UpdateDateEnd>"+
                            UpdateDateEnd+" </UpdateDateEnd></"+
                            head+">","utf-8");
            System.err.println(str);
            System.err.println(strURL);
            str = HttpUtils.httpGet(strURL);

        }catch (Exception e){
            e.printStackTrace();
        }
        return str;
    }
}
