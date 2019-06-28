<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>输入银行卡密码</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<script src="../../js/bankCardInfo.js"></script>

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
	background: url(../../images/yue/ymagpasswd.png) no-repeat;
}
div{
	position: absolute;
	text-align: center;
}

</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>

	<div id="name" style="margin:78px 0px 0px 176px;font-size:33px;color:red;"></div>
	<div id="ynye" style="margin:84px 0px 0px 504px;font-size:33px;color:red;"></div>
	<div id="czje" style="margin:84px 0px 0px 813px;font-size:33px;color:red;"></div>
	
	<div id="shuru" style="margin:461px 0px 0px 566px;">
		<input id="bankPwd" type="text" maxlength="6" style="letter-spacing:10px; border:none;text-align:center;width:226px;height:33px;background-color:#C7D9E7">
	</div>
	
	<div id="cancel" style="margin:576px 0px 0px 414px;height:57px;width:238px;"></div>

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
	var bankObj = window.parent.unionPay;
	var log = window.parent.Logger;
	
	var bankCardNo = $.session.get("bankCardNo");
	var bankName;
	
	var PinCounter;
	var time;
	//输入密码操作
	var PinCounter;
	var timeS;
	function PinProcess() {
		$("#bankPwd")[0].value = "";
		PinCounter = 0;
		timeS = setInterval(UMS_GetOnePass, 200);
	}
	
	function UMS_GetOnePass() {
		var i;
		var iret = bankObj.UMS_GetOnePass();
		if (iret == 42) { //"*"
			PinCounter = PinCounter + 1;
		} else if (iret == 0x08) { //退格
			if (PinCounter > 0) {
				PinCounter = PinCounter - 1;
			}
		} else if (iret == 0x1B) { //取消
			clearInterval(timeS);
			log.WriteLog(getCurrentTime()+" 取消按钮！"+bankCardNo);
			PinCounter = 0;
			window.location.href = "putoutbankcard.jsp";
		} else if (iret == 0x0D) { //确认
			clearInterval(timeS);
			$("#waiting").show();
			$("#cancel").hide();
			$("#shuru").hide();
			log.WriteLog(getCurrentTime()+" 输入密码结束！"+bankCardNo);
			setTimeout("transProcess()",500);

		} else if (iret == 0x02) { //超时
			clearInterval(timeS);
			log.WriteLog(getCurrentTime()+" 超时！");
		} else if (iret == 0xFF) {
			//PinCounter=PinCounter;
		} else {
			clearInterval(timeS);
			log.WriteLog(getCurrentTime()+" 未知键值！");
		}
		$("#bankPwd")[0].value = "";
		for (i = 0; i < PinCounter; i++) {
			document.getElementById("bankPwd").value = document.getElementById("bankPwd").value + "*";
		}
	}
	function transProcess(){
		var iret = bankObj.UMS_GetPin();
		if (iret == 0) {
			log.WriteLog(getCurrentTime()+"  确认密码  开始进行交易："+bankCardNo);
			UMS_TransCard(); //进行交易
		}else{
			log.WriteLog(getCurrentTime()+"  读取密码失败！"+iret);
			message("读取密码失败！");
		}
	}
	//进行银行卡交易结果
	function UMS_TransCard() {
		bankObj.UMS_TransCard();
		if(bankObj.RespCode == "00"){//交易成功
			log.WriteLog("交易成功！返回码，卡号："+bankObj.RespCode+"      "+bankCardNo + "    "+bankObj.RespInfo);
			confirmRecharge();//确认充值
			
		}else{//交易失败
			log.WriteLog(getCurrentTime()+" 交易失败！卡号："+bankCardNo+"    "+bankObj.RespCode +"   "+bankObj.RespInfo);
			message("交易失败!"+bankObj.RespInfo);
		}
	}
	//弹出银行卡
	function EjectCard() {
		var iret
		iret = bankObj.UMS_EjectCard();
		if (iret == 0) {
			message("请取走你的银行卡！");
		} else {
			message("弹出银行卡失败！");
		}
	}
	function message(message) { //提示信息
		if($("#waiting")){
			$("#waiting").hide();
		}
		$("#tip_div").show();
		$("#error").text(message);
		$("#tip_s").off().on("click", function() {
			$("#tip_div").hide();
			window.location.href = "${pageContext.request.contextPath}/jsp/pay/putoutbankcard.jsp";
		});
		return;
	}
	function initialize	(){
		$("#name").text(window.parent.xming0);//姓名
		$("#ynye").text(window.parent.yjjye0);//余额
		$("#czje").text($.session.get("czje"));//充值金额
		
		$("#cancel").bind("click dbclick", function() {//取消
			window.location.href = "putoutbankcard.jsp";
		});
		
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#bankPwd").focus();	
	}
	
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
	var RespCode;//应答码
	var RespInfo;//应答码说明信息
	var RespCardNo;//交易卡号
	var RespAmount;//交易金额
	var RespTrace;//交易凭证号
	var RespBatch;//交易批次号
	var RespTransDate;//交易日期
	var RespTransTime;//交易时间
	var RespRef;//交易参考号
	var RespAuth;//交易授权码
	var RespMemo;//交易返回附加信息
	var RespLrc;//交易校验值
	var RespTId;//终端号
	var RespMId;//商户号
	//确认充值
	function confirmRecharge (){
		RespCode = bankObj.RespCode;//应答码
		RespInfo = bankObj.RespInfo;//应答码说明信息
		RespCardNo = bankObj.RespCardNo;//交易卡号
		if(RespCardNo){
			RespCardNo = RespCardNo.trim();
		}
		RespAmount = bankObj.RespAmount;//交易金额
		RespTrace = bankObj.RespTrace;//交易凭证号
		RespBatch = bankObj.RespBatch;//交易批次号
		RespTransDate = bankObj.RespTransDate;//交易日期
		RespTransTime = bankObj.RespTransTime;//交易时间
		RespRef = bankObj.RespRef;//交易参考号
		RespAuth = bankObj.RespAuth;//交易授权码
		RespMemo = bankObj.RespMemo;//交易返回附加信息
		RespLrc = bankObj.RespLrc;//交易校验值
		RespTId = bankObj.RespTId;//终端号
		RespMId = bankObj.RespMId;//商户号
		var posTrans = {
			"version":"UF",//json标识
			"type":"01",//刷卡交易类型，01(消费)
			"posBankCard":RespCardNo,//POS交易银行卡号
			"posAmount":RespAmount,//POS交易金额
			"posConsultNo":RespRef,//POS交易参考号
			"posSerial":RespTrace,//POS交易流水号
			"posMerchant":RespMId,//POS商户号
			"posTerminal":RespTId,//-POS终端号 
			"posCardType":"00",//00银联卡 
			"posExpire":"1222",//POS交易银行卡 有效期  TODO
			"posBatch":RespBatch,//POS交易批次号 
			"posTradeDate":new Date().getFullYear()+RespTransDate,//POS交易成功日期    				年月日  TODO
			"posTradeTime":RespTransTime,//POS交易成功时间
			"posIssuingBank":bankName//银行卡 发卡行名称
		};
		var datas={
			"funcid":"M07.02.03.09",
			"zdbh00":window.parent.zdbh00,//自助终端编号，
			"ywlx00":$.session.get("zzbkFlag")=="0"?"2":"1",//业务类型，1-充值，2-办卡
			"cxfs00":"1",		//查询方式
			"sfzhao":window.parent.sfzhao,	//	身份证号，
			"posTrans":JSON.stringify(posTrans),//银行卡交易信息，格式如下（JSON）
			"jylsh0":$.session.get("jylsh0"),	//交易流水号
			"czje00":$.session.get("czje"),	//	充值金额（单位元）
			"brid00":window.parent.brid00,		//
			"cxdm00":window.parent.cardNo,	//	
			"yjjxh0":window.parent.yjjxh0,	//	预交金序号，5244515，院内账户id
			"czlb00":"1",//充值类别，1
			"khyh00":bankName,//	开户银行，TODO
			"poslsh":RespTrace,//POS流水号，例如：000932
			"zxlsh0":RespRef,//	POS中心流水号，例如：40014818
			"yhkhao":bankCardNo,//	银行卡号，例：6227000010150104240
			"pospch":RespBatch,//POS批次号，例如：000001
			"posrq0":RespTransDate,//POS日期，例如：0924
			"possj0":RespTransTime,//POS时间，例如：090528
			"poszdh":RespTId,//POS终端号，例如：050
			"shhao0":RespMId,//POS商户号，例如：420051015299
			"possqh":RespAuth,//POS授权号
			"mess00":RespInfo,//POS提示信息，例如：交易成功
			
			"zphm00":"",
			"zpzh00":"",
			"sfjyh0":"",
			"czybh0":"",
			"poslsht":"",
			"zxlsht":"",
			"yhkht0":"",
			"jyh000":""
			};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			url : "http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
			success : function(json) {
				var Data = eval(json);
				if (Data.retcode == "0") {
					var cgjysj = Data.retbody[0].cgjysj;//成功交易时间，例如：20180924090047
					var czje00 = Data.retbody[0].czje00;//充值金额
					var jylsh0 = Data.retbody[0].jylsh0;//交易流水号
					var xtgzh0 = Data.retbody[0].xtgzh0;//系统跟踪号，例如：2018092493654D
					var yjjye0 = Data.retbody[0].yjjye0;//预交金
					$.session.set("ayjjye0",yjjye0);
					//打印小票
					print(cgjysj,czje00,jylsh0,xtgzh0,yjjye0);
					//跳转yhksuccess.jsp
					window.location.href = "yhksuccess.jsp";
				}else{
					printFail();
					message(Data.retmsg);
				}
			},
			error : function() {
				printFail();
				message("系统异常,请稍后再试!");
			}
		}); 
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
	
	function print(cgjysj,czje00,jylsh0,xtgzh0,yjjye0){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
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
        var currTime = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      临沂市人民医院自助银行卡充值(门诊)");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      				");
		printer.WriteTextLineX("      卡        号："+window.parent.cardNo+"  姓     名："+window.parent.xming0);
		printer.WriteTextLineX("      院内余额："+yjjye0+"元");
		printer.WriteTextLineX("      收据号："+xtgzh0);
		printer.WriteTextLineX("      流  水  号："+jylsh0);
		printer.WriteTextLineX("      自助编号："+window.parent.zdbh00);
		printer.WriteTextLineX("      充值时间: "+currTime);
		printer.WriteTextLineX("       —————————————————————");
		printer.WriteTextLineX("      充值金额："+czje00+"元");
		printer.WriteTextLineX("      商户名称：" + "临沂市人民医院");
		printer.WriteTextLineX("      商户编号：" + RespMId);
		printer.WriteTextLineX("      收  单  行："+window.parent.bsdh00);
		printer.WriteTextLineX("      POS编号："+RespTId);
		printer.WriteTextLineX("      银行卡号："+bankCardNo);
		printer.WriteTextLineX("      流  水  号："+RespTrace);
		printer.WriteTextLineX("      参  考  号："+RespRef);
		printer.WriteTextLineX("      交易日期："+RespTransDate+"      时间："+RespTransTime);
		printer.WriteTextLineX("                       ");
		printer.WriteTextLineX("      注意事项：");
		printer.WriteTextLineX("      (1)本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("      (2)退款凭本收据或本人身份证。");
		
		printer.LFX(2);
		
		printer.CeTCutX(); //切纸
	}
	function printFail(){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
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
        var currTime = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("            临沂人民医院自助服务终端系统");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      抱歉，由于某些原因");
		printer.WriteTextLineX("      造成用户  "+window.parent.xming0+"  在 "+ currTime +" 时所充值的 "+ $.session.get("czje") +"元  无法及时提交服务器，特此证明。");
		printer.WriteTextLineX("      若此后您所充值的金额未能及时到账，请手持本凭条到收费窗口人工核对充值信息。");
		printer.WriteTextLineX("      卡            号:"+window.parent.cardNo);
		printer.WriteTextLineX("      合计流水号："+$.session.get("jylsh0"));
		printer.WriteTextLineX("      商    户    号："+RespMId);
		printer.WriteTextLineX("      收    单    行："+bankName);
		printer.WriteTextLineX("      中心流水号："+RespRef);
		printer.WriteTextLineX("      自 助 编  号:"+window.parent.zdbh00);
		printer.WriteTextLineX("      充值时间："+RespTransTime);
		printer.WriteTextLineX("      造成您的不便深感抱歉！");
		printer.LFX(2);
		printer.CeTCutX(); //切纸
	}
	//获取开户行
	var getBankName = function(){
		 $.getJSON("bankbin.json", function (data){
			 var bankNo = bankCardNo.substring(0,6);
			 $.each(data,function (index,temp){
				 if(temp && temp.bin == bankNo){
					 bankName = temp.bankName;
					 return;
				 }
			 });
		 });
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		$("#waiting").hide();
		PinProcess();
		getBankName();
	}
	init();

</script>
</html>