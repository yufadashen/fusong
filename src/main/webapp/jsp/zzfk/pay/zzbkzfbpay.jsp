<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>

<title>自助办卡支付宝充值</title>
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
	background-color: #62BA90;
	border: 1px solid #CAF4F3;
	top: 325px;
	left: 370px;
	padding-top: 10px;
	padding-left: 10px;
}
</style>
</head>

<!-- <body scroll="no" id="info"> -->
<body>
	<div id="title"
		style="z-index:60;display:block;position:absolute;width:1024px;top:0px;left:0px;background-color: #3f7dac">
		<img id="tip1" style="margin-left: -618px;"
			src="${pageContext.request.contextPath}/images/zfbpaytitle.png" /> <span
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

	<!-- 	二维码显示 -->
	<div id="erweima" class="erweima"
		style="z-index:60;display:none;position:absolute;top:200px;left:360px;margin-top:-24px;">
	</div>

	<div id="cancel"
		style="z-index:60;display:none;position:absolute;top:523px;left:360px;margin-top:-24px;">
		<img id="tip3"
			src="${pageContext.request.contextPath}/images/msgbox_button_cancel_down.jpg"
			res_img="${pageContext.request.contextPath}/images/msgbox_button_cancel_downs.jpg"
			height="" width="322" />
	</div>

	<div id="cardinfo" style="position:absolute;top:140px;left:300px">
		<span style="font-size:20px">姓名:</span><span id="xming0"
			style="font-size:20px;color:#0000FF"></span> <span
			style="font-size:20px">卡号:</span><span id="cardNo"
			style="font-size:20px;color:#0000FF"></span> <span
			style="font-size:20px">支付金额:</span><span id="zfye"
			style="font-size:20px;color:#0000FF"></span>
	</div>
	<div id="bottomArea">
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
	 <div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>

<script type="text/javascript">
	var init = function() {
		$("#waiting").show();
		$("#xming0").text(window.parent.xming0);
		$("#cardNo").text(window.parent.cardNo);
		$("#zfye").text("1元");
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		jump();
		ZfPay();
		
	//PrintTicket();打印小票//TODO
	}
		//定义参数
		var log = document.getElementById("AVFOCX");
		var value = window.parent.money; //充值金额
		var jylsh = ""; //交易流水号
		var yhkhao = ""; //银行卡号
		var xming0 = window.parent.xming0; //姓名	
		var cardNo = window.parent.cardNo; //卡号
		var ptqqls; //平台请求流水
		var jylsh0; //交易流水号
		var xtgzh0; //系统跟踪号
		var czztbz; //充值状态标识  返回czztbz=3则付款成功跳到成功界面，czztbz=5则支付成功但是HIS充值失败，打印失败凭条；czztbz=其他继续等待
		var ptddls; //平台订单流水
		var cztype = 1; //1.正常充值  2.结算时金额不足充值   3.挂号时挂号费不足充值 4取号时费用不足充值 5预约时金额不足充值
		var yjjye0 = ""; //院内账户余额 
		var czsucc; //充值成功 1为成功
		var ddbt00; //临沂市人民医院自助终端充值
		var zfblsh; //支付宝流水号
	    var cxfs00; //查询方式

	//初始化倒计时时间：60秒
	var time = 90;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
			 if(time==0){
				//跳转页面
				 window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			} 
			}, 1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 90;
	}
	returnTime();


	//3.支付宝充值下单 
	function ZfPay() {
		
		$("#xming0").text(window.parent.xming0);
		$("#cardNo").text(window.parent.cardNo);
		$("#zfye").text("1元");
		var datas = {
			"funcid" : "M07.02.03.14",
			"zdbh00" : window.parent.zdbh00,
			"cxfs00" : "02",
			"ywlx00" : "2",
			"cxdm00" : $.session.get("zzbkCardNo"),
			"brid00" : window.parent.brid00,
			"czje00" : "1",		
			"sfzhao" :  $.session.get("zzbkIdCard"),
			"xming0" :  $.session.get("zzbkName"),
			"yjjxh0" : ""
		};
		
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do", 
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					//	log.WriteLog("支付宝下单成功,金额为"+value);
					var qrcode = Data.retbody[0].qrcode; //二维码串					
					jylsh0 = Data.retbody[0].jylsh0; //交易流水号
					xtgzh0 = Data.retbody[0].xtgzh0; //系统跟踪号
					$.session.set('jylsh0', jylsh0);
					//将二维码串转换为图片
					jQuery("#erweima").qrcode({
						render : "table",
						width : 320,
						height : 320,
						text : qrcode
					})
					$("#shuru").hide();
					$("#inputmoney").hide();
					$("#money").hide();
					$("#erweima").show();
					watingEvent();
					$("#cancel").show();
					aa = setTimeout("OrderState()", 1000); //查询订单状态 
				} else {
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.reload();
					});
				}
			},
			error : function() {
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}

	//2.支付宝充值查询订单状态
	function OrderState() {
		var datas = {
			"funcid" : "M07.02.03.15",
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
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				
				Data = eval(json);
				if (Data.retcode == "0") {
					cardtype = Data.retbody[0].cardtype//卡类型
					cardNo = Data.retbody[0].kahao; //卡号
					cxfs00 = Data.retbody[0].cxfs00; //查询方式
					ptddls = Data.retbody[0].ptddls; //平台订单流水
					cgjysj = Data.retbody[0].cgjysj; //成功交易时间
					zdbh00 = Data.retbody[0].zdbh00; //终端编号
					czztbz = Data.retbody[0].czztbz; //充值状态标识
					klxbh0 = Data.retbody[0].klxbh0; //卡类型编号
					ptqqls = Data.retbody[0].ptqqls; //平台请求流水	
					ddbt00 = Data.retbody[0].ddbt00; //临沂市人民医院自助终端充值
					xming0 = Data.retbody[0].xming0; //姓名
					cshsj0 = Data.retbody[0].cshsj0; //初始化时间
					sfzhao = Data.retbody[0].sfzhao; //身份证号
					zfblsh = Data.retbody[0].zfblsh; //支付宝流水号
					brid00 = Data.retbody[0].brid00; //病人ID
					jylsh0 = Data.retbody[0].jylsh0; //交易流水号
					xtgzh0 = Data.retbody[0].xtgzh0; //系统跟踪号
					czje00 = Data.retbody[0].czje00; //充值金额
					errmsg = Data.retbody[0].errmsg; //错误信息提示
					
					if(czztbz == "5" || czztbz == "2"){
						$.session.set("xtgzh0",xtgzh0);
						$.session.set("zzbkStatus","2");
						window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/zzbkresulttemp.jsp";
					}else{
						bb = setTimeout("OrderState()", 1000);
						//OrderState();
					}
						
				} else {
					$("#waiting").hide();
					$("#erweima").hide();
					$("#quxiao").hide();
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			},
			error : function() {
				$("#waiting").hide();
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

	//5.支付宝充值撤销订单
	function CancleOrder() {
		var datas = {
			"funcid" : "M07.02.03.16",
			"zdbh00" : window.parent.zdbh00,
 			"jylsh0" : jylsh0,
			"ywlx00" : "2",
			"cxdm00" : $("#cardNo").text(),
			"cxfs00" : "02"
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			success : function(json) {
				setTimeout("watingEvent()", 2000);
				Data = eval(json);
				if (Data.retcode == "0") {
					//	log.WriteLog("卡号"+cardNo+"取消支付宝充值"+value+"元");
					$("#tip_div").show();
					$("#error").text("取消订单成功");
					watingEvent();
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				} else {
					watingEvent();
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
					});
				}
			},
			error : function() {
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.reload();
				});
			}
		});
	}
	function jump() {
		$("#cancel").bind("click dbclick", function() {
				$("#waiting").show();
				$("#erweima").hide();
				$("#cancel").hide();
				$.session.clear();
				clearTimeout(aa);
				clearTimeout(bb);
				CancleOrder();
			
		});

		$("#main").bind("click dbclick", function() {
			if ($("#erweima")[0].style.display == "none") {
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			} else {
				$.session.clear();
				CancleOrder();
			}
		});

		$("#pre").bind("click dbclick", function() {
			if ($("#erweima")[0].style.display == "none") {
				window.location.href = "${pageContext.request.contextPath}/jsp/pay/lypayway.jsp";
			} else {
				$.session.clear();
				CancleOrder();
			}
		});
	}
	function watingEvent(){
		$("#waiting").hide();
	};
	init();
</script>
</html>