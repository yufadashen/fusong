
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
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="word"
		style="width:100%;z-index:60;position:absolute;top:1200px;display:none">
		<span style="width:100%;font-size:60px;text-align:center;color:red">请确认个人信息</span>
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
	var xming0 = window.parent.xming0; //姓名
	var sfzhao = window.parent.sfzhao; //身份证号码
	var brid00 = window.parent.brid00; //病人ID
	var cardNo; //卡号
	var lxdh00 = window.parent.lxdh00; //联系电话
	var pin000 = window.parent.pin000; //密码
	var xbie00 = window.parent.xbie00; //性别
	var xbiemc = window.parent.xbiemc; //性别名称
	var csrq00 = window.parent.csrq00; //出生日期
	var lxdz00 = window.parent.lxdz00; //联系地址
	var yjjye0 = window.parent.yjjye0; //院内账户余额
	var sfyxcb = "1"; //是否允许补卡
	var sfbkcz = $.session.get('sfbkcz'); //是否补卡充值  1补卡  非1 新建卡
	var exist0 = $.session.get('exist0');//是否存在档案  1存在 0不存在
	var log = document.getElementById("AVFOCX");
	var faka = window.parent.faka;
	var Pad = window.parent.Pad;
	//var IDReader = new UserIDCard(plugin, "d:/Intehel/Driver/UserIdCard.dll");
	var bStop = true;
	var jdlsh0; //建档流水号
	var jylsh0; //交易流水号
	var dblsh0; //单笔流水号	
	//var log = document.getElementById("AVFOCX");	

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
	getCardNo();
	
	function getCardNo(){
		var ret = faka.MoveCardX(1);
		if(ret == 0){
			var ret2 = faka.GetCardNumberX();
			if(ret2 != ""){
				cardNo = ret2;
				window.parent.cardNo = cardNo;
				jdInit();
			}else{
				$("#tip_div").show();
				$("#error").text("获取卡号信息失败");
				$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
					});				
			}	
		}else{
			$("#tip_div").show();
			$("#error").text("移动卡片至RF位失败");
			$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
		}			
	}
	
	//建档初始化
	function jdInit() {
		var datas = {
			"funcid" : "M07.02.02.03",
			"cxdm00" : cardNo,
			"cxfs00" : "01",
			"brid00" : brid00,
			"xming0" : xming0,
			"xbie00" : xbie00,
			"xbiemc" : xbiemc,
			"sfzhao" : sfzhao,
			"lxdz00" : lxdz00,
			"csrq00" : csrq00,
			"lxdh00" : lxdh00,
			"czje00" : "0",
			"pin000" : pin000
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"?method=ApplyAction",
			//url:"${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					jdlsh0 = Data.retbody[0].jdlsh0; //建档流水号
					jylsh0 = Data.retbody[0].jylsh0; //交易流水号
					$.session.set('jdlsh0', jdlsh0);
					$.session.set('jylsh0', jylsh0);
					dblsh0 = Data.retbody[0].dblsh0; //单笔流水号
					jdSure();
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

	function jdSure() {
		var datas = {
			"funcid" : "M07.02.02.04",
			"tkzt00" : "",
			"jdlsh0" : jdlsh0,
			"jylsh0" : jylsh0,
			"dblsh0" : dblsh0,
			"brid00" : brid00,
			"sfbkcz" : sfbkcz
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
					if (Data.retbody[1].jdzt00 == "0") {
						$("#tip_div").show();
						$("#error").text("建档成功,办卡工本费1元");
						$("#tip_s").on("click", function() {
							if(exist0 == 1){
								testMoney();								
							}else{
								$("#tip_div").hide();
								window.parent.money = 1;
								window.parent.cztype = 6;
								window.parent.cardtype = "02";
								window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
							}							
						});
					} else {
						$("#tip_div").show();
						$("#error").text("建档失败1");
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
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
	
	function testMoney(){
		if(parseFloat(yjjye0)>=parseInt(1)){
			window.location.href = "fkkf.jsp";
		}else{
			var money = (parseFloat(1)-parseFloat(yjjye0)).toFixed(2);
			window.parent.money = money;
			window.parent.cztype= 6;
			window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
		}
	}
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
</script>
</html>

