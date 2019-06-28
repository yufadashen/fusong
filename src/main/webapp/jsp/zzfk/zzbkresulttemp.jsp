<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>办理就诊卡结果处理</title>
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
	background: url("../../images/bgn.jpg") no-repeat;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no">
	<div id="waiting" style="margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
	var logger = window.parent.Logger;
	function initialize	(){
		var status = $.session.get("zzbkStatus");
		if(status == "2"){//支付成功
			signConfirm();
		}else if(status == "3"){
			cancelzzbk();//取消
		}
	}

	//建档确认
	function signConfirm(){
		var dblsh0 = "";
		if($.session.get("dblsh0")){
			dblsh0 = $.session.get("dblsh0");
		}
		var datas={
				"funcid":"M07.02.02.04",
				"jylsh0":$.session.get("zzbkjylsh0"),
				"jdlsh0":$.session.get("zzbkjdlsh0"),
				"cxdm00":$.session.get("zzbkCardNo"),
				"cxfs00":"1",
				"dblsh0":dblsh0,
				"xtgzh0":$.session.get("xtgzh0")
		};
logger.WriteLog("funcid:M07.02.02.04 交易流水号："+$.session.get("jylsh0")+"建档流水号"+$.session.get("zzbkjdlsh0")+"建档的卡号："+$.session.get("zzbkCardNo")+"系统跟踪号："+$.session.get("xtgzh0"));
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			success : function(json) {
				var Data = eval(json);
				logger.WriteLog("建档确认结果："+Data.retcode+  "卡号：" +$.session.get("zzbkCardNo"));
				if (Data.retcode == "0") {
					
					var brid00 = Data.retbody[0].brid00;
					var xtgzh0 = Data.retbody[0].xtgzh0;
					var jdsj00 = Data.retbody[0].jdsj00;
					var gbfei0 = Data.retbody[0].gbfei0;
					printCard();//打印
					
				}else{
					$("#waiting").hide();
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
	var tkzt00;
	function printCard(){
		logger.WriteLog($.session.get("zzbkName")+"的证卡打印开始，开始打印...");
		var cardPrint = window.parent.cardPrint;
		cardPrint.InitPrinter();
		cardPrint.StartPrinting();
		cardPrint.PrintText(100, 200, 50, 3, "持卡人姓名");
		cardPrint.PrintText(100, 270, 50, 3, "CARDHOLDER");
		cardPrint.PrintText(190, 340, 50, 3, "NAME");
		cardPrint.PrintText(370, 260, 70, 3, $.session.get("zzbkName"));
		tkzt00 = cardPrint.EndPrinting();
		logger.WriteLog("证卡打印结束...");
		setTimeout("tksuccess()",4000);
		//window.location.href = "zzbksuccess.jsp";
	}
	function tksuccess(){
		logger.WriteLog(tkzt00);
		if(tkzt00=="0"){
			logger.WriteLog(tkzt00);
			window.location.href = "zzbksuccess.jsp";
		}
		
	}
	
	function cancelzzbk(){//支付失败，或未支付就就调用取消建档
		var datas={
				"funcid":"M07.02.02.05",
				"cxdm00":$.session.get("zzbkCardNo"),
				"xming0":$.session.get("zzbkName"),
				"sfzhao":$.session.get("zzbkIdCard"),
				"tkzt00":tkzt00=="0"?"2":"1",
				"jdlsh0":$.session.get("jdlsh0"),
				"jyzt00":""
		};
		logger.WriteLog("取消建档 ：funcid:M07.02.02.05 办卡人姓名："+$.session.get("zzbkName")+"取消建档流水号："+$.session.get("jdlsh0"));
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			success : function(json) {
				var Data = eval(json);
				if (Data.retcode == "0") {
					window.location.href = "zzbkfail.jsp";
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
	var init = function(){
		initialize();
	}
	init();
</script>
</html>