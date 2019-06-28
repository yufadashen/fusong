<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>自助办卡支付方式</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
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
	background: url("../../images/yue/zzfk_zffs_select.jpg") no-repeat;
}
div{
	position:absolute;
	/*border:1px red solid;*/
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
	<div id="cashWay"  style="width:303px;height:143px;margin:336px 0px 0px 40px;"></div>
	<div id="alipay" style="width:303px;height:143px;margin:336px 0px 0px 359px;"></div>
	<div id="weChat" style="width:303px;height:143px;margin:336px 0px 0px 679px;"></div>
	
	<div id="btnMain" style="width:149px;height:51px;margin:708px 0px 0px 682px;"></div>
	<div id="btnReturn" style="width:149px;height:51px;margin:708px 0px 0px 851px;"></div>
	<div id="tip_div"  style="margin: 229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
       <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
         <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
       </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
   <div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
var logger = window.parent.Logger;
var czje00 = "1";
//建档初始化
var jylsh0;
var jdlsh0;
var szsjFlag=false;
	//判断充值时间，判断本机当前是否可充值	 	
	function checkCzTime (czlb00){
		 	var datas = {"funcid":"M07.02.03.01",								 
				      "optype":"0",
				      "czlb00":czlb00};//充值类别（1现金充值、2银行卡充值、3支付宝、4微信）
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				
				success:function(json){
					var Data = eval(json);
					
					//如果设备状态正常
					if(Data.retcode=="0"){
						//logger.WriteLog("设备状态正常");
						//如果出参为1，代表可充值
				    	 //logger.WriteLog("自助办卡：充值时间判断=="+Data.retbody[0].sfkcz0);
						 
					     if(Data.retbody[0].sfkcz0=="1"){
					    	szsjFlag = true;
						 }else{
							//log.WriteLog("设备状态正常，但不可充值");
							$("#tip_div").show();
							$("#error").text("该时间段不可充值！");
						 }
					}else{
						//log.WriteLog("设备状态异常");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);							
					}
					$("#waiting").hide();
				
				},
				error:function(){
					$("#waiting").hide();
					//log.WriteLog("获取本机是否可充值信息失败");
					$("#tip_div").show();
					$("#error").text("系统异常,请稍后再试!");		
				}
			});		
	}

	function signInit(zflxbh){
		var temp = $.session.get("zzbkSex")=="男"?"0":"1";
		logger.WriteLog("性别" + $.session.get("zzbkSex") + "   temp="+temp);
		var datas={
				"funcid":"M07.02.02.03",
				
				"cxdm00":$.session.get("zzbkCardNo"),
				"csrq00":$.session.get("zzbkBirth"),
				"cxfs00":"1",
				"czje00":czje00,
				"xming0":$.session.get("zzbkName"),
				"xbie00":temp,
				"xbiemc":$.session.get("zzbkSex"),
				"lxdz00":$.session.get("zzbkAddr"),
				"zflxbh":zflxbh,
				"sfzhao":$.session.get("zzbkIdCard"),
				"lxdh00":$.session.get("zzbkPhone")
		};
		
		//logger.WriteLog("建档初始化！==" + $.session.get("zzbkName") + $.session.get("zzbkCardNo"));
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			
			success : function(json) {
			
				var Data = eval(json);
				if (Data.retcode == "0") {
					jylsh0 = Data.retbody[0].jylsh0;//交易流水号
					jdlsh0 = Data.retbody[0].jdlsh0;//建档流水号
					$.session.set("zzbkjylsh0", jylsh0);
					$.session.set("zzbkjdlsh0", jdlsh0);
				}else{
					$("#tip_div").show();
					$("#error").text(Data.retmsg);
				}
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
			}
		}); 
	}
	function initialize	(){
		$("#cashWay").bind("click dbclick", function() {//现金支付
		/*
			$("#waiting").hide();
			$("#tip_div").show();
			$("#error").text("暂时不支持!");
		*/
		
			$("#waiting").show();
			checkCzTime("1");
			if(szsjFlag){//可以充值
				//logger.WriteLog("自助办卡现金支付！");
				$.session.set("zzbkStatus","1");//支付状态标识   1.待支付  2.支付成功  3.支付失败
				window.location.href = "pay/zzbkcashpay.jsp";
			}else{
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("当前时间不可充值！");
			}
			
		});
		$("#alipay").bind("click dbclick", function() {//支付宝
			$("#waiting").show();
			checkCzTime("3");
			if(szsjFlag){//可以充值
				//logger.WriteLog("支付宝支付！");
				signInit("4");
				$.session.set("zzbkStatus","1");//支付状态标识   1.待支付  2.支付成功  3.支付失败
				//$.session.set("zzbkPayWay","4");//支付类型
				window.location.href = "pay/zzbkzfbpay.jsp";
			}else{
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("当前时间不可充值！");
			}
		});
		$("#weChat").bind("click dbclick", function() {//微信
			$("#waiting").show();
			checkCzTime("4");//充值类别（1现金充值、2银行卡充值、3支付宝、4微信）
			if(szsjFlag){//可以充值
				//logger.WriteLog("微信支付！");
				signInit("3");//支付类型编号，0不充值支付、1现金充值支付、2银行卡充值支付，3微信，4支付宝
				$.session.set("zzbkStatus","1");//支付状态标识   1.待支付  2.支付成功  3.支付失败
				//$.session.set("zzbkPayWay","3");//支付类型
				window.location.href = "pay/zzbkwxpay.jsp";
			}else{
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("当前时间不可充值！");
			}
		});
		
		
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#btnMain").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	
	//初始化倒计时时间：120秒
	var time = 30;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 30;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		setInterval(
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
	}
	init();
</script>
</html>