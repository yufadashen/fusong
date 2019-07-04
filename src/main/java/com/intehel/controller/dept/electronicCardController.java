package com.intehel.controller.dept;

import com.intehel.common.util.HttpUtils;
import com.intehel.common.util.JsonUtil;
import com.intehel.common.util.XmlJsonUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.util.Date;
import java.util.Map;

/**
 * 电子健康卡
 */
@Controller
public class electronicCardController {

    @Value("${hisUrl}")
    private String hisUrl="http://192.9.10.42:10110";
    /**
     * 获取token
     * @param OrgCode   HIS厂商提供医疗机构编码
     * @param Secret    由格润服务平台分配的秘钥
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetAppToken",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetAppToken(String OrgCode,String Secret) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetAppToken?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<AppTokenRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
                            "<OrgCode>" +OrgCode+ "</OrgCode>" +
                            "<Secret>"+Secret +"<Secret>" +
                            "</AppTokenRequest>","utf-8");

            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
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
     * 电子健康卡身份识别
     * @param OrgCode   HIS厂商提供医疗机构编码
     * @param OrgCodeId 由格润服务平台分配的秘钥
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetUserInfo",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetUserInfo(String OrgCode,String OrgCodeId) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetUserInfo?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<UserInfoRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
                            "<OrgCode>" +OrgCode+ "</OrgCode>" +
                            "<OrgCodeId>"+OrgCodeId +"<OrgCodeId>" +
                            "</UserInfoRequest>","utf-8");

            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
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
     * 电子健康卡注册
     * @param Secret    由格润服务平台分配秘钥
     * @param Username  姓名
     * @param Gender    性别
     * @param Nation    民族
     * @param IdCardType    证件类别
     * @param IdCard    证件号码（身份证号）
     * @param mobilePhone   手机号
     * @param Birth 出生日期
     * @param Address   住址
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetRegister",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetRegister(String Secret,String Username,String Gender,String Nation,String IdCardType,String IdCard,String mobilePhone,String Birth,String Address) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetRegister?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<RegisterRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
                            "<Secret>" +Secret+"<Secret>" +
                            "<Username>"+Username +"<Username>" +
                            "<Gender>"+Gender +"<Gender>" +
                            "<Nation>" +Nation+"<Nation>" +
                            "<IdCardType>" +IdCardType+"<IdCardType>" +
                            "<IdCard>" +IdCard+"<IdCard>" +
                            "<mobilePhone>"+mobilePhone +"<mobilePhone>" +
                            "<Birth>"+Birth +"<Birth>" +
                            "<Address>" +Address+"<Address>" +
                            "</RegisterRequest>","utf-8");

            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
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
     * 电子健康卡查询
     * @param Secret    由格润服务平台分配秘钥
     * @param EcardId   电子健康id
     * @param IdCardType    证件类别
     * @param IdCard    证件号码
     * @param QrcodeFlag    是否返回二维码，0不返回（默认值），1返回。
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetInfo",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetInfo(String Secret,String EcardId,String IdCardType,String IdCard,String QrcodeFlag) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetInfo?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<InforRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
                            "<Secret>" +Secret+"</Secret>" +
                            "<EcardId>"+EcardId +"</EcardId>" +
                            "<IdCardType>"+IdCardType +"</IdCardType>" +
                            "<IdCard>"+IdCard + "</IdCard>" +
                            "<QrcodeFlag>" +QrcodeFlag+"</QrcodeFlag>" +
                            "</InforRequest>","utf-8");

            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
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
     * 电子健康卡二维码
     * @param Secret    由格润服务平台分配秘钥
     * @param EcardId   电子健康id
     * @param QrcodeType    二维码类别，1是静态二维码
     * @param ImagePath 图片保存目录
     * @param GenType   返回数据格式。1返回base64编码字符串，2返回二维码图片完整路径。
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GetQrCode",method = RequestMethod.GET,produces = {"text/html;charset=utf-8"})
    public String GetQrCode(String Secret,String EcardId,String QrcodeType,String ImagePath,String GenType) {
        String str="";
        try {
            String strURL=hisUrl+"/ServiceForXml.asmx/GetQrCode?xmltxt="+
                    URLEncoder.encode("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                            "<QrCodeRequest xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
                            "<Secret>"+Secret + "</Secret>" +
                            "<EcardId>"+EcardId +"</EcardId>" +
                            "<QrcodeType>"+QrcodeType +"</QrcodeType>" +
                            "<ImagePath>" +ImagePath+"</ImagePath>" +
                            "<GenType>"+GenType +"</GenType>" +
                            "</QrCodeRequest>","utf-8");

            str = HttpUtils.httpGet(strURL);
            System.err.println(strURL);
            System.err.println(str);
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
