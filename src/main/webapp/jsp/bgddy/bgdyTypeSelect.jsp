<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>报告打印</title>
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
	background: url(../../images/bgn.jpg) no-repeat;
}
div{
	position: absolute;
}

</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
	<div id="jybgdy" style="position:absolute;top:337px;left:44px;width: 303px;height: 143px;display: none;">
		<img alt="" src="../../images/jianyan.png">
	</div>
	<div id="blbgdy" style="position:absolute;top:337px;left:361px;width: 303px;height: 143px;display: none;">
		<img alt="" src="../../images/bingli.png">
	</div>
	<div id="xdbgdy" style="position:absolute;top:337px;left:678px;width: 303px;height: 143px;display: none;">
		<img alt="" src="../../images/xindiantu.png">
	</div>
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		<img alt="" src="../../images/yue/mzgh_index_y.png">
	</div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;">
		<img alt="" src="../../images/yue/mzgh_return_y.png">
	</div>
	
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
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
	var smenus = window.parent.smenus; //报告单打印的二级菜单配置信息
	function initialize	(){
		$("#jybgdy").bind("click dbclick", function() {//检验报告打印
			window.location.href = "jybgdySelect.jsp";
		});
		$("#blbgdy").bind("click dbclick", function() {//病例报告打印
			window.location.href = "blbgdySelect.jsp";
		});
		$("#xdbgdy").bind("click dbclick", function() {//病例报告打印
			window.location.href = "xdtbgdySelect.jsp";
		});
		
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		///获取报告单打印的二级菜单
		var i=0;
		if(smenus.length > 0){
			$.each(smenus,function(index,temp){
				switch (temp.gndjc) {
					case "jybgddy":
						i++;
						$("#jybgdy").css("display","block");
						break;
					case "blbgddy":
						i++;
						$("#blbgdy").css("display","block");
						break;
					case "xdtbgddy":
						i++;
						$("#xdbgdy").css("display","block");
						break;
				}
			});
		}else{
			alert("报告单打印二级菜单未配置，请联系工作人员！");
		}
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
					var mainPage="main"+window.parent.pagescene+".jsp";
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
	}
	init();
</script>
</html>