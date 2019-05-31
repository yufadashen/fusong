package com.intehel.common.util;

import org.w3c.dom.Document;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by ll on 2018/3/13.
 */


    public class HttpPostTest {



        void testPost(String urlStr) {
            try {
                URL url = new URL(urlStr);
                URLConnection con = url.openConnection();
                con.setDoOutput(true);
//                con.setRequestProperty("Pragma:", "no-cache");
                con.setRequestProperty("Cache-Control", "no-cache");
                con.setRequestProperty("Content-Type", "text/xml");

                OutputStreamWriter out = new OutputStreamWriter(con
                        .getOutputStream());
                String xmlInfo = getXmlInfo();
                System.out.println("urlStr=" + urlStr);
                System.out.println("xmlInfo=" + xmlInfo);
                out.write(new String(xmlInfo.getBytes("UTF-8")));
                out.flush();
                out.close();
                BufferedReader br = new BufferedReader(new InputStreamReader(con
                        .getInputStream()));
                String line = "";
                for (line = br.readLine(); line != null; line = br.readLine()) {
                    System.out.println(line);
                }
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        private String getXmlInfo() {
            StringBuilder sb = new StringBuilder();
            sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            sb.append("<DeptsRequest>");
            sb.append("<UpdateDateStart>20130101020202</UpdateDateStart><UpdateDateEnd>20190718020202 </UpdateDateEnd></DeptsRequest>");
            sb.append("</DeptsRequest>");
            return sb.toString();
        }

        public static void main(String[] args) {
            String urls = "http://192.9.10.42:10110/ServiceForXml.asmx/GetDepts";
            new HttpPostTest().testPost(urls);

            String xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?><DeptsRequest> <UpdateDateStart>20130101020202</UpdateDateStart><UpdateDateEnd>20190718020202 </UpdateDateEnd></DeptsRequest>";
            byte[] xmlData = xmlString.getBytes();
            String urlStr = "http://192.9.10.42:10110/ServiceForXml.asmx/GetDepts";
            DataInputStream input = null;
            java.io.ByteArrayOutputStream out = null;
            try{
                //获得到位置服务的链接
                URL url = new URL(urlStr);
                URLConnection urlCon = url.openConnection();
                urlCon.setDoOutput(true);
                urlCon.setDoInput(true);
                urlCon.setUseCaches(false);
                //将xml数据发送到位置服务
                urlCon.setRequestProperty("Content-Type", "text/xml");
                urlCon.setRequestProperty("Content-length",String.valueOf(xmlData.length));
                DataOutputStream printout = new DataOutputStream(urlCon.getOutputStream());
                printout.write(xmlData);
                printout.flush();
                printout.close();
                input = new DataInputStream(urlCon.getInputStream());
                byte[] rResult;
                out = new java.io.ByteArrayOutputStream();
                byte[] bufferByte = new byte[256];
                int l = -1;
                int downloadSize = 0;
                while ((l = input.read(bufferByte)) > -1) {
                    downloadSize += l;
                    out.write(bufferByte, 0, l);
                    out.flush();
                }
                rResult = out.toByteArray();
                DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                DocumentBuilder db = dbf.newDocumentBuilder();
                Document d = db.parse(new ByteArrayInputStream(rResult));
                String TaskAddr = d.getElementsByTagName("TaskAddr").item(0).getFirstChild().getNodeValue();
                System.out.println("TaskAddr:"+TaskAddr);
            }
            catch(Exception e){
                e.printStackTrace();
            }
            finally {
                try {
                    out.close();
                    input.close();
                }
                catch (Exception ex) {
                }
            }
        }

}
