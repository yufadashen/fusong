
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
<title>门诊预约</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
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
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>
<body scroll="no">
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:145px;left:4px" />
   </div>
   <div id="word" style="width:100%;z-index:60;position:absolute;top:1200px;">
		<span  style="width:100%;font-size:60px;text-align:center;color:red">预约成功,请在下方取走凭条</span>
	</div>
	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/ghtitle.png" />
	</div>
	<div id="birdinfo" style="position:absolute;top:1311px;left:175px">
		<span style="font-size:40px">姓名:</span><span id="xming0" style="font-size:40px;color:#0000FF"></span>
		<span style="font-size:40px">电话:</span><span id="lxdh00" style="font-size:40px;color:#0000FF"></span> 
		<span style="font-size:40px">卡内余额:</span><span id="yjjye0" style="font-size:40px;color:#0000FF"></span>
	</div>
	<div id="yyInfo"
		style="z-index:50;position:absolute;top:1450px;left:43px;text-align:center;display:block">
		<table style="table-layout:fixed;width:1000px;border:1px solid #000;background-color:#B4EEB4;font-size:50px;cellspacing:2px" id="info2">
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">预约科室</td>
				<td id="yykeshi" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">预约医生</td>
				<td id="yyyisheng" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">预约日期</td>
				<td id="yyriqi" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">预约时间</td>
				<td id="yyshijian" style="width:650px;border:1px solid #000;"></td>
			</tr>
		</table>
	</div>
	<div id="main" style="position: absolute;top:1730px;left:450px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/images/main1.png"
			height="" width="" />
	</div>
</body>
<script type="text/javascript">	
	var xming0=window.parent.xming0;//患者名称	
	var cardNo =window.parent.cardNo;//卡号
	var cxfs00=window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
	var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
	var keshi = $.session.get('keshi'); //科室
	var riqi = $.session.get('riqi'); //日期
	var shijian = $.session.get('shijian'); //时间
	var doctor = $.session.get('doctor'); //医生
	var lxdh00=window.parent.lxdh00;//手机号
	var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用）
	var log = document.getElementById("AVFOCX");	
	
	//初始化倒计时时间：60秒
	var time = window.parent.reTime;
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
		time = window.parent.reTime;
	}
	returnTime();
	
	
	function yyInfo(){
		$("#yyInfo").show();
		$("#yykeshi").text(keshi);
		$("#yyyisheng").text(doctor);
		$("#yyriqi").text(riqi);
		$("#yyshijian").text(shijian);
		$("#lxdh00").text(lxdh00);
		$("#yjjye0").text(yjjye0);
		$("#xming0").text(xming0);
		print();			
	}
	
	//打印
	function print() {
		var Printer =window.parent.KPrinter;
			Printer.SetFontModeAndTypeX(0x70, 0x01); //设置字体
			Printer.SetTextModeX(1); //设置中文模式
			Printer.WriteTextLineX("吉林大学白求恩第一医院");
			Printer.WriteTextLineX("门诊预约");
			Printer.WriteTextLineX(keshi);
			Printer.WriteTextLineX(doctor);
			Printer.WriteTextLineX(riqi);
			Printer.WriteTextLineX(time);
			Printer.LFX(2); //多行送纸
			Printer.CeTCutX(); //切纸
	}
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});	
	yyInfo();
</script>
</html>





