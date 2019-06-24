
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
	<object width="0" height="0" name="plugin"
			classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
	<object width="0" height="0" id="AVFOCX"
			classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
	<title>门诊预约</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
	<script src="${pageContext.request.contextPath}/js/layui.js"></script>
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
			text-align: center;
			background: url(${pageContext.request.contextPath}/images/bj.jpg)
			no-repeat;
		}
	</style>
</head>
<body scroll="no">
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="stepByKeshi" class="ui-stepBar-wrap" style="display:none;width:90%;height:100px;position:absolute;top:270px;left:40px;background-color:#f7fcff">
	<div class="ui-stepBar">
		<div class="ui-stepProcess"></div>
	</div>
	<div class="ui-stepInfo-wrap">
		<table class="ui-stepLayout" border="0" cellpadding="0"
			   cellspacing="0">
			<tr>
				<td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
					<p class="ui-stepName">选择科室</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
					<p class="ui-stepName">选择医生</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
					<p class="ui-stepName">选择日期</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
					<p class="ui-stepName">选择时间</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">5</a>
					<p class="ui-stepName">填写电话</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">6</a>
					<p class="ui-stepName">预约</p></td>
			</tr>
		</table>
	</div>
</div>
<div id="stepByRiqi" class="ui-stepBar-wrap" style="display:none;width:90%;height:100px;position:absolute;top:200px;left:57px;background-color:#f7fcff">
	<div class="ui-stepBar">
		<div class="ui-stepProcess"></div>
	</div>
	<div class="ui-stepInfo-wrap">
		<table class="ui-stepLayout" border="0" cellpadding="0"
			   cellspacing="0">
			<tr>
				<td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
					<p class="ui-stepName">选择日期</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
					<p class="ui-stepName">选择科室</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
					<p class="ui-stepName">选择医生</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
					<p class="ui-stepName">选择时间</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">5</a>
					<p class="ui-stepName">填写电话</p></td>
				<td class="ui-stepInfo"><a class="ui-stepSequence">6</a>
					<p class="ui-stepName">预约</p></td>
			</tr>
		</table>
	</div>
</div>
<div id="tip_div"  style="z-index:1000;display:block;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:80px;top:480px;">
	<div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
		<span id="error" style="font-size:30px;color:#EE7700;"><strong>确认手机号&nbsp</strong></span>
		<input id="phone" type="text" maxlength="11" style="width:300px;height:50px;font-size:40px;text-align:center;">
	</div>
	<img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
		 width="90" height="43" style="position:relative;top:125px;left:4px" />
</div>
<div id="tip_div2"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:440px;">
	<div id="tip_divInfo2" style="text-align:center;position:relative;top:82px">
		<span id="error2" style="font-size:30px;color:#EE7700;"><strong>手机号码为11位</strong></span>
	</div>
	<img id="tip_s2" src="${pageContext.request.contextPath}/images/qdmix.png"
		 width="90" height="43" style="position:relative;top:125px;left:4px" />
</div>
<div style="z-index:60;position:absolute;top:160px;left:480px;">
	<img id="title"
		 src="${pageContext.request.contextPath}/images/yytitle.png" />
</div>
<div id="main" style="position: absolute;top:800px;left:450px;">
	<img src="${pageContext.request.contextPath}/images/main.png"
		 res_img="${pageContext.request.contextPath}/images/main1.png"
		 height="" width="" />
</div>
<div id="pre" style="position: absolute;top:790px;left:650px;">
	<img src="${pageContext.request.contextPath}/images/pre.png"
		 res_img="${pageContext.request.contextPath}/images/pre1.png"
		 height="" width="" />
</div>

<div id="money"
	 style="position: absolute;top:465px;left:830px;">
	<img src="${pageContext.request.contextPath}/images/kb/1.png"
		 res_img="images/kb/1_1.png" width="102" height="65" value="1"
		 name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/2.png"
		res_img="images/kb/2_1.png" width="102" height="65" value="2"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/3.png"
		res_img="images/kb/3_1.png" width="102" height="65" value="3"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> </br> <img
		src="${pageContext.request.contextPath}/images/kb/4.png"
		res_img="images/kb/4_1.png" width="102" height="65" value="4"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/5.png"
		res_img="images/kb/5_1.png" width="102" height="65" value="5"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/6.png"
		res_img="images/kb/6_1.png" width="102" height="65" value="6"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> </br> <img
		src="${pageContext.request.contextPath}/images/kb/7.png"
		res_img="images/kb/7_1.png" width="102" height="65" value="7"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/8.png"
		res_img="images/kb/8_1.png" width="102" height="65" value="8"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/9.png"
		res_img="images/kb/9_1.png" width="102" height="65" value="9"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> </br> <img
		src="${pageContext.request.contextPath}/images/kb/10.png"
		res_img="images/kb/10_1.png" width="102" height="65" value="10"
		id="modify" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/0.png"
		res_img="images/kb/0_1.png" width="102" height="65" value="0"
		name="numKey" style="margin-right:15px;margin-bottom:10px" /> <img
		src="${pageContext.request.contextPath}/images/kb/11.png"
		res_img="images/kb/11_1.png" width="102" height="65" value="11"
		id="sure" style="margin-right:15px;margin-bottom:10px" />
</div>
</body>
<script type="text/javascript">
	var cardNo =window.parent.cardNo;//卡号
	var cxfs00=window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
	var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
	var log = document.getElementById("AVFOCX");
	var phone=window.parent.lxdh00;//联系电话

	if (phone!= undefined && phone.length != "") {
		$("#phone").val(phone);
		$.session.set('phone', phone);
	}
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

	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = window.parent.reTime;
	}
	returnTime();

	$("#main").bind("click dbclick", function() {
		if (typeof ($.session) != "undefined") {
			$.session.clear();
		}
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#tip_s").bind("click dbclick", function() {
		setPhone();
	});
	$("#tip_s2").bind("click dbclick", function() {
		$("#tip_div2").hide();
	});

	$(document).keydown(function(event){
		if(event.keyCode==13){
			setPhone();
		}
	})
	function stepshow() {
		$("#phone").focus();
		if (pbbz00 != "1") {
			$("#stepByKeshi").show();
			$(function() {
				stepBar.init("stepByKeshi", {
					step : 5,
					change : true,
					animation : false
				});
			});
			$("#phone").val(phone);
		} else {
			$("#stepByRiqi").show();
			$(function() {
				stepBar.init("stepByRiqi", {
					step : 5,
					change : true,
					animation : false
				});
			});
			$("#phone").val(phone);
		}
	}

	function setPhone(){
		phone=$("#phone").val();
		if(phone!="" && phone.length=="11"){
			//更新患者信息，存入电话号码
			if (phone != window.parent.lxdh00) {
				$.session.set('phone', phone);
				updateInfo();
				window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/yyinfo.jsp";
			}else{
				$.session.set('phone', phone);
				window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/yyinfo.jsp";
			}
		}else{
			$("#tip_div2").show();
		}
	}

	//输入金额
	$('img[name="numKey"]').on("click", function() {
		var valStr = $("#phone").val();
		if (valStr == "" || valStr == "0") {
			$("#phone").val($(this).attr("value"));
		} else {
			if ($("#phone").val().length == 11) {
				//todo 阻止界面号码按钮事件
			}else{
				$("#phone").val(valStr + $(this).attr("value"));
			}
		}
	});
	//修改
	$("#modify").on("click", function() {
		var num = $("#phone").val();
		var newstr = num.substring(0, num.length - 1);
		$("#phone").val(newstr);
	});

	//虚拟键盘确认
	$("#sure").bind("click dbclick", function() {
		var phoneno = $("#phone").val();
		if(phoneno.length==11){
			setPhone();
		}else{
			$("#phone").val("");
			$("#tip_div").show();
			$("#error").text("手机号格式不正确");
		}

	});
	function updateInfo() {
		$("#jz").show();
		var datas = {
			"funcid": "M07.02.01.04",
			"cxfs00": window.parent.cardtype,
			"cxdm00": window.parent.cardNo,
			"brid00": window.parent.brid00,
			"sfzhao": window.parent.sfzhao,
			"xming0": window.parent.xming0,
			"xbie00": window.parent.xbie00,
			"csrq00": window.parent.csrq00,
			"lxdh00": $.session.get("phone")
		};
		$.ajax({
			async: false,
			type: "post",
			data: datas,
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			url: window.parent.serverUrl + "?method=ApplyAction",
			//url:"${pageContext.request.contextPath}/Test/test.do",
			success: function (json) {
				window.parent.lxdh00 = $.session.get("phone");
				$("#jz").hide();
			},
			error: function () {
				$("#jz").hide();
			}
		});
	}

	stepshow();
</script>
</html>