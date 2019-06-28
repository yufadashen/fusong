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

<title>微信充值</title>
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

	<div id="erweima" class="erweima"
		style="z-index:60;display:none;position:absolute;top:300px;left:420px;margin-top:-24px;">
	</div>
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
		<span style="font-size:35px">姓名:</span><span id="xming0" style="font-size:35px;color:#0000FF"></span> 
		<span style="font-size:35px;margin-left: 88px;">支付金额:</span><span id="zfye" style="font-size:35px;color:#0000FF"></span>
	</div>

	<div id="bottomArea" style="position:absolute;">
		<div style="margin:-21px 0px 0px 666px;line-height: 78px;display: inline;position: absolute;">
			<img id="main" style="margin-top:-8px;" src="${pageContext.request.contextPath}/images/index.png"/>
		</div>
		<div style="margin:-22px 0px 0px 850px;line-height: 78px;display: inline;position: absolute;">
			<img id="pre" style="margin-top:-8px;"src="${pageContext.request.contextPath}/images/return.png"/>
		</div>
	</div>
</body>
<script type="text/javascript">
	var init = function() {
		$("#xming0").text(window.parent.Name);
		$("#zfye").text($.session.get("TotalFee")+" 元");
		returnTimeStart(); //倒计时
		wxorder();//下单
	}
	var time = 120;
	function returnTimeStart() {
		time = 120;
		function returnTime() {
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
		//用户点击或按键等操作时，倒计时重新计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		function timeAgin() {
			time = 120;
		}
		returnTime();
	}
	function message(msg){
		$("#tip_div").show();
		$("#error").text(msg);
		$("#tip_s").off().on("click", function() {
			$("#tip_div").hide();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	//微信充值下单
	var aa;
	var bb;
	var cc;
	var outTradeNo;//微信订单流水
	function wxorder() {
		var datas = {
			"RegNo" : $.session.get("RegNo"),
			//"RegNo" : "6118173",
			"Fee" : $.session.get("TotalFee")
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"WxPayGH",
			success : function(json) {
				var Data = JSON.parse(json)
				if (Data.Code == "0") {
					var qrcode = Data.retBody.url; //二维码串
					outTradeNo = Data.retBody.outTradeNo; //微信订单流水
					//将二维码串转换为图片
					$("#erweima").qrcode({
						render: "canvas",
						width : 200,
						height : 200,
						text : qrcode
					})
					$("#erweima").show();
					$("#cancel").show();
					$("#zhuyitingxing").show();
					aa = setTimeout("queryOrder()", 2000); //查询订单状态							
				} else {
					message("微信下单失败，请重试");
				}
			},
			error : function() {
				message("系统异常，请稍后再试！");
			}
		});
	}
	//微信充值查询订单状态
	function queryOrder() {
		if(outTradeNo){
			var datas = {
				"outTradeNo" : outTradeNo,
				"RegNo" : $.session.get("RegNo"),
				"opType" : window.parent.ttype //1挂号，  2缴费
			};
			
			if(window.parent.ttype == 2){//缴费需要增加参数
				datas.RecipeNos = $.session.get("RecipeNos");
			}
			$.ajax({
				async : false,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"WxPayIsFee",
				success : function(json) {
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						var czztbz = Data.retBody.trade_state; //充值状态标识
						if(czztbz == "SUCCESS"){//支付成功
							if(bb){
								clearTimeout(bb);
							}
							//打印凭条 跳转成功页面 进行打印凭条
							if(window.parent.ttype==1){//挂号
								window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghsuccess.jsp";
							}else if(window.parent.ttype==2){//门诊缴费
								window.location.href = "${pageContext.request.contextPath}/jsp/mzjf/mzjfsuccess.jsp";
							}
						}else if(czztbz == "NOTPAY"){//未支付
							bb = setTimeout("queryOrder()", 800);
						}else if(czztbz == "HISFAIL"){//充值成功，his挂号失败
							//处理退费打印凭条，还是打印凭条，窗口退费
							$("#erweima").hide();
							$("#cancel").hide();
							if($.session.get("RegNo") && window.parent.ttype == 1){
								sfzhOp();///撤销订单 如果是挂号，同时进行释放号点操作
							}
							alert("his返回失败！打印失败凭条或退费");
							//printFail();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						}
					} else {
						message("查询订单信息失败！");
					}
				},
				error : function() {
					message("系统异常，请稍后再试！");
				}
			});
		}else{
			message("微信订单流水获取失败！"+outTradeNo);
		}
	}
	
	//微信充值撤销订单
	function cancleOrder() {
		if($.session.get("RegNo") && window.parent.ttype == 1){///撤销订单 如果是挂号缴费，同时进行释放号点操作
			sfzhOp();
		}
		var datas = {
			"outTradeNo":outTradeNo
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"WxCloseorder",
			success : function(json) {
				var Data = JSON.parse(json)
				if (Data.Code == "0") {
					message("取消订单成功");
				} else {
					message(Data.retmsg);
				}
			},
			error : function() {
				message("系统异常，请稍后再试！");
			}
		});
	}

		$("#cancel").bind("click dbclick", function() {
			$("#erweima").hide();
			$("#cancel").hide();
			clearTimeout(aa);
			clearTimeout(bb);
			cancleOrder();
			$.session.clear();
		});

		$("#main").bind("click dbclick", function() {
			if ($("#erweima")[0].style.display == "none") {
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			} else {
				$("#erweima").hide();
				$("#cancel").hide();
				clearTimeout(aa);
				clearTimeout(bb);
				cancleOrder();
				$.session.clear();
			}
		});

		$("#pre").bind("click dbclick", function() {
			if ($("#erweima")[0].style.display == "none") {
				window.location.href = "${pageContext.request.contextPath}/jsp/pay/lypayway.jsp";
			} else {
				$("#erweima").hide();
				$("#cancel").hide();
				clearTimeout(aa);
				clearTimeout(bb);
				cancleOrder();
				$.session.clear();
			}
		});
		//释放占号
		function sfzhOp(){
			var datas = {
				"RegNo" : $.session.get("RegNo")
			};
			$.ajax({
				async : false,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"ReleaseRegPoint",
				success : function(json) {
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						//log("释放成功！号点："+RegNo);
					}	
				},
				error : function() {
					message("释放号点时系统异常,请稍后再试!");		
				}
			}); 
		}
	init();
</script>
</html>

