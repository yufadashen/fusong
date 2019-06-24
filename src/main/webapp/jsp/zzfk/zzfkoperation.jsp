<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>				
<title>自助发卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
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
	width: 1280px;
	height: 1024px;
	overflow: hidden;
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
	/*background: url(${pageContext.request.contextPath}/images/ssfz.gif) no-repeat;*/
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no" onselectstart="return false;">
	<div></div>
<!-- 显示返回主页面倒计时时间 -->
	<div id="time"
		style="position:absolute;top:30px;left:1161px;font-size:60px;color: #FF0000;">
	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:465px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div>
   <div id="word" style="width:500px;z-index:60;position:absolute;top:300px;left:385px;">
		<span  style="width:100%;font-size:60px;text-align:center;color:red">请确认个人信息</span>
	</div>
	<div style="z-index:60;position:absolute;top:160px;left:480px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/zzfk.png" />
	</div>
	<div id="yyInfo"
		style="z-index:50;position:absolute;top:445px;left:43px;text-align:center;display:block">
		<table style="table-layout:fixed;width:500px;border:1px solid #000;background-color:#B4EEB4;font-size:30px;cellspacing:2px" id="info2">
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:200px;border:1px solid #000;">姓名</td>
				<td id="xingm0" style="width:550px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:200px;border:1px solid #000;">身份证</td>
				<td id="idCard" style="width:650px;border:1px solid #000;"></td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td style="width:300px;border:1px solid #000;">手机号</td>
				<td style="width:650px;border:1px solid #000;">
					<input style="background-color:transparent;border:none;" readonly="readonly" type="text" id="telNumber" value="请输入手机号码">
				</td>
			</tr>
			<tr style="height:50px;border:1px solid #000;">
				<td colspan="2" style="width:300px;border:1px solid #000;">
					<img src="${pageContext.request.contextPath}/images/queding.png" width="120" height="55" onclick="confirm()" />
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 返回主頁面 -->
	<div id="main" style="position: absolute;top:830px;left:450px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/images/main1.png"
			height="" width="" />
	</div>
	<!-- 返回上一步 -->
	<div id="pre" style="position: absolute;top:818px;left:650px;">
		<img src="${pageContext.request.contextPath}/images/pre.png"
			res_img="${pageContext.request.contextPath}/images/pre1.png"
			height="" width="" />
	</div>
	
	<div id="money"
	 style="top:450px;left:830px;z-index:100;">
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
	//var log = window.parent.Logger;	
	var cardPrinter = window.parent.cardPrinter;	
	
	function process(){
		$("#yyInfo").show();
		$("#xingm0").text(window.parent.xming0);
		$("#idCard").text(window.parent.sfzhao);
	}
	
	//确认信息
    var reg = /^1[3|4|5|6|7|8|9][0-9]{9}$/; //验证规则
	function confirm(){
		if(reg.test($("#telNumber").val())){
			window.parent.lxdh00=$("#telNumber").val();
			//发卡建档初始化M07.02.02.03
			//发卡确认建档：M07.02.02.04 如果jdzt00=9,则his建档成功，允许充值
			signInit();
			
		}else{
			$("#tip_s").off().on("click", function () {
	            $("#tip_div").hide();
	        });
			message("手机号码输入有误！请重新输入！");
			$("#telNumber").val("请重新输入手机号码！");
		}
	}
	
	var jdlsh0;//建档流水号
	var jylsh0;//交易流水号
	var dblsh0;//单笔流水号
	var cxdm00;//就诊卡卡号
	var brid00;//病人id
	//发卡建档初始化M07.02.02.03
	function signInit(){
		var datas = {
		 	"funcid": "M07.02.02.03",
            "cxdm00": window.parent.cardNo,//就诊卡卡号，必填
            "cxfs00": "1",//卡类型 
            "brid00": "",//病人ID
            "sfzhao": window.parent.sfzhao,//身份证号 ，必填姓名 
            "xming0": window.parent.xming0,//姓名 
            "xbie00": window.parent.xbie00=="男"?"1":"2",//  性别 
            "xbiemc": window.parent.xbie00,//  性别名称 
            "lxdz00": "",// 联系地址 
            "csrq00": window.parent.csrq00,//出生日期 
            "lxdh00": window.parent.lxdh00,//联系电话 
            "czje00": "0",// 充值金额 
            "pin000": ""// 账户密码
		}
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            success: function (json) {
            	var Data = eval(json);
				if (Data.retcode == "0") {
					jdlsh0 = Data.retbody[0].jdlsh0;//建档流水号
					jylsh0 = Data.retbody[0].jylsh0;//交易流水号
					dblsh0 = Data.retbody[0].dblsh0;//单笔流水号
					cxdm00 = Data.retbody[0].cxdm00;//就诊卡卡号
					$.session.set("jdlsh0",jdlsh0);
					$.session.set("jylsh0",jylsh0);
					window.location.href = "zzfkpayway.jsp";//跳转充值
				} else {
					message(Data.retmsg);
				}
            },
            error: function () {
                message("系统异常，请稍后再试！");
            }
        });	
	}

	//提示信息
	function message (msg){
		 $("#tip_div").show();
         $("#error").text(msg);
	}
	function event(){//事件
		$("#tip_s").on("click", function () {
            $("#tip_div").hide();
            $.session.clear();
            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
        });
		$("#pre").bind("click dbclick", function() {
			window.history.back();
		});
		$("#main").bind("click dbclick", function() {
			$.session.clear();
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		//输入手机号
		$('img[name="numKey"]').on("click", function() {
			var tem = $("#telNumber").val();
			if(tem.indexOf("请") != -1){
				$("#telNumber").val("");
			}
			var valStr = $("#telNumber").val();
			if (valStr == "" || valStr == "0") {
				$("#telNumber").val($(this).attr("value"));
			} else {
				if ($("#telNumber").val().length == 11) {
					//todo 阻止界面号码按钮事件
				}else{
					$("#telNumber").val(valStr + $(this).attr("value"));
				}
			}
		});
		//修改
		$("#modify").on("click", function() {
			var num = $("#telNumber").val();
			var newstr = num.substring(0, num.length - 1);
			$("#telNumber").val(newstr);
		});

		//虚拟键盘确认
		$("#sure").bind("click dbclick", function() {
			var phoneno = $("#telNumber").val();
			if(phoneno.length==11){
				//setPhone();
				confirm();
			}else{
				$("#telNumber").val("");
				$("#tip_div").show();
				$("#error").text("手机号格式不正确");
			}

		});
	}
	//初始化
	function init(){
		event();//事件
		returnTime();//倒计时
		process();
	}
	
	var time = 60;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 60;
	}
	init();
</script>
</html>