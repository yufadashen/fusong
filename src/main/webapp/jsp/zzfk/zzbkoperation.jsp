<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>门诊挂号</title>
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
	background: url("../../images/yue/bkoperation.jpg") no-repeat;
}
div{
	position:absolute;

}
</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
	<div id="useIdCard" style="width:303px;height:143px;margin:336px 0px 0px 136px;"></div>
	<div id="noCard" style="width:303px;height:143px;margin:336px 0px 0px 588px;"></div>
	
	<div id="btnMain" style="width:149px;height:51px;margin:707px 0px 0px 682px;"></div>
	<div id="btnReturn" style="width:149px;height:51px;margin:707px 0px 0px 851px;"></div>
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
	<div id="tip_div"  style="margin: 385px 319px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:176px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left: 241px;" />
  </div> 
</body>
	<script type="text/javascript">
	var szsjFlag=false;
	//判断充值时间，判断本机当前是否可充值	 	
	function checkCzTime (czlb00){
		 	var datas = {"funcid":"M07.02.03.01",								 
				      "optype":"0",
				      "czlb00":"1"};//充值类别（1现金充值、2银行卡充值、3支付宝、4微信）
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				//url:window.parent.serverUrl+"?method=ApplyAction",
				url : "http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
				success:function(json){
					var Data = eval(json);
					//如果设备状态正常
					if(Data.retcode=="0"){
					     if(Data.retbody[0].sfkcz0=="1"){
					    	szsjFlag = true;
						 }
					}else{
						//log.WriteLog("设备状态异常");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);							
					}
					$("#waiting").hide();
				
				},
				error:function(){
					$("#waiting").hide();
					//log.WriteLog("获取本机是否可充值信息失败");
					$("#tip_div").show();
					$("#error").text("系统异常,请稍后再试!");		
				}
			});		
	}
	
	
	function initialize	(){
		
		$("#useIdCard").bind("click dbclick", function() {//身份证办卡  
			if(szsjFlag){
				window.location.href = "zzbksfyz.jsp";//身份验证
				$("#waiting").show();
			}else{
				$.session.set("errormsg","充值时间已过，无法进行自助办理就诊卡服务！");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			}
		});
		$("#noCard").bind("click dbclick", function() {//无证办卡
			
			if(szsjFlag){
				window.location.href = "zzbkuserinfo2.jsp";
				$("#waiting").show();
				/*
				$("#tip_div").show();
				$("#error").text("无证办卡功能尚未开通，敬请期待...");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
				});
				*/
			}else{
				$.session.set("errormsg","充值时间已过，无法进行自助办理就诊卡服务！");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			}
		});
		$("#btnMain").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		checkCzTime ();
	}
	
	//初始化倒计时时间：120秒
	var time = 30;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 30;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					$.session.clear();
					//跳转页面
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	
	/**
	*初始化操作
	**/
	var init = function(){
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		$("#tip_s").on("click", function() {
					$("#tip_div").hide();
				});
	}
	init();
</script>
</html>