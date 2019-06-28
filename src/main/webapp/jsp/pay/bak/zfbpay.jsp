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
		<span style="font-size:25px;color:red;">请您打开支付宝手机客户端，使用扫一扫功能扫描下方二维码进行支付</span>
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
	<div id = "qrcz" style="position:absolute;top:610px;left:389px">
		<img src="../../images/qrcz.jpg">
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
		$("#zfye").text(window.parent.yjjye0);
		ZFPayReadTime();
		
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		
		jump();
		
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
		var Logger = window.parent.Logger;
	//初始化倒计时时间：120秒
	var time = 120;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 120;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
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
	//returnTime();

	//输入金额
	$('img[name="numKey"]').on("click", function() {
		var valStr = $("#value").val();
		if (valStr == "" || valStr == "0") {
			$("#value").val($(this).attr("value"));
		} else {
			$("#value").val(valStr + $(this).attr("value"));
			if (valStr.length > 6) {
				$("#value").val(valStr);
			}
		}
	});
	//修改
	$("#modify").on("click", function() {
		var num = $("#value").val();
		var newstr = num.substring(0, num.length - 1);
		$("#value").val(newstr);
	});
	//重填
	$("#reinput").on("click", function() {
		$("#value").val("");
	});
	//确认
	$("#sure").bind("click dbclick", function() {
		value = $("#value").val();
		Logger.WriteLog("卡号为:"+cardNo+"输入金额为"+value);
		if (parseFloat(value) <= 1000) {
			window.parent.money = value;
			$("#waiting").show();
			ZfPay();
		} else if (parseFloat(value) > 1000) {
			$("#money").hide();
			$("#tip_div").show();
			$("#error").text("单次充值金额不能超过1000元");
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				$("#money").show();
			});
		} else if (parseFloat(value) < parseFloat(window.parent.money)) {
			$("#money").hide();
			$("#tip_div").show();
			$("#error").text("充值金额不能低于" + window.parent.money + "元");
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				$("#money").show();
			});
		}
	});
	//确认充值
	$("#qrcz").bind("click dbclick", function() {
		value = $("#value").val();
		Logger.WriteLog("卡号为:"+cardNo+"输入金额为"+value);
		if(value){
			if (parseFloat(value) <= 1000) {
				window.parent.money = value;
				ZfPay();
			} else if (parseFloat(value) > 1000) {
				$("#money").hide();
				$("#tip_div").show();
				$("#error").text("单次充值金额不能超过1000元");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					$("#money").show();
				});
			} else if (parseFloat(value) < parseFloat(window.parent.money)) {
				$("#money").hide();
				$("#tip_div").show();
				$("#error").text("充值金额不能低于" + window.parent.money + "元");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					$("#money").show();
				});
			}
		}else{
			$("#money").hide();
			$("#tip_div").show();
			$("#error").text("请输入充值金额！");
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				$("#money").show();
			});
		}
		
	});
	//2.支付宝充值下单时间判断 
	function ZFPayReadTime() {
		var datas = {
			"funcid" : "M07.02.03.01",
			"optype" : "0",
			"czlb00" : "3"
		}
		Logger.WriteLog("卡号为:"+cardNo+"支付宝充值下单时间判断:M07.02.03.01");
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do", 
			success : function(json) {
				$("#waiting").hide();
				Data = eval(json);
				if (Data.retcode == "0") {
					var sfkcz0 = Data.retbody[0].sfkcz0;
					if (sfkcz0 == "1") {
						Logger.WriteLog("卡号为:"+cardNo+"支付宝充值下单时间判断:可以充值");
						//ZfPay();
					} else if (sfkcz0 == "0") {
						$("#tip_div").show();
						$("#error").text("正常充值时间已过！不能充值！");
						Logger.WriteLog("卡号为:"+cardNo+"支付宝充值下单时间判断:不可以充值");
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					} else {
						$("#tip_div").show();
						$("#error").text("非正常充值时间！不能充值！");
						Logger.WriteLog("卡号为:"+cardNo+"支付宝充值下单时间判断:不可以充值");
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
				}else{
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
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

	//3.支付宝充值下单 
	function ZfPay() {
		
		$("#xming0").text(window.parent.xming0);
		$("#cardNo").text(window.parent.cardNo);
		$("#zfye").text(window.parent.money);
		var datas = {
			"funcid" : "M07.02.03.14",
			"zdbh00" : window.parent.zdbh00,
			"cxfs00" : "01",
			"ywlx00" : "1",
			"cxdm00" : window.parent.cardNo,
			"brid00" : window.parent.brid00,
			"czje00" : value,		
			"sfzhao" : "",
			"xming0" : xming0,
			"yjjxh0" : window.parent.yjjxh0
			//"xbie00" : window.parent.xbie00,
			//"ddbt00" : "临沂市人民医院自助终端消费",
			//"bankid" : "",
			//"cardtype" : window.parent.cardtype		
			
		};
		Logger.WriteLog("卡号为:"+cardNo+"支付宝充值下单:M07.02.03.14");
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do", 
			success : function(json) {
				setTimeout("watingEvent()", 1000);
				Data = eval(json);
				if (Data.retcode == "0") {
					Logger.WriteLog("卡号为:"+cardNo+"支付宝下单成功,金额为"+value);
					var qrcode = Data.retbody[0].qrcode; //二维码串					
					jylsh0 = Data.retbody[0].jylsh0; //交易流水号
					xtgzh0 = Data.retbody[0].xtgzh0; //系统跟踪号
					
					//$.session.set('ptqqls', ptqqls);
					//$.session.set('ptddls', ptddls);
					$.session.set('jylsh0', jylsh0);
					//将二维码串转换为图片
					jQuery("#erweima").qrcode({
						render : "table",
						width : 200,
						height : 200,
						text : qrcode
					})
					$("#shuru").hide();
					$("#biankuang").hide();
					$("#qrcz").hide();
					$("#inputmoney").hide();
					$("#money").hide();
					$("#erweima").show();
					watingEvent();
					$("#cancel").show();
					$("#zhuyitingxing").show();
					setTimeout("OrderState()", 1000); //查询订单状态 
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
			"cxdm00" : window.parent.cardNo,
			"jylsh0" : jylsh0,
			"ywlx00" : "1"
			/*"brid00" : window.parent.brid00,
			"czje00" : value,
			"klxbh0" : "",
			"xming0" : xming0,
			"sfzhao" : "",
			"ptqqls" : ptqqls,
			"khsrpz" : "",
			"cshsj0" : "",		
			"xtgzh0" : xtgzh0*/
		};
		Logger.WriteLog("卡号为:"+cardNo+"支付宝充值查询订单状态:M07.02.03.15");
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
					switch (czztbz) {
					case "2":
						Logger.WriteLog("卡号"+cardNo+"成功通过过支付宝充值"+value+"元");
						//print();						
						$("#erweima").hide();
						$("#cancel").hide();
						time = 90;
						$.session.set("money1",value);
						$.session.set("xtgzh0",xtgzh0);
						$.session.set("cgjysj",cgjysj);
						$.session.set("czffstatus","支付宝");
						window.location.href = "${pageContext.request.contextPath}/jsp/pay/paysucc.jsp";
						/*if (cztype == 6) {
							czsucc = 1;
							window.parent.czsucc = czsucc; //充值成功
						 window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/fkkf.jsp"; 
						} else {
							//getNewInfo();
							
						}*/
						break;
					case "5":
						//支付宝充值成功但his充值失败，打印失败凭条
						$("#erweima").hide();
						$("#cancel").hide();
						$("#tip_div").show();
						$("#error").text("支付宝充值成功但HIS充值失败，请取走凭条");
						$("#tip_s").on("click", function() {
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
						Logger.WriteLog("卡号"+cardNo+"成功通过过支付宝充值"+value+"元,，但HIS充值失败");
						//	print();
						break;
					default:
						if (time == 0) {
							CancleOrder();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						} else {
							setTimeout("OrderState()", 1000);
						}

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
				Logger.WriteLog("卡号"+cardNo+"查询订单状态失败");
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}
	//4.
	function getNewInfo() {
		var datas = {
			"funcid" : "M07.02.01.02",
			"cxfs00" : window.parent.cardtype,
			"yyjgdm" : "",
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
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					window.parent.yjjye0 = Data.retbody[0].yjjye0;
					window.parent.sffs = "13";
					window.parent.ptqqls = ptqqls;
					//window.parent.yjjye0 = parseFloat(yjjye0) + parseFloat(value);
					//log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");
					if (cztype == 1) {
						window.location.href = "${pageContext.request.contextPath}/jsp/pay/paysucc.jsp";
					} else if (cztype == 2) {
						czsucc = 1;
						window.parent.czsucc = czsucc; //充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
					} else if (cztype == 3) {
						czsucc = 1;
						window.parent.czsucc = czsucc; //充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghsucc.jsp";
					} else if (cztype == 4) {
						czsucc = 1;
						window.parent.czsucc = czsucc; //充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
					} else if (cztype == 5) {
						czsucc = 1;
						window.parent.czsucc = czsucc; //充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyinfo.jsp";
					} else if (cztype == 6) {
						czsucc = 1;
						window.parent.czsucc = czsucc; //充值成功
						window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/fkkf.jsp";
					}
				} else {
					//Logger.WriteLog("卡号为:"+cardNo+"获取病人信息失败");
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

	//5.支付宝充值撤销订单
	function CancleOrder() {
		var datas = {
			"funcid" : "M07.02.03.16",
			"zdbh00" : window.parent.zdbh00,
 			"jylsh0" : jylsh0,
			"ywlx00" : "1",
			"cxdm00" : window.parent.cardNo,
			"cxfs00" : window.parent.cardtype
		};
		Logger.WriteLog("卡号为:"+cardNo+"支付宝充值撤销订单:M07.02.03.16");
		$("#waiting").show();
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				setTimeout("watingEvent()", 2000);
				Data = eval(json);
				if (Data.retcode == "0") {
					Logger.WriteLog("卡号"+cardNo+"取消支付宝充值"+value+"元");
					$("#tip_div").show();
					
					$("#error").text("取消订单成功");
					watingEvent();
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
			
				$("#erweima").hide();
				$("#cancel").hide();
				$.session.clear();
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
