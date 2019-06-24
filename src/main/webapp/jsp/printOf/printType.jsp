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
		<!-- 显示返回主页面倒计时时间 -->
	 	<div id="time" style="position:absolute;top:10px;right:30px;font-size:40px;color: #FF0000;">
	   	</div>
	   	<div id="tip_div"
			style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:365px;">
			<div id="tip_divInfo"
				style="text-align:center;position:relative;top:82px">
				<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
			</div>
			<img id="tip_s"
				src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
				height="43" style="position:relative;top:140px;left:300px" />
		</div>
		<div id="word" style="width:100%;z-index:60;position:absolute;top:330px;left:0px;">
			<span style="width:100%;font-size:40px;text-align:center;color:#EE7700;">请选择操作类型</span>
		</div>
		<div style="position: absolute;left:12px;">
			<div id="ynjzk" style="position: absolute;top:400px;left:280px;">
				<img src="${pageContext.request.contextPath}/images/print/ynjzk.png" res_img="${pageContext.request.contextPath}/images/print/ynjzk.png" height="305" width="264"/> 
			</div>
			<div id="dzjkk" style="position: absolute;top:400px;left:680px;">
				 <img src="${pageContext.request.contextPath}/images/print/dzjkk.png" res_img="${pageContext.request.contextPath}/images/print/dzjkk.png" height="305" width="264"/>
			</div>
			
		</div>
		<div id="main" style="position: absolute;top:800px;left:550px;">
			<img src="${pageContext.request.contextPath}/images/fanhui.png" res_img="${pageContext.request.contextPath}/" height="67" width="161"/> 
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
	var reader=window.parent.CardReader;
	reader.MoveCardX(2);
	$("#tip_s").on("click", function() {
		window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp";
	});
  	$("#dzjkk").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/printOf/readcardALL.jsp";
	});
	$("#ynjzk").bind("click dbclick", function() {
		/* $("#tip_div").show();
		$("#error").text("暂未开通,敬请期待"); */
		window.location.href="${pageContext.request.contextPath}/jsp/printOf/readcard.jsp";
	});
	$("#main").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/printOf/printMain.jsp";
	});
</script>
</html>
