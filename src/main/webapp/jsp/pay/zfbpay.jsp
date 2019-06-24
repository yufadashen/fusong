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

<title>支付宝充值</title>
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
	width: 100%;
	height: 100%;
	overflow: hidden;
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>

<!-- <body scroll="no" id="info"> -->
<body>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="title"
		style="z-index:60;display:block;position:absolute;top:1095px;left:414px;">
		<img id="tip1"
			src="${pageContext.request.contextPath}/images/zfbpaytitle.png" />
	</div>

	<!-- 	二维码显示 -->
	<div id="erweima"
		style="z-index:60;display:none;position:absolute;top:1274px;left:410px;">		
	</div>

	<div id="cancel"
		style="z-index:60;display:none;position:absolute;top:1650px;left:464px;">
		<img id="tip3"
			src="${pageContext.request.contextPath}/images/quxiao.png"
			res_img="${pageContext.request.contextPath}/images/quxiao.png"
			height="" width="" />
	</div>
	<div id="cardinfo" style="position:absolute;top:1211px;left:185px">
		<span style="font-size:40px">姓名:</span><span id="xming0" style="font-size:40px;color:#0000FF"></span>
		<span style="font-size:40px">卡号:</span><span id="carNo" style="font-size:40px;color:#0000FF"></span>
		<span style="font-size:40px">支付金额:</span><span id="zfye" style="font-size:40px;color:#0000FF"></span> 
	</div>
	<div id="tip_div"
		style="display:none;width:659px;height:243px;z-index:1000;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;z-index:1000;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;z-index:1000;"><strong>充值成功，请在下方取走凭条</strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;z-index:1000;top:125px;left:4px" />
	</div>
	<div id="main" style="position:absolute;top:1745px;left:466px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/" height="" width="" />
	</div>
</body>

<script type="text/javascript">

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
	var cztype = window.parent.cztype; //1.正常充值  2.结算时金额不足充值   3.挂号时挂号费不足充值 4取号时费用不足充值 5预约时金额不足充值
	var yjjye0 = window.parent.yjjye0; //院内账户余额 
	var czsucc; //充值成功 1为成功
	//初始化倒计时时间：60秒
	var time = 90;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				/* if(time==0){
					//跳转页面
					
				} */
			},1000);
	}
	
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = 90;
	}
	returnTime();

	
	//1.支付宝充值下单 
	function ZfPay() {
		$("#xming0").text(window.parent.xming0);
		$("#carNo").text(window.parent.brid00);
		$("#zfye").text(window.parent.money);
		if(cztype==6){
			var funcid="M07.02.03.14";
		}else{
			var funcid="M07.02.03.24";
		}
		var datas = {
			"funcid" : funcid,
			"cxfs00" : window.parent.cardtype,
			"cxdm00" : cardNo,
			"brid00" : window.parent.brid00,
			"czje00" : value,
			"cardno" : cardNo,
			"sfzhao" : "",
			"xming0" : xming0,
			"xbie00" : window.parent.xbie00,
			"ddbt00" : "吉林大学白求恩第一医院自助终端消费",
			"bankid" : "",
			"cardtype" : "",
			"czmzzy":"01",
			"klxbh0" : ""
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
				if (Data.retcode == "0"){
					//	log.WriteLog("支付宝下单成功,金额为"+value);
					var qrcode = Data.retbody[0].qrcode; //二维码串
					ptddls = Data.retbody[0].ptddls; //平台订单流水
					jylsh0 = Data.retbody[0].jylsh0; //交易流水号
					xtgzh0 = Data.retbody[0].xtgzh0; //系统跟踪号
					ptqqls = Data.retbody[0].ptqqls; //平台请求流水	
					$.session.set('ptqqls', ptqqls);
					$.session.set('ptddls', ptddls);
					$.session.set('jylsh0', jylsh0);
					//将二维码串转换为图片
					jQuery("#erweima").qrcode({
						render:"table",
						width:320,
						height:320,
						text:qrcode
					})
					$("#word").hide();
					$("#inputmoney").hide();
					$("#money").hide();
					$("#erweima").show();
					$("#cancel").show();
					
					setTimeout("OrderState()", 1000); //查询订单状态 
				}else{
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.reload();
					});
				}
			},
			error:function(){
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
		if(cztype==6){
			var funcid="M07.02.03.15";
		}else{
			var funcid="M07.02.03.25";
		}
		var datas = {
			"funcid" : funcid,
			"cxdm00" : cardNo,
			"brid00" : window.parent.brid00,
			"czje00" : value,
			"klxbh0" : "",
			"xming0" : xming0,
			"sfzhao" : "",
			"ptqqls" : ptqqls,
			"khsrpz" : "",
			"cshsj0" : "",
			"jylsh0" : jylsh0,
			"xtgzh0" : xtgzh0
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
					czztbz = Data.retbody[0].czztbz; //充值状态标识
					switch (czztbz) {
					case "3":
						// 								//log.WriteLog("卡号"+cardNo+"成功通过过支付宝充值"+value+"元");
						//print();						
						$("#erweima").hide();
						$("#cancel").hide();
						time = 90;
						if(cztype==6){
							czsucc = 1;
							window.parent.czsucc = czsucc;//充值成功
					        window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/fkkf.jsp";
						}else{
							getNewInfo();	
						}
						break;
					case "5":
						//支付宝充值成功但his充值失败，打印失败凭条
						$("#erweima").hide();
						$("#cancel").hide();
						$("#tip_div").show();
						$("#error").text("支付宝充值成功但HIS充值失败，请取走凭条");
						$("#tip_s").on("click", function() {
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
						//		log.WriteLog("卡号"+cardNo+"成功通过过支付宝充值"+value+"元,，但HIS充值失败");
						//	print();
						break;
					default:
						if(time==0){
							CancleOrder();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
						}else{
							setTimeout("OrderState()", 1000);
						}
						
					}
				} else {
					$("#erweima").hide();
					$("#quxiao").hide();
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			},
			error : function() {
				//log.WriteLog("卡号"+cardNo+"查询订单状态失败");
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});

	}

	function getNewInfo() {
		var datas = {
			"funcid" : "M07.02.01.02",
			"cxfs00" : window.parent.cardtype,
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
					window.parent.yjjye0 = Data.retbody[0].yjjye0;
					window.parent.sffs="13";
					window.parent.ptqqls=ptqqls;
					//window.parent.yjjye0 = parseFloat(yjjye0) + parseFloat(value);
					//log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");
					if (cztype == 1) {						
						window.location.href = "${pageContext.request.contextPath}/jsp/pay/paysucc.jsp";
					} else if (cztype == 2) {
						czsucc = 1;
						window.parent.czsucc = czsucc;//充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
					} else if (cztype == 3) {
						czsucc = 1;
						window.parent.czsucc = czsucc;//充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghsucc.jsp";
					} else if (cztype == 4) {
						czsucc = 1;
						window.parent.czsucc = czsucc;//充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
					}else if(cztype==5){
						czsucc = 1;
						window.parent.czsucc = czsucc;//充值成功
		                window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyinfo.jsp";
	                }else if(cztype==6){
						czsucc = 1;
						window.parent.czsucc = czsucc;//充值成功
						 window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/fkkf.jsp";
	                }
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

	$("#cancel").bind("click dbclick", function() {
		$("#erweima").hide();
		$("#cancel").hide();
		CancleOrder();
	});

	//3.支付宝充值撤销订单
	function CancleOrder() {
		if(cztype==6){
			var funcid="M07.02.03.16";
		}else{
			var funcid="M07.02.03.26";
		}
		var datas = {
			"funcid" : funcid,
			"cardno" : cardNo,
			"cxdm00" : cardNo,
			"jylsh0" : jylsh0,
			"ptqqls" : ptqqls,
			"xtgzh0" : xtgzh0,
			"czje00" : value,
			"czmzzy" : "01",
			"brid00" : window.parent.brid00
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
					//	log.WriteLog("卡号"+cardNo+"取消支付宝充值"+value+"元");
					$("#tip_div").show();
					$("#error").text("取消订单成功");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
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
					window.location.reload();
				});
			}
		});
	}




	$("#main").bind("click dbclick", function() {
		CancleOrder();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	ZfPay();
</script>
</html>
