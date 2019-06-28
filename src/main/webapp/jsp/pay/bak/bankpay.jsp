
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
<title>银行卡充值</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/CardPayment.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style>
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>
<body scroll="no" id="info">
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:286px" />
   </div>
	<div id="title"
		style="z-index:60;display:block;position:absolute;top:1095px;left:380px;">
		<img id="tip1"
			src="${pageContext.request.contextPath}/images/banktitle.png" />
	</div>
	<div id="word"
		style="z-index:60;display:block;position:absolute;top:1250px;left:420px;">
		<span id="tip2" style="font-size:40px;color:red">请插入银行卡</span>
	</div>
	<div id="charu"
		style="z-index:60;display:block;position:absolute;top:1345px;left:400px;">
		<img id="tip3"
			src="${pageContext.request.contextPath}/images/crbankcard.png" />
	</div>
	<div id="shuru"
		style="display:none;position:absolute;left:300px;top:1303px;">
		<span id="tip4" style="font-size:40px;color:#EE7700">请输入金额:</span>
	</div>
	<div id="inputmoney"
		style="display:none;position:absolute;left:530px;top:1300px;">
		<input name="value" id="value" type="text"
			style="width:200px;height:50px;font-size:60px">
	</div>
	<div id="money"
		style="position: absolute;top:1400px;left:370px;display:none">
		<img src="${pageContext.request.contextPath}/images/kb/1.png"
			res_img="images/kb/1_1.png" width="102" height="65" value="1"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/2.png"
			res_img="images/kb/2_1.png" width="102" height="65" value="2"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/3.png"
			res_img="images/kb/3_1.png" width="102" height="65" value="3"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> </br> <img
			src="${pageContext.request.contextPath}/images/kb/4.png"
			res_img="images/kb/4_1.png" width="102" height="65" value="4"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/5.png"
			res_img="images/kb/5_1.png" width="102" height="65" value="5"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/6.png"
			res_img="images/kb/6_1.png" width="102" height="65" value="6"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> </br> <img
			src="${pageContext.request.contextPath}/images/kb/7.png"
			res_img="images/kb/7_1.png" width="102" height="65" value="7"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/8.png"
			res_img="images/kb/8_1.png" width="102" height="65" value="8"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/9.png"
			res_img="images/kb/9_1.png" width="102" height="65" value="9"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> </br> <img
			src="${pageContext.request.contextPath}/images/kb/10.png"
			res_img="images/kb/10_1.png" width="102" height="65" value="10"
			id="modify" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/0.png"
			res_img="images/kb/0_1.png" width="102" height="65" value="0"
			name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
			src="${pageContext.request.contextPath}/images/kb/11.png"
			res_img="images/kb/11_1.png" width="102" height="65" value="11"
			id="sure" style="margin-right:15px;margin-bottom:10px" />
	</div>
	<div id="mma"
		style="display:none;position:absolute;left:310px;top:1485px;">
		<span id="qingshuru" style="font-size:50px;color:#EE7700;"><strong>请输入密码:</strong></span>
	</div>
	<div id="password"
		style="display:none;position:absolute;left:610px;top:1495px;">
		<input id="KeyValue" type="text" maxlength="6"
			style="width:200px;height:50px;text-align:center;font-size:40px" />
	</div>
	<div id="main" style="position:absolute;top:1745px;left:466px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/" height="" width="" />
	</div>
	<div id="return"
		style="position:absolute;left:465px;top:1570px;display:none">
		<img src="${pageContext.request.contextPath}/images/fanhui.png"
			res_img="${pageContext.request.contextPath}/images/fanhui1.png" height="" width=""  />
	</div>
</body>
<script type="text/javascript">
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
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
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
	 	
	 	//定义
	 	var log = document.getElementById("AVFOCX");
		var value=window.parent.money;//充值金额
		var ynzhye=window.parent.ynzhye;//院内账户余额
		var jylsh=""; //交易流水号
		var yhkhao=""; //银行卡号
		var bridname=window.parent.xming0;
		var Pad = window.parent.Pad;
		var CardReader = window.parent.card;
	 	var bStop =true;
	 	var cardNo="";
	 	var pinData;//密码
	 	var cztype=window.parent.cztype;//正常充值  2.结算时金额不足充值   3.挂号时金额不足充值
	 	
	 	
	 	$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});	
		
		
		function valueshow(){
	 		$("#value").val(value);
	 	}
		 //判断充值时间，判断本机当前是否可充值
		function testCanPay(){
			//log.WriteLog("卡号为:"+cardNo+"开始判断充值时间，判断本机是否可充值");
			 var datas = {"funcid":"M07.02.03.01",								 
					      "optype":"0",
					      "czlb00":"2"};
				$.ajax({
					async:false,
					type:"post",
					data:datas,
					dataType:"json",
					contentType: "application/x-www-form-urlencoded; charset=utf-8", 
					url:window.parent.serverUrl+"?method=ApplyAction",
					success:function(json){
						Data = eval(json);
						//如果设备状态正常	
						if(Data.retcode=="0"){
							//log.WriteLog("设备状态正常");
							//如果出参为1，代表可充值
						     if(Data.retbody[0].sfkcz0=="1"){
						     	//log.WriteLog("本机可充值,准备读卡");
						     	readCard();
						     }else{
						     	//log.WriteLog("设备状态正常，但不可充值，提示:"+Data.retbody[0].mess00);
						     	$("#tip_div").show();
								$("#error").text(Data.retbody[0].mess00);								
						     }
						 }else{
						 	//log.WriteLog("设备状态异常");
						 	$("#tip_div").show();
							$("#error").text(Data.retmsg);							
						 }   	
					},
					error:function(){
						//log.WriteLog("获取设备状态异常");
						$("#tip_div").show();
						$("#error").text("系统异常,请稍后再试!");						
					}
				});		
		}
		
		//读取银行卡卡号
		function readCard(){
			//log.WriteLog("准备读取银行卡卡号");
			CardReader.CallEntry();
			//log.WriteLog("进卡");
			var retCode = Ret.RetVal;
			if(retCode=="109002"){
				var Ret = CardReader.ReadTracks('11111','13900000000');
				var Track2=Ret.Track2;
				var Track3=Ret.Track3;
				window.parent.Track2=Track2;
				window.parent.Track3=Track3;
				if(Track2 !=""){
					yhkhao=Track2.split("=")[0];
					//log.WriteLog("银行卡号为:"+yhkhao);
					$("#word").hide();
					$("#charu").hide();
					$("#inputmoney").show();
					$("#money").show();
					$("#value").focus();
				}else{
					//log.WriteLog("读取银行卡号失败");
					$("#tip_div").show();
					$("#error").text("读取银行卡号失败");					
				}	
			}else{
				setTimeout("readCard();", 500);
				//log.WriteLog("循环读取进卡");
			}
  		}
  	
  		//输入金额
	    $('img[name="numKey"]').on("click", function() {
	      var valStr = $("#value").val();
	      if(valStr == "" ||valStr=="0"){
	        $("#value").val($(this).attr("value"));
	      }else{
	        $("#value").val(valStr + $(this).attr("value"));
	      }    
	    });
	    //修改
	    $("#modify").on("click", function() {
	      var num = $("#value").val();
	      var newstr = num.substring(0, num.length - 1);
	      $("#value").val(newstr);
	    });
  		
		//确认
		$("#sure").bind("click dbclick", function() {
			value = $("#value").val();
			//log.WriteLog("银行卡号为:"+yhkhao+"输入金额为"+value);
			if(parseInt(value)<=2000){
				window.parent.money = value;
				bankpayInit();
			}else{
				//log.WriteLog("银行卡号为:"+yhkhao+"输入金额为"+value+",提示单次充值金额不能超过2000元");
				$("#tip_div").show();
				$("#error").text("单次充值金额不能超过2000元");				
			}
		});
		
		//银行卡充值初始化
		function bankpayInit(){
			log.WriteLog("银行卡号为:"+yhkhao+"充值初始化");
		 	var datas = {"funcid":"M07.02.03.08",								 
				      "cxfs00":window.parent.cardtype,
				      "cxdm00":"242080006",
				      "brid00":window.parent.brid00,
				      "czje00":value,
				      "czqx00":"1"};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				success:function(json){
						Data = eval(json);
						jylsh0 = Data.retbody[0].jylsh0;
						if(Data.retcode=="0"){
							//log.WriteLog("银行卡号为:"+yhkhao+"充值初始化成功，开始启动密码键盘");
							OpenPinPad();
						}else{
							//log.WriteLog("银行卡号为:"+yhkhao+"充值初始化失败");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);							
						}
				},
				error:function(){
					//log.WriteLog("银行卡号为:"+yhkhao+"充值初始化失败");
					$("#tip_div").show();
					$("#error").text("系统异常，请稍后再试！");					
				}
			});	
		}
		
		/*******************/
		//密码键盘
		function OpenPinPad() {			
			window.parent.SetPan(window.parent.cardNo);//设置加密参数 卡号
			log.WriteLog("设置加密参数");
			Pad.SetWorkMode(1);
			GetNextKey();
		}
		
		function GetNextKey() {
			var Ret1 = Pad.GetNextKey();
			var KeyValueInfo1 = document.getElementById("KeyValue");
			if (Ret1.RetVal == 13) {
				if (KeyValueInfo1.value.length < 6) {
					document.getElementById("KeyValue").value = "";
					Pad.SetWorkMode(1);
					setTimeout("GetNextKey();", 100);
					return;
				}
				bStop = false;
				setTimeout("GetPIN();", 100);
				return;
			} else if (Ret1.RetVal == 27) //取消
			{
				document.getElementById("KeyValue").value = "";
				Pad.SetWorkMode(1);
				setTimeout("GetNextKey();", 100);
				return;
			} else if (Ret1.RetVal == 8) //删除
			{
				document.getElementById("KeyValue").value = "";
				setTimeout("GetNextKey();", 100);
				return;
			}
			if (Ret1.RetVal != 0) { //收到值
				document.getElementById("KeyValue").value += "*";
			}
			if (bStop){
				setTimeout("GetNextKey();", 100);
			}		
		}
		
		function GetPIN() {
			var Ret = Pad.GetPIN();
			if (Ret.RetVal == 0) {
				log.WriteLog("密码输出正确，开始调用银联接口");
				bStop =true;
				pinData = Ret.pData;
				yl();				
			}
		}
		
		//银联接口
		function yl(){
			var Ret;
			if(Ret=="0"){
				log.WriteLog("调用银联接口成功");				
				bankpaySure();
			}else{
				log.WriteLog("调用银联接口失败");
				bankpayFail();	
			}	
		}

		//银行卡充值，确认充值
		function bankpaySure(){
			log.WriteLog("银行卡充值确认充值");
			var datas = {"funcid":"M07.02.03.09",								 
				      "cxfs00":"5",
				      "cxdm00":"242080006",
				      "brid00":"1128742978",
				      "czje00":value,
				      "czqx00":"1",
				      "xming0":window.parent.xming0,
				      "xbie00":window.parent.xbie00,
				      "jylsh0":jylsh0,
				      "yhkhao":yhkhao,
				      "poslsh":"000932",
				      "pospch":"000001",
				      "posrq0":"0924",
				      "possj0":"090528",
				      "zxlsh0":"40014818",
				      "possqh":"",
				      "shhao0":"420051015299",
				      "poszdh":"050",
				      "mess00":"交易成功"};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				success:function(json){
						Data = eval(json);
						if(Data.retcode=="0"){
							//log.WriteLog("银行卡充值成功");
							bankpaySucc();
						}else{ 
							//log.WriteLog("银行卡充值失败");
							$("#tip_div").show();
							$("#error").text("Data.retmsg");							
						}
				},
				error:function(){
					//log.WriteLog("银行卡充值失败");
					$("#tip_div").show();
					$("#error").text("系统异常,请稍后再试!");					
				}
			});
		}
		
		//充值成功
		function bankpaySucc(){
			$("#mma").hide();
			$("#password").hide();
			$("#tip_div").show();
			$("#error").text("银行卡充值成功,请在下方取走凭条");			
			//CardReader.Eject();//退卡
			if(cztype=="1"){
              		window.location.href="${pageContext.request.contextPath}/jsp/pay/paysucc.jsp";
			}else if(cztype=="2"){
					window.location.href="${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
			}else if(cztype=="3"){
					window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghmima.jsp"; 
			}			
		}
		
		//充值失败
		function bankpayFail(){
		 var datas = {"funcid":"M07.02.03.10",								 				     
				      "cxfs00":"5",
				      "cxdm00":"242080006",
				      "jylsh0":jylsh0,
				      "mess00":"密码错误"};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				success:function(json){
						Data = eval(json);
						if(Data.retcode=="0"){
							$("#mma").hide();
							$("#password").hide();
							$("#tip_div").show();
							$("#error").text(Data.mess00);
							$("#tip_s").on("click", function() {
								$("#tip_div").hide();
								$("#mma").show();
								$("#password").show();
							});
						}else{
							$("#tip_div").show();
							$("#error").text("系统异常,请稍后再试!");							
						}				
				},
				error:function(){
					$("#tip_div").show();
					$("#error").text("系统异常,请稍后再试!");					
				}
			});		
	}		 	
	
	 	$("#main").bind("click dbclick", function() {
	 		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#return").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		valueshow();
	 </script>
</html>

