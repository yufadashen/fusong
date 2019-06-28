<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>办理就诊卡结果</title>
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
	background: url("../../images/yue/zzfk_success.jpg") no-repeat;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>

	
	<div id="userName" style="font-size:33px;margin:226px 0px 0px 421px;"></div>
	<div id="userSex"  style="font-size:33px;width:208px;height:40px;margin:294px 0px 0px 421px;"></div>
	<div id="userIdCard" style="font-size:33px;width:210px;height:40px;margin:360px 0px 0px 421px;"></div>
	<div id="userCard" style="font-size:33px;width:283px;height:40px;margin:426px 0px 0px 421px;"></div>
	<div id="userMoney" style="font-size:33px;margin:492px 0px 0px 421px;"></div>
	
	
	
	<div id="confirmBtn" style="width:238px;height:56px;margin:599px 0px 0px 397px;"></div>
	
	<div id="btnMain" style="width:149px;height:51px;margin:708px 0px 0px 682px;"></div>
	<div id="btnReturn" style="width:149px;height:51px;margin:708px 0px 0px 851px;"></div>
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
	var logger = window.parent.Logger;
	function printTicket (){
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
		var  pringtczje = "1.00元";
		if(window.parent.money==0){
            pringtczje = "1.00元";
		}else{
			pringtczje = window.parent.money+"元";
		}
		var printer=window.parent.KPrinter;
		logger.WriteLog("打印发卡凭据，开始打印...");
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      临沂人民医院自助办卡充值");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      —————————————————————");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      卡    号："+$.session.get("zzbkCardNo"));
		printer.WriteTextLineX("      姓    名："+$.session.get("zzbkName"));
		printer.WriteTextLineX("      充值金额："+window.parent.money);//默认为0  现金办卡时候回给其赋值
		printer.WriteTextLineX("      终端编号："+window.parent.zdbh00);
		printer.WriteTextLineX("      收 据 号: "+$.session.get('zzbkjdlsh0'));
		printer.WriteTextLineX("      卡工本费: 1.00元");
		printer.WriteTextLineX("      预交金余额：" + window.parent.yjjye0);
		printer.WriteTextLineX("      办卡时间："+currTime);
		printer.WriteTextLineX("                       ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("       —————————————————————");
		printer.WriteTextLineX("      注意事项：");
		printer.WriteTextLineX("      1.本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("      2.退款凭本收据或本人身份证。");
		
		printer.LFX(2);
		
		printer.CeTCutX(); //切纸
		logger.WriteLog("打印发卡凭据，打印完成...");
	}
	function initialize(){
		$("#userName").text($.session.get("zzbkName"));
		$("#userSex").text($.session.get("zzbkSex"));
		$("#userIdCard").text($.session.get("zzbkIdCard"));
		$("#userCard").text($.session.get("zzbkCardNo"));
		
		$("#btnMain").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#confirmBtn").bind("click dbclick", function() {//确认办卡
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
 	function getBridInfo(){
		 var datas = {"funcid":"M07.02.01.02",	
					  "zdbh00":"",
					  "yyjgdm":"01",
				      "cxdm00":$.session.get("zzbkCardNo"),
				      "cxfs00":"02"};
			$.ajax({
				async:true,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				//url:"${pageContext.request.contextPath}/Test/test.do",
				success:function(json){
						Data = eval(json);
						if(Data.retcode == "0"){
							window.parent.yjjye0=Data.retbody[0].yjjye0;
							$("#userMoney").text(window.parent.yjjye0);
							printTicket();
						}else{
							$("#tip_div").show();
							$("#error").text(Data.retmsg);
						}
											
				},
				error:function(){
					alert("系统异常，请稍后再试！");
				}
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
	/**
	*初始化操作
	**/
	var init = function(){
		logger.WriteLog("进入发卡成功页面，完成发卡凭据打印。");
		initialize();
		getBridInfo();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();
</script>
</html>