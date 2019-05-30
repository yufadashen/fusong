package com.intehel.common.util.pool;

import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TestThread extends Thread{
	
    public static void main(String[] args) throws UnsupportedEncodingException {
    	String name = "请13号，杨秀清，到妇科诊室3就诊，请00003号，沈佳，到妇科诊室3准备就诊";
    	String str = "http://127.0.0.1:801/?Func=Sound_Play&Info="+name+"&Cust=13";
    	String URL = new String(str.getBytes("UTF-8"), "GB2312");
//    	String URL = "http://127.0.0.1:801/?Func=Sound_Play&Info=12345678";
    	String encode = "utf-8";
    	test1(URL,encode);
    	
    }
    
   public static void test1(String URL, String encode) {
	    ExecutorService newFixedThreadPool = Executors.newFixedThreadPool(5);
	    for (int i = 0; i < 3; i++) {
		    final int index = i;
		    newFixedThreadPool.execute(new Runnable() {
		     
			    @Override
			    public void run() {
			    	String strOut = "";
					try
					{
						URL url;
						URLConnection urlConn;
						DataInputStream dis;
						url = new URL(URL);
						urlConn = url.openConnection();
						urlConn.setConnectTimeout(2000);
						urlConn.setReadTimeout(1000);
						urlConn.setDoInput(true);
						urlConn.setUseCaches(false);
						dis = new DataInputStream(urlConn.getInputStream());
						byte[] buffer = new byte[2048];
//						byte[] buffer = URL.getBytes("GBK");
						int length = 0;
						ByteArrayOutputStream outStream = new ByteArrayOutputStream();
						/*
						 * while ((length = (dis.read(buffer))) != -1) { outStream.write(buffer, 0,
						 * length); }
						 */
						outStream.write(buffer, 0, buffer.length);
						outStream.close();
						byte[] bOut = outStream.toByteArray();
						dis.close();
					}
					catch (IOException ioe)
					{
						ioe.printStackTrace();
						System.out.println("请求失败URL=" + URL);
					}
			    }
		    });
	    }
    
   }
    
    
}
