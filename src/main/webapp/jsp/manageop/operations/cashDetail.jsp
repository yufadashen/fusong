<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>现金详情</title>
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
	background: url(../../../images/yue/sqmx_select.jpg) no-repeat;
}

div {
	position: absolute;
	text-align: center;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="bcsqmx" style="width:303px;height:143px;margin:298px 0px 0px 137px;"></div>
	<div id="scsqmx" style="width:303px;height:143px;margin:298px 0px 0px 588px;"></div>
	<div id="mainPage" style="width: 149px;height: 50px;margin:688px 0px 0px 690px;"></div>
	<div id="backPage" style="width: 149px;height: 50px;margin:688px 0px 0px 859px;"></div>
	
	<div id="tip_div"  style="margin:229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:175px;left:-6px" />
   </div> 
</body>
<script type="text/javascript">
	function czmx(){
		$.ajax({
			async : true,
			type : "post",
			data : {"funcid":"M07.02.03.02","sfcdbz":"0","sfykt0":"0","sfdyyh":"0","zdbh00":window.parent.zdbh00},//本次充值明细
			//data : {"funcid":"M07.02.03.02","sfcdbz":"0","sfykt0":"0","sfdyyh":"0","zdbh00":"371300600153"},
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			//url : window.parent.serverUrl + "?method=ApplyAction",
			url : "http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
			success : function(json) {
				var Data = eval(json);
				if (Data.retcode == "0") {
					print(Data);
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
	function czmx1(){
		$.ajax({
			async : true,
			type : "post",
			data : {"funcid":"M07.02.03.02","sfcdbz":"1","sfykt0":"0","sfdyyh":"0","zdbh00":window.parent.zdbh00},//上次充值明细
			//data : {"funcid":"M07.02.03.02","sfcdbz":"0","sfykt0":"0","sfdyyh":"0","zdbh00":"371300600153"},
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			//url : window.parent.serverUrl + "?method=ApplyAction",
			url : "http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
			success : function(json) {
				var Data = eval(json);
				if (Data.retcode == "0") {
					print(Data);
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
	function print(Data){//打印明细
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("            临沂人民医院收钱明细");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      终端编号:"+window.parent.zdbh00);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      上次收钱时间:"+Data.retbody[0].scsqsj);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      本次收钱时间："+Data.retbody[0].bcsqsj);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      成功交易笔数：" + Data.retbody[0].cgjybs);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      成功交易金额：" + Data.retbody[0].cgjyje);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      汇总待冲正笔数：" + Data.retbody[0].hzsbbs);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      汇总待冲正金额：" + Data.retbody[0].hzsbje);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      单笔待冲正笔数:" + Data.retbody[0].dbsbbs);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      单笔待冲正金额:" + Data.retbody[0].dbsbje);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      单笔有争议笔数："+Data.retbody[0].dbzybs);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      单笔有争议金额："+Data.retbody[0].dbzyje);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      两次收钱日期收钱情况如下：");
		printer.WriteTextLineX("          ");
		var reslength = Data.retbody[0].res.length;
		var rqcs=0;
		var dayintiaoshu=reslength;
		while(reslength!="0"){
			if(rqcs<dayintiaoshu){
				printer.WriteTextLineX("      日期："+Data.retbody[0].res[rqcs].rq0000+" 笔数："+Data.retbody[0].res[rqcs].cgzbs0+" 金额："+Data.retbody[0].res[rqcs].cgzje0);
				printer.WriteTextLineX("          ");
				rqcs = rqcs+1;
			}
			reslength=reslength-1;
		}
		
		
		printer.LFX(2);
		printer.CeTCutX(); //切纸
		
	}
	
	function initialize() {
		returnTime();//倒计时
		
		$("#bcsqmx").bind("click dbclick", function() {//本次充值明细
			czmx();
		});
		$("#scsqmx").bind("click dbclick", function() {//上次充值明细
			czmx1();
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			window.location.href = "../managePage.jsp";
		});
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
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
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
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
				if(time==0){
					$.session.clear();
					//跳转页面
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}

	init();
</script>
</html>