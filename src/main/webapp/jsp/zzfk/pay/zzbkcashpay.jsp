<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>现金充值</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	background: url(../../../images/yue/dlg_bg_ynzhcz.png) no-repeat;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no" >
	<div id="time" style="position:absolute;top:565px;left:500px;font-size:60px;color: #FF0000;"></div>
	
	<div id="name" style="margin:68px 0px 0px 376px;font-size:33px;color:red;"></div>
	<div id="ynye" style="margin:120px 0px 0px 376px;font-size:33px;color:red;"></div>
	<div id="bcczje" style="margin:173px 0px 0px 490px;font-size:33px;color:red;"></div>
	
	<div id="sure" style="margin:457px 0px 0px 559px;font-size:33px;color:red;"><img src="../../../images/yue/jscz_cash.png"></div>
	
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:701px 0px 0px 674px;"></div>
	<div id="backPage" style="width: 149px;height: 50px;margin:701px 0px 0px 843px;"></div>
	
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:255px;">
        <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
          <span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
        </div>
     	<img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" width="90" height="43" style="position:relative;top:125px;left:1px" />
    </div>
    
	<div id="waiting"  style="margin: 229px 0px 0px 31px;display:none;z-index:1000;width:576px;height:321px;background-image:url('../../../images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>
<script type="text/javascript">
		var hjlsh;
	 	returnTime();
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
		
		//定义
		var log = window.parent.Logger;
		var tmp = window.parent.CashBV;
		var bStop =true;		
 		var sumvalue=0;//总金额		
		var moneyNum = 0;
 		var value=0; //单笔金额
 		var yjjye0 = window.parent.yjjye0;//院内账户余额
 		var cardNo=window.parent.cardNo;//就诊卡号
 		var dblsh0;//单笔流水号
 		var jylsh0="";//交易流水号
 		var cshsj0;//初始化时间
 		var cztype=window.parent.cztype;//1.正常充值  2.结算时金额不足充值   3.挂号时挂号费不足充值 4取号时费用不足充值5自助发卡时充值
		
		//开始识币
		function StartIdentify() {
			//返回值: 0 == 成功，其他 == 失败
			var ret2 = tmp.Enable();
			if(ret2!=0){
				alert("初始化钞箱失败！请联系管理员或更换其他充值方式,谢谢配合!");
				log.WriteLog("自助发卡  钞箱初始化失败！");
				$.session.clear();
				window.location.href = "../../lypayway.jsp";
				return;
			}
		  	singleop();
 		}
 		 
				//停止识币
			  function Stop(){
				tmp.Disable();
			  	//bStop = true;
			  	//log.WriteLog("停止识币");
			  }
				
		//单笔充值
		function singleop(){
			/* value="5";
			//log.WriteLog("卡号:"+cardNo+"本次收到纸币"+value);
				sumvalue+=value;
				moneyNum++;//人民币总张数
				//log.WriteLog("卡号:"+cardNo+"共收到纸币"+sumvalue);	
				$("#bcczje").text(sumvalue);
				//现金充值初始化
				cashpayInit();
				signInit(); */
				
			var ret = tmp.GetStatus();
			if(ret.substr(0,2)==13){//识别成功
				$("#waiting").show();
				var ret = tmp.BillStack();//压钞
				value=parseInt(ret);
				log.WriteLog("识币成功，卡号："+cardNo+"  本次收到纸币"+value);
				if(value!=0){
					sumvalue+=value;
					moneyNum++;//人民币总张数
					//log.WriteLog("卡号:"+cardNo+"共收到纸币"+sumvalue);	
					$("#bcczje").text(sumvalue);
					//现金充值初始化
					cashpayInit();
					signInit();
				}
			}else{
				setTimeout(function(){
					singleop();
				},1000);
			} 
				
		}
 
		//现金充值初始化
		function cashpayInit(){
			log.WriteLog("自助发卡  卡号:"+$.session.get("zzbkCardNo")+"开始现金充值初始化");	
			 var datas = {"funcid":"M07.02.03.04",
			 			  "dzjec0":value,
			 			  "czje00":value,
					      "ycmklx":"2",//验钞模块
					      "zzs000":moneyNum,//总张数
					      "jylsh0":jylsh0,
					      "cxfs00":"01",
					      "cxdm00":$.session.get("zzbkCardNo"),
					      "czqx00":"1",//充值去向 1位院内预交金
					      "brid00":window.parent.brid00};
				$.ajax({
					async:false,
					type:"post",
					data:datas,
					dataType:"json", 
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					url:window.parent.serverUrl+"?method=ApplyAction",
					success:function(json){
						var Data = eval(json);
						if(Data.retcode=="0"){
							dblsh0=Data.retbody[0].dblsh0;
							jylsh0=Data.retbody[0].jylsh0;
							$.session.set("dblsh0", dblsh0);
							$.session.set("jylsh0", jylsh0);
							
							cshsj0=Data.retbody[0].cshsj0;
							log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"现金充值初始化成功");
							cashpaySucc();//单笔充值成功
						}else{
							message.text(Data.retmsg);
							cashpayFail();//单笔充值失败！
						}
					},
					error:function(){
						log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"现金充值初始化失败");
						message("系统异常,请稍后再试!");
					}
				});		
		} 
		
		
		 //单笔充值成功
		function cashpaySucc(){
			log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔充值开始");
			 var datas = {"funcid":"M07.02.03.05",								 				      
					      "cxfs00":"01",
					      "cxdm00":$.session.get("zzbkCardNo"),
					      "jylsh0":jylsh0,
					      "dblsh0":dblsh0,
					      "czje00":value,
					      "ycmklx":"2"};
				$.ajax({
					async:false,
					type:"post",
					data:datas,
					dataType:"json",
					contentType: "application/x-www-form-urlencoded; charset=utf-8", 
					url:window.parent.serverUrl+"?method=ApplyAction",
					success:function(json){
							var Data = eval(json);
							if(Data.retcode=="0"){
								log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔充值成功");
								cashpayEnd();
							}else{
								log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔充值失败");
								message(Data.retmsg);								
							}
					},
					error:function(){
						log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔系统异常");
						//log.WriteLog("卡号:"+cardNo+"现金充值单笔充值失败");
						message("系统异常,请稍后再试!");						
					}
				});		
		} 
		//单笔充值失败
		 function cashpayFail(){
			 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔失败开始 ！");
			 var datas = {"funcid":"M07.02.03.06",								 				      
				      "cxfs00":"01",
				      "cxdm00":$.session.get("zzbkCardNo"),
				      "jylsh0":jylsh0,
				      "dblsh0":dblsh0,
				      //"czje00":value,
				      "ycmklx":"2"};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				success:function(json){
						var Data = eval(json);
						if(Data.retcode=="0"){
							 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔失败！ 000");
							
						}else{
							 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔失败！ -1");
							message(Data.retmsg);
						}
				},
				error:function(){
					 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"单笔失败！系统异常！");
					message("系统异常,请稍后再试!");						
				}
			});		
		 }
		 
		 
		 
		//结束充值 弹出充值成功界面
		function cashpayEnd(){
			 $("#waiting").show();
			 Stop();
			 window.parent.money=sumvalue;
			 if(sumvalue == 0){
				 window.location.href = "zzbkcashfail.jsp";
				 return;
			 }
			 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"结束充值，本次充值："+sumvalue);
			 var datas = {"funcid":"M07.02.03.07",	
						  "zdbh00":window.parent.zdbh00,
						  "jylsh0":jylsh0,
						  "czje00":sumvalue,
						  "brid00":"",
						  "dblsh0":dblsh0,
					      "yjjxh0":"",
					      "czlb00":"1",//现金
					      "cxdm00":$.session.get("zzbkCardNo"),
					      "ywlx00":"2",//办卡
					      "cxfs00":"02",
					      "sfzhao":$.session.get("zzbkIdCard"),
					      //
					      "khyh00":"",
					      "zphm00":"",
					      "zpzh00":"",
					      "poslsh":"",
					      "zxlsh0":"",
					      "yhkhao":"",
					      "poslsht":"",
					      "zxlsht":"",
					      "yhkht0":"",
					      "poszdh":"",
					      "shhao0":"",
					      "sfjyh0":"",
					      "jyh000":"",
					      "czybh0":"",//操作员，后台已给
					      "dybz00":"0",//调用标志 0正常调用,1收费时使用银联卡调用，传0，后台已给
					      "dbzhxh":"0",//代币卡账户序号，传“0”，后台已给
					      "hcxh00":"0",//红冲序号，"0"，后台已给
					      "czlx00":"0"//操作类别(0：预交金收 1：预交金红冲)，后台已给
					      };
				$.ajax({
					async:false,
					type:"post",
					data:datas,
					dataType:"json",
					contentType: "application/x-www-form-urlencoded; charset=utf-8", 
					url:window.parent.serverUrl+"?method=ApplyAction",
					success:function(json){
							var Data = eval(json);
							if(Data.retcode=="0"){
								 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"充值成功！，本次充值："+sumvalue);
								window.parent.yjjye0 = Data.retbody[0].yjjye0;//预交金余额
								window.parent.money = Data.retbody[0].czje00;//本次充值金额
								var  xtgzh0 = Data.retbody[0].xtgzh0;//系统跟踪号
								var cgjysj = Data.retbody[0].cgjysj;//成功交易时间
								$.session.set("xtgzh0",xtgzh0);
								$.session.set("zzbkStatus","2");
								window.location.href = "../zzbkresulttemp.jsp";//制卡
							}else{
								 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"充值失败！，本次充值："+sumvalue);
								message(Data.retmsg);		
								print2();
							}
					},
					error:function(){
						 log.WriteLog("卡号:"+$.session.get("zzbkCardNo")+"充值系统异常！，本次充值："+sumvalue);
						message("系统异常,请稍后再试!");						
					}
				});		
		} 
		//建档初始化
 		function signInit(){
 			var datas={
 					"funcid":"M07.02.02.03",
 					"cxdm00":$.session.get("zzbkCardNo"),
 					"csrq00":$.session.get("zzbkBirth"),
 					"cxfs00":"1",
 					"czje00":sumvalue,
 					"xming0":$.session.get("zzbkName"),
 					"xbie00":$.session.get("zzbkSex")=="男"?"0":"1",
 					"xbiemc":$.session.get("zzbkSex"),
 					"lxdz00":$.session.get("zzbkAddr"),
 					"zflxbh":"1",
 					"sfzhao":$.session.get("zzbkIdCard"),
 					"lxdh00":$.session.get("zzbkPhone")
 			};
 			
 			log.WriteLog("建档初始化！==" + $.session.get("zzbkName") + $.session.get("zzbkCardNo"));
 			$.ajax({
 				async : false,
 				type : "post",
 				data : datas,
 				dataType : "json",
 				contentType : "application/x-www-form-urlencoded; charset=utf-8",
 				url : window.parent.serverUrl + "?method=ApplyAction",
 				success : function(json) {
 				
 					var Data = eval(json);
 					if (Data.retcode == "0") {
 						var jylsh01 = Data.retbody[0].jylsh0;//交易流水号
 						var jdlsh01 = Data.retbody[0].jdlsh0;//建档流水号
 						//$.session.set("jylsh0", jylsh01);
 						$.session.set("zzbkjdlsh0", jdlsh01);
 					}else{
 						$("#tip_div").show();
 						$("#error").text(Data.retmsg);
 					}
 				},
 				error : function() {
 					$("#tip_div").show();
 					$("#error").text("系统异常,请稍后再试!");
 				}
 			}); 
 		}
		//打印
		function print2() {
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
	        if(!cshsj0){
	        	cshsj0 = currTime;
	        }
			var printer=window.parent.KPrinter;
			printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
			printer.SetTextModeX(1);				//设置中文模式
			printer.WriteTextLineX("            临沂人民医院自助服务终端系统");
			printer.SetTextModeX(0);
			printer.WriteTextLineX("      抱歉，由于某些原因");
			printer.WriteTextLineX("      造成用户  "+$.session.get("zzbkName")+"  在 "+ currTime +" 时所充值的 "+ sumvalue +"元  无法及时提交服务器，特此证明。");
			printer.WriteTextLineX("      若此后您所充值的金额未能及时到账，请手持本凭条到收费窗口人工核对充值信息。");
			printer.WriteTextLineX("      卡           号:"+$.session.get("zzbkCardNo"));
			printer.WriteTextLineX("      合计流水号："+jylsh0);
			printer.WriteTextLineX("      自 助 编 号:"+window.parent.zdbh00);
			printer.WriteTextLineX("      充值时间："+cshsj0);
			printer.WriteTextLineX("      造成您的不便深感抱歉！");
			printer.LFX(2);
			printer.CeTCutX(); //切纸
		}
		function message(msg){
			$("#waiting").hide();
			$("#tip_div").show();
			$("#error").text(msg);		
		}
		var init = function(){
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
			});
			$("#name").text($.session.get("zzbkName"));
			$("#ynye").text("");
			$("#bcczje").text(sumvalue);//本次充值金额
			$.session.set("Byjje",yjjye0);
			$("#sure").bind("click dbclick", function() {//结束充值按钮
				cashpayEnd();
			});
			StartIdentify();
		}	
		init();
	 </script>
</html>