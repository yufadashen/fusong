<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<title>门诊挂号</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<script src="${pageContext.request.contextPath}/js/pageOper.js"></script>
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
	background:url(../../images/yue/bgn.jpg) no-repeat;
}
#titleArea{
	background-color:#3f7dac; 
	width:1024px;
	height:68px;
	text-align:left;
	font-size:44px;
	color:white;
	margin-top:-16px;
}
#bottomArea{
	background-color:#3f7dac; 
	width:1024px;
	height:68px;
	text-align:left;
	font-size:24px;
	color:white;
	margin-top:40px;
}
.btnYY{
	margin-top:200px;
	margin-left: 8px;
}
#showArea{
	border-radius:10px; 
	width:995px;
	height:570px;
	margin-left:11px;
	margin-top:20px;
	behavior:url(../../js/PIE.htc);
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">预约挂号</font>
	</div>
	<div id="showArea">
		<img id="yyoper" class="btnYY" src="${pageContext.request.contextPath}/images/yue/yyoper.png" res_img="" height="" width=""/></img>
		<img id="yyqh" class="btnYY" src="${pageContext.request.contextPath}/images/yue/yyqh_y.png" res_img="" height="" width=""/></img>
		<img id="yyqx" class="btnYY" src="${pageContext.request.contextPath}/images/yue/yyqx_y.png" res_img="" height="" width=""/></img>
	</div>

	<div id="bottomArea">
		<span style="margin-left:670px;">
			<img id="btnMain" style="margin-top:8px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</span>
		<span style="margin-left:20px;">
			<img id="btnReturn" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
		</span>
	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:165px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:120px;left:250px" />
	</div>
	<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>
<script type="text/javascript">
	//var xbie00="男";
	//var brnl00="25";
	var keshi; //科室
	var ksbh00;//科室代码
	var cardNo = window.parent.cardNo;
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var brnl00 = window.parent.brnl00;//病人年龄
	var log = document.getElementById("AVFOCX");
	var fssj00;//发送时间
	var	ksczrq;//开始日期时间
	var	jsczrq;//结束日期时间
	var sjdms01;//时间点编号
	
	function initialize	(){
		$("#yyoper").bind("click dbclick", function() {//预约
			window.location.href = "yykebie.jsp";
			$("#waiting").show();
		});
		$("#yyqh").bind("click dbclick", function() {//预约取号
		/*
			$("#tip_div").show();
			$("#error").text("本机暂时不支持此功能请在其他设备操作，谢谢合作！");
			$("#tip_s").bind("click dbclick", function() {//预约取消
				$("#tip_div").hide();
			});
			*/
			window.location.href = "yyqh2.jsp";
			loading();
		});
		$("#yyqx").bind("click dbclick", function() {//预约取消
			window.location.href = "yyqx.jsp";
			loading();
		});
		$("#btnMain").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			$("#waiting").hide();
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			$("#waiting").hide();
		});
	}
	var loading = function(){
		$("#waiting").show();
	}
	//初始化倒计时时间：120秒
	var time = 120;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 120;
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
		$("#waiting").show();
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		$("#waiting").hide();
	}
	init();
</script>
</html>