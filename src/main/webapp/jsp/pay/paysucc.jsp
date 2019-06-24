
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>	
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<title>充值成功</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/CardPayment.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style>
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>
<body scroll="no" id="info">
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="title"
		style="z-index:60;display:block;position:absolute;top:1095px;left:380px;">
		<img id="tip1"
			src="${pageContext.request.contextPath}/images/paysucctitle.png" />
	</div>
	 <div id="word" style="width:100%;z-index:60;position:absolute;top:1180px;left:365px">
		<span  style="width:100%;font-size:30px;text-align:center;color:red">充值成功,请在下方取走凭条</span>
	</div>
	<div id=""
		style="width:1060px;display:block;position:absolute;top:1250px;left:220px;">
		<table>			
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">用户姓名:</td>
				<td id="xming0" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">用户卡号:</td>
				<td id="cardNo" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">充值金额:</td>
				<td id="value" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">卡内余额:</td>
				<td id="yjjye0" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;border:1px solid black">
				<td colspan="2" style="width:320px;border:1px solid black;font-size:35px;text-align:center"><button  id="close" class="layui-btn layui-btn-sm layui-btn-normal" style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">关闭</button></td>
			</tr>
		</table>
	</div>
	<div id="main" style="position:absolute;top:1745px;left:466px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/" height="" width="" />
	</div>
</body>
<script type="text/javascript">
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
	 	
	 	//定义
	 	var log = document.getElementById("AVFOCX");
		var value=window.parent.money;//充值金额
		var jylsh=""; //交易流水号
	 	var cardNo =window.parent.cardNo;//卡号
		var xming0 = window.parent.xming0;//患者名称
		var xbie00 = window.parent.xbie00;//患者性别
		var csrq00 = window.parent.csrq00;//出生日期
		var brnl00 = window.parent.brnl00;//病人年龄
		var brid00 = window.parent.brid00;//病人ID
		var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用） 	
	 	
	 	$("#main").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#close").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	 	$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
	 		
	 	function getNewInfo(){
	 		var datas = {"funcid":"M07.02.01.02",								 
				      "cxfs00":window.parent.cardtype,
				      "cxdm00":cardNo,
					  "sfybye":"5"};
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
						if(Data.retcode=="0"){
							yjjye0 = Data.retbody[0].yjjye0;
							window.parent.yjjye0=yjjye0;
							setInfo();
							//log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");
						}else{
							//log.WriteLog("卡号为:"+cardNo+"获取病人信息失败");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);							
						}
				},
				error:function(){
					$("#tip_div").show();
					$("#error").text("系统异常，请稍后再试！");					
				}
			});	
	 	}
	 	
	 	function setInfo(){
	 		$("#xming0").text(xming0);
	 		$("#cardNo").text(window.parent.brid00);
	 		$("#value").text(value);
	 		$("#yjjye0").text(yjjye0);
	 		print();
	 	}
	 	
	 	
	//打印
	function print() {
		var printer = window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x20, 0x01); //设置字体
		printer.SetTextModeX(2); //设置中文模式
		printer.WriteTextLineX("吉林大学白求恩第一医院");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("充值");
		printer.WriteTextLineX("");
		printer.LFX(2); //多行送纸
		printer.SetFontModeAndTypeX(0x20, 0x00); //设置字体
		printer.WriteTextLineX("  姓    名："+xming0);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  就诊卡号："+window.parent.brid00);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  充值金额："+value +"元");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  卡内余额："+yjjye0 +"元");
		printer.WriteTextLineX("");
		printer.LFX(2); //多行送纸
		printer.SetTextModeX(1); //设置中文模式
		printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  退款凭本收据或本人身份证。");
		printer.LFX(3); //多行送纸
		printer.CeTCutX(); //切纸
	}
	 getNewInfo();	
	 </script>
</html>


