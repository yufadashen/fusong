package com.intehel;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;


public class TestUrl {
	public static void main(String[] args) {
		
 
 
	}
	
	/**
	 * 发送POST请求
	 *
	 * @param url         请求地址url
	 * @param params      需要发送的请求参数字符串
	 * @param connTimeout 连接超时时间（毫秒），如果为null则默认为180秒
	 * @param readTimeout 读取超时时间（毫秒），如果为null则默认为180秒
	 * @return 请求响应内容，如果为null则表示请求异常
	 */
	public static String doPost(String url, String params, Integer connTimeout, Integer readTimeout, String contentType)
	{
	    PrintWriter out = null;
	    BufferedReader in = null;
	    String result = "";
	    try
	    {
	        URL realUrl = new URL(url);
	        // 打开和URL之间的连接,根据url
	        URLConnection conn = realUrl.openConnection();
	        // 设置通用的请求属性
	        conn.setRequestProperty("accept", "*/*");
	        conn.setRequestProperty("connection", "Keep-Alive");
	        conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
	        conn.setRequestProperty("Content-Type", contentType == null? "application/json" : contentType);
	        // 发送POST请求必须设置如下两行
	        conn.setDoOutput(true);
	        conn.setDoInput(true);
	 
	        // 设置请求超时时间和读取超时时间
	        conn.setConnectTimeout(connTimeout == null ? 180 : connTimeout);
	        conn.setReadTimeout(readTimeout == null ? 180 : readTimeout);
	 
	        // 获取URLConnection对象对应的输出流
	        out = new PrintWriter(conn.getOutputStream());
	        // 发送请求参数
	        out.print(params);
	        // flush输出流的缓冲
	        out.flush();
	        // 定义BufferedReader输入流来读取URL的响应
	        in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String line;
	        while ((line = in.readLine()) != null)
	            result += line;
	    }
	    catch (Exception e)
	    {
	        e.printStackTrace();
	        result = null;
	    }
	    //使用finally块来关闭输出流、输入流
	    finally
	    {
	        try
	        {
	            if (out != null)
	            {
	                out.close();
	            }
	            if (in != null)
	            {
	                in.close();
	            }
	        }
	        catch (IOException ex)
	        {
	            ex.printStackTrace();
	        }
	    }
	    return result;
	}

	
	
	public static void BaiduTest () {
		//定义一个字符用来存储网页内容
				String name = "请13号，杨秀清，到妇科诊室3就诊，请00003号，沈佳，到妇科诊室3准备就诊";
		    	String url = "http://127.0.0.1:801/?Func=Sound_Play&Info="+name+"&Cust=13";
		    	
//				String url = "http://www.baidu.com";
				//定义一个缓冲字符输入流
				String result = "";
				//定一个字符缓冲输入流
				BufferedReader in = null;
				
				
				try {
					//将String转化为一个url对象
					URL realUrl;
					realUrl = new URL(url);
					//初始化一个到指定的url的链接
					URLConnection connection = realUrl.openConnection();
				
					//开启实际的链接
					connection.connect();
					//初始化BufferReader输入流来读取Url的相应
					in = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));
					File file = new File("F:\\Baidu.txt");
					
					FileWriter out = new FileWriter(file);
					
					//用来临时存储抓取到的每一行的数据
					String line;
					while((line=in.readLine())!=null){
						//result = result+"\n"+line;
						//String  data = new String(line.getBytes(), "GBK"); 
						result = result+"\n"+line;
						out.write(line);
					}
					System.out.println(result);
					out.close();
				} catch (MalformedURLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					try {
						in.close();
						
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
				
	}
	
	
	
	

}
