<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>管理操作界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
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
	margin: 0px;
	background: url(../../images/yue/toolpage.jpg) no-repeat;
}

div {
	position: absolute;
	text-align: center;
	/*border:1px red solid;*/
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div class="operations" id="rmPrinterTest" style="width: 236px;height: 112px;margin:88px 0px 0px 29px;"> </div><!-- 热敏打印机测试 -->
	<div class="operations" id="ycTest" style="width: 236px;height: 112px;margin:88px 0px 0px 274px;"> </div>	  <!-- 验钞测试 -->
	<div class="operations" id="cashDetail" style="width: 236px;height: 112px;margin:88px 0px 0px 519px;"> </div><!-- 收钱明细 -->
	<div class="operations" id="suspend" style="width: 236px;height: 112px;margin:88px 0px 0px 764px;"> </div><!-- 暂停使用 -->
	
	<div class="operations" id="czManage" style="width: 236px;height: 112px;margin:211px 0px 0px 29px;"> </div><!--充值管理 -->
	<div class="operations" id="restartCom" style="width: 236px;height: 112px;margin:211px 0px 0px 274px;"> </div><!-- 重启电脑 -->
	<div class="operations" id="refundCard" style="width: 236px;height: 112px;margin:211px 0px 0px 519px;"> </div><!-- 退卡 -->
	<div class="operations" id="closeCom" style="width: 236px;height: 112px;margin:211px 0px 0px 764px;"> </div><!-- 关闭电脑 -->
	
	<div class="operations" id="netTest" style="width: 236px;height: 112px;margin:335px 0px 0px 29px;"> </div><!-- 网络测试 -->
	<div class="operations" id="cardNumOp" style="width: 236px;height: 112px;margin:335px 0px 0px 274px;"> </div><!-- 卡数量重置 -->
	<div class="operations" id="blbNumOp" style="width: 236px;height: 112px;margin:335px 0px 0px 519px;"> </div><!-- 病历本数量重置 -->
	<div class="operations" id="jzkRefund" style="width: 236px;height: 112px;margin:335px 0px 0px 764px;"> </div><!--就诊卡退卡 -->
	
	<div class="operations" id="exit" style="width: 236px;height: 112px;margin:462px 0px 0px 29px;"> </div><!-- 退出程序 -->
	
	
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:688px 0px 0px 690px;"> </div>
	<div id="backPage" style="width: 149px;height: 50px;margin:688px 0px 0px 860px;"> </div>
	
	<div id="tip_div"
		style="margin:229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div id="waiting"
		style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
//var regtest = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/; 
	 var Logger = window.parent.Logger;
	 var reader = window.parent.Reader;
	function goNext(pageFlag) {
		if(pageFlag == 1){
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		}else if(pageFlag == "exit"){//退出程序
			var shell = new ActiveXObject("WScript.Shell");
			shell.SendKeys("{F4}");
		}else if(pageFlag == "closeCom"){//关闭电脑
			shut_down();
			//var Application=new ActiveXObject('Shell.Application.1');
			//Application.ShutdownWindows();
		}else if(pageFlag == "restartCom"){//重启电脑
			re_boot();
		}else if(pageFlag == "refundCard"){//退卡
			refundCard();
		}else if(pageFlag == "ycTest"){
			ycTest();//验钞测试
		}else if(pageFlag=="rmPrinterTest"){
			rmPrinterTest();//热敏打印测试
		}else if(pageFlag=="czManage"){
			czManage();//充值管理界面
		}else{
			window.location.href = "operations/"+pageFlag+".jsp";
		}
		
	}
	//js控制系统关机重启
	function  run(str){
		try{
			var objShell = new ActiveXObject("wscript.shell");
			objShell.Run(str);
			objShell=null;
		}catch(e){
			alert("获取脚本ActiveXObject对象失败！");
		}
	}
	//设备关机 
	function shut_down(){
		run("shutdown -s -t 0");
	}
	//设备重启
	function re_boot(){
		run("shutdown -r -t 0")
	}
	//退卡
	function refundCard(){
		
		var ret = reader.CloseCardReader();
		if(ret == 0){
			var ret2 = reader.OpenCardReader(2,4);
			if(ret2 == 0){
				reader.MoveCardX(2);
			}
		}else{
			alert("设备异常！");
		}
	}
	//验钞测试
	function ycTest(){
		var CashBV = window.parent.CashBV;
		var ret1 = CashBV.INIT(3,9600,100);
		if(ret1!=0){
			//alert("初始化钞箱失败！现金充值不可用，请联系管理员！");
			Logger.WriteLog("初始化钞箱失败！现金充值不可用，请联系管理员！return:"+ret1);
			return;
		}else{
			alert("钱箱初始化成功！");
		}
	}
	//热敏打印测试
	function rmPrinterTest(){
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("            临沂人民医院自助机热敏打印机测试");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("         	");
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("            我想那缥缈的空中");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("            ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("     	    定然有美丽的街市");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("            ");
		printer.SetTextModeX(1);		
		printer.WriteTextLineX("     		街市上陈列的一些物品 ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("            定然是世上没有的珍奇" );
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("            你看，那浅浅的天河" );
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("            定然是不甚宽广");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      	    那隔着河的牛郎织女");
		printer.SetTextModeX(0); //设置中文模式
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      	    定能够骑着牛儿来往。选自郭沫若《天上的街市》");
		
		printer.WriteTextLineX("       注意事项：");
		printer.WriteTextLineX("            (1)本打印测试页只做测试使用。");
		printer.LFX(2);
		printer.CeTCutX(); //切纸
	}
	//充值管理
	function czManage(){
       window.location.href("operations/czManage.jsp");
	}
	function initialize() {
		$(".operations").on("click dbclick", function() {
			//alert($(this)[0].id);
			goNext($(this)[0].id);
		});
		$("#mainPage").bind("click dbclick", function() { //返回主页
			goNext(1);
		});
		$("#backPage").bind("click dbclick", function() { //返回上一级
			goNext(1);
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
	}
	
	/**
	*初始化操作
	**/
	var init = function() {
		initialize();
	}

	init();
	function CloseWin(){
		var ua=navigator.userAgent
		var ie=navigator.appName=="Microsoft Internet Explorer"?true:false
		if(ie){
			var IEversion=parseFloat(ua.substring(ua.indexOf("MSIE ")+5,ua.indexOf(";",ua.indexOf("MSIE "))))
			if(IEversion < 5.5){
				var str = ' <object id=noTipClose classid="clsid:ADB880A6-D8FF-11CF-9377-00AA003B7A11">'
				str += '<param name="Command" value="Close"> </object>';
				document.body.insertAdjacentHTML("beforeEnd", str);
				document.all.noTipClose.Click();
			}else{
				window.opener =null;
				window.close();
			}
		}else{
			window.close();
		}
	}
</script>
</html>