	<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE HTML>
	<html>
	 <head>
	 <object width="0" height="0" name="plugin" classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
	 <object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	 
	    <title>现金充值</title>
	   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/CashPayment.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
	    <meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
	    <meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
		<style type="text/css">
			body {
		        width: 100%;
		        height: 100%;
		        overflow: hidden;
		        background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat; 
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
	 	<div id="payinfo" style="position:absolute;left:515px;top:1450px;"> 	
			 <div id="paymoney">
		   		<span style="font-size:50px;color:#3A5FCD;">充值金额&nbsp&nbsp</span>
		   		<span id="money" style="font-size:50px;color:#CD0000;"></span>
		   		<span style="font-size:50px;color:#3A5FCD;">&nbsp元</span>                         
		   	 </div>
			<div id="sure" style="position:absolute;left:98px;top:122px;">                     
		  		<img src="${pageContext.request.contextPath}/images/queding.png" res_img="${pageContext.request.contextPath}/images/queding1.png" height="" width=""/> 
		    </div>
	   </div>
	   <div id="smoney" style="position:absolute;left:300px;top:1100px;">
	 		<img src="${pageContext.request.contextPath}/images/cashtitle.png" res_img="${pageContext.request.contextPath}/images/cashp.png" height="" width=""/>
	 	</div>
	   <div id="money" style="position:absolute;left:150px;top:1350px;">
	 		<img src="${pageContext.request.contextPath}/images/crcash.png" res_img="${pageContext.request.contextPath}/images/cashpay.png" height="" width=""/>
	 	</div>
	   <div id="main" style="position: absolute;top:1780px;left:450px;">
			<img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
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
					parent.location.reload();
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
		var CashBV = window.parent.CashBV;
		var bStop =true;		
 		var sumvalue=0;//总金额		
 		var value=0; //单笔金额
 		var yjjye0 = window.parent.yjjye0;//院内账户余额
 		var cardNo=window.parent.cardNo;//就诊卡号
 		var dblsh0;//单笔流水号
 		var jylsh0;//交易流水号
 		var cztype=window.parent.cztype;//1.正常充值  2.结算时金额不足充值   3.挂号时挂号费不足充值 4取号时费用不足充值5自助发卡时充值
 		
 		
	 	//判断充值时间，判断本机当前是否可充值	 	
		function testCanPay(){
			log.WriteLog("卡号为:"+cardNo+"开始判断充值时间，判断本机是否可充值");
			 var datas = {"funcid":"M07.02.03.01",								 
					      "optype":"0",
					      "czlb00":"1"};
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
						     	//log.WriteLog("本机可充值,准备识币");
						    	 StartIdentify();
							}else{
								//log.WriteLog("设备状态正常，但不可充值");
								$("#tip_div").show();
								$("#error").text(Data.retbody[0].mess00);							
							}
						}else{
							//log.WriteLog("设备状态异常");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);							
						};
					},
					error:function(){
						//log.WriteLog("获取本机是否可充值信息失败");
						$("#tip_div").show();
						$("#error").text("系统异常,请稍后再试!");						
					}
				});		
		}
		
		//开始识币
		function StartIdentify() {
		  	if(!bStop)
		  	 return;
		  	//1:1元  2:2元 4:5元 8:10元 16:20元 32:50元 64:100元
		  	CashBV.SetDenominations(64+32+16+8+4+2+1);
		  	//log.WriteLog("设置可接收的纸币面额");
		  	var Ret = CashBV.StartIdentify('10002','13900000000');
		  //	alert(Ret.RetVal);
		  	bStop = false;
		  	GetBillValue();
 		}
 		 
		//停止识币
		function Stop()
		  {
		  	var Ret = CashBV.StopIdentify();
		  	bStop = true;
		  	//log.WriteLog("停止识币");
		  }
		
 		
 		//得到金额
		  function GetBillValue(){
			  	var Ret = CashBV.GetBillValue();
			  	value=Ret.RetVal;
			  	//log.WriteLog("卡号:"+cardNo+"本次收到纸币"+value);
				if(value!=0){
					sumvalue+=value;
					//log.WriteLog("卡号:"+cardNo+"共收到纸币"+sumvalue);	
					$("#money").text(sumvalue);
					//停止识币
					Stop();
					//现金充值初始化
					cashpayInit(); 
				}else{
					setTimeout("GetBillValue();", 1500);
				}
		  }  
		//现金充值初始化
		function cashpayInit(){
			//log.WriteLog("卡号:"+cardNo+"开始现金充值初始化");	
			 var datas = {"funcid":"M07.02.03.04",
			 			  "dzjec0":"",
			 			  "czje00":"",								 
					      "jylsh0":"",
					      "dblsh0":"",
					      "ycmklx":"",
					      "czqx00":"",
					      "zzs000":"",
					      "cxfs00":"5",
					      "cxdm00":"242080006",					      
					      "brid00":window.parent.brid00};
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
								dblsh0=Data.rebody[0].dblsh0;
								jylsh0=Data.rebody[0].jylsh0;
								//log.WriteLog("卡号:"+cardNo+"现金充值初始化成功");
								cashpaySucc();
							}else{
								//log.WriteLog("卡号:"+cardNo+"现金充值初始化失败");
								$("#tip_div").show();
								$("#error").text(Data.retmsg);								
							}
					},
					error:function(){
						//log.WriteLog("卡号:"+cardNo+"现金充值初始化失败");
						$("#tip_div").show();
						$("#error").text("系统异常,请稍后再试!");						
					}
				});		
		} 
		
		
		 //单笔充值成功
		function cashpaySucc(){
			 var datas = {"funcid":"M07.02.03.05",								 				      
					      "cxfs00":"5",
					      "cxdm00":"242080006",
					      "jylsh0":jylsh0,
					      "dblsh0":dblsh0,
					      "czje00":value,
					      "ycmklx":"2"};
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
								//log.WriteLog("卡号:"+cardNo+"现金充值单笔充值成功");
								StartIdentify()
							}else{
								//log.WriteLog("卡号:"+cardNo+"现金充值单笔充值失败");
								$("#tip_div").show();
								$("#error").text(Data.retmsg);								
							}
					},
					error:function(){
						//log.WriteLog("卡号:"+cardNo+"现金充值单笔充值失败");
						$("#tip_div").show();
						$("#error").text("系统异常,请稍后再试!");						
					}
				});		
		} 
		
		
		//结束充值 弹出充值成功界面
		function cashpayEnd(){
			window.parent.money=sumvalue;
			 var datas = {"funcid":"M07.02.03.07",								 					     
					      "cxfs00":"5",
					      "cxdm00":"242080006",
					      "cardno":window.parent.cardNo,
					      "cardtype":window.parent.cardtype,
					      "jylsh0":jylsh0,
					      "ycmklx":"2",
					      "czqx00":"",
					      "czlb00":"1",
					      "czje00":sumvalue,
					      "brid00":window.parent.brid00,
					      "xming0":window.parent.xming0,
					      "xbie00":window.parent.xbie00,
					      };
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
								//log.WriteLog("卡号:"+cardNo+"现金充值成功");
								getNewInfo();															
							}
					},
					error:function(){
						$("#tip_div").show();
						$("#error").text("系统异常,请稍后再试!");						
					}
				});		
		} 
		
		function getNewInfo(){
	 		var datas = {"funcid":"M07.02.01.02",								 
				      "cxfs00":"5",
				      "cxdm00":"242080006",
					  "sfybye":"5"};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				//url:"${pageContext.request.contextPath}/Test/test.do",
				success:function(json){
						Data = eval(json);
						if(Data.retcode=="0"){
							window.parent.yjjye0 = Data.retbody[0].yjjye0;
							//window.parent.yjjye0 = parseInt(yjjye0)+parseInt(value);
							//log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");
							if(cztype=="1"){						
              							window.location.href="${pageContext.request.contextPath}/jsp/pay/paysucc.jsp";
								}else if(cztype=="2"){
									window.location.href="${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
								}else if(cztype=="3"){
									window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghdoctor.jsp"; 
								}else if(cztype=="4"){
									window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
								}	
						}else{
							//log.WriteLog("卡号为:"+cardNo+"获取病人信息失败");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);							
						}
				},
				error:function(){
					$("#tip_div").show();
					$("#error").text("系统异常，请稍后再试！");					
				}
			});	
	 	}
		
		
		
		$("#sure").bind("click dbclick", function() {
			cashpayEnd();
		});
		$("#main").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		testCanPay();
	 </script>
</html>
	
