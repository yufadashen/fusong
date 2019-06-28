<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>专家排班一览表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"
	charset="utf-8"></script>
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
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	
}

span{
	font-size: 30px;
	text-align: center;
}
#main {
	height: 49px;
	left: 684px;
	top: 709px;
	width: 148px;
}

#pre {
	height: 49px;
	left: 852px;
	top: 708px;
	width: 148px;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no">
	
	<div id="time" style="position:absolute;top:5px;left:800px;font-size:60px;color: #FF0000;"></div>
	
	<div id="bgimg" style="width:1024px;height:768px;background-image:url(../../images/zjpb/xxcx_zjpb_1.jpg) "></div>
	<div id="preImg21" style="position:absolute;left:200px;top:591px; width:178px;height:55px;z-index: 100;"></div>
	<div id="nextImg21" style="position:absolute;left:646px;top:591px; width:178px;height:55px;z-index: 100;"></div>
	
	<div class="imgTextNumberinfo" style="position:absolute;left:423px;top:603px; width:178px;height:55px;text-align:center;">
	 	<span id = "imgTextNumber"></span>
	</div>
	
	<div id="main" style="position:absolute;z-index: 100;"></div>
	<div id="pre" style="position:absolute;z-index: 100;"></div>

	
</body>

<script type="text/javascript">
	var time1 = 30;
	//初始化倒计时时间：60秒
	var time = 60;
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 60;
	}
	var flag = true;
	var i = 1;
	var urlStringImg = "";
	$("#imgTextNumber").text(i+"/9");
	$("#preImg21").bind("click dbclick", function() { 
			if(i>1){
				i--;
				urlStringImg="../../images/zjpb/xxcx_zjpb_"+i+".jpg";
				$("#bgimg")[0].style.backgroundImage="url("+urlStringImg+")";
			}
			$("#imgTextNumber").text(i+"/9");
		
		
	});
	$("#nextImg21").bind("click dbclick", function() { 
		if(i<9){
			i++;
			urlStringImg="../../images/zjpb/xxcx_zjpb_"+i+".jpg";
			$("#bgimg")[0].style.backgroundImage="url("+urlStringImg+")";
		}
		$("#imgTextNumber").text(i+"/9");
	});	
	$("#main").bind("click dbclick", function() { //返回主页
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() { //返回上一级
		window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
	});
	/**
	*初始化操作
	**/
	var init = function() {
		
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();
</script>
</html>

