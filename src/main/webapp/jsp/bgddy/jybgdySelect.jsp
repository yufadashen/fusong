<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>报告打印</title>
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
	background: url(../../images/m_mz_bgdy/1.png) no-repeat;
}
div{
	position: absolute;
	
}

</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
	<div id="duka" style="position:absolute;top:306px;left:12px;width: 303px;height: 143px;">
		
	</div>
	<div id="tmsm" style="position:absolute;top:306px;left:358px;width: 303px;height: 143px;">
		
	</div>
	<div id="srblh" style="position:absolute;top:306px;left:705px;width: 303px;height: 143px;">
		
	</div>
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		
	</div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;">
		
	</div>
	
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
	function initialize	(){
		$("#duka").bind("click dbclick", function() {//检验报告打印
			window.parent.ttype = "31";
			window.location.href = "${pageContext.request.contextPath}/jsp/main/readcard.jsp";
		});
		$("#tmsm").bind("click dbclick", function() {//病例报告打印
			window.location.href = "tmsm.jsp";
		});
		$("#srblh").bind("click dbclick", function() {//病例报告打印
			window.location.href = "srblh.jsp";
		});
		$("#mainPage").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	
	//初始化倒计时时间：120秒
	var time = 120;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 120;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					$.session.clear();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	
	/**
	*初始化操作
	**/
	var init = function(){
		$.session.set("printType01","jybgddy");
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();
</script>
</html>