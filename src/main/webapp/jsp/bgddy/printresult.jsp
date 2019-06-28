<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>	
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<title>打印结果</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"
	charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
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
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(../../images/error.jpg) no-repeat;
}
#confirm{
	top:598px;
	left:396px;
	width: 240px;
	height: 56px;
	text-align: center;
	font-size: 35px;
}
#main{
	top:707px;
	left:683px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
#pre{
	top:707px;
	left:852px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
div{
	position:absolute;
    /*border:red 1px solid;*/
}
#reslutmsg{
	font-size:35px;
	color:red;
}
</style>
</head>
<body>
<div id="reslutmsg" style="top:400px;left:250px;width:659px;height:243px;">
</div>
<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		
	</div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;">
		
	</div>
<span
	id="time"
			style="position:absolute;top:20px;right:75px;font-size:60px;color: red;">
		</span>
<div id="tip_div"  style="margin: 385px 319px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:176px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:554px" />
  </div> 
<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
	 <img src="${pageContext.request.contextPath}/images/waiting.gif" >
</div>

</body>
<script type="text/javascript">
			var	jcdh00;//检查单号
			var cxdm00;//查询代码
			var	bglx00;//报告类型
			var	bgxh00;//报告序号
			var	ftpurl;//报告下载地址
			var	bgrq00;//报告日期
			var	bgzt00;//报告状态
			var	pdfstr;//base64流
			var	pdfurl;//pdfurl
			var	pdfname;//pdf名称
			var printType02 =  $.session.get("printType02");//选择的打印方式
			var statusret = $.session.get("statusret");//打印机状态
function init(){
		$("#waiting").css("display","block");
		dayinpanduan();//修改打印单类型判断
		
		event();
	}
	function event(){
		$("#mainPage").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
function dayinpanduan(){	
	if(statusret == 0){
	//打印类型获取成功
		if(printType02){
				if(printType02 == "blbgdysrblh"){//输入病例号打印方式，1
					blbgPrintPDF();
				}else if(printType02 == "blbgdytmsm"){//条形码扫码打印方式，2
					blbgPrintPDF();
				}else if(printType02 == "xdtbgdysrblh"){//输入病例号打印方式，1
					xdbgPrintPDF();
				}else if(printType02 == "xdtbgdytmsm"){//条形码扫码打印方式，2
				    xdbgPrintPDF();
				}else if(printType02 == "xdtbgdysrzyh"){//输入住院号打印方式，3
					xdbgPrintPDF();
				}else if(printType02 == "xdtbgdyduka"){//读卡打印方式，4
					xdbgPrintPDF();
				}else{
					$("#tip_div").show();
					$("#error").text("打印方式错误！");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
				}else{
					$("#tip_div").show();
					$("#error").text("打印类型获取失败");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
		}else{
			$("#tip_div").show();
			$("#error").text("打印机状态不正确。");
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				$.session.clear();
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}
		
	}

	//修改病理报告打印单状态
	function blbgPrintPDF(){
		var datas = {
				"funcid" : "M07.02.18.02",
				"cxfs00" : "1",
				"cxdm00" : $.session.get("cxdm00"), //查询代码
				"jcdh00" : $.session.get("jcdh00"),	//检查单号
				"bglx00" : $.session.get("bglx00"),	//报告类型
				"bgxh00" : $.session.get("bgxh00")	//报告序号
				};
		$.ajax({
				async : false,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url : window.parent.serverUrl + "?method=ApplyAction",
				//url : "${pageContext.request.contextPath}/Test/test.do",
				success : function(json) {
					$("#waiting").css("display","none");
					Data = eval(json);
					if(Data.retcode== "0"){
							$("#reslutmsg").text("打印成功，请在下方打印机出口领取病理打印单。")
							$.session.clear();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					}else{
						$("#waiting").css("display","none");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);	
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
					
				},
				error : function() {
					$("#waiting").css("display","none");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);	
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			});		
	};
	
	//修改心电图打印状态
	function xdbgPrintPDF(){
		var datas = {
				"funcid" : "M07.02.18.04",
				"zdbh00" : window.parent.zdbh00,
				"yyjgdm" : "",
				"cxdm00" : $.session.get("cxdm00"),		//查询代码		
				"cxfs00" : "1",			//查询方式
				};
		$.ajax({
				async : false,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url : window.parent.serverUrl + "?method=ApplyAction",
				//url : "${pageContext.request.contextPath}/Test/test.do",
				success : function(json) {
					$("#waiting").css("display","none");
					Data = eval(json);
					if(Data.retcode== "0"){
						//pdfurl=Data.retbody[0].pdfurl;
						//jylsh0=Data.retbody[0].jylsh0;
						//掉打印方法
						$("#reslutmsg").text("打印成功，请在下方打印机出口领取心电报告单。")
						setTimeout("backMain()",2000);
					}else{
						$("#waiting").css("display","none");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);	
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
					
				},
				error : function() {
					$("#waiting").css("display","none");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);	
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			});		
	};
	function backMain(){
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	}
	init();
</script>
</html>
