<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>

<title>微信</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>

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
	background-color: #62BA90;
	background: url(${pageContext.request.contextPath}/images/bgn.jpg)
		no-repeat; 
}

#bottomArea {
	background-color: #3f7dac;
	width: 100%;
	height: 80px;
	margin-left: -8px;
	text-align: left;
	font-size: 50px;
	color: white;
	margin-top: 700px;
	line-height: 60px;
}

#money {
	background-color: #B2CFEB;
	border: 1px solid black;
	top: 325px;
	left: 370px;
	padding-top: 3px;
	padding-left: 3px;
}
</style>
</head>
<!-- <body scroll="no" id="info"> -->
<body>
	<div id="title"
		style="z-index:60;display:block;position:absolute;width:1024px;top:0px;left:0px;background-color: #3f7dac">
		<img id="tip1" style="margin-left: -618px;"
			src="${pageContext.request.contextPath}/images/wxpaytitle.png" /> <span
			id="time"
			style="position:absolute;top:20px;right:75px;font-size:60px;color: red;">
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
	<div id="shuru"
		style="display:block;position:absolute;left:375px;top:253px;">
		<span id="tip2" style="font-size:40px;color:black">请输入<span style="font-size:40px;color:red">充值金额</span>!</span>
	</div>
	<div id="inputmoney"
		style="display:block;position:absolute;left:235px;top:420px;">
		<span style="font-size:35px;color:black">充值金额:</span>
		<input name="value" id="value" type="text" maxlength="5"
			style="width:200px;height:50px;text-align:center;font-size:40px;border:black;background-color:#6CC918;">
	</div>
	
	<div id="money"
		style="z-index:999; width:276px; position:absolute;top:340px;left:567px;">
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
		<img src="../../images/kb2/0.png" value="0" name="numKey" style="width:130px;height:50px;" /> 
		<img src="../../images/kb2/sure.png" value="11" id="sure" style="width:130px;height:53px;margin-top:4px;" />
	</div>
	<!-- 	二维码显示 -->
	<div id="erweima" class="erweima"
		style="z-index:60;display:none;position:absolute;top:300px;left:420px;margin-top:-24px;">
	</div>
    <div id = "biankuang"
		style="z-index:60;position:absolute;width:715px;height:489px;top:187px;left:150px;border:1px solid black;border-radius:30px;"></div>
	<div id="cancel"
		style="z-index:60;display:none;position:absolute;top:501px;left:420px;margin-top:-24px;">
		<img id="tip3"
			src="${pageContext.request.contextPath}/images/msgbox_button_cancel_down.jpg"
			res_img="${pageContext.request.contextPath}/images/msgbox_button_cancel_downs.jpg"
			height="" width="200" />
	</div>
	<div id="zhuyitingxing"style="z-index:60;display:none;position:absolute;top:160px;left:140px;">
		<span style="font-size:25px;color:red;">请您打开微信手机客户端，使用扫一扫功能扫描下方二维码进行支付</span>
		<br/><br/>
		<span style="font-size:25px;color:red;"> 温馨提示:扫码的退款业务是原路返回,二维码充值<span style="font-size:35px;color:blue;">勿让他人代充</span>.</span>
	</div>
	<div id="cardinfo" style="position:absolute;top:100px;left:200px">
		<span style="font-size:35px">姓名:</span><span id="xming0"
			style="font-size:35px;color:#0000FF"></span> <span
			style="font-size:35px">卡号:</span><span id="cardNo"
			style="font-size:35px;color:#0000FF"></span> <span
			style="font-size:35px">支付金额:</span><span id="zfye"
			style="font-size:35px;color:#0000FF"></span>
	</div>
	<!--<div id="openkb" style="margin:351px 0px 0px 400px;">
		<img src="../../images/yue/keyboard_y.png">
	</div>-->
	<div id = "qrcz" style="position:absolute;top:610px;left:389px">
		<img src="../../images/qrcz.jpg">
	</div>
	<div id="bottomArea" style="position:absolute;">
		<div style="margin-left:664px;line-height: 78px;display: inline">
			<img id="main" style="margin-top:-8px;"
				src="${pageContext.request.contextPath}/images/index.png" res_img="" />
		</div>
		<div style="margin-left:10px;line-height: 78px;display: inline;">
			<img id="pre" style="margin-top:-8px;"
				src="${pageContext.request.contextPath}/images/return.png"
				res_img="" />
		</div>
	</div>
</body>
<script type="text/javascript">
	var init = function() {
		$("#xming0").text(window.parent.xming0);
		$("#cardNo").text(window.parent.cardNo);
		$("#zfye").text(window.parent.yjjye0);
		returnTimeStart(); //倒计时
		wxorder();
	//PrintTicket();打印小票//TODO
	}
	var time = 120;
	//设置倒计时功能
	function returnTimeStart() {
		//初始化倒计时时间：120秒
		time = 120;
		//自动倒计时，计时时间为0时，
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
			time = 120;
		}
		returnTime();
	}
	;
	//定义
	//var log = document.getElementById("AVFOCX");
	var value = window.parent.money; //充值金额
	var jylsh = ""; //交易流水号
	var yhkhao = ""; //银行卡号
	var xming0 = window.parent.xming0; //姓名
	var brid00 = window.parent.brid00; //病人ID
	var xbie00 = window.parent.xbie00; //病人性别
	var cardNo = window.parent.cardNo; //卡号
	var ptqqls; //平台请求流水
	var jylsh0; //交易流水号
	var xtgzh0; //系统跟踪号
	var ptddls; //平台订单流水	 	
	var czztbz; //充值状态标识  返回czztbz=3则付款成功跳到成功界面，czztbz=5则支付成功但是HIS充值失败，打印失败凭条；czztbz=其他继续等待
	var czsucc; //充值成功   1为成功
	var cztype = window.parent.cztype; //1.正常充值  2.结算时金额不足充值   3.挂号时挂号费不足充值  4.取号时金额不足充值  5预约时金额不足充值
	var yjjye0 = window.parent.yjjye0; //院内账户余额
	var aa; //设置循环查询
	var bb; //设置循环查询回调
	var cgjysj; //充值成功时间
	var zzbkStatus;//自助办卡标识
	var log = window.parent.Logger;//日志OCX

	//微信充值下单
	function wxorder() {
		$("#xming0").text($.session.get("zzbkName"));
		$("#cardNo").text($.session.get("zzbkCardNo"));
		$("#zfye").text("1元");
		var datas = {
			"funcid" : "M07.02.03.22",
			"zdbh00" : window.parent.zdbh00,
			"cxdm00" : $.session.get("zzbkCardNo"),
			"cxfs00" : "02",
			"ywlx00" : "2",//业务类型   2 为办卡
			"brid00" : window.parent.brid00,
			"czje00" : "1",
			"sfzhao" : $.session.get("zzbkIdCard"),
			"xming0" : $.session.get("zzbkName"),
			"yjjxh0" : ""//预交金序号需要查询基本信息

		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					//log.WriteLog("微信下单成功，金额为"+value);
					var qrcode = Data.retbody[0].qrcode; //二维码串
					ptddls = Data.retbody[0].ptddls; //平台订单流水
					jylsh0 = Data.retbody[0].jylsh0; //交易流水号
					$.session.set("jylsh0",jylsh0);
					xtgzh0 = Data.retbody[0].xtgzh0; //系统跟踪号
					ptqqls = Data.retbody[0].ptqqls; //平台请求流水
					//将二维码串转换为图片
					$("#erweima").qrcode({
						render : "table",
						width : 200,
						height : 200,
						text : qrcode
					})
					$("#shuru").hide();
					$("#inputmoney").hide();
					$("#money").hide();
					$("#erweima").show();
					$("#cancel").show();
					aa = setTimeout("queryOrder()", 1000); //查询订单状态							
				} else {
					$("#tip_div").show();
					$("#error").text("微信下单失败，请重试");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}
	//微信充值查询订单状态
	function queryOrder() {
		var datas = {
			"funcid" : "M07.02.03.23",
			"zdbh00" : window.parent.zdbh00,
			"cxdm00" : $.session.get("zzbkCardNo"),
			"jylsh0" : jylsh0,
			"ywlx00" : "2"
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					czztbz = Data.retbody[0].czztbz; //充值状态标识
					xtgzh0 = Data.retbody[0].xtgzh0; //系统跟踪号
					cgjysj = Data.retbody[0].cgjysj; //充值成功时间
					if(czztbz == "5" || czztbz == "2"){
						clearTimeout(bb);
						$.session.set("xtgzh0",xtgzh0);
						$.session.set("zzbkStatus","2");
						window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/zzbkresulttemp.jsp";
					}else{
						bb = setTimeout("queryOrder()", 1000);
						
					}
				}else{
					$("#erweima").hide();
					$("#cancel").hide();
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			},
			error : function() {
				//log.WriteLog("卡号"+cardNo+"查询订单状态失败");
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}

	//微信充值撤销订单
	function cancleOrder() {
		var datas = {
			"funcid" : "M07.02.03.24",
			"zdbh00" : window.parent.zdbh00,
			"jylsh0" : jylsh0,
			"ywlx00" : "2",
			"cxdm00" : $("#cardNo").text(),
			"cxfs00" : "02"
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			success : function(json) {
				var Data = eval(json);
				//Data = {"retbody":[{"ynzhye":"0","cgjysj":"20180924060812","ptddls":"20180924061719003587","jylsh0":"2018112010049H"}],"retmsg":"","retcode":"0"};
				//alert(Data.retcode);
				if (Data.retcode == "0") {
					//log.WriteLog("取消微信办卡");
					$("#tip_div").show();
					$("#error").text("取消订单成功");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				} else {
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
					});
				}
				
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}

		$("#cancel").bind("click dbclick", function() {
			$("#erweima").hide();
			$("#cancel").hide();
			clearTimeout(aa);
			clearTimeout(bb);
			$.session.clear();
			cancleOrder();
		});

		$("#main").bind("click dbclick", function() {
			if ($("#erweima")[0].style.display == "none") {
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			} else {
				$.session.clear();
				clearTimeout(aa);
				cancleOrder();
			}
		});

		$("#pre").bind("click dbclick", function() {
			if ($("#erweima")[0].style.display == "none") {
				window.location.href = "${pageContext.request.contextPath}/jsp/pay/lypayway.jsp";
			} else {
				$.session.clear();
				clearTimeout(aa);
				cancleOrder();
			}
		});
	init();
</script>
</html>