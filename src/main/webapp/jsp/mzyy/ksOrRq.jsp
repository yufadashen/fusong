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
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
   	<div id="tip_div" style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/yytitle.png" />
	</div>
	<div id="word" style="width:100%;z-index:60;position:absolute;top:1210px;">
		<span style="width:100%;font-size:40px;text-align:center">按科室或日期选择</span>
	</div>
	 <div id="tip1" style="width:100%;z-index:60;position:absolute;top:1264px;">
		<span style="width:100%;font-size:40px;text-align:center">注:每天的7:00-9:00不可预约</span>
	</div>
	<div id="type"
		style="z-index:40;position:absolute;top:1375px;left:150px;display:block">
		<img id="byks"
			src="${pageContext.request.contextPath}/images/bykeshi.png"
			height="" width="" style="margin-right:70px"/> 
		<img id="byrq"
			src="${pageContext.request.contextPath}/images/byriqi.png"
			height="" width="" />
	</div>
	<div id="main" style="position: absolute;top:1730px;left:425px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/images/main1.png"
			height="" width="" />
	</div>
	<div id="pre" style="position: absolute;top:1718px;left:600px;">
		<img src="${pageContext.request.contextPath}/images/pre.png"
			res_img="${pageContext.request.contextPath}/images/pre1.png"
			height="" width="" />
	</div>
</body>
<script type="text/javascript">
	var cardNo = window.parent.cardNo;//卡号
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var csrq00 = window.parent.csrq00;//出生日期
	var brnl00 = window.parent.brnl00;//病人年龄
	var brid00 = window.parent.brid00;//病人ID
	var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用）
	var ynzhye = window.parent.ynzhye;//院内账户余额
	var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
	var pbbz00;//1表示按日期预约   0表示按科室预约
	var log = document.getElementById("AVFOCX");	
	//初始化倒计时时间：60秒
	var time = window.parent.reTime;
	var sfjf;  //是否有未缴费记录  1：有未缴费   0：无未缴费
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
	
	//点击按科室按钮
	$("#byks").bind("click dbclick", function() {
		//log.WriteLog("卡号为:"+cardNo+"选择按取科室预约"); 	
		if(sfjf==1){
			$("#tip_div").show();
				$("#error").text("您有未缴费的费用，请缴费后办理，或直接到窗口办理！");
				$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}else{
			pbbz00=0;
			$.session.set('pbbz00', pbbz00);
			window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yykeshi.jsp";	
		}
						
	});
	//点击按日期按钮
	$("#byrq").bind("click dbclick", function() {
		//log.WriteLog("卡号为:"+cardNo+"选择按取科室预约");
		if(sfjf==1){
			$("#tip_div").show();
				$("#error").text("您有未缴费的费用，请缴费后办理，或直接到窗口办理！");
				$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}else{
			pbbz00=1;
			$.session.set('pbbz00', pbbz00);
			window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyriqi.jsp";
		}
	});
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	
	
	//查询门诊待缴费信息记录
	function getJSInfo(){
		 var datas = {"funcid":"M07.02.05.01",
		 			  "cxfs00":window.parent.cardtype,							 
				      "cxdm00":window.parent.cardNo,					     
				      "brid00":window.parent.brid00,
				      "sfybye":""};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl + "?method=ApplyAction",
				//url:"${pageContext.request.contextPath}/Test/test.do",
				success:function(json){
					var Data = eval(json);		
					if(Data.retcode=="0"){
						if(Data.retbody.length!="0"){
							sfjf=1;
						//log.WriteLog("获取结算信息成功");
						}else{
							sfjf=0;
						}
					}else{		
						sfjf=0;
						/* $("#tip_div").show();
          				$("#error").text(Data.retmsg); */
						//log.WriteLog("获取结算信息失败");
					}						
				},	
				 error:function(){						
					$("#tip_div").show();
          			$("#error").text("系统异常，请稍后再试！");
				}
			});	
	}
	getJSInfo();
</script>
</html>





