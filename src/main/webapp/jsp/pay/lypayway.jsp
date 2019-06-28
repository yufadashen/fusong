<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML">
<html>
<head>
<title>充值方式</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- <meta http-equiv="X-UA-Compatible" content="IE=8"> -->
<!-- 以IE8模式渲染  -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<style>
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(${pageContext.request.contextPath}/images/yjjcz_select_mode.png) no-repeat; 
}
</style>
</head>
<body scroll=no>
	<div>
		<div id="time"
			style="position:absolute;top:10px;right:37px;font-size:60px;color: #FF0000;">
		</div>
		
		<div id="zfbpay" style="position:absolute;left:133px;top:255px;px; width:301px;height:142px;">
			<img src="${pageContext.request.contextPath}/images/alipay.png"/>
		</div>
		
		<div id="wxpay" style="position:absolute;left:587px;top:255px;px; width:301px;height:142px;">
			<img src="${pageContext.request.contextPath}/images/wxpay.png"/>
		</div>
		<div id="main"
			style="position: absolute;top:708px;left:683px;width:148px;height:50px;">
		</div>
		<div id="pre"
			style="position: absolute;top:708px;left:852px;width:148px;height:50px;">
		</div>
	</div>
<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;margin-top:-100px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:260px;padding-left: 214px;" />
	</div>
</body>
<script language="javascript">
	var init = function(){
		returnTimeStart(); //倒计时方法
		jump();//跳转页面方法
	}
	function returnTimeStart(){
		//初始化倒计时时间：60秒
		var time = 120;
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
			//time = window.parent.reTime;
			time = 120;
		}
		returnTime();
	}
	function jump() {
		$("#zfbpay").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/pay/alipay.jsp";
		});
		$("#wxpay").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/pay/wxpay.jsp";  
		});
		$("#main").bind("click dbclick", function() {
			if($.session.get("RegNo") && window.parent.ttype == 1){
				sfzhOp();
			}
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
			if($.session.get("RegNo") && window.parent.ttype == 1){
				sfzhOp();
			}
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	//释放占号
	function sfzhOp(){
		var datas = {
			"RegNo" : $.session.get("RegNo")
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"ReleaseRegPoint",
			success : function(json) {
				var Data = JSON.parse(json)
				if (Data.Code == "0") {
					//log("释放成功！号点："+RegNo);
				}	
			},
			error : function() {
				message("释放号点时系统异常,请稍后再试!");		
			}
		}); 
	}
	init();
</script>
</html>
