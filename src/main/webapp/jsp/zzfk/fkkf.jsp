
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
<object width="0" height="0" id="faka"
	classid="clsid:E59A197F-4491-4818-A20F-920166E41AD7"> </object>					
<title>自助发卡</title>
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
	<div id="time"
		style="position:absolute;top:1030px;right:80px;font-size:60px;color: #FF0000;">
	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div>
   <div id="word" style="width:100%;z-index:60;position:absolute;top:1200px;display:none">
		<span  style="width:100%;font-size:60px;text-align:center;color:red">请取走您的就诊卡和身份证</span>
	</div>
	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/zzfk.png" />
	</div>

	<!-- 返回主頁面 -->
	<div id="main" style="position: absolute;top:1730px;left:600px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/images/main1.png"
			height="" width="" />
	</div>
	<!-- 返回上一步 -->
	<div id="pre" style="position: absolute;top:1718px;left:400px;">
		<img src="${pageContext.request.contextPath}/images/pre.png"
			res_img="${pageContext.request.contextPath}/images/pre1.png"
			height="" width="" />
	</div>
</body>
<script type="text/javascript">	
	var cardNo = window.parent.cardNo;//卡号
	var yjjye0;//预交金余额
	var jdlsh0 = $.session.get('jdlsh0'); //建档流水号
	var jylsh0 = $.session.get('jylsh0'); //交易流水号
	var brid00 = window.parent.brid00; //病人id
	//var log = document.getElementById("AVFOCX");	
	var faka = window.parent.faka;
	var jdkssj;//创建时间
	var time = 60;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 60;
	}
	returnTime();
	
	
	function kfqr() {
		var datas = {
			"funcid" : "M07.02.02.05",
			"jdlsh0" : jdlsh0,
			"jylsh0" : jylsh0,
			"brid00" : brid00
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					jdkssj = Data.retbody[0].jdkssj;					
					getNewInfo();				
				} else {
					//log.WriteLog("设备状态异常");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			},
			error : function() {
				//log.WriteLog("获取设备状态异常");
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
				$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}
	
	function faka3(){
		var ret = faka.WriteCardX(brid00);
		if(ret == 0){
			var ret2 = faka.MoveCardX(3);
			if(ret2 == 0){
				print();
				$("#word").show();
				$("#tip_div").show();
				$("#error").text("请取走您的就诊卡和身份证");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					$.session.clear();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}else{
				$("#tip_div").show();
				$("#error").text("移动卡失败");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					$.session.clear();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		}else{
			$("#tip_div").show();
			$("#error").text("写卡失败");
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				$.session.clear();
				window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}
	}
	
	function getNewInfo() {
		var datas = {
			"funcid" : "M07.02.01.02",
			"cxfs00" : "5",
			"cxdm00" : cardNo,
			"sfybye" : "5"
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url:"${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					yjjye0 = Data.retbody[0].yjjye0;
					window.parent.yjjye0 = yjjye0;
					faka3();	
					//log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");					
				} else {
					//log.WriteLog("卡号为:"+cardNo+"获取病人信息失败");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
				}
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
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
	
	function print(){
		var Printer = window.parent.KPrinter;
		//log.WriteLog("打印机端口设置成功");
		Printer.SetFontModeAndTypeX(0x20,0x01);//设置字体						 			
		Printer.SetTextModeX(2);//设置中文模式						
		Printer.WriteTextLineX("吉林大学白求恩第一医院");
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("办理就诊卡");
		Printer.LFX(2); //多行送纸
		Printer.WriteTextLineX("");
		Printer.SetFontModeAndTypeX(0x20, 0x00); //设置字体		
		Printer.WriteTextLineX("  患者姓名："+window.parent.xming0);
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  就诊卡号："+window.parent.brid00);
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  卡内余额："+yjjye0+"元");
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  操作时间："+jdkssj);
		Printer.SetTextModeX(1); //设置中文模式
		Printer.WriteTextLineX("  注  意 事 项：");
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  该卡为实名制，请妥善保管");
		Printer.LFX(3); //多行送纸
		Printer.CeTCutX(); //切纸						
	}
	kfqr();
</script>
</html>

