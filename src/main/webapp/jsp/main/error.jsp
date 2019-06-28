<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>	
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<title>错误提示</title>
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
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(../../images/error.jpg) no-repeat;
}
#main{
	top:707px;
	left:683px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
#pre{
	top:707px;
	left:852px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
div{
	position:absolute;
}
#msg{
	font-size:35px;
	color:red;
}
</style>
</head>
<body>
<div id="msg" style="top:400px;left:250px;width:659px;height:243px;">
</div>
<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		
	</div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;">
		
	</div>
<span
	id="time"
			style="position:absolute;top:20px;right:75px;font-size:60px;color: red;">
		</span>
</body>
<script type="text/javascript">
	var time = 10;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 10;
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
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	function event(){
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	function init(){
		$("#msg").text($.session.get("errormsg"));
		event();
		returnTime();
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();
</script>
</html>
