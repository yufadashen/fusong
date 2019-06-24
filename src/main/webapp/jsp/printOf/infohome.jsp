<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>读卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
    body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: url(${pageContext.request.contextPath}/images/print/printmain.jpg) no-repeat;
    }
    #apDiv2 {	position:absolute;	left:0px;	top:0px;	width:1280px;	height:900px;	z-index:10;	margin: 0 0 0 0px;}
    </style>
</head>

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:910px;right:30px;font-size:40px;color: #FF0000;">
   	</div>
	<div id ="apDiv2">
			<iframe  id="pa" name="page1" src="${pageContext.request.contextPath}/jsp/printOf/infomain.jsp" width="1280" height="900" align="center" scrolling="no" frameborder="0" allowTransparency="false" ></iframe>
	</div>
	<div id="main" style="position: absolute;top:900px;left:550px;">
			<img src="${pageContext.request.contextPath}/images/fanhui.png"  height="67" width="161"/> 
	</div>
	
</body>
<script language="javascript">
	//初始化倒计时时间：60秒
	var time = 60;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp";
				}
			},1000);
	}
	
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = 60;
	}
	returnTime();
	var pid=window.parent.brid00;
	//var pid="1172764546";
  	$("#main").bind("click dbclick", function() {
  		//window.location.href = "http://172.16.11.34:9080/htmz/ShowMedicalRecordsInfoZJJ.jsp?pid=1172764546";
  		window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp"; 
	});
</script>
</html>
