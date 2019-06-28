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
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	margin: 0px;
	background: url(../../../images/yue/stop_use.jpg) no-repeat;
}

div {
	border:1px red solid;
	position: absolute;
	text-align: center;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="manageArea" style="width:72px;height: 60px;margin:-26px 0px 0px -7px;"></div>
</body>
<script type="text/javascript">
 	var cNum = 0;
	function initialize() {
		setInterval(function() {
			cNum = 0;
		}, 5000);
		
		$("#manageArea").bind("click", function() {
			cNum++;
			if(cNum == 5){
				cNum = 0;
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			}
		});
	}
	
	/**
	*初始化操作
	**/
	var init = function() {
		initialize();
	}

	init();
</script>
</html>