<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>输入病例号打印</title>
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
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	background:url(../../images/m_mz_bgdy/yBarcodeScanDlg.jpg) no-repeat;
}

#return{
	position:absolute;
    left: 392px;
    top: 597px;
    height: 58px;
    width: 238px;

}

</style>
</head>
<body scroll="no" >
	<div id="time"
		style="position:absolute;top:5px;left:800px;font-size:60px;color: #FF0000;"></div>
		<input  id="text1" type ="text" name="text1" autofocus="autofocus"
		        style="height:45px;width:290px;border:none;background: none;font-size:35px;letter-spacing:7px;color:#397DAD"/>
	<div id="return">
		
	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:260px" />
	</div>
</body>

<script type="text/javascript">
	var logger = window.parent.Logger;
	var time1 = 30;
	//初始化倒计时时间：60秒
	var time = 30;
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 30;
	}
 var tmsmpanduan = function (){
			var text1 = $("#text1").val();
			//alert(text1.length+"编号："+text1);	
			logger.WriteLog("扫描的号码："+text1);
			if(text1.length){
				//alert(text1.length+"编号："+text1);
				$.session.set("printtmsm", text1);
				window.location.href = "${pageContext.request.contextPath}/jsp/bgddy/print.jsp";
			}
	}
 
 function event(){
	 $("#return").bind("click dbclick", function() {
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
 }
	/**
	*初始化操作
	**/
	var init = function() {
	//document.getElementById(id).innerHTML
		var printType01 = $.session.get("printType01");
		$.session.set("printType02",printType01+"tmsm");
		setTimeout("$(\"#text1\").focus()",100);
		setInterval("tmsmpanduan()",500);//条码扫描判断
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		event();
	//PrintTicket();打印小票//TODO
	}
	init();
</script>
</html>

