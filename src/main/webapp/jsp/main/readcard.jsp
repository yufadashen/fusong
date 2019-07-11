<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>读卡</title>
<object id="AVFOCX" classid="clsid:28DF5A67-DFD2-4309-97E9-0601C4C54411" width="0" height="0">
               <param name="s1" value="" />
</object>
<object width="0" height="0" id="AVFOCXLOG"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
 --%><!-- <script language="javascript" src="DriverJS/ReceiptPrinter.js"></script> -->
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
    body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: url(../../images/yue/bgn.jpg) no-repeat; 
    }
    </style>
</head>

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:507px;right:224px;font-size:60px;color: #FF0000;">
   	</div>
   	
   	<div style="position:absolute;top:130px;left:220px;font-size:40px;color:#3f7dac;letter-spacing:11px;">请按照范例完成身份验证！</div>
   	
   	
   	
   	<div style="width:283px;height:360px;margin: 221px 0px 0px 360px;position:absolute;">
   		<img style="width:199px;" src="../../images/yue/putIdCard.gif">
   	</div>
   	<!-- 返回 -->
   	<div id="fanhui" style="width:237px;height:57px;margin: 575px 0px 0px 387px;position:absolute; ">
   		<img style="width:199px;" src="../../images/btn_cancel.png">
   	</div>
	<div style="width:198px;position:absolute;top:369px;left:610px;font-size:22px;text-align:left;line-height:31px;">请使用二代身份证完成验证，并确保身份证在感应器上方。</div>
	<div style="position:absolute;top:521px;left:143px;font-size:40px;color:#FFA042;letter-spacing:6px;">正在读取身份证信息，剩余&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 秒！</div>
   	
   	
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:150px;top:266px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<strong><span id="error" style="font-size:30px;color:#EE7700;"></span></strong>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:148px;left:300px" />
	</div>
	<div id="pay" style="display:block;margin-top:1200px; ">
	</div>	
	<div id="title"
			style="text-align:center;position:absolute;top:1112px;left:400px;">
			<span id="error" style="font-size:40px;color:#EE7700;"><strong>请刷院内就诊卡</strong></span>
	</div>
	<div id="main" style="position: absolute;top:1745px;left:395px;">
			<img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
	</div>
	<div id="next" style="position: absolute;top:1728px;left:545px;">
			<img src="${pageContext.request.contextPath}/images/next.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
	</div>	
	<div id="main_box" style="text-align:center;">
		<div id="pay" style="display:block;margin-top:300px;">
			<%-- <img src="${pageContext.request.contextPath}/queding.png" res_img="${pageContext.request.contextPath}/queding1.png" height="" width=""> --%> 
		</div>	
	</div>
</body>
<script language="javascript">
	//初始化倒计时时间：60秒
	var time = 30;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = window.parent.reTime;
	}
	returnTime();

	//读取身份证信息
	//var idCarder = window.parent.idCarder;
  	function readCard(){
  		window.parent.Name = "岳帅锋";
  		window.parent.idCardNo = "410327199011276410";
  		window.parent.Sex = "1";
  		window.parent.brith = "19901127";
  		getBridInfo();
  		
  		/* 
		var status=idCarder.OpenDeviceAndReadCard(1001,200);//usb串口
		//log.WriteLog("打开身份证读卡："+status);
		if(status=="0"){
			window.parent.Name = idCarder.GetCardInfo(0);
			window.parent.Sex = idCarder.GetCardInfo(1);
			window.parent.idCardNo = idCarder.GetCardInfo(5);
			window.parent.brith = idCarder.GetCardInfo(3);
			//log.WriteLog("读取身份证信息："+window.parent.xming0+window.parent.sfzhao);
			if(window.parent.xming0 && window.parent.sfzhao){
				getBridInfo();
			}else{
				message("身份证读取失败！请联系工作人员！");
			}
		}else{
			setTimeout("readCard();", 800);
		}
		 */
  	}
  	//根据身份证查询基本信息
  	function getBridInfo(){
		 var datas = {"Name":window.parent.Name,//姓名
					  "PapersNo":window.parent.idCardNo,//证件号
					  "PapersType":"1",//证件类型
				      "PhoneNo":"",//电话号
				      "Gender":window.parent.Sex,//性别 1男2女
				      "BirthDate":window.parent.brith//出生日期格式yyyyMMdd
				      };
			$.ajax({
				async:true,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded;charset=utf-8", 
				url:window.parent.serverUrl+"FindPatient",
				success:function(json){
					var Data = JSON.parse(json);
					if(Data.Code == "0"){
						window.parent.OutpatientId=Data.Departments[0].OutpatientId;
						window.parent.CardType=Data.Departments[0].CardType;
						window.parent.CardNo=Data.Departments[0].CardNo;
						window.parent.Balance=Data.Departments[0].Balance;
						window.parent.Limit=Data.Departments[0].Limit;
						window.parent.CreateTime=Data.Departments[0].CreateTime;
						window.parent.CardName=Data.Departments[0].CardName;
						window.parent.Enable=Data.Departments[0].Enable;
						var type=window.parent.ttype;
						if(type==1){
							window.location.href="../mzgh/ghkebie.jsp";//门诊挂号
							//window.location.href="${pageContext.request.contextPath}/jsp/mzgh/ghkebie.jsp";
						}else if(type==2){//门诊缴费
							window.location.href="../mzjf/mzjf2.jsp";//门诊挂号
						}if(type==30){//查询挂号信息
							window.location.href="../cxym/cxghInfo.jsp";//查询挂号信息
						}
					}else{
						message("失败！");
					}
											
				},
				error:function(){
					goError("系统异常，请稍后再试！");
				}
			});
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
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
	}
  	$("#main").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
  	$("#next").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/readCardType.jsp";
	});
  	$("#fanhui").bind("click dbclick", function() {
		window.location.href="main.jsp";
	});
  	function init(){
	  	readCard();
  	}
  	init();
</script>
</html>