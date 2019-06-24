<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
 <head>
 	<!-- <OBJECT name="xn_pos" ID="pos" WIDTH="640" HEIGHT="480" CLASSID="CLSID:16F4DBF0-6FC9-424A-BB65-8DA8EF3AF531" codebase="ReadM1.ocx"></OBJECT> -->
 	 <!-- 读卡器，密码键盘，身份证，识币器ocx -->
 	<!--<object width="0" height="0" name="plugin" classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> 
	</object>  -->
	<!--  M1读卡器ocx -->
	<object id="AVFOCX" classid="clsid:A5D2E211-A165-4316-8373-C02F199C55D8" width="0" height="0">
               <param name="s1" value="" />
     </object>
     <object id="AVFOCX2" classid="clsid:A7C153B2-3299-4474-A6A0-6276739BDAC3" width="0" height="0">
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
     <!--  获取打印机状态ocx -->
     <object id="AVFOCX5" classid="clsid:4BF69B6C-272C-4C59-8658-2D98FADC6F35" width="0" height="0">
               <param name="s1" value="" />
       </object>
    <title>吉林大学白求恩第一医院—首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
   	<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    

   <style type="text/css">
   	/* #apDiv1 {	position:absolute;	left:0px;	top:0px;	width:1080px;	height:517px;	z-index:11;	margin: 0 0 0 0px;border:1px solid red} */
	#apDiv2 {	position:absolute;	left:0px;	top:0px;	width:1280px;	height:1024px;	z-index:10;	margin: 0 0 0 0px;}
    body {
        width: 1080px;
        height: 1920px;
        overflow: hidden;
       /*  background: url(${pageContext.request.contextPath}/images/payway.jpg) no-repeat;  */
    }
    </style>
   </head>
 <body scroll="no">
	<div id='main_box'>
		<%-- <div id ="apDiv1">
			<iframe  id="pa" name="page1" src="${pageContext.request.contextPath}/jsp/main/main.jsp" width="1080" height="517" align="center" scrolling="no" frameborder="0" allowTransparency="false" ></iframe>
		</div> --%>
		<div id ="apDiv2">
			<iframe  id="pa" name="page1" src="${pageContext.request.contextPath}/jsp/printOf/printMain.jsp" width="1280" height="1024" align="center" scrolling="no" frameborder="0" allowTransparency="false" ></iframe>
		</div>
	</div>
 </body>
 <script type="text/javascript">
 var serverUrl = "http://172.16.5.104:7001/ylzzzjserver/controlAction.do";
 var cardNo;//卡号
 var cardtype;//卡类型  01 身份证   02：就诊卡
 //*******查询患者信息返回参数开始
 var sfykt0;//是否一卡通
 var pin000;//账户密码
 var lxdh00;//联系电话
 var xming0;//患者名称
 var xbie00;//患者性别
 var csrq00;//出生日期
 var brnl00;//病人年龄
 var brid00="";//病人ID
 var yjjye0;//预交金余额（结算金额使用）
 var ynzhye;//院内账户余额
 var bryblb;//是否医保病人
 var jzhsfjd;//介质号重复
 var zdbh00;//终端编号
 var ttype;//操作类型  1：病历打印  2：报告打印
 //*******查询患者信息返回参数结束
 
 //硬件状态开始*************************
 //var CardReader = new CardPayment(plugin, "读卡器");
 var CardReader = document.getElementById("AVFOCX");
 var ListEXE = document.getElementById("AVFOCX2");
 var shutdown=document.getElementById("AVFOCX4");
 var printStatus=document.getElementById("AVFOCX5");
 function openDevices(){
	 //var ret3 = printStatus.GetStatu("172.16.105.18");
	 var ret = CardReader.OpenCardReader(3,4);
	 var ret2 = CardReader.GetCardReaderStatus();
	 //CardReader.OpenDevice(1);
	
 } 
 //硬件状态结束*************************
 
 
 openDevices();
 </script>
</html>
