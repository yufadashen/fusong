package com.intehel.common.util;


import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;


import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @author Almostman
 *
 * @Desc Http工具类
 *
 * @date 2016-5-27 下午5:19:11
 */
public class HttpUtils {
    // get请求
    public static String httpGet(String urlAddr) {
        HttpURLConnection conn = null;
        try {
//<?xml version="1.0" encoding="UTF-8"?><RegInfosRequest><HospId/><IsSee>false</IsSee><IsNiox>1</IsNiox><OutpatientIds>0051522299</OutpatientIds><RegNos>6118003</RegNos><UpdateDateStart>20120101</UpdateDateStart><UpdateDateEnd>20190605</UpdateDateEnd><RegDateStart>20190602</RegDateStart><RegDateEnd>20190606</RegDateEnd><ExtParams><ExtItem><Key></Key><Value/></ExtItem></ExtParams></RegInfosRequest>
            URL url = new URL(urlAddr.toString()); // 创建URL对象
            // 返回一个URLConnection对象，它表示到URL所引用的远程对象的连接
            conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(5000); // 设置连接超时为5秒
            conn.setRequestMethod("GET"); // 设定请求方式
            // conn.setRequestProperty("User-Agent",
            // "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0");
            conn.connect(); // 建立到远程对象的实际连接
            // 返回打开连接读取的输入流
//            System.err.println(urlAddr);
            DataInputStream dis = new DataInputStream(conn.getInputStream());
            String backData = new String(readStream(dis),"utf-8");
            //System.out.println(">>-----------: " + backData);
            backData=backData.replace("</string>","").
                    replace("<?xml version=\"1.0\" encoding=\"utf-8\"?>","").
                    replace("<string xmlns=\"http://tempuri.org/\">&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;","").
                    replace("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"","");
            backData=backData.replace("&lt;","<").replace("&gt;",">");
            return backData;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("这是异常！");
        } finally {
            if (conn != null) {
                conn.disconnect(); // 中断连接
            }
        }
        return null;
    }

    private static byte[] readStream(InputStream inputStream) throws Exception {
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = inputStream.read(buffer)) != -1) {
            bout.write(buffer, 0, len);
        }
        bout.close();
        inputStream.close();

        return bout.toByteArray();
    }


}
