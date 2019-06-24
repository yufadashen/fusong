<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>打印病历单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
    body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
    }
    </style>
</head>

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:910px;right:30px;font-size:40px;color: #FF0000;">
   	</div>
   	<div id="mma"
		style="position: absolute;top:500px;left:400px;display:block">
		<span id="qingcharu" style="font-size:50px;color:#FF0000;"><strong>正在查询，请等待...</strong></span>
	</div>
	<div id="main" style="position: absolute;top:900px;left:550px;">
			<img src="${pageContext.request.contextPath}/images/fanhui.png"  height="67" width="161"/> 
	</div>
	
</body>
<script language="javascript">
	//初始化倒计时时间：60秒
	var time = 6;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = 6;
	}
	returnTime();
	var pid=window.parent.brid00;
	//var pid="000717916400";

  	$("#main").bind("click dbclick", function() {
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
  	function exec(command) {
  	    window.oldOnError = window.onerror;
  	    window._command = command;
  	    window.onerror = function (err) {
  	        if (err.indexOf('utomation') != -1){
  	            alert('请更改你的IE的安全级别：开始->设置->控制面板->Internet选项->安全->自定义级别->对没有标记为安全的ActiveX控件进行初始化和脚本运行->启用。命令：'+ window._command);
  	            return true;
  	        }
  	        else
  	            return false;
  	    };

  	    var wsh = new ActiveXObject('WScript.Shell');
  	    if (wsh) wsh.Run(command);
  	    wsh = null;
  	    window.onerror = window.oldOnError;
  	}
  	function reprint(){
  		var weblis="D:\\autolis\\print.exe"+pid;
  		exec(weblis);
  	}
  	//reprint();
  	
  	function printLis(){
		var lis=window.parent.ListEXE;
		lis.CallLis("D:\\autolis\\print.exe",pid); 
		window.location.href="${pageContext.request.contextPath}/jsp/dybgd/chooseType.jsp";

	}
  	printLis();
</script>
</html>
