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
        background: url(../../images/yue/ypushcard.jpg) no-repeat; 
    }
    </style>
</head>

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
   	<div style="width:283px;height:360px;margin: 177px 0px 0px 360px;position:absolute;">
   		<img style="width:288px;height:365px;" src="../../images/yue/ckTips.gif">
   	</div>
   	<!-- 返回 -->
   	<div id="fanhui" style="width:237px;height:57px;margin: 575px 0px 0px 387px;position:absolute;"></div>
   	
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:160px;left:300px" />
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
	var time = window.parent.reTime;
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
	$("#tip_s").on("click", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});

	//读取身份证信息
	//var reader=window.parent.Reader;
  	function readCard(){
  		window.parent.Name = "岳帅锋";
  		window.parent.PapersNo = "410327199011276410";
  		window.parent.Sex = "410327199011276410";
  		getBridInfo();
  	}
  	//根据身份证查询基本信息
  	function getBridInfo(){
		 var datas = {"Name":"岳帅锋",//姓名
					  "PapersNo":"410327199011276410",//证件号
					  "PapersType":"1",//证件类型
				      "PhoneNo":"15517961123",//电话号
				      "Gender":"1",//性别 1男2女
				      "BirthDate":"19901127"//出生日期格式yyyyMMdd
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
						$("#tip_div").show();
						$("#error").text(Data.retmsg);
					}
											
				},
				error:function(){
					goError("系统异常，请稍后再试！");
				}
			});
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