<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>身份验证</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
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
	background: url("../../images/bgn.jpg") no-repeat;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no">
	<div style="position:absolute;top:3px;left:10px;font-size:40px;color: white;">身份验证</div>
	<div id="time" style="position:absolute;top:591px;left:708px;font-size:60px;color:#FFFF37;"></div>
	
	<div style="position:absolute;top:200px;left:220px;font-size:40px;color:#3f7dac;letter-spacing:11px;">请按照范例完成身份验证！</div>
	<div style="width:198px;position:absolute;top:369px;left:504px;font-size:22px;text-align:left;line-height:31px;">请使用二代身份证完成验证，并确保身份证在感应器上方。</div>
	<div style="position:absolute;top:600px;left:143px;font-size:40px;color:#FFA042;letter-spacing:6px;">正在读取身份证信息，剩余&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 秒！</div>
	
	<div id="cancelBtn" style="width:250px;height:60px;top:500px;left:520px;font-size:30px;color:white;letter-spacing:6px;background-color:#8CEA00;line-height:60px;">取消</div>
	<div  style="margin:336px 0px 0px 365px;"><img src="../../images/yue/putIdCard.gif"></div>
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
	<div id="tip_div"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
       <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
         <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
       </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
</body>
<script type="text/javascript">
var logger = window.parent.Logger;
	function initialize	(){
		$("#cancelBtn").bind("click dbclick", function() {//取消
			//alert(11);
			window.location.href = "zzbkoperation.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
	}
	
	//初始化倒计时时间：120秒
	var time = 30;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 30;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		setInterval(
			function(){
				time--;
				$("#time").text(time);
				readIdCard();
				if(time==0){
					$.session.clear();
					//跳转页面
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	function readIdCard(){
		var idCarder = window.parent.idCarder;
		var ret = idCarder.OpenDeviceAndReadCard(4,200);
		/*
		$.session.set("zzbkName","岳帅锋");
		$.session.set("zzbkSex","男");
		$.session.set("zzbkIdCard","410327199011276410");
		$.session.set("zzbkAge","18");
		$.session.set("zzbkBirth","19901127");
		$.session.set("zzbkAddr","dsfsdfs ");
		logger.WriteLog("打开身份证阅读器成功:"+idCarder.GetCardInfo(0) +"  "+idCarder.GetCardInfo(1) +"  "+idCarder.GetCardInfo(5) +"  "+idCarder.GetCardInfo(3) +"  ");
		window.location.href = "zzbkuserinfo.jsp";
		*/
		if(ret == 0){
			$.session.set("zzbkName",idCarder.GetCardInfo(0));
			$.session.set("zzbkSex",idCarder.GetCardInfo(1));
			$.session.set("zzbkIdCard",idCarder.GetCardInfo(5));
			$.session.set("zzbkAge",getAge(idCarder.GetCardInfo(3)));
			$.session.set("zzbkBirth",idCarder.GetCardInfo(3));
			$.session.set("zzbkAddr",idCarder.GetCardInfo(4));
			logger.WriteLog("打开身份证阅读器成功:"+idCarder.GetCardInfo(0) +"  "+idCarder.GetCardInfo(1) +"  "+idCarder.GetCardInfo(5) +"  "+idCarder.GetCardInfo(3) +"  ");
			window.location.href = "zzbkuserinfo.jsp";
		}
		
	}
	function getAge(birthday) {
	    //出生时间 毫秒
	    var birthDayTime = new Date(birthday.substr(0, 4),birthday.substr(4, 2),birthday.substr(6, 2)).getTime(); 
	    //当前时间 毫秒
	    var nowTime = new Date().getTime(); 
	    //一年毫秒数(365 * 86400000 = 31536000000)
	    return Math.floor((nowTime-birthDayTime)/31536000000);
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		setTimeout("readIdCard()",1000);
		$("#waiting").hide();
	}
	init();
</script>
</html>