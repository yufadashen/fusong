<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>输入充值金额</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
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
	margin:0px;
	background: url(../../images/yue/yhkcz_select_je.jpg) no-repeat;
}
div{
	position: absolute;
	text-align: center;
}
img[name=numKey]{
	margin-top:4px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
  <div id="money"  style="z-index:1000; width:272px; position:absolute;top:248px;left:620px;background-color: black;">
    <img src="../../images/kb2/1.png" res_img="../../../images/kb/1_1.png" value="1" name="numKey" /> 
    <img src="../../images/kb2/2.png" res_img="../../..images/kb/2_1.png" value="2" name="numKey" /> 
    <img src="../../images/kb2/3.png" res_img="../../../images/kb/3_1.png" value="3"  name="numKey"/> 
    <img src="../../images/kb2/delete.png"res_img="../../../images/kb/10_1.png" value="10"  id="modify" style="margin-top:4px;"/><br> 
     
    <img src="../../images/kb2/4.png" res_img="../../../images/kb/4_1.png" value="4"name="numKey"  /> 
    <img src="../../images/kb2/5.png" res_img="../../../images/kb/5_1.png" value="5" name="numKey" /> 
    <img src="../../images/kb2/6.png"res_img="../../../images/kb/6_1.png" value="6"name="numKey" /> 
    <img src="../../images/kb2/reinput.png"res_img="../../../images/kb/10_1.png" value="10" id="reinput" style="margin-top:4px;"/> <br>
    
    <img src="../../images/kb2/7.png"res_img="../../../images/kb/7_1.png" value="7"name="numKey" /> 
    <img src="../../images/kb2/8.png"res_img="../../../images/kb/8_1.png" value="8" name="numKey" /> 
    <img src="../../images/kb2/9.png"res_img="../../../images/kb/9_1.png" value="9"name="numKey"/> 
    <img src="../../images/kb2/close.png"res_img="../../../images/kb/10_1.png" value="10"  id="close"style="margin-top:4px;"/> <br>
    
    <img src="../../images/kb2/0.png" res_img="../../../images/kb/0_1.png" value="0"name="numKey" style="width:122px;height:53px;"/> 
    <img src="../../images/kb2/sure.png" res_img="../../../images/kb/11_1.png" value="11" id="sure" style="width:146px;height:53px;margin-top:4px;" />
  </div>
	
	
	<div id="name" style="margin:130px 0px 0px 262px;font-size:33px;color:red;"></div>
	<div id="ynye" style="margin:133px 0px 0px 642px;font-size:33px;color:red;"></div>
	<div style="margin:207px 0px 0px 402px;font-size:33px;">
		<input id="czje" value="" style="letter-spacing:4px; width:200px;height:35px;background-color:#28FF28;">
	</div>
	<div id="openkb" style="margin:214px 0px 0px 634px;height: 30px;width: 43px;"></div>
	<div id="qrcz" style="margin:213px 0px 0px 702px;height: 32px;width: 119px;"></div>
	
	<div id="wsy" style="margin:279px 0px 0px 201px;height:76px;width:192px;"></div>
	<div id="yby" style="margin:279px 0px 0px 416px;height:76px;width:192px;"></div>
	<div id="eby" style="margin:279px 0px 0px 631px;height:76px;width:192px;"></div>
	
	<div id="sby" style="margin:389px 0px 0px 201px;height:76px;width:192px;"></div>
	<div id="wby" style="margin:389px 0px 0px 416px;height:76px;width:192px;"></div>
	<div id="yqy" style="margin:389px 0px 0px 631px;height:76px;width:192px;"></div>
	
	
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;"> </div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;"> </div>
	<div id="tip_div"  style="margin:229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
</body>
<script type="text/javascript">
	var log = window.parent.Logger;
    var sfkcz = 0;//TODO
	function goNext(){
		window.location.href = "xryhk.jsp";
		if(sfkcz == 1){//是否可充值
			$.session.set("czje",$("#czje").val());
			window.location.href = "xryhk.jsp";
		}else{
			message("该时间段不可充值！请咨询工作人员！");
		}
	}
 	//判断充值时间，判断本机当前是否可充值
	function checkCzTime (){
		 var datas = {"funcid":"M07.02.03.01",								 
				      "optype":"0",
				      "czlb00":"2"};//银行卡充值
			$.ajax({
				async:true,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				url:"http://188.188.28.81:7001/lyrmzzjserver/controlAction.do?method=ApplyAction",
				success:function(json){
					var Data = eval(json);
					//如果设备状态正常
					if(Data.retcode=="0"){
						//log.WriteLog("设备状态正常");
						//如果出参为1，代表可充值
				    	// log.WriteLog("银行卡充值：充值时间判断=="+Data.retbody[0].sfkcz0);
					     if(Data.retbody[0].sfkcz0=="1"){
					    	 sfkcz = 1;
						 }else{
							 //sfkcz = 1;
							log.WriteLog("设备状态正常，但不可充值");
							message("该时间段不可进行银行卡充值！");
						 }
					}else{
						log.WriteLog("设备状态异常");
						message(Data.retmsg);							
					}
					$("#waiting").hide();
				},
				error:function(){
					message("系统异常,请稍后再试!");						
				}
			});		
	}
	function initialize	(){
		$("#name").text(window.parent.xming0);//姓名
		$("#ynye").text(window.parent.yjjye0);//余额
		
		$("#openkb").bind("click dbclick", function() {//打开 关闭键盘
			var a = $("#money")[0].style.display;
			if(a == "none"){
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
		});
		$("#qrcz").bind("click dbclick", function() {//确认充值
			if($("#czje").val()){
				goNext();
			}
		});
		$("#wsy").bind("click dbclick", function() {//50元点击事件
			$("#czje").val("50");
			goNext();	
		});
		$("#yby").bind("click dbclick", function() {//100
			$("#czje").val("100");
			goNext();
		});
		$("#eby").bind("click dbclick", function() {//200
			$("#czje").val("200");
			goNext();
		});
		$("#sby").bind("click dbclick", function() {//300
			$("#czje").val("300");
			goNext();
		});
		$("#wby").bind("click dbclick", function() {//500
			$("#czje").val("500");
			goNext();
		});
		$("#yqy").bind("click dbclick", function() {//1000
			$("#czje").val("1000");
			goNext();
		});
		
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			window.location.href = "lypayway.jsp";
		});
	}
	
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
	
	function message(message) { //提示信息
		if($("#waiting")){
			$("#waiting").hide();
		}
		$("#tip_div").show();
		$("#error").text(message);
		$("#tip_s").off().on("click", function() {
			$("#tip_div").hide();
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		return;
	}
	/**
	*初始化操作
	**/
	var init = function(){
		checkCzTime();
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	/***
	***  键盘事件
	***/
	 $('img[name="numKey"]').on("click", function() {
		    var valStr = $("#czje").val();
		    if (valStr == "" || valStr == 0) {
		      $("#czje").val($(this).attr("value"));
		    } else {
		      $("#czje").val(valStr + $(this).attr("value"));
		      if (valStr.length > 3) {
		        $("#czje").val(valStr);
		      }
		      if(parseInt($("#czje").val())>2000){
		    	  $("#czje").val(2000);
		      }
		    }
	  });
	   //删除
	  $("#modify").on("click", function() {
		    var num = $("#czje").val();
		    var newstr = num.substring(0, num.length - 1);
		    $("#czje").val(newstr);
	  });
	   //重填
	  $("#reinput").on("click", function() {
		    $("#czje").val("");
	  });
	  //关闭
	  $("#close").bind("click dbclick", function() {
		    var a = $("#money")[0].style.display;
			if(a == "none"){
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
	  });
	  //确认
	  $("#sure").bind("click dbclick", function() {
		  if($("#czje").val()){
			  goNext();
		  }
	  });
	  init();
</script>
</html>