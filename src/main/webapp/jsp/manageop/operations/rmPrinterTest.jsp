<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>暂停使用</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<object id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461" width="0"
	height="0">
	<param name="s1" value="" />
</object>
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	margin: 0px;
	background: url(../../../images/bgn.jpg) no-repeat;
}

div {
	border: 1px red solid;
	position: absolute;
	text-align: center;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="manageArea"
		style="width:72px;height: 60px;margin:-26px 0px 0px -7px;"></div>

	<p>
		<input type='button' value='初始化打开设备' onclick='init()' />
	<p>
		<input type='button' value='获取设备状态' onclick='GetStatus()' />
	<p>
		<input type='button' value='打印小票' onclick='PrintText()' />
	<p>
		<input type='button' value='打印图片' onclick='PrintImage()' />
	<p>
		<input type='button' value='打印二维码' onclick='PrintBarCode()' />
	<p>
		<input type='button' value='关闭设备' onclick='Close()' />
</body>
<script type="text/javascript">
var printer = document.getElementById("printer");
function init()  {
	var ret = printer.OpenAndSetCOMX("COM1",115200);
	if(ret == 0){
		alert("打开设备成功！");
	}
}
function GetStatus()  {
	var printer = document.getElementById("printer");
	var ret = printer.GetStatusX();
	alert(ret);
}
function PrintText()  {
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
        if(hours<10){
        	hours="0"+hours;
        }
        if(minutes<10){
        	minutes="0"+minutes;
        }
        if(seconds<10){
        	seconds="0"+seconds;
        }
        var currTime = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
		var printer=document.getElementById("printer");
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);	  //设置中文模式
		printer.WriteTextLineX("      临沂人民医院自助预约凭条");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      —————————————————————");
		
			
		printer.WriteTextLineX("      就诊卡号:");
		printer.WriteTextLineX("                       ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      姓名：张三      性别:女 ");
		printer.WriteTextLineX("                       ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      预约日期：2008-02-03");
		printer.WriteTextLineX("                       ");
		printer.WriteTextLineX("      预约时间：14:33");
		printer.WriteTextLineX("                       ");
		printer.WriteTextLineX("      预约科室: 内科");
		printer.WriteTextLineX("                       ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      预约医生: 李四");
		printer.WriteTextLineX("                       ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("       —————————————————————");
		printer.WriteTextLineX("      自助机号：xxxxxxxxxxxxxxxxxxx");
		printer.WriteTextLineX("                       ");
		printer.WriteTextLineX("      打印时间：" + currTime);
		printer.WriteTextLineX("                       ");
		
		printer.WriteTextLineX("      *请妥善保存此预约单！");
		printer.WriteTextLineX("                       ");
		printer.WriteTextLineX("      本凭条不作为就诊凭证！");
		printer.WriteTextLineX("                       ");
		printer.WriteTextLineX("      预约成功后请在就诊当天预约时间30分钟前进行       取号，获取就诊凭证！");
		
		printer.LFX(2);
		
		printer.CeTCutX(); //切纸
}
function PrintImage()  {
     var temp = document.getElementById("printer");
	 var value;
	value  = temp.PrintNVImageX("../../../images/wxpay.png",0);
			 temp.LFX(2);
			 temp.CeTCutX();	
	//alert(value);
}

function PrintBarCode()  {
     var temp = document.getElementById("printer");
	 var value;
	 //第一个参数，条形码类型
	 //65= UPC-A,66= UPC-B,67= EAN13(JAN),68= EAN8(JAN) ,69=CODE39 ,70=ITF ,71=CODABAR ,72=CODE93 ,73=CODE128 ,90=CODE32  
	 //第二个参数，条形码高度 1 = 0.125mm 自行换算
	 //第三个参数，宽度 1= 0.125mm 自行换算
	 //第四个参数，要生成条形码的内容
		value  = temp.PrintBarCodeX(73,100,3,"000216219100");
		temp.LFX(2);
		temp.CeTCutX();	
		//alert(value);
	}
	
	function Close()  {
	     var temp = document.getElementById("printer");
		 var ret = temp.CloseCOMX();
		 if(ret == 0){
			 alert("关闭设备!");
		 }
	}
</script>
</html>