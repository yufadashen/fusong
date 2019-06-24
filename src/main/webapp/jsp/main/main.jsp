<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
	<OBJECT classid=clsid:D21F6E52-42EA-44B5-A3EA-F2D069C2B9E5 width=0 height=0 align="center"  id="CHeNanCPUCtrl" HSPACE=0 VSPACE=0></OBJECT>
 <object id="AVFOCX" classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA" width="0" height="0">
               <param name="s1" value="" />
       </object>
	<title>河北北方学院附属第一医院—首页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>


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
<div id="termialNum" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
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

<div id="gh" style="position:absolute;left:170px;top:260px;" >
	<img src="${pageContext.request.contextPath}/images/yygh.png"  height="" width=""/>
</div>
<%--<div id="yy" style="position:absolute;left:420px;top:260px;">--%>
<%--<img src="${pageContext.request.contextPath}/images/yy.png"  height="" width=""/>--%>
<%--</div>--%>
<div id="jf" style="position:absolute;left:420px;top:260px;">
	<img src="${pageContext.request.contextPath}/images/jf.png"  height="" width=""/>
</div>
<div id="zndz" style="position:absolute;left:670px;top:260px;">
	<img src="${pageContext.request.contextPath}/images/zndz.png"  height="" width=""/>
</div>

<div id="myd" style="position:absolute;left:960px;top:260px;">
	<img src="${pageContext.request.contextPath}/images/myddc.png" height="" width=""/>
</div>
<div id="jzk" style="position:absolute;left:170px;top:580px;">
	<img src="${pageContext.request.contextPath}/images/jzk.png"  height="" width=""/>
</div>
<div id="jzjlcx" style="position:absolute;left:420px;top:580px;">
	<img src="${pageContext.request.contextPath}/images/jz1.png"  height="" width=""/>
</div>
<div id="dybgd" style="position:absolute;left:670px;top:580px;">
	<img src="${pageContext.request.contextPath}/images/binglidayin.png"  height="" width=""/>
</div>
<div id="others" style="position:absolute;left:960px;top:580px;">
	<img src="${pageContext.request.contextPath}/images/qt.png" height="" width=""/>
</div> 

</body>
<script type="text/javascript">
	//var temp = document.getElementById("AVFOCX");
	//var ret = temp.WriteLog("TEST");
					//alert(ret);
	var shutdown=window.parent.shutdown;
	var KPrinter=window.parent.KPrinter;
	var logger = window.parent.logger;
	//var faka = window.parent.faka;
	var status="00000000";
	var bh;
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

	/*初始化个人信息*/
	function reloadUserInfo() {
		window.parent.money=0;
		window.parent.jstype=1;
		window.parent.cztype=1;
		window.parent.czsucc=0;

		window.parent.brid00 = "";//病人id
		window.parent.cardNo = "";//卡号
		window.parent.lxdh00 = "";//联系电话
		window.parent.sfzhao = "";//身份证号
	}

	function useM() {
		//alert(0);
		var datas ={
            "funcid":"M07.02.01.08"
		};
        $.ajax({
            async : true,
            type : "post",
            data : datas,
            dataType : "json",
            contentType : "application/x-www-form-urlencoded; charset=utf-8",
            url : window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success : function(json) {
				//alert(1);
                //1、解析json
				var data = eval(json);
				//2、判断出参
				if(data.retcode=="0"){
				    //3、根据出参选择是否调用关机
					//alert(data.retbody[0].sfgj00)
					/*if(data.retbody[0].sfgj00=="1") {
                        shutdown.ShutdownFunc();
					}*/
					//显示终端编号
					var number =  data.retbody[0].zdbh00;
					//alert(number);
					$("#termialNum").text(number);
				}
            },
            error : function() {
				//alert(2);
            },
        });
    }

	function re(){
		//alert(logger);
		useM();
		reloadUserInfo();

		//在此处判断是否要显示 病历单打印按钮
		var xdStatus = window.parent.xdResult;
	    	
		if (xdStatus == "40000" || xdStatus == "41913" ||xdStatus == "10001" ){
			$("#dybgd").show();
		}else{
			$("#dybgd").hide();
		}
		var cardPrinter = window.parent.cardPrinter;
		
		if (!cardPrinter.contentDocument) {
			//alert("no faka");
			$("#jzk").hide();
		}else{
			//alert("faks yes");
			$("#jzk").show();
		}
		var  IPHlpOcx = window.parent.IPHlpOcx;
//		alert(IPHlpOcx.contentDocument) //是否安装ipocx
		if(IPHlpOcx.contentDocument){
			//alert(IPHlpOcx.GetHostIP());;
			if(IPHlpOcx.GetHostIP()=="192.168.8.85"){
				$("#gh").hide();
				$("#jf").hide();
				$("#zndz").hide();
				$("#myd").hide();
				$("#gh").hide();
				$("#jzk").hide();
				$("#jzjlcx").hide();
				$("#others").hide();
				$("#dybgd").show();
				$("#dybgd").css({"position":"absolute","top":"440px","left":"550px","width":"400px","height":"400px"})

			}
		}
testRe();
		returnTime();
		
		

	}
	
	//测试2019-5-21-21.25
	function testRe() {
        	var datas = {
            		"funcid" : "M07.02.01.08"
        		};
       		$.ajax({
           		async : true,
           		type : "post",
           		data : datas,
           		dataType : "json",
           		contentType : "application/x-www-form-urlencoded; charset=utf-8",
           		url : window.parent.serverUrl + "?method=ApplyAction",
           		success : function(json){
				 var data = eval(json); //将json 字符串解析为json 对象
                		 if (data.retcode=="0") { //json 返回是成功状态
                    		 $.session.set("zdbh00",data.retbody[0].zdbh00);
				 bh = data.retbody[0].zdbh00;
               		 }

           		},error : function () {

           		}
       		    });
   		 }

	//倒计时60S后 无操作自动关机
	function returnTime(){
		myVar=setInterval(
				function(){
					//测试2019-5-21-21.25(todo:此方法存在性能问题)
					//testRe();
					$.session.set("zdbh00",bh);
					time--;
					if(time==0){
						//定时关机任务
						var weekResult = isWeek();
						if (weekResult == true) {
							//shutdownt1();
							shutdownt();
							
						}else{
							shutdownt();

						}
					}
				},1000);
	}

	function isWeek() {
		var date = new Date();
		var day = date.getDay();//周日getDay值为0
		var limit = date.getDate();
		var month = date.getMonth();
		//if (day=="0") {//临时增加五一假期不开机 五月5日周日要开机
		if (month=="4" && limit <5) {//临时增加五一假期不开机 五月5日周日要开机
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
		if((h==17 && m>30)){
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
		if((h==5 && m>29)|| h>5){
			shutdown.ShutdownFunc();
		}else{
			setTimeout(function(){ shutdownt1(); }, 60000);
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

	$("#zndz").bind("click dbclick",function () {
	
		window.location.href="${pageContext.request.contextPath}/jsp/zndz/zndz.jsp";
		//$("#tip_div").show();
		//$("#error").text("该功能暂未开放");
		//$("#tip_s").on("click", function () {
		//	$("#tip_div").hide();
		//	if (typeof ($.session) != "undefined"){
		//		$.session.clear();
		//	}
		//	 window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		//});
	})
	
	//其他
	$("#others").bind("click dbclick",function () {
		$("#tip_div").show();
		$("#error").text("敬请期待!");
		$("#tip_s").on("click", function () {
			$("#tip_div").hide();
			if (typeof ($.session) != "undefined"){
				$.session.clear();
			}
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	})
	
	//打印报告单
	$("#dybgd").bind("click dbclick",function () {
		//如果设备有打印机,显示该图标，如果没有打印机，则屏蔽该图标
		//如果缺纸，则在界面进行提示
		var xdStatus = window.parent.xdResult;
		if (xdStatus=="41913") {
			$("#tip_div").show();
			$("#error").text("打印机缺纸，请联系工作人员!");
		} else if (xdStatus == "40000" || xdStatus == "10001") {
			window.parent.ttype=10;//打印报告单
			//window.location.href="${pageContext.request.contextPath}/jsp/main/readCardType.jsp";
		            window.location.href="${pageContext.request.contextPath}/jsp/dybgd/chooseType.jsp";
		} else{
			$("#tip_div").show();
			$("#error").text("打印机异常,请联系工作人员!");
		}
	});

	$("#myd").bind("click dbclick",function () {
		$("#tip_div").show();
		$("#error").text("该功能暂未开放");
		$("#tip_s").on("click", function () {
			$("#tip_div").hide();
			if (typeof ($.session) != "undefined"){
				$.session.clear();
			}
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	})

	$("#gh").bind("click dbclick", function() {
		var date=new Date();
		var h=parseInt(date.getHours());
		var m=parseInt(date.getMinutes());
		/*if((h==17 && m>30)){
			$("#tip_div").show();
			$("#error").text("17点30分之后不能挂当日号");
		}else{
			status=KPrinter.GetStatusX();

			if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
				window.parent.ttype=1;
				//window.location.href="<%--${pageContext.request.contextPath}--%>/jsp/main/readcard.jsp";
				window.location.href="<%--${pageContext.request.contextPath}--%>/jsp/main/readCardType.jsp";
			}else{
				$("#tip_div").show();
				$("#error").text("打印机缺纸，请联系工作人员");
			}
		}*/
			status=KPrinter.GetStatusX();

			if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
				window.parent.ttype=1;
				//window.location.href="<%--${pageContext.request.contextPath}--%>/jsp/main/readcard.jsp";
				window.location.href="<%--${pageContext.request.contextPath}/jsp--%>/main/readCardType.jsp";
			}else{
				$("#tip_div").show();
				$("#error").text("打印机缺纸，请联系工作人员");
			}

	});

	//门诊缴费按钮
	$("#jf").bind("click dbclick", function () {
		status=KPrinter.GetStatusX();
		if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
			window.parent.ttype=3;
			window.location.href="${pageContext.request.contextPath}/jsp/main/readCardType.jsp";
		}else{
			$("#tip_div").show();
			$("#error").text("打印机缺纸，请联系工作人员");
		}
	});

	//就诊记录查询
	$("#jzjlcx").bind("click dbclick",function () {
		/*window.parent.ttype = 9;
		window.location.href="${pageContext.request.contextPath}/jsp/main/readCardType.jsp";*/

		/*$("#tip_div").show();
		$("#error").text("该功能暂未开放");
		$("#tip_s").bind("click dbclick",function () {
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});*/

		status=KPrinter.GetStatusX();
		if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
			window.parent.ttype = 9;
			window.location.href="<%--${pageContext.request.contextPath}/jsp/--%>main/readCardType.jsp";
		}else{
			$("#tip_div").show();
			$("#error").text("打印机缺纸，请联系工作人员");
		}
	});

	$("#mzgh").bind("click dbclick", function() {
		status=KPrinter.GetStatusX();
		if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
			window.parent.ttype=2;
			window.location.href="<%--${pageContext.request.contextPath}/jsp--%>/main/readcard.jsp";
		}else{
			$("#tip_div").show();
			$("#error").text("打印机缺纸，请联系工作人员");
		}
	});

	$("#mzyy").bind("click dbclick", function() {
		status=KPrinter.GetStatusX();
		if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
			window.parent.ttype=3;
			window.location.href="<%--${pageContext.request.contextPath}/jsp--%>/main/readcard.jsp";
		}else{
			$("#tip_div").show();
			$("#error").text("打印机缺纸，请联系工作人员");
		}
	});

	$("#cx").bind("click dbclick", function() {
		status=KPrinter.GetStatusX();
		if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
			window.parent.ttype=4;
			window.location.href="<%--${pageContext.request.contextPath}/jsp--%>/main/readcard.jsp";
		}else{
			$("#tip_div").show();
			$("#error").text("打印机缺纸，请联系工作人员");
		}
	});

	$("#jzk").bind("click dbclick", function() {	
		var cardPrinter = window.parent.cardPrinter;
		var status = cardPrinter.GetStatus();
		if(status.length==4){
			if(status.slice(2,3) == "1"){//卡栈内无卡
				$("#tip_div").show();
				$("#error").text("机器内无卡,请联系工作人员!");
			}else{
				if(status.slice(1,2)=="1"){////第2位：0 = 回收盒未满，1 = 回收盒收卡已满
					$("#tip_div").show();
					$("#error").text("回收槽已满,请联系工作人员!");
				}else{
					status=KPrinter.GetStatusX();
					//alert();
					if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
						window.parent.ttype=100;
						window.location.href="<%--${pageContext.request.contextPath}/jsp--%>/zzfk/zzfkreadidcard.jsp";
					}else{
						$("#tip_div").show();
						$("#error").text("打印机缺纸，请联系工作人员");
					}
				}
			}
		}else{
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

