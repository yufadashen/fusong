<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<object width="0" height="0" name="plugin"
			classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
	<object width="0" height="0" id="AVFOCX"
			classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
	<title>职工医保还是居民医保</title>
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

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:425px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:150px;left:300px" />
	</div>
	<%--职工医保--%>
	<div id="zgyb" style="z-index:60;position:absolute;top:350px;left:240px;">
		<img src="${pageContext.request.contextPath}/images/zhigongyibao.png" />
	</div>
	<%--居民医保--%>
	<div id="jmyb" style="z-index:60;position:absolute;top:350px;left:700px;">
		<img src="${pageContext.request.contextPath}/images/juminyibao.png" />
	</div>
	<%--返回主页--%>
	<div id="main" style="position: absolute;top:800px;left:450px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			 res_img="${pageContext.request.contextPath}/images/main1.png"
			 height="" width="" />
	</div>
	<%--后退一步按钮--%>
	<div id="pre" style="position: absolute;top:790px;left:650px;">
		<img src="${pageContext.request.contextPath}/images/pre.png"
			 res_img="${pageContext.request.contextPath}/images/pre1.png"
			 height="" width="" />
	</div>
</body>
<script language="javascript">
	var cardNo =window.parent.cardNo;//卡号
	var cxfs00=window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
	var log = document.getElementById("AVFOCX");
	var phone=window.parent.lxdh00;//联系电话
	//初始化倒计时时间：60秒
	var time = window.parent.reTime;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
				function(){
					time--;
					$("#time").text(time);
					if(time==0){
						//跳转页面
						window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
					}
				},1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = window.parent.reTime;
	}
	returnTime();

	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#tip_s").bind("click dbclick", function() {
	});
	$("#tip_s2").bind("click dbclick", function() {
		$("#tip_div2").hide();
	});

	//职工医保
	$("#zgyb").bind("click dbclick",function () {
				window.parent.ybsflx = 91;
		$.session.set("xzbs00",0);

		window.location.href = "${pageContext.request.contextPath}/jsp/main/readYiBaoCard.jsp";
	});
	//居民医保
	$("#jmyb").bind("click dbclick",function () {
				window.parent.ybsflx = 96;
		$.session.set("xzbs00",1);

		window.location.href = "${pageContext.request.contextPath}/jsp/main/readYiBaoCard.jsp";
	});

</script>
</html>
