<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>充值成功取回银行卡</title>
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
	background: url(../../images/yue/ymagsuccess.png) no-repeat;
}
div{
	position: absolute;
	text-align: left;
}
.pageButton{
	width:260px;
	height:60px;
	border-radius:10px; 
	background-color:#85c531;
	line-height:60px;
	font-size:30px;
	color:white;
	behavior:url(../../js/PIE.htc);
	position: absolute;
	text-align: center;
	margin:484px 0px 0px 410px;
}

</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="name" style="margin:223px 0px 0px 646px;height:33px;width:238px;line-height:33px;font-size:32px;">李腾腾</div>
	<div id="czje" style="margin:283px 0px 0px 646px;height:33px;width:238px;line-height:33px;font-size:32px;">2.00</div>
	<div id="czqye" style="margin:343px 0px 0px 646px;height:33px;width:238px;line-height:33px;font-size:32px;">20.00</div>
	<div id="czhye" style="margin:403px 0px 0px 646px;height:33px;width:238px;line-height:33px;font-size:32px;">120.00</div>
	<div class="pageButton" id="confirmApp">确认返回</div>
	
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
//初始化倒计时时间：15秒
var time = 15;
//自动倒计时，计时时间为0时，
function returnTime(){
	var myVar=setInterval(
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

//用户点击或按键等操作时，倒计时重新计时
document.onkeydown = timeAgin;
document.onclick = timeAgin;
function timeAgin(){
	time = 15;
}
returnTime();

var bankObj = window.parent.unionPay;
	function initialize	(){
		$("#name").text(window.parent.xming0);//姓名
		$("#czje").text($.session.get("czje"));//充值金额
		$("#czqye").text(window.parent.yjjye0);//充值前金额
		$("#czhye").text($.session.get("ayjjye0"));//充值后金额
		
		$("#confirmApp").bind("click dbclick", function() {//确认返回
			window.location.href = "yjjczsuccess.jsp";
		});
		
		var ret = bankObj.UMS_EjectCard();//退卡
		if(ret == 0){
			bankObj.UMS_CardClose();
		}
		checkCardPositon();
		
	}
	function checkCardPositon(){
		var iret = bankObj.UMS_CheckCard();
		//获取银行卡读卡器状态，设置持续判断状态，如果已取出卡跳转
		if(iret == 0x35){
			if($.session.get("ayjjye0")){
				window.location.href="${pageContext.request.contextPath}/jsp/pay/yjjczsuccess.jsp";
			}else{
				$.session.clear();
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			}
		}else{
			setTimeout("checkCardPositon()",500);
		}
		
	}
	/**
	*初始化操作
	**/
	var init = function(){
		initialize();
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();

</script>
</html>