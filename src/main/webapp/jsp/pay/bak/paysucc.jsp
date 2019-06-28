
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
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style>
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	/* background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat; */
}
#bottomArea {
	background-color: #3f7dac;
	width: 100%;
	height: 80px;
	margin-left: -8px;
	text-align: left;
	font-size: 50px;
	color: white;
	margin-top: 700px;
	line-height: 60px;
}
</style>
</head>
<body scroll="no" id="info">
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="title"
		style="z-index:60;display:block;position:absolute;top:95px;left:380px;">
		<img id="tip1"
			src="${pageContext.request.contextPath}/images/paysucctitle.png" />
	</div>
	 <div id="word" style="width:100%;z-index:60;position:absolute;top:180px;left:365px">
		<span  style="width:100%;font-size:30px;text-align:center;color:red">充值成功,请在下方取走凭条</span>
	</div>
	<div id=""
		style="width:1060px;display:block;position:absolute;top:250px;left:220px;">
		<table>			
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">用户姓名:</td>
				<td id="xming0" name="xming0" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">用户卡号:</td>
				<td id="cardNo" name="cardNo" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">充值金额:</td>
				<td id="value" name="value" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
				<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">卡内余额:</td>
				<td id="yjjye0" name="yjjye0" style="width:320px;border:1px solid black;font-size:35px;text-align:center"></td>				
			</tr>
			<tr style="width:1050px;height:60px;border:1px solid black">
				<td colspan="2" style="width:320px;border:1px solid black;font-size:35px;text-align:center"><button  id="close" class="layui-btn layui-btn-sm layui-btn-normal" style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">关闭</button></td>
			</tr>
		</table>
	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:260px" />
	</div>
	<div id="bottomArea">
		<span style="margin-left:664px;line-height: 78px;"> <img
			id="main" style="margin-top:-8px;"
			src="${pageContext.request.contextPath}/images/index.png" res_img="" />
		</span> <span style="margin-left:10px;line-height: 78px;"> <img
			id="pre" style="margin-top:-8px;"
			src="${pageContext.request.contextPath}/images/return.png" res_img="" />
		</span>
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
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
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
	 	//var log = document.getElementById("AVFOCX");
		var value=$.session.get('money1');//充值金额
		var jylsh=""; //交易流水号
	 	var cardNo =window.parent.cardNo;//卡号
		var xming0 = window.parent.xming0;//患者名称
		var xbie00 = window.parent.xbie00;//患者性别
		var csrq00 = window.parent.csrq00;//出生日期
		var brnl00 = window.parent.brnl00;//病人年龄
		var brid00 = window.parent.brid00;//病人ID
		var yjjye0 = "";//预交金余额（结算金额使用）
		var zdbh00 = window.parent.zdbh00;//终端编号
	 	
	 	$("#main").bind("click dbclick", function() {
	 		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
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
					  "zdbh00":window.parent.zdbh00,
					  "yyjgdm":"01",
				      "cxdm00":window.parent.cardNo,
				      "cxfs00":window.parent.cardtype};
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
	 		$("#cardNo").text(window.parent.cardNo);
	 		$("#value").text(value);
	 		$("#yjjye0").text(yjjye0);
	 		print();
	 	}
	 
	 	
		
		
	//打印
	function print() {
			var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("            临沂人民医院自助"+$.session.get('czffstatus')+"充值（门诊）");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      卡号:"+window.parent.cardNo);
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      姓名："+window.parent.xming0);
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);		
		printer.WriteTextLineX("      预交余额：" + window.parent.yjjye0);
		printer.WriteTextLineX("      充值金额：" + $.session.get('money1'));
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      收 据 号:" + $.session.get('xtgzh0'));
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      自助编号:"+window.parent.zdbh00);
		printer.SetTextModeX(0);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      打印时间："+$.session.get('cgjysj'));
		printer.SetTextModeX(0); //设置中文模式
		printer.WriteTextLineX("          ");
		
		printer.WriteTextLineX("       注意事项：");
		printer.WriteTextLineX("       (1)本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("       (2)退款凭本收据或本人身份证。");
		printer.LFX(2);
		printer.CeTCutX(); //切纸
	}
	 getNewInfo();	
	 </script>
</html>


