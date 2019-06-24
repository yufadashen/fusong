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
	<div id="readcard" style="display:block;margin-top:1200px; ">
			<img src="${pageContext.request.contextPath}/images/readSFZ.png"  height="" width=""/> 
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
	<div id="tip_div2"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo2"
			style="text-align:center;position:relative;top:82px">
			<span id="error2" style="font-size:30px;color:#EE7700;"><strong>确认手机号&nbsp</strong></span>
			<input id="lxdh00" type="text" maxlength="11"
				style="width:300px;height:50px;font-size:40px;text-align:center;">
		</div>
		<img id="tip_l"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="mma"
		style="position:absolute;top:1360px;left:385px;display:none">
		<span id="qingcharu" style="font-size:60px;color:#4169E1;"><strong>请输入密码</strong></span>
	</div>
	<div id="tishi"
		style="position:absolute;top:1220px;left:385px;display:none">
		<span id="qingcharu" style="font-size:60px;color:#4169E1;"><strong>请输入手机号</strong></span>
	</div>
	<div id="login_pa"
		style="position:absolute;top:1460px;left:320px;display:none">
		<input id="KeyValue" type="password" maxlength="6"
			style="width:400px;height:60px;text-align:center;font-size:40px" />
	</div>
	<div id="telNumber"
		style="position:absolute;top:1310px;left:320px;display:none">
		<input id="telValue" type="text" maxlength="11"
			style="width:500px;height:60px;text-align:center;font-size:40px" />
	</div>
	<div id="queding"
		style="position:absolute;top:1585px;left:415px;display:none">
		<img src="${pageContext.request.contextPath}/images/queding.png"
			res_img="${pageContext.request.contextPath}/images/queding1.png"
			height="" width="" />
	</div>
	<div id="sure"
		style="position:absolute;top:1585px;left:415px;display:none">
		<img src="${pageContext.request.contextPath}/images/queding.png"
			res_img="${pageContext.request.contextPath}/images/queding1.png"
			height="" width="" />
	</div>
	<div id="sfbk"
		style="display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error1" style="font-size:30px;color:#EE7700;"><strong>已经建档，是否补卡</strong></span>
		</div>
		<img id="back" src="${pageContext.request.contextPath}/images/no.png"
			width="90" height="43" style="position:relative;top:125px;left:-30px" />
		<img id="banka"
			src="${pageContext.request.contextPath}/images/yes.png" width="90"
			height="43" style="position:relative;top:125px;left:30px" />
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
	var xming0; //姓名
	var sfzhao; //身份证号码
	var brid00; //病人ID
	var xbiemc; //性别名称
	var xbie00; //性别
	var lxdh00; //联系电话
	var lxdz00; //联系地址
	var yjjye0;//院内账户余额
	var sfyxcb = "1"; //是否允许补卡
	var exist0 = 0;//是否建过档   1之前有档案  0 之前无档案
	var sfbkcz; //是否补卡充值   1是补卡  非1新建卡 
	var log = document.getElementById("AVFOCX");
	var faka = window.parent.faka;
	var Pad = window.parent.Pad;
	var IDReader = window.parent.IDReader;
	var bStart =true;
	var cxdm00; //就诊卡卡号
	//初始化倒计时时间：60秒
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

	/* //判断充值时间，判断本机当前是否可充值
	 	function testCanPay() {
	 		//log.WriteLog("开始判断充值时间，判断本机是否可充值");
	 		var datas = {
	 			"funcid" : "M07.02.03.01",
	 			"optype" : "0",
	 			"czlb00" : "1"
	 		};
	 		$.ajax({
	 			async : false,
	 			type : "post",
	 			data : datas,
	 			dataType : "json",
	 			contentType : "application/x-www-form-urlencoded; charset=utf-8",
	 			//url:window.parent.serverUrl+"?method=ApplyAction",
	 			url : "${pageContext.request.contextPath}/Test/test.do",
	 			success : function(json) {
	 				Data = eval(json);
	 				//如果设备状态正常	
	 				if (Data.retcode == "0") {
	 					//log.WriteLog("设备状态正常");
	 					//如果出参为1，代表可充值
	 					if (Data.retbody[0].sfkcz0 == "1") {
	 						//log.WriteLog("本机可充值");
	 						checkCardAmount();
	 					} else {
	 						//log.WriteLog("设备状态正常，但不可充值，提示:"+Data.retbody[0].mess00);
	 						$("#tip_div").show();
	 						$("#error").text(Data.retbody[0].mess00);
	 					}
	 				} else {
	 					//log.WriteLog("设备状态异常");
	 					$("#tip_div").show();
	 					$("#error").text(Data.retmsg);
	 				}
	 			},
	 			error : function() {
	 				//log.WriteLog("获取设备状态异常");
	 				$("#tip_div").show();
	 				$("#error").text("系统异常,请稍后再试!");
	 			}
	 		});
	 	} */



	
	
	function checkCardAmount(){
		var statusNum = faka.CardStatusX();
		if(statusNum.length = 3){
			var cardPosition = statusNum.substr(0,1);
			if(cardPosition == 0){				
				readIdCard();
			}else{
				var ret = faka.MoveCardX(4);
				if(ret == 0){
					readIdCard();			
				}else{
					$("#tip_div").show();
					$("#error").text("移动卡片至回收槽失败");
				}				
			}			
		}else{
			$("#tip_div").show();
			$("#error").text("发卡器异常");
		}  
	}
	
	function readIdCard(){
		var Ret = IDReader.ReadCard();
		if(Ret.RetVal=="111001"){			
			bStart = false;
			$("#readcard").hide();
			$("#word").hide();
			$("#title").show();
			xming0 = IDReader.GetCardInfo(0).Value;
			xbiemc = IDReader.GetCardInfo(1).Value;
			csrq00 = IDReader.GetCardInfo(3).Value;
			sfzhao = IDReader.GetCardInfo(5).Value;
			lxdz00 = IDReader.GetCardInfo(4).Value;
			
			window.parent.xming0 = xming0;
			window.parent.xbiemc = xbiemc;
			window.parent.csrq00 = csrq00;
			window.parent.sfzhao = sfzhao;
			window.parent.lxdz00 = lxdz00;
			if(xbiemc == "男"){
				xbie00 = 1;
				window.parent.xbie00 = xbie00;
			}else{
				xbie00 = 2;
				window.parent.xbie00 = xbie00;
			};
			existing();
		}
		if (bStart){
			setTimeout("readIdCard();", 500);
		}
	}
	
	function existing() {
		var datas = {
			"funcid" : "M07.02.02.01",
			"tradecode" : "",
			"cardtype" : "",
			"cxdm00" : "",
			"pin000" : "",
			"xming0" : xming0,
			"lxdh00" : "",
			"sfzhao" : sfzhao,
			"hqbrid" : "0"
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
					var sfcg00 = Data.retbody[0].sfcg00;
					if (sfcg00 == "AA" && Data.retbody[0].brid00!=undefined && Data.retbody[0].brid00.length>7) {
							if (sfyxcb == "1") {								
								brid00 = Data.retbody[0].brid00;
								yjjye0 = Data.retbody[0].yjjye0;
								pin000 = Data.retbody[0].pin000;
								window.parent.yjjye0 = yjjye0;
								window.parent.brid00 = brid00;
								window.parent.pin000 = pin000;
								exist0 = 1;//存在档案
								$.session.set('exist0', exist0);
								$("#sfbk").show();
								$("#error1").text("是否选择补卡");
								$("#back").on("click", function() {
									$("#sfbk").hide();
									$.session.clear();
									window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
								});
								$("#banka").on("click", function() { //补卡确认
									$("#sfbk").hide();
									sfbkcz = 1;
									$.session.set('sfbkcz', sfbkcz);
									inputTelNumber();
								});
							}else{
								$("#tip_div").show();
								$("#error").text("当前机器不允许补卡");
								$("#tip_s").on("click", function() {
									$("#tip_div").hide();
									$.session.clear();
									window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
								});
							}											
					} else {
						$.session.set('exist0', exist0);
						cxbrid();												
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
	function cxbrid() {
		var datas = {
			"funcid" : "M07.02.02.01",
			"tradecode" : "",
			"cardtype" : "",
			"cxdm00" : "",
			"pin000" : "",
			"xming0" : xming0,
			"lxdh00" : "",
			"sfzhao" : sfzhao,
			"hqbrid" : "1"
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
					var sfcg00 = Data.retbody[0].sfcg00;
					if(sfcg00 == "AA"){
						brid00 = Data.retbody[1].brid00; //病人ID					
						window.parent.brid00 = brid00;
						//输入手机号
						inputTelNumber();
					}else{
						$("#tip_div").show();
						$("#error").text("获取病人ID失败");
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}					
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
	//输入手机号
	function inputTelNumber() {
		$("#tishi").show();
		$("#telNumber").show();
		$("#telNumber").focus();
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
		
		$(document).keydown(function(event){
			if(event.keyCode==13){
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
					window.location.href = "setInfo.jsp";
				}
			}
		})
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
				window.location.href = "setInfo.jsp";
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
	checkCardAmount();
	//readIdCard();
</script>
</html>

