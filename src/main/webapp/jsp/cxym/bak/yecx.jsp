
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>
<head>
<title>账户余额查询</title>
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
	background:url(../../images/bgn.jpg) no-repeat;
}

#titleArea {
	font-size: 50px;
	background-color: #3f7dac;
	color: white;
	padding-left: 25px;
	height: 60px;
	text-align: left;
	vertical-align: text-bottom;
}

#bottomArea {
	background-color: #3f7dac;
	width: 100%;
	height: 65px;
	margin-left: 0px;
	text-align: left;
	font-size: 50px;
	color: white;
	margin-top: 50px;
	line-height: 30px;
}

#showArea {
	border: 1px black solid;
	border-radius: 10px;
	width: 995px;
	height: 570px;
	margin-left: 11px;
	margin-top: 20px;
	behavior: url(../../js/PIE.htc);
}

.models {
	width: 210px;
	height: 80px;
	background-color: #599CE0;
	border-radius: 10px;
	display: table-cell;
	vertical-align: middle;
	text-align: center;
	font-size: 22px;
	behavior: url(../../js/PIE.htc);
}

.pageButton {
	width: 260px;
	height: 60px;
	border-radius: 10px;
	background-color: #85c531;
	margin-left: 220px;
	margin-top: 120px;
	line-height: 60px;
	font-size: 30px;
	color: white;
	behavior: url(../../js/PIE.htc);
}

#wxts {
	position: absolute;
	font-size: 30px;
	margin-left: 63px;
	margin-top: 84px;
}

#yycg {
	position: absolute;
	margin-left: 364px;
	font-size: 68px;
	margin-top: 209px;
}

#confirmApp {
	margin-top: 450px;
	margin-left: 378px;
}

#rebuildArea {
	position: absolute;
	border: 1px black solid;
	height: 300px;
	width: 550px;
	margin: 100px 0px 0px 245px;
	border-radius: 5px;
	behavior: url(../../js/PIE.htc);
}
</style>
</head>
<body scroll="no" id="info">
	<div id="time"
		style="position:absolute;top:5px;left:800px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">账户余额查询</font>
	</div>
	<div id="showArea">
		<div id="wxts"></div>
		<div id="rebuildArea">
			<div style="margin-top: 80px;font-size: 20px;">
				姓&emsp;&emsp;&emsp;&emsp;&emsp;名：<font color="#85c531">_______________________</font>
				<div
					style="position: absolute;margin-left: 230px; margin-top: -27px;">
					<input readonly="readonly" id="xming0" type="text"
						style="height:25px;width:290px;border:none;background: none;letter-spacing:20px;">
				</div>
			</div>
			<div style="margin-top: 120px;font-size: 20px;">
				账&emsp;户&emsp;余&emsp;额：<font color="#85c531">_______________________</font>
				<div
					style="position: absolute;margin-left: 230px; margin-top: -27px;">
					<input readonly="readonly" id="yjjye0" type="text"
						style="height:25px;width:290px;border:none;background: none;">
				</div>
			</div>
		</div>
		<div class="pageButton" id="confirmApp">确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认</div>
	</div>
	<div id="bottomArea">
		<span style="margin-left:620px;"> <img id="btnMain"
			style="margin-top:8px;"
			src="${pageContext.request.contextPath}/images/index.png" res_img="" />
		</span> <span style="margin-left:40px;"> <img id="btnReturn"
			style="margin-top:6px;"
			src="${pageContext.request.contextPath}/images/return.png" res_img="" />
		</span>
	</div>

</body>

<script type="text/javascript">
	// var zjlx00 = window.parent.cardtype; //证件类型 ：01、02、5
	// var zjbm00 = window.parent.cardNo; //证件编号
	var xming0 = window.parent.xming0; //患者姓名
	//var sfzhao = window.parent.sfzhao; //身份证号
	var yjjye0 = window.parent.yjjye0; //卡内余额
	// var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
	// var sfykt0 = window.parent.sfykt0; //是否为一卡通
	// var money; //预交金金额
	var time1 = 30;
	//初始化倒计时时间：60秒
	var time = 60;
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
		time = 60;
	}

	
	function logicBusiness() {
		$("#xming0").val("  "+window.parent.xming0);
		$("#yjjye0").val("           "+window.parent.yjjye0+"元");
	}
	/**
	*初始化操作
	**/
	var init = function() {
		logicBusiness();
		$("#btnMain").bind("click dbclick", function() { //返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() { //返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});
		$("#confirmApp").on("click", function() { //确认完毕返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	//PrintTicket();打印小票//TODO
	}
	init();
</script>
</html>

