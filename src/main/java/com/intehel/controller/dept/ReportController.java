package com.intehel.controller.dept;

import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.util.Map;


/**
 * PACS报告 LIS报告 查询
 */
@Controller
public class ReportController {

    @Value("${hisUrl}")
    private String hisUrl="http://192.9.10.42:10110";
    /**
     * 查询PACS报告列表
     * @param RegNos    挂号流水号集合
     * @param InpatientSeriNos  住院流水号集合 OutPatientIds为空则InpatientSeriNos不为空
     * @param OutPatientIds 患者门诊ID集合    InpatientSeriNos为空则OutPatientIds不为空
     * @param TestDateStart 检查日期开始  格式yyyyMMdd
     * @param TestDateEnd   检查日期结束  格式yyyyMMdd
     * @param UpdateDateStart   根据最后更新时间查询数据，时间段开始
     * @param UpdateDateEnd 根据最后更新时间查询数据，时间段结束
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetPacsReportList",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetPacsReportList(String RegNos,String InpatientSeriNos,String OutPatientIds,String TestDateStart,String TestDateEnd,String UpdateDateStart,String UpdateDateEnd) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetPacsReportList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
                            "<ReportInfoRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId />" +
                            "<RegNos>" +
                            "<string>43249235843</string>" +
                            "<string>124324325</string>" +
                            "</RegNos>" +
                            "<InpatientSeriNos>" +
                            "<string>xxxx123</string>" +
                            "<string>xxcc234</string>" +
                            "</InpatientSeriNos>" +
                            "<OutPatientIds>" +
                            "<string>wr123424</string>" +
                            "<string>er323233</string>" +
                            "</OutPatientIds>" +
                            "<TestDateStart>yyyyMMdd</TestDateStart>" +
                            "<TestDateEnd>yyyyMMdd</TestDateEnd>" +
                            "<UpdateDateStart>yyyyMMddHHmmss</UpdateDateStart>" +
                            "<UpdateDateEnd>yyyyMMddHHmmss</UpdateDateEnd>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key>x</Key>" +
                            "<Value/>" +
                            "</ExtItem>" +
                            "</ExtParams>" +
                            "</ReportInfoRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
//            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (str==null){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }else if (str.length()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }

    /**
     * 查看PACS报告详情
     * @param ReportId  ReportId
     * @param InpatientSeriNo   InpatientSeriNo
     * @param OutpatientId  OutpatientId
     * @param CheckTime CheckTime
     * @param CheckPoint    CheckPoint
     * @param MachineCode   MachineCode
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetPacsReport",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetPacsReport(String ReportId,String InpatientSeriNo,String OutpatientId,String CheckTime,String CheckPoint,String MachineCode) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetPacsReport?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
                            "<ReportInfoRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId />" +
                            "<RegNos>" +
                            "<string>43249235843</string>" +
                            "<string>124324325</string>" +
                            "</RegNos>" +
                            "<InpatientSeriNos>" +
                            "<string>xxxx123</string>" +
                            "<string>xxcc234</string>" +
                            "</InpatientSeriNos>" +
                            "<OutPatientIds>" +
                            "<string>wr123424</string>" +
                            "<string>er323233</string>" +
                            "</OutPatientIds>" +
                            "<TestDateStart>yyyyMMdd</TestDateStart>" +
                            "<TestDateEnd>yyyyMMdd</TestDateEnd>" +
                            "<UpdateDateStart>yyyyMMddHHmmss</UpdateDateStart>" +
                            "<UpdateDateEnd>yyyyMMddHHmmss</UpdateDateEnd>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key>x</Key>" +
                            "<Value/>" +
                            "</ExtItem>" +
                            "</ExtParams>" +
                            "</ReportInfoRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
//            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (str==null){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }else if (str.length()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


    /**
     * 查询LIS报告列表
     * @param RegNos    挂号流水号集合
     * @param InpatientSeriNos  住院流水号集合
     * @param OutPatientIds 患者门诊ID集合
     * @param TestDateStart 检查日期开始
     * @param TestDateEnd   检查日期结束
     * @param UpdateDateStart   根据最后更新时间查询数据，时间段开始
     * @param UpdateDateEnd 根据最后更新时间查询数据，时间段结束
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetLisReportList",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetLisReportList(String RegNos,String InpatientSeriNos,String OutPatientIds,String TestDateStart,String TestDateEnd,String UpdateDateStart,String UpdateDateEnd) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetLisReportList?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
                            "<ReportInfoRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<HospId />" +
                            "<RegNos>" +
                            "<string>43249235843</string>" +
                            "<string>124324325</string>" +
                            "</RegNos>" +
                            "<InpatientSeriNos>" +
                            "<string>xxxx123</string>" +
                            "<string>xxcc234</string>" +
                            "</InpatientSeriNos>" +
                            "<OutPatientIds>" +
                            "<string>wr123424</string>" +
                            "<string>er323233</string>" +
                            "</OutPatientIds>" +
                            "<TestDateStart>yyyyMMdd</TestDateStart>" +
                            "<TestDateEnd>yyyyMMdd</TestDateEnd>" +
                            "<UpdateDateStart>yyyyMMddHHmmss</UpdateDateStart>" +
                            "<UpdateDateEnd>yyyyMMddHHmmss</UpdateDateEnd>" +
                            "<ExtParams>" +
                            "<ExtItem>" +
                            "<Key>x</Key>" +
                            "<Value />" +
                            "</ExtItem>" +
                            "</ExtParams>" +
                            "</ReportInfoRequest>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
//            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (str==null){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }else if (str.length()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


    /**
     * 查看LIS报告详情
     * @param RegNo 挂号流水号
     * @param CheckTime 检查时间
     * @param MachineCode   检查机器号
     * @param ReportId  报告ID
     * @param SampleId  样本ID
     * @return
     */
    @ResponseBody
    @CrossOrigin
    @RequestMapping(value = "/GetLisReport",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String GetLisReport(String RegNo,String CheckTime,String MachineCode,String ReportId,String SampleId) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetLisReport?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                            "<LisReportResponse xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                            "<Code>0</Code>" +
                            "<Message/>" +
                            "<ReportDetail>" +
                            "<ConfirmDrName/>" +
                            "<ConfirmDrId/>" +
                            "<FileUrl/>" +
                            "<ImageUrl/>" +
                            "<Items>" +
                            "<LisItem>" +
                            "<Flag/>" +
                            "<ItemName/>" +
                            "<ItemNo/>" +
                            "<Range/>" +
                            "<ReportId/>" +
                            "<Result/>" +
                            "<Unit/>" +
                            "<ExtItems>" +
                            " <ExtItem>" +
                            "<Key>itemName</Key>" +
                            " <Value xsi:type=\"xsd:string\">itemValue</Value>" +
                            " </ExtItem>" +
                            "</ExtItems>" +
                            "</LisItem>" +
                            "</Items>" +
                            "<PatientId/>" +
                            "<PatientName/>" +
                            "<ReportId/>" +
                            "<ReportName/>" +
                            "<SampleDateTime/>" +
                            "<VisitType>0</VisitType>" +
                            "<CheckDate/>" +
                            "<CheckDrId/>" +
                            "<CheckDrName/>" +
                            "<ConfirmTime/>" +
                            "<InPatientId/>" +
                            "<MachineCode/>" +
                            "<RegNo/>" +
                            "<SampleId/>" +
                            "<ExtItems>" +
                            "    <ExtItem>\n" +
                            "      <Key>itemName</Key>\n" +
                            "      <Value xsi:type=\"xsd:string\">itemValue</Value>\n" +
                            "    </ExtItem>\n" +
                            "  </ExtItems>\n" +
                            "\t</ReportDetail>\n" +
                            "<ExtItems>\n" +
                            "    <ExtItem>\n" +
                            "      <Key>itemName</Key>\n" +
                            "      <Value xsi:type=\"xsd:string\">itemValue</Value>\n" +
                            "    </ExtItem>\n" +
                            "  </ExtItems>\n" +
                            "</LisReportResponse>","utf-8");
            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
//            System.err.println(str);
        }catch (Exception e){
            e.printStackTrace();
            return "{\"Message\":\"输入内容有误\",\"Code\":\"-1\"}";
        }
        if (str==null){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }else if (str.length()<1){
            return "{\"Message\":\"获取失败\",\"Code\":\"-1\"}";
        }
        // 解析XML
        Map<String,Map> map=XmlJsonUtils.readStringXmlOut(str);
        System.err.println(JsonUtil.toString(map));
        return JsonUtil.toString(map);
    }


}
