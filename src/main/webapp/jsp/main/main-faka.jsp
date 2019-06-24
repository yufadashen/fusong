<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
	<OBJECT classid=clsid:D21F6E52-42EA-44B5-A3EA-F2D069C2B9E5 width=0 height=0 align="center"  id="CHeNanCPUCtrl" HSPACE=0 VSPACE=0></OBJECT>
	<title>河北北方学院附属第一医院—首页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>

	<style>
		body {
			width: 100%;
			height: 100%;
			overflow: hidden;
			background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
		}
	</style>
</head>
<body scroll="no">
<div id="tip_div"
	 style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:465px;">
	<div id="tip_divInfo"
		 style="text-align:center;position:relative;top:82px">
		<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
	</div>
	<img id="tip_s"
		 src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
		 height="43" style="position:relative;top:160px;left:300px" />
</div>



<div id="jzk" style="position:absolute;left:470px;top:280px;">
	<img src="${pageContext.request.contextPath}/images/jzk.png" style="width:300px;"  height="" width=""/>
</div>





</body>
<script type="text/javascript">
	var shutdown=window.parent.shutdown;
	var KPrinter=window.parent.KPrinter;
	//var faka = window.parent.faka;
	var status="00000000";
	//初始化倒计时时间：60秒
	var time = window.parent.reTime;

	$(document).keydown(function(event){
		if(event.keyCode==13){
			//alert(13)
			window.history.go(0);
		}
		if(event.keyCode==8){
			//alert(8);
			window.history.go(0);
		}
	})

	function re(){
		window.parent.money=0;
		window.parent.jstype=1;
		window.parent.cztype=1;
		window.parent.czsucc=0;
		returnTime();
	}
	//倒计时60S后 无操作自动关机
	function returnTime(){
		myVar=setInterval(
				function(){
					time--;
					if(time==0){
						//定时关机任务
						var weekResult = isWeek();
						if (weekResult == true) {
							//在测试库关闭自动关机功能
							//shutdownt1();
						}else{
							//shutdownt();
						}
					}
				},1000);
	}

	function isWeek() {
		var date = new Date();
		var day = date.getDay();//周日getDay值为0
		var limit = date.getDate();
		var month = date.getMonth();
		if (day=="0" ||( month=="4" && limit <5)) {//临时增加五一假期不开机
			//周六或周日,系统开机后则关闭机器
			return true;
		}else{
			return false;
		}
	}

	//定时关机任务
	function shutdownt(){
		var date=new Date();
		var h=parseInt(date.getHours());
		var m=parseInt(date.getMinutes());
		if((h==22 && m>30)){
			shutdown.ShutdownFunc();
		}else{
			setTimeout(function(){ shutdownt(); }, 60000);
		}
	}

	//周六周日关机，五点半
	function shutdownt1(){
		var date=new Date();
		var h=parseInt(date.getHours());
		var m=parseInt(date.getMinutes());
		if((h==22 && m>29)|| h>22){
			shutdown.ShutdownFunc();
		}else{
			setTimeout(function(){ shutdownt(); }, 60000);
		}
	}

	$('img').mouseover(function() {
		imgSrc = $(this).attr("src");
		$(this).attr("src", $(this).attr("res_img"));
	});

	$('img').mouseout(function() {
		$(this).attr("src", imgSrc);
	});
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});

	$("#jzk").bind("click dbclick", function() {
		//window.location.href="${pageContext.request.contextPath}/jsp/zzfk/zzfkreadidcard.jsp";
		//返回值为四位字符串
		//第1位：0 = 卡机中无卡（包含插卡口），1 = 插卡口处有卡，2 = 卡机中有卡
		//第2位：0 = 回收盒未满，1 = 回收盒收卡已满
		//第3位：0 = 卡栈内有卡，1 = 卡栈内无卡
		//第4位：0 = 卡栈卡足够，1 = 卡栈卡不足
		$("body").append("<div id=\"waiting\" style=\"margin:444px 0px 0px 351px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;\"></div>");
		var cardPrinter = window.parent.cardPrinter;
		var status = cardPrinter.GetStatus();
		if(status.length==4){
			if(status.slice(2,3) == "1"){//卡栈内无卡
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("机器内无卡,请联系工作人员!");
			}else{
				if(status.slice(1,2)=="1"){////第2位：0 = 回收盒未满，1 = 回收盒收卡已满
					$("#waiting").hide();
					$("#tip_div").show();
					$("#error").text("回收槽已满,请联系工作人员!");
				}else{
					status=KPrinter.GetStatusX();
					if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
						window.parent.ttype=100;
						window.location.href="${pageContext.request.contextPath}/jsp/zzfk/zzfkreadidcard.jsp";
					}else{
						$("#waiting").hide();
						$("#tip_div").show();
						$("#error").text("打印机缺纸，请联系工作人员");
					}
				}
			}
		}else{
			$("#waiting").hide();
			$("#tip_div").show();
			$("#error").text("发卡器异常！请联系工作人员!");
		}
	});


	function printdevice(){
		var Pstatus=KPrinter.GetStatusX();
		var message="";
		if(Pstatus=="00000000" || Pstatus=="20000000"){
			Pstatus="000";
			message="设备正常";
		}else if(Pstatus=="04000000" || Pstatus=="24000000"){
			Pstatus="005";
			message="即将缺纸";
		}else{
			Pstatus="006";
			message="设备缺纸";
		}
		var datas = {
			"funcid" : "M07.02.01.13",
			"devType" : "1",
			"status" : Pstatus,
			"message" : message
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url:"${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				carddevice();
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
			}
		});
	}
	function carddevice(){
		var statusNum=faka.CardStatusX();
		var cstatus;
		var message="";

		if(statusNum.length == 3){
			var cardAmount = statusNum.substr(1,1);
			var errorcardAmount = statusNum.substr(2,1);
			if(errorcardAmount == 1){
				cstatus="011";
				message="回收槽满";
			}else{
				if(cardAmount != 0){
					cstatus="000";
					message="设备正常";
				}else{
					cstatus="010";
					message="设备缺卡";
				}
			}
		}else{
			cstatus="001";
			message="设备异常";
		}
		var datas = {
			"funcid" : "M07.02.01.13",
			"devType" : "6",
			"status" : cstatus,
			"message" : message
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url:"${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {

			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
			}
		});
	}



for (i in document.images) document.images[i].ondragstart = imgdragstart;
 
    function imgdragstart() {
        return false;
    };
	re();


</script>
</html>

