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
.ksWz{
	
}
td{
	padding:7px;
}
.pageButton{
	width:260px;
	height:60px;
	border-radius:10px; 
	background-color:#85c531;
	margin-left:220px;
	margin-top: 120px;
	line-height:60px;
	font-size:30px;
	color:white;
	behavior:url(../../js/PIE.htc);
}

.modifyInput{
	margin:4px 0px 0px 0px;
	height: 105px;
	width: 350px;
}
.chooseType{
	margin: 0px 0px 0px -180px;
	font-size: 28px;
	color: grey;
}
.chooseType1{
	margin: 0px 0px 0px -180px;
	font-size: 28px;
	color: #599CE0;
}
.modifys{
	background-color:#599CE0;
	position:absolute;
	height:60px;
	width:91px;
	margin:-55px 0px 0 189px;
	font-size:30px;
	color:white;
	line-height:55px;
}
.modifys1{
	background-color:grey;
	position:absolute;
	height:60px;
	width:91px;
	margin:-55px 0px 0 189px;
	font-size:30px;
	color:white;
	line-height:55px;
}
.chooseContent{
	width:182px;
	height:40px;
	margin-left:-93px;
	border:none;
	font-size:28px;
	margin-top:15px;
}
.contentBox{
	position:absolute;
	height:60px;
	width:280px;
	border-radius:5px;
	border:1px #599CE0 solid;
	margin-top:0px;
	behavior:url(../../js/PIE.htc);
}
.yykey{
	font-size: 22px;
	margin-left:2px;
	color: grey;
}
.yyValue{
	color:black;
	font-size: 28px;
	margin-left:22px;
}

</style>
</head>
<body scroll="no"  onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">挂号确认</font>
	</div>
	<div id="showArea">
		<table id="keshi_t" style="margin-left:90px;margin-top: 100px;text-align: left;">
			<tbody id="info_t" >
				<tr><td style="width: 500px;"><span class="yykey">挂号午别:</span><span id="yydate" class="yyValue">1111</span></td></tr>
				<tr><td style="width: 500px;"><span class="yykey">挂号科别:</span><span id="yykebie" class="yyValue">1111</span></td></tr>
				<tr><td style="width: 500px;"><span class="yykey">挂号科室:</span><span id="yykeshi" class="yyValue">1111</span></td></tr>
				<tr><td style="width: 500px;"><span class="yykey">挂号医生:</span><span id="yydoctor" class="yyValue">1111</span></td></tr>
				<tr><td style="width: 500px;"><span class="yykey">挂号时间:</span><span id="yytime" class="yyValue">1111</span></td></tr>
			</tbody>
		</table>
		<div class="pageButton" id="confirmApp">确认挂号</div>
	</div>
	<div id="rightOper" style="position: absolute;margin-top:-569px;margin-left:720px;width:350px;">
		<div class="modifyInput">
			<span class="chooseType">选择挂号科别</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseKb" type="text"  readonly="readonly">
				<div class="modifys1" id="ghkebie">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType">选择挂号科室</span>
			<div class="contentBox">
				<input class="chooseContent"  id="chooseKs" type="text"  readonly="readonly">
				<div class="modifys" id="ghkeshi">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType">选择挂号午别</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseNoon" type="text"  readonly="readonly">
				<div class="modifys" id="ghwb">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType" >选择挂号医生</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseDoc" type="text"  readonly="readonly">
				<div class="modifys" id="ghdoctor2">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType">选择挂号时间</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseTime" type="text"  readonly="readonly">
				<div class="modifys" id="ghtime" >修改</div>
			</div>
		</div>
	</div>
	
	<div id="bottomArea">
		<span style="margin-left:20px;">姓名：<span id="cusName">name</span></span>
		<span style="margin-left:60px;">卡号：<span id="cusCardNo">0</span></span>
		<span style="margin-left:60px;">余额：<span id="cusBalance">0.00</span></span>
		<div style="margin-left:50px;position:absolute;margin: -62px 0px 0px 700px;">
			<img id="btnMain" style="margin-top:8px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</div>
		<div style="margin-left:20px;position:absolute;margin: -61px 0px 0px 855px;">
			<img id="btnReturn" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
		</div>
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
	//var xbie00="男";
	//var brnl00="25";
	var keshi; //科室
	var ksbh00;//科室代码
	var cardNo = window.parent.cardNo;
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var brnl00 = window.parent.brnl00;//病人年龄
	var log = document.getElementById("AVFOCX");
	var fssj00;//发送时间
	var	ksczrq;//开始日期时间
	var	jsczrq;//结束日期时间
	var sjdms01;//时间点编号
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
	
	//根据input框内容是否存在值，确认是否进行过该页面的操作，如果有操作，可以进行修改，如果没有，置灰 不可修改
	function initStyle(){
		var inputs = $(".chooseContent");
		$.each(inputs,function(index,temp){
			if(temp.value){
				$(this).parent().css("border","1px #599CE0 solid");
				$(this).parent().prev().removeClass();
				$(this).parent().prev().addClass("chooseType1");//蓝色可点击  
				$(this).next().removeClass();
				$(this).next().addClass("modifys");
				$(this).next().click(goModify);
			}else{
				$(this).parent().css("border","1px grey solid");
				$(this).parent().prev().removeClass();
				$(this).parent().prev().addClass("chooseType");
				$(this).next().removeClass();
				$(this).next().addClass("modifys1");//置灰不可点击
				$(this).next().unbind();//不可点击
			}
		});
	}
	function goModify(){
		var pageName = $(this).attr("id");
		window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/"+pageName+".jsp";
		$("#waiting").show();
	}

	function confirmGh (){
		$("#waiting").show();
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
        var currTime = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
			var datas = {
					"funcid" : "M07.02.04.07",
					"isgh00" : "1",//是否挂号，暂不需要。
					"pbid00" : $.session.get('pbid'),//排班id
					"brid00" : window.parent.brid00,//时间点
					"yyrq00" : currDate,
					"yysj00" : $.session.get('ghsj'),//时间点
					"cxdm00" : window.parent.cardNo,
					"xming0" : window.parent.xming0,
					"ksbh00" : $.session.get('hisksbh00'),
					"ysbh00" : $.session.get('ysbh00'),
					"yywbmc" : $.session.get('noon'),
					"yysjd0" : $.session.get('noon')=="上午"?"0":"1"//时间点
				
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
				//$.getJSON("../mzgh/yydj.json",function(json){//测试数据
					var Data = eval(json);
					if (Data.retcode == "0") {
						var jzxh00 = Data.retbody[0].pdxh00;//就诊序号(排队序号)
						var pjh000 = Data.retbody[0].pjh000;//票据号
						var jzwz00 = Data.retbody[0].jzwz00;//票据号
						//打印挂号小票
						print(jzxh00,pjh000,jzwz00);
						
						window.location.href = "ghsuccess.jsp";
						$("#waiting").show();
					} else {
						$("#waiting").hide();
						$("#tip_div").show();
						$("#error").text(Data.retmsg);			
					}
					flag = true;
					$("#waiting").hide();
				//});
			},
			error : function() {
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");		
			}
		}); 
	}	
	//打印挂号小票
	function print(jzxh00,pjh000,jzwz00){
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
        var currTime = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      临沂人民医院自助挂号凭条");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      —————————————————————");
		//Printer.LFX(2);
		printer.WriteTextLineX("      就诊卡号:"+window.parent.cardNo);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      姓名："+window.parent.xming0+"  性别: "+window.parent.xbie00);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      挂号日期：" + currDate);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂号时间：" + $.session.get('time'));
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂号科室:" + $.session.get('keshi'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      挂号医生:"+$.session.get('doctor'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      就诊位置："+$.session.get('jzwz00'));
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      诊疗费用："+$.session.get('ghf00'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      就诊序号:"+jzxh00);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      *请尽快到候诊区候诊，避免过号！*");
		printer.WriteTextLineX("      —————————————————————");
		printer.WriteTextLineX("      自助机号："+window.parent.zdbh00);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      打印时间："+currTime);
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
	/**
	*初始化操作
	**/
	var init = function(){
		//初始化挂号信息
		$("#yydate").text($.session.get('noon'));
		$("#yykebie").text($.session.get('kebie'));
		$("#yykeshi").text($.session.get('keshi'));
		$("#yydoctor").text($.session.get('doctor'));
		$("#yytime").text($.session.get('time'));
		//右侧修改内容默认显示
		$("#chooseKb").val($.session.get('kebie'));
		$("#chooseKs").val($.session.get('keshi'));
		$("#chooseNoon").val($.session.get('noon'));
		$("#chooseDoc").val($.session.get('doctor'));
		$("#chooseTime").val($.session.get('time'));
		
		$("#confirmApp").bind("click dbclick", function() {//挂号
			$("#waiting").show();
			confirmGh();
		});
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "ghdoctor2.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		$("#cusName").text(window.parent.xming0);
		$("#cusCardNo").text(window.parent.cardNo);
		$("#cusBalance").text(window.parent.yjjye0);
		initStyle();
	}
	init();
</script>
</html>