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
<title>满意度调查</title>
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
	margin-top: 0px;
	margin-left: 0px;
	width: 100%;
	height: 100%;
	overflow: hidden;
	background: url(../../images/error.jpg) no-repeat;
}
#warning{
	position:absolute;
	font-size: 40px;
	color: red;
	top:385px;
	left: 355px;
}
#main{
	width:150px;
	height:50px;
	position:absolute;
	top:708px;
	left:682px;
}
#pre{
	width:150px;
	height:50px;
	position:absolute;
	top:708px;
	left:851px;
}
</style>

</head>
<body scroll="no" id="info">
	<div id="time"
		style="position:absolute;top:30px;right:50px;font-size:30px;color: #FF0000;">
	</div>
	<div id="warning">
	</div>
	<div id="main">
	</div>
	<div id="pre">
	</div>
</body>

<script>
	
	//初始化倒计时时间：120秒
	var time = 30;
	function timeAgin() {
		time = 30;
	}
	//自动倒计时，计时时间为0时，
function returnTime() {
			myVar = setInterval(
				function() {
					time--;
					$("#time").text(time);
					if (time == 50) {
						//跳转页面
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					}
				}, 1000);
		}
function event(){
			$("#main").bind("click dbclick", function() {
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
			$("#pre").bind("click dbclick", function() {
				window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
			});
		}
var init = function() {

		$("#warning").text("您近期暂无门诊消费记录.");
		event();
		returnTime(); //倒计时方法
		//用户点击或按键等操作时，倒计时重新计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	};
	init();
</script>
</html>

