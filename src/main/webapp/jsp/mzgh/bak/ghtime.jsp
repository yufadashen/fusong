<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>门诊挂号</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<script src="${pageContext.request.contextPath}/js/pageOper.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">

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
	width:180px;
	height:60px;
	border:1px black solid; 
	border-radius:10px; 
	background-color:#85c531;
	line-height:60px;
	margin-left:20px;
	behavior:url(../../js/PIE.htc);
}
#confirmBtn{
	border:2px solid #3f7dac;
	width:180px;
	height:60px;
	line-height:60px;
	border-radius:10px; 
	margin-left:20px;
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
.ksbh{
	display: none;
}
</style>
</head>
<body scroll="no"  onselectstart="return false">
<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">选择挂号时间</font>
	</div>
	<div id="showArea">
		<div style="font-size:44px;margin-top:25px;"><span style="margin-left:-170px;">请选择要挂号时间!</span></div>
		<table id="keshi_t" style="table-layout:fixed;cellspacing:20px;margin-left:15px;">
			<tbody id="info_t" >
			</tbody>
			<tfoot>
				<tr>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.prePage($('#confirmBtn'))">上一页</div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px; text-align:center;">
						<div id="confirmBtn" ></div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.nextPage($('#confirmBtn'))">下一页</div>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<div style="position: absolute;margin:-569px 0px 0px 720px;width:350px;">
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
   <div id="tipsModel" style="position: absolute;border:1px solid;display:none; width:600px;height:350px;margin:-574px 0px 0px 222px;background-color:#dff7f7;text-align:center;">
   		<div id="djsn" style="width:100%;height:40px;background-color:#161688;line-height:40px;font-size:26px;text-align:left;">提示(10)</div>
   		<div id="srqy" style="width:92%;height:50%;border:1px solid;margin:22px 0px 0px 22px;background-color:white;letter-spacing: 2px;font-size: 19px;font-family: cursive;line-height: 160px;">
   		</div>
   		<div id="qran" style="width:200px;height:80px;background-color:#2020af;margin:15px 0px 0px 57px;font-size:36px;color: white;font-family: cursive;line-height: 80px;">确定</div>
   		<div id="qxan" style="width:200px;height:80px;background-color:#e2e203;margin:-80px 0px 0px 332px;font-size:36px;color: white;font-family: cursive;line-height: 80px;">取消</div>
   </div>
</body>
<script type="text/javascript">
	var djstime = 10;
	var mysitv=setInterval(function() {
		djstime--;
		$("#djsn").text("提示("+djstime+")");
		if (djstime == 0) {
			//clearInterval(mysitv);
			$("#tipsModel").hide();
		}
	}, 1000);
	function tipsTime(){
		djstime=10;
		$("#tipsModel").show();
		$("#srqy").text("挂号费"+$.session.get('ghf00')+"元 ,将直接从您的就诊卡中扣除，是否确认？");
	}
	$("#qran").on("click", function() {
		confirmGh ();
	});
	$("#qxan").on("click", function() {
		$("#tipsModel").hide();
	});

	//returnTime();
	//var xbie00="男";
	//var brnl00="25";
	var keshi; //科室
	var ksid00;//科室代码
	var cardNo = window.parent.cardNo;
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var brnl00 = window.parent.brnl00;//病人年龄
	var fssj00;//发送时间
	var	ksczrq;//开始日期时间
	var	jsczrq;//结束日期时间
	var sjdms01;//时间点编号
	//初始化倒计时时间：120秒
	var time = 120;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 120;
	}
	returnTime();
	
	function getParma(){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
        if(month<10){
        	month=month+"0";
        }      
        if(day<10){
        	day=day+"0";
        }
        if(hours<10){
        	day=day+"0";
        }
        if(minutes<10){
        	day=day+"0";
        }
        if(seconds<10){
        	day=day+"0";
        }
        fssj00=year+""+month+""+day+""+hours+""+minutes+""+seconds+".000";
		ksczrq=year+""+month+""+day+"000000.000";
		jsczrq=year+""+month+""+day+"235900.000";
		sjdms01=year+""+month+""+day;
		$.session.set('sjdms01', sjdms01);
		$.session.set('ksczrq', ksczrq);
		$.session.set('jsczrq', jsczrq);
	}
	
	
	function clickKeshi(obj) {
		keshi = obj.children[0].innerText;
		var ghsj = obj.children[1].innerText;
		$.session.set('time', keshi);
		$.session.set('ghsj', ghsj);
		//window.location.href = "ghconfirm.jsp";
		tipsTime();//弹出提示框 ，并进行挂号操作
	}
	
	//获取挂号时间信息
	function getGhtime() {
		var datas = {
				
				"funcid" : "M07.02.04.06",
				"pbid00" : $.session.get("pbid")//排班id
				/*  
				"funcid" : "M07.02.04.01",
				"ghyylx" : "G",
				"pbbz00" : "",
				"fssj00" : fssj00,
				"ksczrq" : ksczrq,
				"jsczrq" : jsczrq
				 */
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
						
						//$.getJSON("../mzgh/yytime.json",function(json){//测试数据
						var Data = eval(json);
						if (Data.retcode == "0") {
							var length = Data.retbody.length;
							for (var i = 0; i < length; i = i + 3) {
								if (i + 2 < length) {
									$("#info_t").append(
											"<tr>"
											+"<td><div class=\"models\" onclick=\"clickKeshi(this)\"> <span class=\"ksWz\" style=\"color:white;\">" + Data.retbody[i].yysjxs + "</span><span class=\"ksbh\" style=\"color:white;\">" + Data.retbody[i].yysj00 + "</span></div></td>"
											+"<td><div class=\"models\" onclick=\"clickKeshi(this)\"> <span class=\"ksWz\" style=\"color:white;\">" + Data.retbody[i+1].yysjxs + "</span><span class=\"ksbh\" style=\"color:white;\">" + Data.retbody[i+1].yysj00 + "</span></div></td>"
											+"<td><div class=\"models\" onclick=\"clickKeshi(this)\"> <span class=\"ksWz\" style=\"color:white;\">" + Data.retbody[i+2].yysjxs + "</span><span class=\"ksbh\" style=\"color:white;\">" + Data.retbody[i+2].yysj00 + "</span></div></td>"
											+"</tr>");
								} else if (i + 1 < length) {
									$("#info_t").append(
											"<tr>"
											+"<td><div class=\"models\" onclick=\"clickKeshi(this)\"> <span class=\"ksWz\" style=\"color:white;\">" + Data.retbody[i].yysjxs + "</span><span class=\"ksbh\" style=\"color:white;\">" + Data.retbody[i].yysj00 + "</span></div></td>"
											+"<td><div class=\"models\" onclick=\"clickKeshi(this)\"> <span class=\"ksWz\" style=\"color:white;\">" + Data.retbody[i+1].yysjxs + "</span><span class=\"ksbh\" style=\"color:white;\">" + Data.retbody[i+1].yysj00 + "</span></div></td>"
											+"</tr>");
								} else if (i < length) {
									$("#info_t").append(
											"<tr>"
											+"<td><div class=\"models\" onclick=\"clickKeshi(this)\"> <span class=\"ksWz\" style=\"color:white;\">" + Data.retbody[i].yysjxs + "</span><span class=\"ksbh\" style=\"color:white;\">" + Data.retbody[i].yysj00 + "</span></div></td>"
											+"</tr>");
								}
							}
							page = new Page(4, "keshi_t", "info_t");
							$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
							$(".models").bind("click dbclick", function(){
								clickKeshi(this);
							});
					} else {
						$("#tip_div").show();
						$("#error").text(Data.retmsg);			
					}
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
				$(this).parent().prev().addClass("chooseType");//置灰
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
		$("#waiting").show();
		//setTimeout("getGhtime();",500);
		getGhtime();
		$("#chooseKb").val($.session.get('kebie'));
		$("#chooseKs").val($.session.get('keshi'));
		$("#chooseNoon").val($.session.get('noon'));
		$("#chooseDoc").val($.session.get('doctor'));
		
		
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghdoctor2.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		
		$("#cusName").text(window.parent.xming0);
		$("#cusCardNo").text(window.parent.cardNo);
		$("#cusBalance").text(window.parent.yjjye0);
		initStyle();
	}
	init();	
</script>
</html>