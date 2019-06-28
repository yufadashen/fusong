<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
 <head>
    <!--  K80打印机ocx -->
    <object id="AVFOCX2" classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461" width="0" height="0">
               <param name="s1" value="" />
    </object>
    <!--  日志ocx -->
    <object id="AVFOCX3" classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA" width="0" height="0">
               <param name="s1" value="" />
    </object>
    <!--  定时关机ocx -->
    <object id="AVFOCX4" classid="clsid:17E4902E-876F-439A-92AC-717AFAF51673" width="0" height="0">
               <param name="s1" value="" />
     </object>
   
    <!-- 身份证读卡器 -->
    <object id="IDCARD" classid="clsid:7FAD456B-5D32-4AF4-B588-29E78440D647" width="0" height="0">
             <param name="s1" value="" />
    </object>
	<object id="IPHlpOcx" hidden="hidden" width="0" height="0" classid="clsid:CFF0A334-C8A5-4C9E-A705-36E2B0651461"></object>
	  


    <title>吉林大学白求恩第一医院—首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
   	

   <style type="text/css">
	#apDiv2 {	position:absolute;	left:0px;	top:0px;	width:1024px;	height:768px;	z-index:10;	margin: 0 0 0 0px;}
    body {
        width: 1024px;
        height: 768px;
        overflow: hidden;
    }
    </style>
   </head>
 <body scroll="no">
	<div id='main_box'>
		<div id ="apDiv2">
			<iframe  id="pa" name="page1" src="${pageContext.request.contextPath}/jsp/main/main.jsp" width="1024" height="768" align="center" scrolling="no" frameborder="0" allowTransparency="false" ></iframe>
		</div>	
 </body>
 
 <script type="text/javascript">
 var serverUrl = "http://127.0.0.1:8888/";
 var reTime = 120;//倒计时时间
 var OutpatientId;//病人id
 var Name;
 var Sex;
 var PapersNo;
 var ttype;//操作类型
 
 var CardNo;//卡号
 var CardType;//医院定义的卡类型
 var CardNo;//卡号
 var Balance;//卡内余额
 var Limit;// 日限额
 var CreateTime;//创建时间
 var CardName;// 卡名称
 var Enable;// 数据状态

 
 
 //硬件状态开始*************************
 var Reader = document.getElementById("AVFOCX");
 var KPrinter = document.getElementById("AVFOCX2"); 
 var Logger = document.getElementById("AVFOCX3");
 var shutdown=document.getElementById("AVFOCX4");
 var idCarder = document.getElementById("IDCARD");
 var IPHlpOcx = document.getElementById("IPHlpOcx");//获取本地IP

 function openDevices(){

	 var aa = Reader.OpenCardReader(2,4);
	 var bb = KPrinter.OpenAndSetCOMX("COM1",19200);
	 var cc = idCarder.OpenDeviceAndReadCard(4,10);
  
 } 
 //硬件状态结束*-***********************

 openDevices();
 
	
 </script>
</html>
