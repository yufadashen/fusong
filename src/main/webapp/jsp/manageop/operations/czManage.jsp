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
	background: url(../../../images/czgl_mzczgl.jpg) no-repeat;
}

div {
	/*border:1px red solid;*/
	position: absolute;
	text-align: center;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="back" style="left: 861px; top: 688px; width: 146px; height: 50px;"></div>
	<div id="backMain" style="left: 692px; top: 688px; width: 146px; height: 50px;"></div>
	<div id="startCash" style="width:302px;height: 142px;top: 241px;left: 136px;"></div>
	<div id="endCash" style="width:302px;height: 142px;top: 241px;left: 589px;"></div>
	<div id="startyinhang" style="width:302px;height: 142px;top: 405px;left: 136px;"></div>
	<div id="endyinhang" style="width:302px;height: 142px;top: 405px;left: 589px;"></div>
</body>
<script type="text/javascript">
	function event(){
		$("#startCash").bind("click", function() {
			startCash();//开启现金功能
		});
		$("#endCash").bind("click", function() {
			endCash();//关闭现金功能
		});
		$("#startyinhang").bind("click", function() {
			startyinhang();//开启银行功能
		});
		$("#endyinhang").bind("click", function() {
			endyinhang();//关闭银行功能
		});
		$("#back").bind("click", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/manageop/managePage.jsp";
		});
		$("#backMain").bind("click", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	function startCash(){
		console.log("开启现金充值");
		//log.WriteLog("卡号为:"+cardNo+"开始判断充值时间，判断本机是否可充值");
		var datas = {"funcid":"M07.02.03.01",								 
					"optype":"1",
					"czlb00":"1"};
		$.ajax({
			async:false,
			type:"post",
			data:datas,
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			url:window.parent.serverUrl+"?method=ApplyAction",
			success:function(json){
				alert("开启现金充值成功！");
			},
			error:function(){
				alert("开启现金充值失败！");				
			}
		});		
	}
	function endCash(){
		console.log("关闭现金充值");
		//log.WriteLog("卡号为:"+cardNo+"开始判断充值时间，判断本机是否可充值");
		var datas = {"funcid":"M07.02.03.01",								 
					"optype":"2",
					"czlb00":"1"};
		$.ajax({
			async:false,
			type:"post",
			data:datas,
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			url:window.parent.serverUrl+"?method=ApplyAction",
			success:function(json){
				alert("关闭现金充值成功！");	
			},
			error:function(){
				alert("关闭现金充值失败！");					
			}
		});		
		
	}
	function startyinhang(){
		console.log("开启银行卡充值");
		var datas = {"funcid":"M07.02.03.01",								 
					"optype":"1",
					"czlb00":"2"};
		$.ajax({
			async:false,
			type:"post",
			data:datas,
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			url:window.parent.serverUrl+"?method=ApplyAction",
			success:function(json){
				alert("开启银行卡充值成功！");
			},
			error:function(){
				alert("开启银行卡充值失败！");			
			}
		});	
	}
	function endyinhang(){
		console.log("关闭银行卡充值");
		var datas = {"funcid":"M07.02.03.01",								 
					"optype":"2",
					"czlb00":"2"};
		$.ajax({
			async:false,
			type:"post",
			data:datas,
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			url:window.parent.serverUrl+"?method=ApplyAction",
			success:function(json){
				alert("关闭银行卡充值成功！");
			},
			error:function(){
				alert("关闭银行卡充值失败！");				
			}
		});	
	}
	/**
	*初始化操作
	**/
	var init = function() {
		event();
	}

	init();
</script>
</html>