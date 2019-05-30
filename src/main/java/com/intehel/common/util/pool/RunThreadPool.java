package com.intehel.common.util.pool;

import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;

import com.intehel.common.util.pool.Constant;

//测试线程池  
public class RunThreadPool extends Thread
{
	private String	url;

	public static void main(String[] args)
	{
		// 创建3个线程的线程池  
		ThreadPool t = ThreadPool.getThreadPool(3); 
		String url = "http://127.0.0.1:801/?Func=Sound_Play&Info=请13号，杨秀清，到妇科诊室3就诊，请00003号，沈佳，到妇科诊室3准备就诊";
//		String url= "http://127.0.0.1:8888/getPatientList.json";
//		String url= "https://www.baidu.com";
		t.execute(new Thread[]{ new RunThreadPool(url)});
//		t.execute(new Thread[] { new RunThreadPool("任务1"), new RunThreadPool("任务2"), new RunThreadPool("任务3") });
//		t.execute(new Thread[] { new RunThreadPool("任务4"), new RunThreadPool("任务5"), new RunThreadPool("任务6") });
		System.out.println(t);
		t.destroy();// 所有线程都执行完成才destory  
		System.out.println(t);
	}

	public RunThreadPool(String url)
	{
		this.url = url;
	}

	@Override
	public void run()
	{// 执行任务  
		//System.out.println(url + "完成");
		this.GetURL(this.url, "utf-8");
	}

	public static void executeThread()
	{
		Constant.threadPool.execute(new Thread[] { new RunThreadPool("任务-2"), new RunThreadPool("任务-1") });
		Constant.threadPool.execute(new Thread[] { new RunThreadPool("任务-2"), new RunThreadPool("任务-1"), new RunThreadPool("任务0"), new RunThreadPool("任务1"), new RunThreadPool("任务2"), new RunThreadPool("任务3") });
	}

	public String GetURL(String URL, String encode)
	{
		System.out.println("URL--->>>" + URL);
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
			int length = 0;
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();
			while ((length = (dis.read(buffer))) != -1)
			{
				outStream.write(buffer, 0, length);
			}
			outStream.close();
			byte[] bOut = outStream.toByteArray();
			dis.close();
		}
		catch (IOException ioe)
		{
			ioe.printStackTrace();
			System.out.println("请求失败URL=" + URL);
		}
		return strOut;
	}
}