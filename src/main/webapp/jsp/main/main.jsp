<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>

<title>临沂人民医院—首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>

<style>
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	background: url(${pageContext.request.contextPath}/images/bg_nn.png)
		no-repeat;
}

.menu {
    margin: 54px 0px 0px 160px;
	float: left;
	padding: 0px 0px 0px 0px;
}
.menu img{
	width:260px;
	opacity: 1;
}
</style>
</head>
<body scroll="no" ondragstart="return false" onselectstart="return false">
	<div id="zdbh"
		style="position:absolute;margin: -5px 0px 0px 839px;font-size:28px;color:red;"></div>
	<div class='timerShow'
		style="position:absolute;width:501px;color:red;font-size:28px;margin:30px 0px 0px 784px;">
		<span class='Y'></span> <span class='D'></span> <span class='H'></span>
	</div>

	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:165px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:120px;left:300px" />
	</div>
	<div id="manageArea"
		style="width:72px;height: 60px;margin:-26px 0px 0px -7px;"></div>
	<div style="margin:115px 0px 0px 0px;">
		<!-- 门诊缴费-->
		<div name="menus" id="mzcz" class="menu">
			<img src="${pageContext.request.contextPath}/images/mzcz_s.png">
		</div>
		<!-- 门诊挂号-->
		<div name="menus" id="mzgh" class="menu">
			<img src="${pageContext.request.contextPath}/images/mzgh_s1.png">
		</div>
		<!-- 门诊预约-->
		<div name="menus" id="mzyy" class="menu" style="display:none;">
			<img src="${pageContext.request.contextPath}/images/mzyy_s.png">
		</div>

		<!-- 住院充值-->
		<div name="menus" id="zycz" class="menu">
			<img src="${pageContext.request.contextPath}/images/zycz_s.png">
		</div>
		<!-- 查询-->
		<div name="menus" id="zzcx" class="menu">
			<img src="${pageContext.request.contextPath}/images/cx_s1.png">
		</div>
	</div>


</body>
<script type="text/javascript">
	 $.session.clear();
	 var shutdown=window.parent.shutdown;
	 var KPrinter=window.parent.KPrinter;
	 var zdbh00 = window.parent.zdbh00;
	 var logger = window.parent.Logger;//日志OCX对象
	 var status;
	 //初始化倒计时时间：60秒
	 var time = window.parent.reTime;
	 
	 function re(){
		$("#zdbh").text(zdbh00);
		 window.parent.money=0;
		 window.parent.jstype=1;
		 window.parent.cztype=1;
		 window.parent.czsucc=0;
		 returnTime();//长时间无操作关机判断
		 document.onkeydown = timeAgin;
		 document.onclick = timeAgin;
		 
	 }
	 function timeAgin(){
		 time = 60;
	 }
	 //倒计时60S后 无操作自动关机
	 function returnTime(){
			myVar=setInterval(
				function(){
					time--;
					if(time==0){
						//定时关机任务
						shutdownt();
					}
				},1000);
	}
	 
	 //定时关机任务
	 function shutdownt(){
		 var date=new Date();
		 var h=parseInt(date.getHours());
		 var m=parseInt(date.getMinutes());
		 if((h==18 && m>00) ||h>18 || (h==6 && m<25) || h<6){
			 shutdown.ShutdownFunc();
		 }else{
			 setTimeout(function(){ shutdownt(); }, 1000);
		 }
	 }
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});
	//门诊缴费
 	$("#mzcz").bind("click dbclick", function() {
			window.parent.ttype=2;
			window.location.href="${pageContext.request.contextPath}/jsp/main/readcard.jsp";
		/* 	
			status=KPrinter.GetStatusX();
			//alert(status);
			if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
				window.parent.ttype=2;
				window.location.href="${pageContext.request.contextPath}/jsp/main/readcard.jsp";
			}else if(status="01000000"){
				$.session.set("errormsg","热敏打印机缺纸，请联系工作人员");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			}else if(status="00010000"){
				$.session.set("errormsg","热敏打印机卡纸，请联系工作人员");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			}else{
				$.session.set("errormsg","热敏打印机脱机，请联系工作人员");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			} */
	});
	
	//门诊挂号
	$("#mzgh").bind("click dbclick", function() {
			window.parent.ttype=1; //1挂号， 2缴费
			window.location.href="../main/readcard.jsp";
			/* 
			var status = KPrinter.GetStatusX();
			if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
				window.parent.ttype=1;
				window.location.href="../main/readcard.jsp";
			}else if(status="01000000"){
				$.session.set("errormsg","热敏打印机缺纸，请联系工作人员");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			}else if(status="00010000"){
				$.session.set("errormsg","热敏打印机卡纸，请联系工作人员");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			}else{
				$.session.set("errormsg","热敏打印机脱机，请联系工作人员");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
			} */
	});
	
	//住院充值
	$("#zycz").bind("click dbclick", function() {
		window.parent.ttype=3;
		window.location.href="${pageContext.request.contextPath}/jsp/cxym/cxzyInfo_b.jsp";
	});
	
	//查询
	$("#zzcx").bind("click dbclick", function() {
		window.parent.ttype=4;
		window.location.href="${pageContext.request.contextPath}/jsp/cxym/cxmenu.jsp";
	});
	
	/**三秒连点五下打开管理界面****/
 	var cNum = 0;
 	setInterval(function() {
 		 cNum = 0;
 	}, 3000);
	$("#manageArea").bind("click", function() {
		cNum++;
		if(cNum == 2){
			cNum = 0;
			window.location.href="../manageop/checkPage.jsp";
		}
	}); 
	function timer(obj, txt) {
		//console.log(txt);
		obj.text(txt);
		 if(window.parent.zdbh00){
			 $("#zdbh").text(window.parent.zdbh00);
		 }
	}
	
	setInterval(showTime, 1000);
	function showTime() {
		var today = new Date();
		var weekday = new Array(7);
		weekday[0] = "星期日";
		weekday[1] = "星期一";
		weekday[2] = "星期二";
		weekday[3] = "星期三";
		weekday[4] = "星期四";
		weekday[5] = "星期五";
		weekday[6] = "星期六";
		var y = today.getFullYear() + "-";
		var month = (today.getMonth()+1) + "-";
		var td_keleyi_com = today.getDate() + " ";
		var d = weekday[today.getDay()];
		var h;
		if(today.getHours() < 10){
			h = "0" + today.getHours() + ":";
		}else{
			h = today.getHours() + ":";
		}
		var m;
		if(today.getMinutes() < 10){
			m = "0" + today.getMinutes() + ":";
		}else{
			m = today.getMinutes() + ":";
		}
		var s;
		if(today.getSeconds() < 10){
			s = "0" + today.getSeconds();
		}else{
			s = today.getSeconds();
		}
		timer($(".Y"), y+month+td_keleyi_com);
		//timer($(".D"), d);
		timer($(".H"), h+m+s);
	}

 re();
</script>
</html>

