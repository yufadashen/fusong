<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>输入住院号</title>
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
	background: url(../../images/bgn.jpg) no-repeat;
}
div{
	position: absolute;
	text-align: center;
}
img[name=numKey]{
	margin-top:4px;
}
#qrcz{
	margin: 486px 0px 0px 404px;
    height: 54px;
    width: 219px;
    background-color: #F89C35;
    font-size: 38px;
    border-radius: 20px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	
  <div id="money"  style="z-index:1000; width:272px; position:absolute;top:278px;left:698px;background-color: black;">
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
    
    <img src="../../images/kb2/blank.png" style=""/>
    <img src="../../images/kb2/blank.png" style="margin-left:0px;"/>
    <img src="../../images/kb2/0.png" style="margin-left:0px;" res_img="../../../images/kb/0_1.png" value="0"name="numKey"/> 
    <img src="../../images/kb2/sure.png" res_img="../../../images/kb/11_1.png" value="11" id="sure"/>
  </div>
	
	<div style="font-size:33px;margin: 192px 200px;">请输入住院号：</div>
	<div style="margin:274px 0px 0px 351px;;font-size:33px;">
		<input  id="czje" value="" style="letter-spacing:0px; width:320px;height:52px;background-color:#28FF28;">
	</div>
	<div id="qrcz">查询</div>
	
	
	<div id="mainPage" style="width: 149px;height: 50px;margin:708px 0px 0px 683px;">
		<img alt="" src="../../images/yue/mzgh_index_y.png">
	 </div>
	<div id="backPage" style="width: 149px;height: 50px;margin:708px 0px 0px 851px;"> 
		<img alt="" src="../../images/yue/mzgh_return_y.png">
	</div>
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
	var zylsh;//住院流水号
	var zyFlag = false;//在院信息
	function goNext(){
		getZyPatientInfo();//获取住院流水号及基本信息 
		if(zyFlag){
			$.session.set("srzyh",$("#czje").val());
			if(window.parent.ttype == 3){//住院充值
				window.location.href = "../zyyjf/czje.jsp";
			}else if(window.parent.ttype == 4){//查询住院费用信息
				window.location.href = "cxzyInfo.jsp";
			}
		}else{
			message("未查到住院信息，请确认住院号！");
		}
	}
    //获取住院病人住院流水号
 	function getZyPatientInfo(){
		var datas = {
			"InpatientNo":	$("#czje").val()
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"GetInPatientSeriNos",
			success : function(json) {
				var data = JSON.parse(json);
				if (data.Code == "0") {
					var length = data.Departments.length;
					if(length > 0){
						$.each(data.Departments,function(index,temp){
							if(temp.InpatientStatus == "0"){//0未出院   1已出院
								window.parent.Name = temp.Name;
								$.session.set("zyyeb",temp.Balance);//充值前住院余额
								$.session.set("zylsh",temp.InpatientSeriNo);//住院流水号
								zyFlag = true;
							}
						});
					}else{
						message("查询住院流水号为空！请确认住院号！");
					}
				} else {
					message("未找到住院信息!");
				}
				$("#waiting").hide();
			},
			error : function() {
				goError("系统异常,请稍后再试!");
			}
		});
 	}
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
	}
	function initialize	(){
		$("#qrcz").bind("click dbclick", function() {//确认充值
			if($("#czje").val()){
				goNext();
			}else{
				message("请输入住院号！");
			}
		});
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			if(window.parent.ttype == 3){
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			}else{
				window.location.href="${pageContext.request.contextPath}/jsp/cxym/cxmenu.jsp";
			}
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
		return;
	}
	$("#tip_s").off().on("click", function() {
		 $("#tip_div").hide();
    });
	/**
	*初始化操作
	**/
	var init = function(){
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
		      if (valStr.length > 9) {
		        $("#czje").val(valStr);
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
		   /*  var a = $("#money")[0].style.display;
			if(a == "none"){
				$("#money").css("display","block");
			}else{
				$("#money").css("display","none");
			} */
	  });
	  //确认
	  $("#sure").bind("click dbclick", function() {
		  if($("#czje").val()){
			  goNext();
		  }else{
			  $("#tip_div").show();
			  $("#error").text("请输入住院号！");
			  $("#tip_s").off().on("click", function() {
				 $("#tip_div").hide();
			  });
		  }
	  });
	  init();
</script>
</html>