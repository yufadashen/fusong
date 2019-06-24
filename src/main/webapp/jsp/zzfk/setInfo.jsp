
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>
<object width="0" height="0" id="faka"
	classid="clsid:E59A197F-4491-4818-A20F-920166E41AD7"> </object>					
<title>自助发卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">		
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>
<body scroll="no">
<!-- 显示返回主页面倒计时时间 -->
	<div id="time"
		style="position:absolute;top:1030px;right:80px;font-size:60px;color: #FF0000;">
	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div>
   <div id="word" style="width:100%;z-index:60;position:absolute;top:1200px;">
		<span  style="width:100%;font-size:60px;text-align:center;color:red">请确认个人信息</span>
	</div>
	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/zzfk.png" />
	</div>
	<div id="yyInfo"
		style="z-index:50;position:absolute;top:1400px;left:43px;text-align:center;display:block">
		<table style="table-layout:fixed;width:1000px;border:1px solid #000;background-color:#B4EEB4;font-size:50px;cellspacing:2px" id="info2">
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">姓名</td>
				<td id="xingm0" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">身份证</td>
				<td id="idCard" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">手机号</td>
				<td id="telNumber" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td colspan="2" style="width:300px;border:1px solid #000;"><img id="tip_s" src="${pageContext.request.contextPath}/images/queding.png" 
        width="120" height="55" onclick="get()" /></td>
			</tr>
		</table>
	</div>
	
	<!-- 返回主頁面 -->
	<div id="main" style="position: absolute;top:1730px;left:600px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/images/main1.png"
			height="" width="" />
	</div>
	<!-- 返回上一步 -->
	<div id="pre" style="position: absolute;top:1718px;left:400px;">
		<img src="${pageContext.request.contextPath}/images/pre.png"
			res_img="${pageContext.request.contextPath}/images/pre1.png"
			height="" width="" />
	</div>
</body>
<script type="text/javascript">	
	var xingm0 = window.parent.xming0; //姓名
	var sfzhao = window.parent.sfzhao; //身份证号
	var lxdh00 = window.parent.lxdh00; //联系电话
	//var log = document.getElementById("AVFOCX");	
	
	var time = 60;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 60;
	}
	returnTime();
	
	
	function yyInfo(){
		
		$("#yyInfo").show();
		$("#xingm0").text(xingm0);
		$("#idCard").text(sfzhao);
		$("#telNumber").text(lxdh00);		
	}
	function get(){
		window.location.href = "setPwd.jsp";
	}
	
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	yyInfo();
</script>
</html>

