<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>门诊预约</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
    body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
    }
    </style>
</head>
<body scroll=no>
		<!-- 显示返回主页面倒计时时间 -->
	 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
	   	</div>
	   	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
			<img id="title"
				src="${pageContext.request.contextPath}/images/yytitle.png" />
		</div>
		<div id="word" style="width:100%;z-index:60;position:absolute;top:1210px;">
			<span style="width:100%;font-size:40px;text-align:center;color:#EE7700;">请选择操作类型</span>
		</div>
		<div style="position: absolute;left:12px;">
			<div id="yygh" style="position: absolute;top:1370px;left:220px;">
				 <img src="${pageContext.request.contextPath}/images/yygh0.png" res_img="${pageContext.request.contextPath}/images/yygh1.png" height="" width=""/>
			</div>
			<div id="yyqh" style="position: absolute;top:1370px;left:625px;">
				<img src="${pageContext.request.contextPath}/images/yyqh0.png" res_img="${pageContext.request.contextPath}/images/yyqh1.png" height="" width=""/> 
			</div>
			<%-- <div id="yyqx" style="position: absolute;top:1370px;left:730px;">
				<img src="${pageContext.request.contextPath}/images/yyqx0.png" res_img="${pageContext.request.contextPath}/images/yyqx1.png" height="" width=""/> 
			</div> --%>
		</div>
		<div id="main" style="position: absolute;top:1745px;left:395px;">
			<img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
		</div>
		<div id="next" style="position: absolute;top:1728px;left:545px;">
			<img src="${pageContext.request.contextPath}/images/next.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
		</div>		
</body>
<script language="javascript">
	//初始化倒计时时间：60秒
	var time = window.parent.reTime;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = window.parent.reTime;
	}
	returnTime();
	
  	$("#yygh").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/mzyy/ksOrRq.jsp";
	});
	$("#yyqh").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
	});
	$("#yyqx").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqx.jsp";
	});
	$("#main").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	/* $("#next").bind("click dbclick", function() {
		window.location.href="main.jsp";
	}); */
</script>
</html>
