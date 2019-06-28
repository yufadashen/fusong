<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>身份证办卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
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
	background: url("../../images/yue/zzfk_grjbxx.jpg") no-repeat;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
  <div id="money"  style="z-index:1000; width:272px; position:absolute;top:475px;left:685px;">
    <img src="../../images/kb2/1.png"  value="1" name="numKey" /> 
    <img src="../../images/kb2/2.png"  value="2" name="numKey" /> 
    <img src="../../images/kb2/3.png" value="3"  name="numKey"/> 
    <img src="../../images/kb2/delete.png" value="10"  id="modify" style="margin-top:4px;"/><br> 
     
    <img src="../../images/kb2/4.png"  value="4"name="numKey"  /> 
    <img src="../../images/kb2/5.png"  value="5" name="numKey" /> 
    <img src="../../images/kb2/6.png" value="6"name="numKey" /> 
    <img src="../../images/kb2/reinput.png" value="10" id="reinput" style="margin-top:4px;"/> <br>
    
    <img src="../../images/kb2/7.png" value="7"name="numKey" /> 
    <img src="../../images/kb2/8.png" value="8" name="numKey" /> 
    <img src="../../images/kb2/9.png" value="9"name="numKey"/> 
    <img src="../../images/kb2/close.png" value="10"  id="close"style="margin-top:4px;"/> <br>
    
    <img src="../../images/kb2/0.png" value="0"name="numKey" style="width:122px;height:53px;"/> 
    <img src="../../images/kb2/sure.png" value="11" id="sure" style="width:146px;height:53px;margin-top:4px;" />
  </div>
	
	
	
	<div id="userName" style="font-size:33px;width:283px;height:40px;margin:228px 0px 0px 421px;">李小腾</div>
	<div id="userSex" style="font-size:33px;width:283px;height:40px;margin:289px 0px 0px 421px;">男</div>
	<div id="userCardNo" style="font-size:33px;width:335px;height:40px;margin:359px 0px 0px 421px;">410123456151666576</div>
	<div id="userAge" style="font-size:33px;width:283px;height:40px;margin:419px 0px 0px 421px;">26</div>
	<div id="" style="font-size:33px;margin:479px 0px 0px 421px;">
		<input id="userPhone" value="" maxlength="11" style="width:210px;height:35px;background-color:#28FF28;">
	</div>
	<div id="openkb" style="width:41px;height:29px;margin:479px 0px 0px 637px;"></div>
	
	<div id="confirmBtn" style="width:238px;height:56px;margin:599px 0px 0px 397px;"></div>
	
	<div id="btnMain" style="width:149px;height:51px;margin:708px 0px 0px 682px;"></div>
	<div id="btnReturn" style="width:149px;height:51px;margin:708px 0px 0px 851px;"></div>
	<div id="waiting"  style="margin: 212px 0px 0px  0px;display:none;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
	 <img src="${pageContext.request.contextPath}/images/waiting.gif" >
   </div>
	<div id="tip_div"  style="margin:229px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:266px" />
   </div> 
</body>
<script type="text/javascript">
var cardPrint = window.parent.cardPrint;
var logger = window.parent.Logger;
var idCarder = window.parent.idCarder;
var signFlag = false;

	//发卡机读卡，获取卡号，根据卡号判断是否建档
	function readCardAndGetYes(){
		var ret = cardPrint.InitPrinter();
		if(window.parent.cardPrintFlag == "n"){//新设备的打印机为虚拟串口11
			cardPrint.InitCardReader(11,115200);
		}else{
			cardPrint.InitCardReader(6,115200);
		}
		logger.WriteLog("cardPrinter InitPrinter()=="+(ret==0?"成功":"失败"));
		if(ret == 0){
			cardPrint.M1_Read(4);//
			var cardNo = cardPrint.M1_ReadFixedLen_Hex(4,9);//读取卡号
			if(!cardNo || cardNo.length != 9){
				$.session.set("errormsg","卡号读取出错！");
				window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				return;
			}else{
				//var cardNo = "001842816";
				cardPrint.UnInitCardReader();//关闭读卡
				$.session.set("zzbkCardNo",cardNo);
				logger.WriteLog(" cardPrint.M1_Read(4) =="+ cardNo);
				logger.WriteLog("funcid ：M07.02.02.11  判断卡号："+ cardNo+"是否建档！");
				signFlag = false;
				$.ajax({
					async : false,
					type : "post",
					data : {"funcid":"M07.02.02.11","cxdm00":cardNo,"cxfs00":"1"},
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					url : window.parent.serverUrl + "?method=ApplyAction",
					success : function(json) {
						var Data = eval(json);
						if (Data.retcode == "0") {
							logger.WriteLog("该卡["+cardNo+"]未建档");
							signFlag = true;
						}else{
							logger.WriteLog("该卡["+cardNo+"]已经建档");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);
						}
					},
					error : function() {
						logger.WriteLog("该卡"+cardNo+"判断该卡是否建档失败！");
						$("#tip_div").show();
						$("#error").text("系统异常,请稍后再试!");
					}
				}); 
			}
		}else{
			//初始化证卡打印机失败
			$("#tip_div").show();
			$("#error").text("证卡打印机初始化失败，请联系相关人员!");		
			setTimeout(function(){
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			},3000);
		}
	}
	

	function putIdCard (){
		//idCarder.OpenDeviceAndReadCard(4,10000);
		$("#userName").text($.session.get("zzbkName"));
		$("#userSex").text($.session.get("zzbkSex"));
		$("#userCardNo").text($.session.get("zzbkIdCard"));
		$("#userAge").text($.session.get("zzbkAge"));
		
		/*$("#userName").text(idCarder.GetCardInfo(0));
		$("#userSex").text(idCarder.GetCardInfo(1));
		$("#userCardNo").text(idCarder.GetCardInfo(5));
		$("#userAge").text(getAge(idCarder.GetCardInfo(3)));
		
		$.session.set("zzbkName",idCarder.GetCardInfo(0));
		$.session.set("zzbkSex",idCarder.GetCardInfo(1));
		$.session.set("zzbkIdCard",idCarder.GetCardInfo(5));
		$.session.set("zzbkAge",getAge(idCarder.GetCardInfo(3)));
		$.session.set("zzbkBirth",idCarder.GetCardInfo(3));
		$.session.set("zzbkAddr",idCarder.GetCardInfo(4));
		logger.WriteLog("打开身份证阅读器成功:"+idCarder.GetCardInfo(0) +"  "+idCarder.GetCardInfo(1) +"  "+idCarder.GetCardInfo(5) +"  "+idCarder.GetCardInfo(3) +"  ");*/
	}
	function getAge(birthday) {
	    //出生时间 毫秒
	    var birthDayTime = new Date(birthday.substr(0, 4),birthday.substr(4, 2),birthday.substr(6, 2)).getTime(); 
	    //当前时间 毫秒
	    var nowTime = new Date().getTime(); 
	    //一年毫秒数(365 * 86400000 = 31536000000)
	    return Math.floor((nowTime-birthDayTime)/31536000000);
	}

	function initialize	(){
		
		$("#btnMain").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#confirmBtn").bind("click dbclick", function() {//确认办卡
			  $("#money").css("display","none");
			  $("#waiting").show();
			  checkstatusfk();
			  $("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#openkb").bind("click dbclick", function() {//打开 关闭键盘
			var a = $("#money")[0].style.display;
			if(a == "none"){
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
		});
	}
	
	//初始化倒计时时间：120秒
	var time = 30;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 30;
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
		
		//checkstatusfk();//证卡打印机状态检查
		//readCardAndGetYes();
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		putIdCard();
		
	}
	/***
	***  证卡打印机状态检查
	***/
	function checkstatusfk(){
		$("#waiting").show();
		var ret = cardPrint.InitPrinter();
		var reg = /^1[3|4|5|6|7|8|9][0-9]{9}$/; //验证规则
		cardPrint.AsynMoveCard(3);
		var intel = setInterval(function(){
			if(cardPrint.moveCardRet !=	0 ){
				ret = cardPrint.GetPrinterStatus();
				clearInterval(intel);
				//$("#waiting").hide();
				if(ret==0){
					logger.WriteLog("证卡打印机状态正常："+ret);
						readCardAndGetYes();
						if(signFlag){ //判断该卡是否建档
						  if(reg.test($("#userPhone").val())){//手机号码校验下
							  $.session.set("zzbkPhone",$("#userPhone").val());
								//跳转支付页面
								window.location.href = "zzbkzffs.jsp";
								$("#waiting").show();
							  }else{
								  $("#waiting").hide();
								  $("#tip_div").show();
								  $("#error").text("电话号码输入错误，请输入正确电话号码!");
								  //$.session.set("errormsg","电话号码输入错误,请输入正确电话号码!");
								  //window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
							  }
						  }else{
						  $.session.set("errormsg","抱歉，当前办卡卡号重复,请联系自助机引导员，谢谢您的配合。");
						  window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
						  //$("#tip_div").show();
						  //$("#error").text("当前办卡卡号重复，或者电话号码输入错误！！");
						  }
				}else if(ret==0x400){
					logger.WriteLog("证卡打印机错误代码："+ret);
					$.session.set("errormsg","非常抱歉，证卡打印机内无卡，麻烦您通知自助机管理员，谢谢配合。");
					window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				}else if(ret==0x301 || ret == 0x304){
					logger.WriteLog("证卡打印机错误代码："+ret);
					$.session.set("errormsg","非常抱歉，证卡打印机内色带用尽，麻烦您通知自助机管理员，谢谢配合。");
					window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				}else if(ret==0x80 ){
					logger.WriteLog("证卡打印机错误代码："+ret);
					$.session.set("errormsg","非常抱歉，证卡打印机脱机，麻烦您通知自助机管理员，谢谢配合。");
					window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				}else {
					$.session.set("errormsg","非常抱歉，证卡打印机错误，麻烦您通知自助机管理员，谢谢配合。");
					logger.WriteLog("证卡打印机错误代码："+ret);
					window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				}
			}
		},200);
		//console.log("打印循环结束");
	}
	/***
	***  键盘事件
	***/
	 $('img[name="numKey"]').on("click", function() {
		    var valStr = $("#userPhone").val();
		    if (valStr == "") {
		      $("#userPhone").val($(this).attr("value"));
		    } else {
		      $("#userPhone").val(valStr + $(this).attr("value"));
		      if (valStr.length > 10) {
		        $("#userPhone").val(valStr);
		      }
		    }
	  });
	   //删除
	  $("#modify").on("click", function() {
		    var num = $("#userPhone").val();
		    var newstr = num.substring(0, num.length - 1);
		    $("#userPhone").val(newstr);
	  });
	   //重填
	  $("#reinput").on("click", function() {
		    $("#userPhone").val("");
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
		  	$("#money").css("display","none");
			$("#waiting").show();
			  checkstatusfk();
			  $("#waiting").show();
		  	  /*var reg = /^1[3|4|5|6|7|8|9][0-9]{9}$/; //验证规则
			  readCardAndGetYes();
		  	  if(signFlag){ //判断该卡是否建档
					 if(reg.test($("#userPhone").val())){//手机号码校验下
						  $.session.set("zzbkPhone",$("#userPhone").val());
							//跳转支付页面
							window.location.href = "zzbkzffs.jsp";
							$("#waiting").show();
					  }else{
						  $("#tip_div").show();
						  $("#error").text("电话号码输入错误，请输入正确电话号码!");
						  //$.session.set("errormsg","电话号码输入错误,请输入正确电话号码!");
						  //window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
					  }
			  }else{
				  $.session.set("errormsg","抱歉，当前办卡卡号重复,请联系自助机引导员，谢谢您的配合。");
				  window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				  //$("#tip_div").show();
				  //$("#error").text("当前办卡卡号重复，或者电话号码输入错误！！");
			  }*/
			 
	  });
	init();
</script>
</html>