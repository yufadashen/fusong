<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>	
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<title>退卡界面提示</title>
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
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(../../images/yputout.jpg) no-repeat;
}
#confirm{
	top:598px;
	left:396px;
	width: 240px;
	height: 56px;
	text-align: center;
	font-size: 35px;
}
#main{
	top:707px;
	left:683px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
#pre{
	top:707px;
	left:852px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
div{
	position:absolute;

}
</style>
</head>
<body>
<span
	id="time"
			style="position:absolute;top:20px;right:75px;font-size:60px;color: red;">
		</span>

</body>
<script type="text/javascript">
		var time = 15;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 15;
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
	function init(){
		returnTime();
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		setInterval(function(){
			 var reader=window.parent.Reader;
				 reader.MoveCardX(2);
			 var status = reader.GetCardReaderStatus;
			 if(status == 9){ //卡机内无卡
				 var reader=window.parent.Reader;
				 reader.MoveCardX(2);
				 $.session.clear();
				 //跳转页面
				 window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			 }
		},1000);
	}
	init();
</script>
</html>
