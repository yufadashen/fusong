<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>取走银行卡</title>
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
	background: url(../../images/yue/ymagputout.png) no-repeat;
}
div{
	position: absolute;
	text-align: center;
}

</style>
</head>
<body scroll="no">
	
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
var bankObj = window.parent.unionPay;
	function initialize	(){
		var ret = bankObj.UMS_EjectCard();//退卡
		if(ret == 0){
			bankObj.UMS_CardClose();
		}
		//获取银行卡读卡器状态，设置持续判断状态，如果已取出卡跳转
		setTimeout(function(){
			if($.session.get("ayjjye0")){
				window.location.href="${pageContext.request.contextPath}/jsp/pay/yjjczsuccess.jsp";
			}else{
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			}
			
		},3000);
	}
	/**
	*初始化操作
	**/
	var init = function(){
		initialize();
	}
	init();
</script>
</html>