<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>补全个人信息</title>
	<object id="AVFOCX" classid="clsid:28DF5A67-DFD2-4309-97E9-0601C4C54411" width="0" height="0">
		<param name="s1" value="" />
	</object>
	<object width="0" height="0" id="AVFOCXLOG"
			classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
	<script language="javascript" src="DriverJS/json2.js"></script>
	<!-- <script language="javascript" src="DriverJS/ReceiptPrinter.js"></script> -->
	<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染-->
	<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
		body {
			width: 100%;
			height: 100%;
			overflow: hidden;
			background: url(${pageContext.request.contextPath}/images/ssfz.gif) no-repeat;
		}
	</style>
</head>

<body scroll=no>
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="tip_div"
	 style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:425px;">
	<div id="tip_divInfo"
		 style="text-align:center;position:relative;top:82px">
		<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
	</div>
	<img id="tip_s"
		 src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
		 height="43" style="position:relative;top:150px;left:300px" />
</div>
<%--<div id="title"
        style="text-align:center;position:absolute;top:212px;left:470px;">
        <span id="error" style="font-size:40px;color:#EE7700;"><strong>请补全个人信息</strong></span>
</div>--%>
<%--	<div id="main" style="position: absolute;top:870px;left:395px;">
			<img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/" height="" width=""/>
	</div>
	<div id="next" style="position: absolute;top:860px;left:545px;">
			<img src="${pageContext.request.contextPath}/images/pre.png" res_img="${pageContext.request.contextPath}/" height="" width=""/>
	</div>--%>
<div id="main" style="position: absolute;top:860px;left:450px;z-index:101">
	<img src="${pageContext.request.contextPath}/images/main.png"
		 res_img="${pageContext.request.contextPath}/images/main1.png"
		 height="" width=""/>
</div>
<div id="pre" style="position: absolute;top:850px;left:650px;z-index:101">
	<img src="${pageContext.request.contextPath}/images/pre.png"
		 res_img="${pageContext.request.contextPath}/images/pre1.png"
		 height="" width=""/>
</div>
<%--<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
	<img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
		 style="position: absolute;top:320px;left:490px;"/>
	<br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>--%>
</body>
<script language="javascript">
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
						window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
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
	$("#tip_s").on("click", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	var IdCard=window.parent.IdCard;
	var status=IdCard.OpenDeviceAndReadCard(9,500);

	function readCard(){
		status=IdCard.OpenDeviceAndReadCard(9,500);
		
		if(status=="0"){
			//身份证号
			var sfzh=IdCard.GetCardInfo(5);
			window.parent.sfzhao=sfzh;
			if (sfzh.length!="18") {
				$("#tip_div").show();
				$("#error").text("身份证号不正确");
			}
			//出生日期
			var csrq=IdCard.GetCardInfo(3);
			//姓名
			var xming = IdCard.GetCardInfo(0);
			if (window.parent.xming0 != xming) {
				$("#tip_div").show();
				$("#error").text("原就诊卡姓名"+ window.parent.xming0  +",请绑定本人的身份证");
			}else{
				window.parent.csrq00=csrq;
				window.parent.xming0=xming;
				window.location.href="${pageContext.request.contextPath}/jsp/main/infoFull.jsp";
			}
				// window.parent.csrq00=csrq;
				// window.parent.xming0=xming;
				//window.location.href="${pageContext.request.contextPath}/jsp/main/infoFull.jsp";
		}else{
			setTimeout("readCard();", 1000);
		}

	}


	$("#tip_s").on("click", function () {
		$("#tip_div").hide();
	});
	function bqxx(){

		window.parent.sfzhao="131022199401224216";
		window.parent.lxdh00="18610080774";
		var datas = {
			"funcid":"M07.02.01.04",
			"cxfs00":window.parent.cardtype,
			"cxdm00":window.parent.cardNo,
			"brid00":window.parent.brid00,
			"sfzhao":window.parent.sfzhao,
			"xming0":window.parent.xming0,
			"xbie00":window.parent.xbie00,
			"csrq00":window.parent.csrq00,
			"lxdh00":window.parent.lxdh00};
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
				if(Data.retcode == "0"){
					$("#tip_div").show();
					$("#error").text("更新信息成功");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
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

	$("#main").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/readcard.jsp";
	});
	//bqxx();
	readCard();
</script>
</html>
