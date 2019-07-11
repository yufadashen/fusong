<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>挂号成功</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
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
	text-align: center;
	background:url(../../images/yue/bgn.jpg) no-repeat;
}
#titleArea{
	background-color:#3f7dac; 
	width:1024px;
	height:68px;
	text-align:left;
	font-size:44px;
	color:white;
	margin-top:0px;
}
#bottomArea{
	background-color:#3f7dac; 
	width:1024px;
	height:68px;
	text-align:left;
	font-size:24px;
	color:white;
	margin-top:35px;
	line-height:60px;
}
#showArea{
	border:1px black solid; 
	border-radius:10px; 
	width:995px;
	height:570px;
	margin-left:11px;
	margin-top:20px;
	behavior:url(../../js/PIE.htc);
}
.models{
	width:210px;
	height:80px;
	background-color:#599CE0;
	border-radius:10px;
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    font-size: 22px;
    behavior:url(../../js/PIE.htc);
}
.pageButton{
	width:260px;
	height:60px;
	border-radius:10px; 
	background-color:#85c531;
	line-height:60px;
	font-size:30px;
	color:white;
	behavior:url(../../js/PIE.htc);
}

#showArea{
	
}
#wxts{
	position: absolute;
    font-size: 30px;
    margin-left: 63px;
    margin-top: 84px;
}
#yycg{
	position: absolute;
    margin-left: 268px;
    font-size: 40px;
    margin-top: 209px;
}
#confirmApp{
	margin-top: 450px;
    margin-left: 355px;
}
#btn_tk{
	width:260px;
	height:60px;
	border-radius:10px; 
	background-color:#f37208;
	margin-left:533px;
	margin-top: -60px;
	line-height:60px;
	font-size:30px;
	color:white;
	behavior:url(../../js/PIE.htc);
}
</style>
</head>
<body scroll="no"  onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">挂号成功</font>
	</div>
	<div id="showArea">
		<div id="wxts">温馨提示：</div>
			<div id="yycg">挂号成功，请取走凭条！</div>
		<div class="pageButton" id="confirmApp">确认返回</div>
	</div>
	
	
	<div id="bottomArea">
		<span style="margin-left:620px;">
			<img id="btnMain" style="margin-top:8px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</span>
		<span style="margin-left:40px;">
			<img id="btnReturn" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
		</span>
	</div>
	
	<div id="tip_div"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
   <div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>
<script type="text/javascript">
	//初始化倒计时时间：120秒
	var time = 120;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 120;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					$.session.clear();
					//跳转页面
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#confirmApp").on("click", function(){
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		$("#waiting").hide();
		alert("打印凭条");
		//print();
	}
	//打印挂号小票
	function print(){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
        if(hours<10){
        	hours="0"+hours;
        }
        if(minutes<10){
        	minutes="0"+minutes;
        }
        if(seconds<10){
        	seconds="0"+seconds;
        }
        var currDate = year+"-"+month+"-"+day;
        var currTime = hours+":"+minutes+":"+seconds;
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      抚松县人民医院自助挂号凭条");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      —————————————————————");
		Printer.PrintBarCodeX(73,100,4,window.parent.OutpatientId);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      姓名："+window.parent.Name+"  性别: "+window.parent.Sex);
		printer.WriteTextLineX("          ");
		Printer.WriteTextLineX("  	  ID号：" + window.parent.OutpatientId);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      挂号日期：" + currDate);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂号时间：" + currTime);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂号科室:" + $.session.get('keshi'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      挂号医生:"+$.session.get('doctor'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      就诊位置："+$.session.get('jzwz00'));
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂  号  费："+$.session.get("TotalFee"));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      *请尽快到候诊区候诊，避免过号！*");
		printer.WriteTextLineX("      —————————————————————");
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      打印时间："+currDate+" "+currTime);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      1.请您按照候诊区显示屏上的呼叫信息有序");
		printer.WriteTextLineX("      就诊，具体就诊时间以屏幕实际呼叫为准！");
		printer.WriteTextLineX("      2.预约分诊单当日有效，预约当日该医师有可");
		printer.WriteTextLineX("      能遇急事不能坐诊，请您谅解！");
		printer.WriteTextLineX("      3.此凭条不做报销凭证，就诊完毕后，可到各");
		printer.WriteTextLineX("      楼层收费窗口打印发票");
		printer.LFX(2);
		printer.CeTCutX(); 						//切纸
	}
	
	init();
</script>
</html>