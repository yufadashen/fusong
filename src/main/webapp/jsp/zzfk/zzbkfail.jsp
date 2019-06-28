<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>自助办卡失败</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
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
	margin:0px;
	background: url(../../images/bgn.jpg) no-repeat;
}
div{
	position: absolute;
	text-align: center;
}

</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>

	<div id="name" style="margin:178px 0px 0px 76px;font-size:53px;">温馨提示：</div>
	<div id="ynye" style="margin:384px 0px 0px 204px;font-size:33px;color:red;letter-spacing: 4px;">买家取消付款或未付款，取消订单！<br>若已扫码，请勿付款！</div>
	
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		<img alt="" src="../../images/yue/mzgh_index_y.png">
	</div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;">
		<img alt="" src="../../images/yue/mzgh_return_y.png">
	</div>
	
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
	function initialize	(){
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	
	//初始化倒计时时间：120秒
	var time = 30;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 30;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					$.session.clear();
					//跳转页面
					//window.location.href = "yhkcz.jsp";
				}
			},1000);
	}
	
	/**
	*初始化操作
	**/
	var init = function(){
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();

</script>
</html>