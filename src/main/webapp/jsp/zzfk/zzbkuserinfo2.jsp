<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>无证办卡</title>
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
<object id="handInput"  width="0px" height="0px" classid="clsid:247FABEB-AB88-4671-8AB2-3A7EF084A307"></object>
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	background: url("../../images/yue/zzbk_wzbk.jpg") no-repeat;
}
div{
	
	position:absolute;
}
</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
  <div id="money" style="z-index:1000;display:none; width:272px; position:absolute;top:485px;left:685px;">
    <img src="../../images/kb2/1.png"  value="1" name="numKey" /> 
    <img src="../../images/kb2/2.png"  value="2" name="numKey" /> 
    <img src="../../images/kb2/3.png" value="3"  name="numKey"/> 
    <img src="../../images/kb2/delete.png" value="10"  id="modify" style="margin-top:1px;"/><br> 
     
    <img src="../../images/kb2/4.png"  value="4"name="numKey"  /> 
    <img src="../../images/kb2/5.png"  value="5" name="numKey" /> 
    <img src="../../images/kb2/6.png" value="6"name="numKey" /> 
    <img src="../../images/kb2/reinput.png" value="10" id="reinput" style="margin-top:1px;"/> <br>
    
    <img src="../../images/kb2/7.png" value="7"name="numKey" /> 
    <img src="../../images/kb2/8.png" value="8" name="numKey" /> 
    <img src="../../images/kb2/9.png" value="9"name="numKey"/> 
    <img src="../../images/kb2/close.png" value="10"  id="close"style="margin-top:1px;"/> <br>
    
    <img src="../../images/kb2/0.png" value="0"name="numKey" style="width:122px;height:53px;"/> 
    <img id="zmx" src="../../images/kb2/X.png" value="X" name="numKey" />
    <img src="../../images/kb2/sure.png" value="11" id="sure" style="margin-top:1px;" />
  </div>
	
	
	
	<div style="font-size:33px;margin:194px 0px 0px 421px;">
		<input class="userinfo" readonly="readonly" id="userName" type="text" style="width:209px;height:40px;">
	</div>
	<div style="font-size:20px;width:208px;height:40px;margin:267px 0px 0px 421px;">
		<input  class="userinfo" readonly="readonly" id="userCardNo" type="text"  style="width:209px;height:40px;text-align:right;">
	</div>
	<div style="font-size:33px;width:210px;height:40px;margin:336px 0px 0px 421px;">
		<input  class="userinfo" readonly="readonly" id="userBirth" type="text" style="width:209px;height:40px;">
	</div>
	<div style="font-size:33px;width:283px;height:40px;margin:404px 0px 0px 421px;">
		<select id="userSex" style="width:100px;">
			<option selected="selected" value="男">男</option>
			<option value="女">女</option>
		</select>
	</div>
	<div id="" style="font-size:33px;margin:482px 0px 0px 421px;">
		<input class="userinfo" readonly="readonly" id="userPhone"  maxlength="11" style="width:210px;height:35px;background-color:#28FF28;">
	</div>
	
	
	
	<div id="openkb4" style="width:141px;height:29px;margin:200px 0px 0px 640px;"></div>
	<div id="openkb3" style="width:141px;height:29px;margin:273px 0px 0px 640px;"></div>
	<div id="openkb2" style="width:141px;height:29px;margin:342px 0px 0px 640px;"></div>
	<div id="openkb" style="width:141px;height:29px;margin:489px 0px 0px 640px;"></div>
	
	<div id="confirmBtn" style="width:238px;height:56px;margin:585px 0px 0px 397px;"></div>
	
	<div id="btnMain" style="width:149px;height:51px;margin:695px 0px 0px 682px;"></div>
	<div id="btnReturn" style="width:149px;height:51px;margin:695px 0px 0px 851px;"></div>
	<div id="waiting" style="display:none;margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
	
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
							message(Data.retmsg);
						}
					},
					error : function() {
						logger.WriteLog("该卡"+cardNo+"判断该卡是否建档失败！");
						message("系统异常,请稍后再试!");
					}
				}); 
			}
		}else{
			//初始化证卡打印机失败
			message("证卡打印机初始化失败，请联系相关人员!");		
			setTimeout(function(){
				handInput.HideInputdlg();//关闭手写
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			},3000);
		}
	}
	
	//校验输入的参数
	var checkParam = function(){
		var flag = false;
		var reg = /^1[3|4|5|6|7|8|9][0-9]{9}$/; //验证规则
		var idcardReg = /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;
		if($("#userName").val() == ""){
			message("请输入正确的姓名！")
		}else if(!idcardReg.test($("#userCardNo").val())){
			message("请输入正确的身份证号码！");
		}else if(!reg.test($("#userPhone").val())){
			message("请输入正确的手机号码！");
		}else if($("#userBirth").val() == "" || $("#userBirth").val().length != 8){
			message("请按照格式填写出生年月日");
		}else{
			flag = true;
		}
		return flag;
	}
	
	/***
	***  证卡打印机状态检查
	***/
	function checkstatusfk(){
		$("#waiting").show();
		var ret = cardPrint.InitPrinter();
		cardPrint.AsynMoveCard(3);
		var intel = setInterval(function(){
			if(cardPrint.moveCardRet !=	0 ){
				ret = cardPrint.GetPrinterStatus();
				clearInterval(intel);
				if(ret==0){
					logger.WriteLog("证卡打印机状态正常："+ret);
					//跳转支付页面
					window.location.href = "zzbkzffs.jsp";
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
	}
	
	//设置身份信息
	function setPationInfo (){
		//idCarder.OpenDeviceAndReadCard(4,10000);
		$.session.set("zzbkName",$("#userName").val());
		$.session.set("zzbkSex",$("#userSex").val());
		$.session.set("zzbkIdCard",$("#userCardNo").val());
		$.session.set("zzbkAge",getAge($("#userBirth").val()));
		$.session.set("zzbkPhone",$("#userPhone").val());
		$.session.set("zzbkBirth",$("#userBirth").val());
	}
	
	function getAge(birthday) {
	    //出生时间 毫秒
	    var birthDayTime = new Date(birthday.substr(0, 4),birthday.substr(4, 2),birthday.substr(6, 2)).getTime(); 
	    //当前时间 毫秒
	    var nowTime = new Date().getTime(); 
	    //一年毫秒数(365 * 86400000 = 31536000000)
	    return Math.floor((nowTime-birthDayTime)/31536000000);
	}
	
	function initHand(){
		handInput.ShowInputdlg(400,270);
		var inter = setInterval(function () {
			/**获取对话框是否关闭
			 * LONG GetStatus(void);
			 * 返回值:-1=重复打开，0=窗口未关闭，1=窗口已关闭
			**/
			if (handInput.GetStatus() != 0)
			{
				//窗口关闭
				/**获取输入的字符串
				 * BSTR GetInput(void);
				 * 返回值:用户输入的字符串
				**/
				$("#userName").val(handInput.GetInput());
				clearInterval(inter);
			}
		}, 500);
	}
	function initialize	(){
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$(".userinfo").focus(function(){
			$("#money").hide();
			$(this).css("background-color","#28FF28");
		});
		$(".userinfo").blur(function(){
			$(this).css("background-color","");
		});
		$("#btnMain").bind("click dbclick", function() {//返回上一级
			handInput.HideInputdlg();//关闭手写
			window.location.href = "../main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			handInput.HideInputdlg();//关闭手写
			window.location.href = "../main/main.jsp";
		});
		$("#confirmBtn").bind("click dbclick", function() {//确认办卡
			  $("#waiting").show();
			  handInput.HideInputdlg();//关闭手写
			  $("#money").css("display","none");
			  var flag = checkParam();//校验病人输入得参数
			  if(flag){//参数通过
				  setPationInfo ();//设置用户录入信息  初始化建档使用
				  checkstatusfk();//校验证卡打印机  正常就跳转支付
			  }
		});
		
		$("#openkb").bind("click dbclick", function() {//打开 关闭键盘
			$("#userPhone").css("background-color","#28FF28");
			var a = $("#money")[0].style.display;
			if(a == "none"){
				obj = $("#userPhone");
		    	inLength = 10;
		    	$("#money")[0].style.top="485px";
		    	$("#money")[0].style.left="685px";
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
		});
		$("#openkb2").bind("click dbclick", function() {//打开 关闭键盘
			$("#userBirth").css("background-color","#28FF28");
			var a = $("#money")[0].style.display;
			if(a == "none"){
				obj = $("#userBirth");
		    	inLength = 7;
		    	$("#money")[0].style.top="385px";
		    	$("#money")[0].style.left="685px";
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
		});
		$("#openkb3").bind("click dbclick", function() {//打开 关闭键盘
			$("#userCardNo").css("background-color","#28FF28");
			var a = $("#money")[0].style.display;
			if(a == "none"){
				obj = $("#userCardNo");
		    	inLength = 17;
				$("#money").css("display","block");
		    	
		    	
		    	$("#money")[0].style.top="285px";
		    	$("#money")[0].style.left="685px";
			}else{
				$("#money").css("display","none");
			}
		});
		$("#openkb4").bind("click dbclick", function() {//打开 手写
			$("#userName").css("background-color","#28FF28");
			$("#userName").val("");
			initHand();
		});
	}
	
	function message(msg){
		$("#waiting").hide();
		$("#tip_div").show();
		$("#error").text(msg);
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
	//加载流程
	function process(){
		readCardAndGetYes();//首先判断是否可建档
		if(!signFlag){
		 	$.session.set("errormsg","抱歉，当前办卡卡号重复,请联系自助机引导员，谢谢您的配合。");
		 	window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
		}
		$("#waiting").hide();
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		initialize();
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		process();
	}
	init();
	
	/***
	***  键盘事件
	***/
	  //确认
	  $("#sure").bind("click dbclick", function() {
		 	var a = $("#money")[0].style.display;
			if(a == "none"){
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			}
	  });
	
	 $('img[name="numKey"]').on("click", function() {
		 if(obj[0].id != "userCardNo" && $(this).attr("value") == "X"){
			 return;
		 }
	     var valStr = obj.val();
	     if (valStr == "") {
	    	 obj.val($(this).attr("value"));
	     } else {
	    	 obj.val(valStr + $(this).attr("value"));
	         if (valStr.length > inLength) {
	    	     obj.val(valStr);
	         }
	     }
	  });
	   //删除
	  $("#modify").on("click", function() {
		    var num = obj.val();
		    var newstr = num.substring(0, num.length - 1);
		    obj.val(newstr);
	  });
	   //重填
	  $("#reinput").on("click", function() {
		  obj.val("");
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
</script>
</html>