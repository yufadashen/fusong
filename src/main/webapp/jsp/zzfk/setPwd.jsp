
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
	<div id="tip_div1"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo1"
			style="text-align:center;position:relative;top:82px">
			<span id="error1" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s1"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;z-index:10">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong>发卡成功，请在下方取走院内卡和身份证</strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="mma"
		style="position:absolute;top:1345px;left:290px;display:none">
		<span id="qingcharu" style="font-size:60px;color:#4169E1;"><strong>请设置6位数字密码</strong></span>
	</div>
	<div id="login_pa"
		style="position:absolute;top:1460px;left:320px;display:none">
		<input id="KeyValue" type="password" maxlength="6"
			style="width:400px;height:60px;text-align:center;font-size:40px" />
	</div>
	<div id="sure"
		style="position:absolute;top:1585px;left:430px;display:none">
		<img src="${pageContext.request.contextPath}/images/queding.png"
			res_img="${pageContext.request.contextPath}/images/queding1.png"
			height="" width="" />
	</div>
	<div id="mma1"
		style="position:absolute;top:1360px;left:330px;display:none">
		<span id="qingcharu" style="font-size:60px;color:#4169E1;"><strong>请再次输入密码</strong></span>
	</div>
	<div id="login_pa1"
		style="position:absolute;top:1460px;left:320px;display:none">
		<input id="KeyValue1" type="password" maxlength="6"
			style="width:400px;height:60px;text-align:center;font-size:40px" />
	</div>
	<div id="sure1"
		style="position:absolute;top:1585px;left:430px;display:none">
		<img src="${pageContext.request.contextPath}/images/queding.png"
			res_img="${pageContext.request.contextPath}/images/queding1.png"
			height="" width="" />
	</div>
	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/zzfk.png" />
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
	var pwd = "";
	var pwd1 = "";
	var xingm0 = window.parent.xingm0; //姓名
	var sfzhao = window.parent.sfzhao; //身份证号
	//var sfzhao = $.session.get('sfzhao'); //身份证号
	var lxdh00 = $.session.get('lxdh00'); //联系电话
	var exist0 = $.session.get('exist0'); //是否已建档  1已建档 非1未建档
	var pin000; //密码
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
	
	function inputPassword() {
		if(exist0 == 1){
			window.location.href = "qrjd.jsp";
		}else{
			$("#mma").show();
			$("#login_pa").show();
			$("#sure").show();
			$("#KeyValue").focus();
		}
	}

	
	$("#sure").bind("click dbclick", function() {
		pwd = $("#KeyValue").val();
		if(pwd.length!=6){
			$("#tip_div").show();
			$("#error").text("请设置6位数字密码");
			$("#tip_s").on("click", function() {				
				$("#KeyValue").val("");
				$("#tip_div").hide();
			});
		}else{		
				$("#mma").hide();
				$("#login_pa").hide();
				$("#sure").hide();
				inputPassword1();		
		}		
	});
	function inputPassword1() {
		$("#mma1").show();
		$("#login_pa1").show();
		$("#sure1").show();
		$("#KeyValue1").focus();
	}


	$("#sure1").bind("click dbclick", function() {
		pwd1 = $("#KeyValue1").val();
		if(pwd1.length!=6){
			$("#tip_div").show();
			$("#error").text("请设置6位数字密码");
			$("#tip_s").on("click", function() {				
				$("#tip_div").hide();
				inputPassword1();
			});
		}else{
			$("#mma1").hide();
			$("#login_pa1").hide();
			$("#sure1").hide();
			if (pwd == pwd1) {
				window.parent.pin000 = pwd;
				window.location.href = "qrjd.jsp";
			} else {
				$("#tip_div").show();
				$("#error").text("两次密码输入不一致，请重新输入！");
				$("#KeyValue").val("");
				$("#KeyValue1").val("");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					inputPassword();
				});
			}
		}		
	});

	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	inputPassword();
</script>
</html>

