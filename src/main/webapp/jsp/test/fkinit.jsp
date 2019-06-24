<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<object width="0" height="0" id="faka"
	classid="clsid:E59A197F-4491-4818-A20F-920166E41AD7"> </object>
<title>自助发卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"
	charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/UserIDCard.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>
<body scroll="no">
	<!-- 显示返回主页面倒计时时间 -->
	<div id="time"
		style="position:absolute;top:1030px;right:80px;font-size:60px;color: #FF0000;">
	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;z-index:10">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="word" style="z-index:60;display:block;position:absolute;top:1112px;left:442px;">
		<span id="tip2" style="font-size:40px;color:#EE7700;">请放入身份证</span>
	</div>
	<div id="title"
		style="z-index:60;display:none;position:absolute;top:1095px;left:380px;">
		<img id="tip1"
			src="${pageContext.request.contextPath}/images/zzfk.png" />
	</div>
	<div id="money"
		style="position:absolute;top:1400px;left:370px;display:none">
		<img src="${pageContext.request.contextPath}/images/kb/1.png"
			res_img="images/kb/1_1.png" width="102" height="65" value="1"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/2.png"
			res_img="images/kb/2_1.png" width="102" height="65" value="2"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/3.png"
			res_img="images/kb/3_1.png" width="102" height="65" value="3"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <br>
		<img src="${pageContext.request.contextPath}/images/kb/4.png"
			res_img="images/kb/4_1.png" width="102" height="65" value="4"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/5.png"
			res_img="images/kb/5_1.png" width="102" height="65" value="5"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/6.png"
			res_img="images/kb/6_1.png" width="102" height="65" value="6"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <br>
		<img src="${pageContext.request.contextPath}/images/kb/7.png"
			res_img="images/kb/7_1.png" width="102" height="65" value="7"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/8.png"
			res_img="images/kb/8_1.png" width="102" height="65" value="8"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/9.png"
			res_img="images/kb/9_1.png" width="102" height="65" value="9"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <br>
		<img src="${pageContext.request.contextPath}/images/kb/10.png"
			res_img="images/kb/10_1.png" width="102" height="65" value="10"
			id="modify" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/0.png"
			res_img="images/kb/0_1.png" width="102" height="65" value="0"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/11.png"
			res_img="images/kb/11_1.png" width="102" height="65" value="11"
			id="sureNumber" style="margin-right:15px;margin-bottom:10px" />
	</div>
	<div id="telNumber"
		style="position:absolute;top:1310px;left:320px;display:none">
		<input id="telValue" type="text" maxlength="11"
			style="width:500px;height:60px;text-align:center;font-size:40px" />
	</div>
	

</body>
<script type="text/javascript">
	
	
	
	//输入手机号
	function inputTelNumber() {
		$("#tishi").show();
		$("#telNumber").show();
		$("#money").show();
		
		//输入手机号
	$('img[name="numKey"]').on("click", function() {
		var valStr = $("#telValue").val();
		if (valStr == "" || valStr == "0") {
			$("#telValue").val($(this).attr("value"));
		} else {		
			$("#telValue").val(valStr + $(this).attr("value"));
			if(valStr.length>10){
				$("#telValue").val(valStr);
			}
		}
	});
		
		//修改
		$("#modify").on("click", function() {
			var num = $("#telValue").val();
			var newstr = num.substring(0, num.length - 1);
			$("#telValue").val(newstr);
		});
		//确认
		$("#sureNumber").bind("click dbclick", function() {
			var phone = $("#telValue").val();
			if (phone.length!=11) {
				$("#tishi").hide();
				$("#telNumber").hide();
				$("#money").hide();
				$("#tip_div").show();
				$("#error").text("手机格式输入错误，请重新输入!");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					$("#telValue").val("");
					$("#tishi").show();
					$("#telNumber").show();
					$("#money").show();
				});
			} else {
				lxdh00 = $("#telValue").val();
				window.parent.lxdh00 = lxdh00;
				window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/setInfo.jsp";
			}
		});
	
	}
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	inputTelNumber()
	//checkCardAmount();
	//readIdCard();
</script>
</html>

