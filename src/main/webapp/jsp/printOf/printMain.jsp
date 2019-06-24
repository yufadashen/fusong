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
        background: url(${pageContext.request.contextPath}/images/print/printmain.jpg) no-repeat;
    }
    </style>
</head>
<body scroll=no>
		<div style="position: absolute;left:12px;">
			 <div id="bldy" style="position: absolute;top:430px;left:280px;">
				 <img src="${pageContext.request.contextPath}/images/print/bldy.png" res_img="${pageContext.request.contextPath}/images/print/bldy.png" height="100" width="300"/>
			</div>
			<div id="bgdy" style="position: absolute;top:430px;left:660px;">
				<img src="${pageContext.request.contextPath}/images/print/jybgdy.png" res_img="${pageContext.request.contextPath}/images/print/jybgdy.png" height="100" width="300"/> 
			</div> 
			<%-- <div id="bgdy" style="position: absolute;top:430px;left:460px;">
				<img src="${pageContext.request.contextPath}/images/print/jybgdy.png" res_img="${pageContext.request.contextPath}/images/print/jybgdy.png" height="100" width="300"/> 
			</div> --%>
		</div>
</body>
<script language="javascript">
//定时关机任务
	var shutdown=window.parent.shutdown;
	var time=60;
	//倒计时60S后 无操作自动关机
	 function returnTime(){
			myVar=setInterval(
				function(){
					time--;
					if(time==0){
						//定时关机任务
						shutdownt();
					}
				},1000);
	}
	function shutdownt(){
		 var date=new Date();
		 var h=parseInt(date.getHours());
		 var m=parseInt(date.getMinutes());
		 if((h>15 && m>29) ||h>16){
			 shutdown.ShutdownFunc();
		 }else{
			 setTimeout(function(){ shutdownt(); }, 60000);
		 }
	}
	returnTime()
  	$("#bldy").bind("click dbclick", function() {
  		window.parent.ttype=1;
		window.location.href="${pageContext.request.contextPath}/jsp/printOf/printType.jsp";
	});
  	$("#bgdy").bind("click dbclick", function() {
  		window.parent.ttype=2;
		window.location.href="${pageContext.request.contextPath}/jsp/printOf/printTypeLis.jsp";
	});
  	shutdownt();
</script>
</html>
