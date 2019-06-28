<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>提示插入银行卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
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
	margin:0px;
	background: url(../../images/yue/xryhk.png) no-repeat;
}
div{
	position: absolute;
	text-align: center;
}

</style>															
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:569px;left:775px;font-size:60px;color: #FF0000;"></div>

	<div id="name" style="margin:78px 0px 0px 176px;font-size:33px;color:red;"></div>
	<div id="ynye" style="margin:84px 0px 0px 504px;font-size:33px;color:red;"></div>
	<div id="czje" style="margin:84px 0px 0px 813px;font-size:33px;color:red;"></div>
	
	<div id="cancel" style="margin:425px 0px 0px 577px;height:57px;width:238px;"></div>

	<div id="tip_div"  style="margin:229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
var log = window.parent.Logger;
var bankObj = window.parent.unionPay;
var cardNo = window.parent.cardNo;


	//初始化倒计时时间：120秒
	var time = 30;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 30;
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


	//银行卡充值初始化
	function bankpayInit(){
		//logger.WriteLog("银行卡号为:"+yhkhao+"充值初始化");
	 	var datas = {"funcid":"M07.02.03.08",								 
			      "cxfs00":"5",
			      "cxdm00":window.parent.cardNo,
			      "brid00":window.parent.brid00,
			      "czje00":$.session.get("czje"),
			      "yjjxh0":window.parent.yjjxh0,
			      "czqx00":"1"};
		$.ajax({
			async:true,
			type:"post",
			data:datas,
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			url:window.parent.serverUrl+"?method=ApplyAction",
			url:"http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
			success:function(json){
					Data = eval(json);
					jylsh0 = Data.retbody[0].jylsh0;
					if(Data.retcode=="0"){
						var jylsh0 = Data.retbody[0].jylsh0;//交易流水号
						var cshsj0 = Data.retbody[0].cshsj0;//初始化时间
						$.session.set("jylsh0", jylsh0);
						$.session.set("cshsj0", cshsj0);
						cardStart();
					}else{
						message.text(Data.retmsg);							
					}
			},
			error:function(){
				log.WriteLog("充值初始化失败！");
				message("系统异常，请稍后再试！");	
			}
		});	
	}
	
	function cardStart(){
		var flag = initBankCard();//银联硬件初始化操作
		if (flag) {
			$("#waiting").hide();
			cardOper();
		}else{
			message("银行卡初始化失败！");
		}
	}
	
	//初始化银行卡操作
	var initBankCard = function() {
		log.WriteLog(getCurrentTime()+"  初始化银行卡控件");
		//2、初始化银行 并读卡
		
		var iret = bankObj.UMS_Init(1); //初始化  设置1 类型为银行卡
		var iret4 = bankObj.UMS_CheckCard();
		if (iret4 == 0x37) {
			log.WriteLog(getCurrentTime()+"  当前读卡器有卡，弹出卡!");
			EjectCard();
			message("读卡器有银行卡，请工作人员取走后，进行银行卡充值！");
		}
		if (iret == 0) { //初始化成功
			log.WriteLog(getCurrentTime()+ "  初始化成功！");
			var iret1 = UMS_SetReq();//设置参数
			if (iret1 == 0) {
				log.WriteLog(getCurrentTime()+"  设置参数成功！");
				//设置参数成功  进卡、读卡操作
				var iret3 = bankObj.Ums_EnterCard(); //进卡
				if (iret3 == 0) {
					return true;
				}
			}
		}
		return false;
	}
	//银行卡操作
	function cardOper() {
		var iret4 = bankObj.UMS_CheckCard();
		var tmo;
		if (iret4 == 0x37) { //卡在读卡器内
			clearTimeout(tmo);
			//读取卡号
			var iret5 = bankObj.Ums_ReadCard();
			if (iret5 == 0 || iret5 == 1) {
				var bankCardNo = bankObj.CardNum; //银行卡号
				$.session.set("bankCardNo",bankCardNo);
				log.WriteLog(getCurrentTime()+"  读取银行卡卡号："+bankCardNo);
				var iret6 = bankObj.UMS_StartPin(); //键盘启动加密成功
				if (iret6 == 0) {
					log.WriteLog(getCurrentTime()+"  键盘启动加密成功："+bankCardNo);
					//跳转到输入密码页面
					window.location.href = "${pageContext.request.contextPath}/jsp/pay/inputpassword.jsp";
				}
			} else {
				message("读取银行卡卡号异常，请按插卡标识方向插卡！");
				$("#tip_s").off().on("click", function() {
					$("#tip_div").hide();
					window.location.href = "putoutbankcard.jsp";
				});
			}
		} else {
			tmo = setTimeout("cardOper();", 500);
		}
	}
	
	//设置银联参数
	var UMS_SetReq = function() {
		var czje = $.session.get("czje");
		var Amount = czje +"00";//后两位为角和分   充值金额入参一共12位 
		var tn = Amount.length;
		for(var i=0;i<(12-tn);i++){
			Amount = "0"+Amount;
		}
		log.WriteLog(getCurrentTime()+"  充值金额："+Amount);
		var Request="00000001"+//收银台号CounterId
		"00000002"+//操作员号OperId
		"00"+//交易类型TransType  00消费
		Amount+//交易金额Amount
		//"000000000001"+
		"666666"+//原交易凭证号OldTrace
		"20150805"+//原交易日期OldDate
		"121212121212"+//原交易参考号OldRef
		"777777"+//原交易授权码OldAuth
		"888888"+
		"20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"+
		"999";//交易校验值LRC
		var iret = bankObj.UMS_SetReq(Request);
		return iret;
	}
	
	//弹出银行卡
	function EjectCard() {
		var iret = bankObj.UMS_EjectCard();
		if (iret == 0) {
			bankObj.UMS_CardClose();
			message("请取走你的银行卡！");
		} else {
			message("弹出银行卡失败！");
		}
	}
	//获取当前时间
	var getCurrentTime = function (){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
        var milliSeconds=date.getMilliseconds();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
        if(hours<10){
        	hours="0"+hours;
        }
        if(minutes<10){
        	minutes="0"+minutes;
        }
        if(seconds<10){
        	seconds="0"+seconds;
        }
        return year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds+":"+milliSeconds;
	}
	
	function message(message) { //提示信息
		if($("#waiting")){
			$("#waiting").hide();
		}
		$("#tip_div").show();
		$("#error").text(message);
		$("#tip_s").off().on("click", function() {
			$("#tip_div").hide();
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		return;
	}
	
	function initialize	(){
		$("#name").text(window.parent.xming0);//姓名
		$("#ynye").text(window.parent.yjjye0);//余额
		$("#czje").text($.session.get("czje"));//充值金额
		$("#waiting").show();
		$("#cancel").bind("click dbclick", function() {//取消
			$.session.clear();
			window.location.href = "qxcryhk.jsp";
		});
		
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
	}
	
	/**
	*初始化操作
	**/
	var init = function(){
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		bankpayInit();
	}
	init();

</script>
</html>