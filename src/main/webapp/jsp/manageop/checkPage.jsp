<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>输入密码</title>
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
	background: url(../../images/bgn.jpg) no-repeat;
}

div {
	position: absolute;
	text-align: center;
}
#money{
	border:1px black solid;
	background-color:#ccc;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div style="font-size:40px;color:white;letter-spacing:5px;">输入密码</div>
	<div id="time"
		style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>

	<div
		style="margin:145px 0px 0px 112px;font-size:40px;letter-spacing:11px;">
		请输入您的密码，按“<font color="red">确定</font>”键确认！
	</div>


	<div style="margin:342px 0px 0px 191px; font-size:40px;">
		密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码: <input id="czje"
			type="password"
			style="border:black;letter-spacing:3px;text-align:center;width:251px;height:56px;background-color:#28FF28;line-height:56px;">
	</div>
	<div id="openkb" style="margin:351px 0px 0px 691px;">
		<img src="../../images/yue/keyboard_y.png">
	</div>

	<div
		style="margin:470px 0px 0px 226px;font-size:30px;color:red;letter-spacing:5px;">为了您的安全，请妥善保护好您的密码！</div>
	<!-- 键盘 -->
	<div id="money"
		style="z-index:999; width:272px; position:absolute;top:240px;left:667px;">
		<img src="../../images/kb2/1.png" value="1" name="numKey" width="60px" height="50px" /> 
		<img src="../../images/kb2/2.png" value="2" name="numKey" width="60px" height="50px"/>
		<img src="../../images/kb2/3.png" value="3" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/delete.png" value="10" id="modify" style="margin-top:4px;" />
		<br> 
		<img src="../../images/kb2/4.png" value="4" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/5.png" value="5" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/6.png" value="6" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/reinput.png" value="10" id="reinput" style="margin-top:4px;" /> 
		<br>
		<img src="../../images/kb2/7.png" value="7" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/8.png" value="8" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/9.png" value="9" name="numKey" width="60px" height="50px"/> 
		<img src="../../images/kb2/close.png" value="10" id="close"	style="margin-top:4px;" /> 
		<br> 
		<img src="../../images/kb2/0.png" value="0" name="numKey" style="width:123px;height:50px;margin-top:4px;" /> 
		<img src="../../images/kb2/sure.png" value="11" id="sure" style="width:123px;height:50px;margin-top:4px;" />
	</div>


	<div id="confirmbtn"
		style="margin:576px 0px 0px 342px;color:white;height:57px;width:282px;font-size:40px;background-color:#000093;line-height:57px;">确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认</div>


	<div id="mainPage"
		style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		<img alt="" src="../../images/yue/mzgh_index_y.png">
	</div>
	<div id="backPage"
		style="width: 149px;height: 50px;margin:708px 0px 0px 851px;">
		<img alt="" src="../../images/yue/mzgh_return_y.png">
	</div>
	<div id="tip_div"
		style="margin:229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="waiting"
		style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
//var regtest = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/; 
	var stoping = $.session.get("stoping");
	function getPwd() {
		var pwd = $("#czje").val();
		if (pwd == "4009988988") {
			return true;
		}else{
			return false;
		}
	}
		

	function goNext() {
		window.location.href = "managePage.jsp";
	}
	function initialize() {
		$("#confirmbtn").bind("click dbclick", function() { //确认
			if (getPwd()) {
				 if(stoping == "backMain"){
					$.session.clear();
					//CardSetting(1);
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}else{
					goNext();
				}
			}
		});

		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#czje").focus();
		$("#mainPage").bind("click dbclick", function() { //返回主页
			if(stoping == "backMain"){
				if(qrtg){
					$.session.clear();
					//CardSetting(1);
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}else{
					window.location.href="${pageContext.request.contextPath}/jsp/manageop/operations/suspend.jsp";
				}
					
			}else{
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			}
			//window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() { //返回上一级
			if(stoping == "backMain"){
				if(qrtg){
					$.session.clear();
					//CardSetting(1);
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}else{
					window.location.href="${pageContext.request.contextPath}/jsp/manageop/operations/suspend.jsp";
				}
					
			}else{
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			}
			//window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#openkb").bind("click dbclick", function() { //打开 关闭键盘
			var a = $("#money")[0].style.display;
			if (a == "none") {
				$("#money").css("display", "block");
			} else {
				$("#money").css("display", "none");
			}
		});
	}

	var time = 30;
	function timeAgin() {
		time = 30;
	}
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					$.session.clear();
				//跳转页面
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	/**
	*初始化操作
	**/
	var init = function() {
		initialize();
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	/***
	***  键盘事件
	***/
	
	$('img[name="numKey"]').on('click', function() {
		var valStr = $('#czje').val();
		if (valStr.length < 15) {
			if (valStr == "" || valStr == 0) {
				$('#czje').val($(this).attr('value'));
				//console.log("11111"+$("#czje").val());
			} else {
				$('#czje').val(valStr + $(this).attr('value'));
			}
				//console.log("22222"+$("#czje").val());
		}else{
			$("#czje").val(valStr);
		};
		/*
		if(parseInt($("#czje").val())>2000){
		    	  $("#czje").val(2000);
		} */
		
	});
	//删除
	$("#modify").on("click", function() {
		var num = $("#czje").val();
		var newstr = num.substring(0, num.length - 1);
		$("#czje").val(newstr);
	});
	//重填
	$("#reinput").on("click", function() {
		$("#czje").val("");
	});
	//关闭
	$("#close").bind("click dbclick", function() {
		var a = $("#money")[0].style.display;
		if (a == "none") {
			$("#money").css("display", "block");
		} else {
			$("#money").css("display", "none");
		}
	});
	//确认
	$("#sure").bind("click dbclick", function() {
		if (getPwd()) {
				if(stoping == "backMain"){
					$.session.clear();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}else{
					goNext();
				}
			}
	});

	init();
</script>
</html>