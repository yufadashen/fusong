
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<title>智能导诊</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
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

#man {
	margin-top: 20px;
	margin-right: 30px;
	margin-bottom: 30px;
	margin-left: 40px;
}

#woman {
	margin-top: 20px;
	margin-right: 30px;
	margin-bottom: 30px;
	margin-left: 200px;
}
</style>
</head>
<body scroll="no">
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:20px;right:80px;font-size:60px;color: #FF0000;">
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
	<div style="z-index:60;position:absolute;top:160px;left:460px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/zndz/zndztitle.png" />
	</div>
	<div id="word"
		style="width:600px;z-index:60;position:absolute;top:290px;left:320px;">
		<span style="width:600px;font-size:60px;text-align:center;color:red">请选择您的性别</span>
	</div>
	<div id="sex"
		style="z-index:40;position:absolute;top:410px;left:250px">

		<img id="man"
			src="${pageContext.request.contextPath}/images/zndz/chooseman.png"
			res_img="${pageContext.request.contextPath}/images/zndz/chooseman.png"
			height="" width="" /> <img id="woman"
			src="${pageContext.request.contextPath}/images/zndz/choosewoman.png"
			res_img="${pageContext.request.contextPath}/images/zndz/choosewoman.png"
			height="" width="" margin-left="10px" />
	</div>
	<div id="main" style="position: absolute;top:830px;left:320px;">
		<img src="${pageContext.request.contextPath}/images/zndz/main.png"
			res_img="${pageContext.request.contextPath}/images/zndz/main1.png"
			height="" width="" />
	</div>
	<div id="pre" style="position: absolute;top:830px;left:760px;">
		<img src="${pageContext.request.contextPath}/images/zndz/pre.png"
			res_img="${pageContext.request.contextPath}/images/zndz/pre1.png"
			height="" width="" />
	</div>
</body>
<script type="text/javascript">
	//returnTime();
	var xbbh00 = ""; //性别
	var log = document.getElementById("AVFOCX");
	//初始化倒计时时间：120秒
	var time = window.parent.reTime;
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
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});
	//点击男    
	$("#man").bind("click dbclick", function() {
		xbbh00 = "1";
		$.session.set('xbbh00', xbbh00);
		window.location.href = "man.jsp";
	})

	//点击女
	$("#woman").bind("click dbclick", function() {
		xbbh00 = "2";
		$.session.set('xbbh00', xbbh00);
		window.location.href = "woman.jsp";
	})
	
</script>
</html>



