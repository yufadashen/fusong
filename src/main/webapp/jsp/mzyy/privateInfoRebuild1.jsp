<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>个人信息补录</title>
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

#showArea{
	
}
#wxts{
	position: absolute;
    font-size: 30px;
    margin-left: 63px;
    margin-top: 84px;
}
#yycg{
	position: absolute;
    margin-left: 364px;
    font-size: 68px;
    margin-top: 209px;
}
#confirmApp{
	margin-top: 450px;
    margin-left: 378px;
}
#rebuildArea{
	position:absolute;
	border: 1px black solid;
	height:300px;
	width:550px;
	margin:100px 0px 0px 245px;
	border-radius: 5px;
	behavior:url(../../js/PIE.htc);
}
.keyboards{
	position: absolute;
    margin-left: 475px;
    margin-top: -34px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">个人信息补录</font>
	</div>
	<div id="showArea">
		<div id="wxts"></div>
			<div id="rebuildArea">
				<div style="margin-top: 30px;font-size: 20px;">姓&emsp;&emsp;&emsp;&emsp;名：<font color="#85c531">_______________________</font>
					<div style="position: absolute;margin-left: 230px; margin-top: -27px;">
						<input readonly="readonly" id="cusName" type="text" style="height:25px;width:290px;border:none;background: none;letter-spacing:20px;">
					</div>
				</div>
				<div style="margin-top: 20px;font-size: 20px;">卡&emsp;&emsp;&emsp;&emsp;号：<font color="#85c531">_______________________</font>
					<div style="position: absolute;margin-left: 230px; margin-top: -27px;">
						<input readonly="readonly" id="cusCardNo" type="text" style="height:25px;width:290px;border:none;background: none;">
					</div>
				</div>
				<div style="margin-top: 20px;font-size: 20px;">病&emsp;&emsp;人&emsp;ID：<font color="#85c531">_______________________</font>
					<div style="position: absolute;margin-left: 230px; margin-top: -27px;">
						<input readonly="readonly" id="patientId" type="text" style="height:25px;width:290px;border:none;background: none;">
					</div>
				</div>
				<div style="margin-top: 20px;font-size: 20px;">身&nbsp;&nbsp;份&nbsp;&nbsp;&nbsp;证&nbsp;&nbsp;号：<font color="#85c531">_______________________</font>
					<div style="position: absolute;margin-left: 230px; margin-top: -27px;">
						<input id="idCard" type="text" style="height:25px;width:290px;border:none;background: none;">
					</div>
				</div>
				<div id="inputPhoneNo" style="margin-top: 20px;font-size: 20px;">输入电话号码：<font color="#85c531">_______________________</font>
					<div style="position: absolute;margin-left: 230px; margin-top: -27px;">
						<input id="phoneNo" maxlength="11" type="text" style="height:25px;width:290px;border:none;background: none;">
					</div>
				</div>
				<div class="keyboards" id = "keyboards" style=""><img src="../../images/yue/keyboard_y.png"></div>
			</div>
		<div class="pageButton" id="confirmApp">确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认</div>
	</div>
	<div id="money"  style="z-index:1000; width:272px; position:absolute;top:475px;left:685px;">
    <img src="../../images/kb2/1.png"  value="1" name="numKey" /> 
    <img src="../../images/kb2/2.png"  value="2" name="numKey" /> 
    <img src="../../images/kb2/3.png" value="3"  name="numKey"/> 
    <img src="../../images/kb2/delete.png" value="10"  id="modify" style="margin-top:4px;"/><br> 
     
    <img src="../../images/kb2/4.png"  value="4"name="numKey"  /> 
    <img src="../../images/kb2/5.png"  value="5" name="numKey" /> 
    <img src="../../images/kb2/6.png" value="6"name="numKey" /> 
    <img src="../../images/kb2/reinput.png" value="10" id="reinput" style="margin-top:4px;"/><br>
    
    <img src="../../images/kb2/7.png" value="7"name="numKey" /> 
    <img src="../../images/kb2/8.png" value="8" name="numKey" /> 
    <img src="../../images/kb2/9.png" value="9"name="numKey"/> 
    <img src="../../images/kb2/close.png" value="10"  id="close" style="margin-top:4px;"/><br>
    
    <img src="../../images/kb2/0.png" value="0"name="numKey" style="width:122px;height:53px;"/> 
    <img src="../../images/kb2/sure.png" value="11" id="sure" style="width:146px;height:53px;margin-top:4px;" />
  </div>
	<div id="bottomArea">
		<span style="margin-left:620px;">
			<img id="btnMain" style="margin-top:8px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</span>
		<span style="margin-left:40px;">
			<img id="btnReturn" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
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
	var phoneNo = window.parent.lxdh00;//联系电话
	var idCard = window.parent.sfzhao;//身份证号
	var brid00 = window.parent.brid00;//病人id
	var cardNo = window.parent.cardNo;//卡号
	var xming0 = window.parent.xming0;//患者名称
	var phoneNoFlag = false;//是否补录手机号标识
	
	
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
	function logicBusiness(){
		$("#cusName").val(xming0);
		$("#cusCardNo").val(cardNo);
		$("#patientId").val(brid00);
		$("#idCard").val(idCard);
		if(phoneNo){
			$("#inputPhoneNo").val(phoneNo);
			$("#inputPhoneNo").css("display","none");
			phoneNoFlag = true;
		}
		if(idCard){
			$("#idCard").attr("readonly","readonly");
		}
	}
	//补录个人信息
	function recordData(){
		var idcardReg = /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;
		var phoneReg = /^1[1|2|3|4|5|6|7|8|9][0-9]\d{8}$/;
		if(!phoneNoFlag){
			if(!$("#phoneNo").val() || !phoneReg.test($("#phoneNo").val())){
				$("#tip_div").show();
				$("#error").text("请输入正确的手机号码！");	
				return;
			}
		}
		if(!$("#idCard").val() || !idcardReg.test($("#idCard").val())){
			$("#tip_div").show();
			$("#error").text("请输入正确的身份证号码！");
			return;
		}
		var datas = {
			"funcid" : "M07.02.04.12",
			"zdbh00" : window.parent.zdbh00,//终端编号
			"brid00" : brid00,
			"xming0" : xming0,
			"lxdh00" : $("#phoneNo").val(),
			"sfzhao" : $("#idCard").val()
		}
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url:"${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				//$.getJSON("../mzgh/yycx.json",function(json){//测试数据
					var Data = eval(json);
					if (Data.retcode == "0") {
						var flag = $.session.get("backyemianname");//获取身份信息补录的跳转页面标识
						if(flag=="yykebie"){
							window.location.href = "yykebie.jsp";
						}else{
							window.location.href = "yyqh2.jsp";
						}
						$("#waiting").show();
					} else {
						$("#tip_div").show();
						$("#error").text(Data.retmsg);	
					}
				//});
		},
		error : function() {
			$("#tip_div").show();
			$("#error").text("系统异常,请稍后再试!");		
		}
	}); 
	}
	
	/**
	*初始化操作
	**/
	var init = function(){
		logicBusiness();
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "yyoperation.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#keyboards").on("click",function(){
			console.log("调用键盘");
			$("#money").show();
		})
		$("#confirmApp").on("click", function(){//确认补录信息
			recordData();
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		//PrintTicket();打印小票//TODO
	}
	/***
	***  键盘事件
	***/
	 $('img[name="numKey"]').on("click", function() {
		    var valStr = $("#idCard").val();
		    if (valStr == "") {
		      $("#idCard").val($(this).attr("value"));
		    } else {
		      $("#idCard").val(valStr + $(this).attr("value"));
		      if (valStr.length > 18) {
		        $("#idCard").val(valStr);
		      }
		    }
	  });
	   //删除
	  $("#modify").on("click", function() {
		    var num = $("#idCard").val();
		    var newstr = num.substring(0, num.length - 1);
		    $("#idCard").val(newstr);
	  });
	   //重填
	  $("#reinput").on("click", function() {
		    $("#idCard").val("");
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
			recordData();
	  });
	init();
</script>
</html>