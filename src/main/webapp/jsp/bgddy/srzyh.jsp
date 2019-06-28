
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>输入住院号打印</title>
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
#money img{
	width: 70px;
	height: 70px;
}
</style>
</head>
<body scroll="no" id="info">
	<div id="time"
		style="position:absolute;top:5px;left:800px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">输入住院号</font>
	</div>
	<div id="showArea">
		<div id="wxts"></div>
		<div id="rebuildArea">
			<div style="margin-top: 80px;font-size: 35px;">
				<span style="color: red;">请&emsp;输&emsp;入&emsp;住&emsp;院&emsp;号：</span><br/><br/>
				<div
					style="position: absolute;margin-left: 50px; margin-top: -27px;top:181px;left:68px;">
					
					<input  id="value" type="text" autofocus="autofocus"
						style="height:45px;width:290px;border:none;background: none;font-size:35px;letter-spacing:7px;">
				</div>
				<font color="#85c531">____________________</font>
				<img id="keyinsert" src="../../images/keyboard.jpg">
			</div>
		</div>
		<div class="pageButton" id="confirmApp">确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认</div>
	</div>

<div id="money" style="z-index:1000;border:2px solid #4C8599;background-color:white; width:300px; position:absolute;top:339px;left:662px;padding-top: 2px;padding-left: 2px;">
    <img src="../../images/kb2/1.png"  value="1" name="numKey"/>
    <img src="../../images/kb2/2.png"  value="2" name="numKey" />
    <img src="../../images/kb2/3.png" value="3"  name="numKey"/>
    <img src="../../images/kb2/delete.png" value="10"  id="modify" style="margin-top:1px;"/><br> 
     
    <img src="../../images/kb2/4.png"  value="4"name="numKey"  />
    <img src="../../images/kb2/5.png"  value="5" name="numKey" /> 
   	<img src="../../images/kb2/6.png" value="6"name="numKey" /> 
    <img src="../../images/kb2/reinput.png" value="10" id="reinput" style="margin-top:1px;"/><br>
    
    <img src="../../images/kb2/7.png" value="7"name="numKey" />
    <img src="../../images/kb2/8.png" value="8" name="numKey" />
    <img src="../../images/kb2/9.png" value="9"name="numKey"/>
    <img src="../../images/kb2/close.png" value="10"  id="close"style="margin-top:1px;"/><br> 
    
    <img src="../../images/kb2/0.png" value="0"name="numKey" style="width:144px;height:65px;"/>
    <img id="zmx" src="../../images/kb2/X.png" value="X" name="numKey" />
    <img src="../../images/kb2/sure.png" value="11" id="sure" style="margin-top:1px;" />
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
	var obj = $("#value");//获取输入框的号码
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
	
	/***
	***  键盘事件
	***/
	  //确认
	  $("#sure").bind("click dbclick", function() {
		  if(obj.val()!=""){
		  	$.session.set("printzyh00",obj.val());
			window.location.href = "${pageContext.request.contextPath}/jsp/bgddy/print.jsp";
		  }else{
		  		$("#tip_div").show();
				$("#error").text("住院号不能为空");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
			});
		  }
		 	
	  });
		
	 $('img[name="numKey"]').on("click", function() {
	 	
		 /* if(obj[0].id != "userCardNo" && $(this).attr("value") == "X"){//屏蔽键盘按键事件
			 return;
		 } */
	     var valStr = obj.val();
	     if (valStr == "") {
	    	 obj.val($(this).attr("value"));
	     } else {
	    	 obj.val(valStr + $(this).attr("value"));
	     }
	  });
	   //删除
	  $("#modify").on("click", function() {
		    var num = obj.val();
		    var newstr = num.substring(0, num.length - 1);
		    obj.val(newstr);
	  });
	   //重填
	  $("#reinput").on("click", function() {
		  obj.val("");
	  });
	  //关闭
	  $("#close").bind("click dbclick", function() {
		    var a = $("#money")[0].style.display;
			if(a == "none"){
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
	  });
	  
	/**
	*初始化操作
	**/
	var init = function() {
		var printType01 = $.session.get("printType01");
		$.session.set("printType02",printType01+"srzyh");
		
		$("#keyinsert").bind("click dbclick", function() { //调出键盘
			$("#money").css("display","block");
		});
		$("#btnMain").bind("click dbclick", function() { //返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() { //返回上一级
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#confirmApp").on("click", function() { //确认完毕开始打印
			 if(obj.val()!=""){
		  	$.session.set("printzyh00",obj.val());
			window.location.href = "${pageContext.request.contextPath}/jsp/bgddy/print.jsp";
		  }else{
		  		$("#tip_div").show();
				$("#error").text("住院号不能为空");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
			});
		  }
		});
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	//PrintTicket();打印小票//TODO
	}
	init();
</script>
</html>

