<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>预约科室</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<script src="${pageContext.request.contextPath}/js/pageOper.js"></script>
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
	behavior:url(../../js/PIE.htc);
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
	margin-top:0px;
	line-height:60px;
}
#showArea{
	/* border:1px black solid;  */
	border-radius:10px; 
	width:995px;
	height:570px;
	margin-left:11px;
	margin-top:20px;
	behavior:url(../../js/PIE.htc);
}
td{
	padding:3px;
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
.theads{
	height:35px;
	border:1px solid #3f7dac;
	font-size:25px;
	text-align:center;
	color: white;
}
.tb_tr{
	height:35px;
	border:1px solid #3f7dac;
	margin:10px;
}
.tb_td{
	border:1px solid #3f7dac;
	font-size:20px;
	text-align:center;
	height:35px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">预约取号</font>
	</div>
	<div id="showArea">
		<div style="width: 995px;height: 414px;">
			<table id="keshi_t" style="width:960px;margin-top:60px;margin-left:20px;">
				<tr style="width:100%; background-color:#3f7dac;border:1px solid black;">
					<td class="theads" style="width:6%;">序号</td>
					<td class="theads" style="width:15%;">预约日期</td>
					<td class="theads" style="width:30%;">预约科室</td>
					<td class="theads" style="width:15%;">预约医生</td>
					<td class="theads" style="width:15%;">预约时间</td>
					<td class="theads" style="width:15%;">操作</td>
				</tr>
				<tbody id="info_t" >
				</tbody>
			</table>
		</div>
			
	    <table style="margin-top:20px;margin-left: 149px;">
			<tfoot>
				<tr>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.prePage($('#confirmBtn'))">上一页</div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px; text-align:center;">
						<div id="confirmBtn"></div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.nextPage($('#confirmBtn'))">下一页</div>
					</td>
				</tr>
			</tfoot>
		</table>
		
	</div>
	
	<div id="bottomArea">
		
		<span style="margin-left:660px;">
			<img id="btnMain" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</span>
		<span style="margin-left:40px;">
			<img id="btnReturn" style="margin-top:4px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
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
	//获取预约信息
	function getAppInfo() {
		var datas = {
			"funcid" : "M07.02.04.08",
			"cxdm00" : window.parent.cardNo//患者卡号
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
					$("#waiting").hide();					
					var Data = eval(json);
					if (Data.retcode == "0") {
						var length = Data.retbody.length;
						$("#info_t").empty();
						for (var i = 0; i < length; i++) {
							$("#info_t").append(
									"<tr class=\"tb_tr\">"
									+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
									+ "<td class=\"tb_td\">"+Data.retbody[i].yyrq00+"</td>"
									+ "<td class=\"tb_td\">"+Data.retbody[i].mzksmc+"</td>"
									+ "<td class=\"tb_td\">"+Data.retbody[i].mzysxm+"</td>"
									+ "<td class=\"tb_td\">"+Data.retbody[i].yysj00+"</td>"//预约时间
									
									+ "<td style=\"display:none;\">"+Data.retbody[i].yylsh0+"</td>"//预约号码
									+ "<td style=\"display:none;\">"+Data.retbody[i].ksbh00+"</td>"//his科室编号
									+ "<td style=\"display:none;\">"+Data.retbody[i].ysbh00+"</td>"//his医生编号
									+ "<td style=\"display:none;\">"+Data.retbody[i].mzksbh+"</td>"//泛喜科室编号
									
									+ "<td>"
										+ "<img src=\"../../images/yue/yyqh.jpg\" onclick='qhOperation(this)'></img>"
									+ "</td>"
									+ "</tr>");
						}
						page = new Page(8, "keshi_t", "info_t");
						$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
					} else {
						$.session.set("errormsg",Data.retmsg);
						window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
					}
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");		
			}
		}); 
	}	
	
	
	//取号操作
	var flag = false;
	function qhOperation(obj){
		//卡内余额判断是请求结果判断，还是有个标准确定，或是根据挂号费判断  TODO  确定是否需要充值  cztype 赋值  以充完值之后跳转回来
		var tds = obj.parentElement.parentElement.children;//所有td节点
		var yyrq = tds[1].innerText;//预约日期
		var ksmc = tds[2].innerText;//科室名称
		var ysxm = tds[3].innerText;//医师姓名
		var yylsh0 = tds[5].innerText;//预约号码
		var ysbh00 = tds[7].innerText;//挂号专家代码
		var mzksbh = tds[8].innerText;//挂号专家代码
		var ksbh00 = tds[6].innerText;//挂号科室代码
		//var brid00 = userInfo.brid00;//病人ID
		var brid00 = window.parent.brid00;//病人ID
		var yysj00 = tds[4].innerText;//预约时间
		var mits= yysj00.substr(0,2);
		var ses = yysj00.substr(2,2);
		yysj00 = mits+"点" + ses +"分";
		var datas = {
				"funcid" : "M07.02.04.10",
				"cxdm00" : window.parent.cardNo,//患者卡号
				"cxfs00" : window.parent.cardType,//卡类别 0:无卡,1:磁卡,2:保障卡,3:ic卡
				"yylsh0" : yylsh0,//预约号码
				"zdbh00" : window.parent.cardNo,//终端编号
				"ysbh00" : ysbh00,//挂号专家代码
				"ksbh00" : ksbh00,//挂号科室代码
				"brid00" : brid00,//病人ID
				"yysj00" : yysj00//预约时间
				
			/* 	
				"funcid" : "M07.02.04.01",
				"ghyylx" : "G",
				"pbbz00" : "",
				"fssj00" : fssj00,
				"ksczrq" : ksczrq,
				"jsczrq" : jsczrq
			 */	
		};
		if(!flag){
			flag = true;
				$.ajax({
					async : false,
					type : "post",
					data : datas,
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					url : window.parent.serverUrl + "?method=ApplyAction",
					//url:"${pageContext.request.contextPath}/Test/test.do",
					success : function(json) {
						$("#waiting").hide();
						//$.getJSON("../mzgh/yyqh.json",function(json){//测试数据
							var Data = eval(json);
							if (Data.retcode == "0") {
								//取号验证操作   扣费操作完成   打印凭条、预约取号成功 ； 扣费失败余额不足：您的预交金金额不足，请先充值
								var jzxh00 = Data.retbody[0].pdxh00;//就诊序号（排队序号）
								var pjh000 = Data.retbody[0].pjh000;//票据号
								var jzwz00 = Data.retbody[0].jzwz00;//就诊位置
								$("#tip_div").show();
								$("#error").text("取号成功，请取走凭条！");	
								//setTimeout("getAppInfo()",5000);//刷新列表
								//打印小票  TODO
								print(yyrq,yysj00,ksmc,ysxm,jzxh00,jzwz00);
								window.location.href = "yyqhsuccess.jsp";
							} else {
								$.session.set("errormsg",Data.retmsg);
								window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
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
	}
	//首先判断是否需要个人信息补录
	function privateInfoRecord(){
		//身份证号码 和手机号码 如果有一个为空就提示补录
		var phoneNo = window.parent.lxdh00;//联系电话
		var idCard = window.parent.sfzhao;//身份证号
		if (!phoneNo || !idCard){//有一个为空
			window.location.href = "privateInfoRebuild.jsp";
			$("#waiting").show();
		}
	}
	//打印的挂号小票
	function print(yyrq,yysj,yyks,yyys,jzxh,jzwz00){
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
        var currTime = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      临沂市人民医院自助预约取号凭条");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      —————————————————————");
		printer.WriteTextLineX("      就诊卡号:"+window.parent.cardNo);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      姓名："+window.parent.xming0+"  性别: "+window.parent.xbie00);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      预约日期："+yyrq);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      预约时间："+yysj);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      预约科室:"+yyks);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      预约医生:"+yyys);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      就诊位置："+jzwz00);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);
		printer.WriteTextLineX("      就诊序号:"+jzxh);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      *请尽快到候诊区候诊，避免过号！");
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
		printer.CeTCutX(); 								//切纸
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		privateInfoRecord();//如果信息不完善，补录个人信息
		setTimeout("getAppInfo();",500);//获取预约信息
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyoperation.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();
</script>
</html>