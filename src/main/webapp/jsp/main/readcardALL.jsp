<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>读卡-点击健康卡</title>
<object id="AVFOCX" classid="clsid:28DF5A67-DFD2-4309-97E9-0601C4C54411" width="0" height="0">
               <param name="s1" value="" />
</object>
<object width="0" height="0" id="AVFOCXLOG"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js"></script>
<script language="javascript" src="DriverJS/json2.js"></script>
<script language="javascript" src="DriverJS/ReceiptPrinter.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
    body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat; 
    }
    </style>
</head>

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
   	
   	<div id="title"
			style="text-align:center;position:absolute;top:1112px;left:330px;">
			<span  style="font-size:40px;color:#EE7700;"><strong>请扫描电子健康卡二维码</strong></span>
	</div>
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
	<div id="pay" style="display:block;margin-top:1180px; ">
			<img src="${pageContext.request.contextPath}/images/readEWM.png"  height="" width=""/> 
	</div>	
	
	<div style="text-align:center;position:absolute;top:1682px;left:330px;">
			<span  style="font-size:40px;color:#EE7700;"><strong>二维码:</strong></span>
			<input id="ewm" style="width:350px;height:40px;font-size:30px;" >
	</div>
	
	<div id="qdb" style="position:absolute;top:1670px;left:830px; ">
			<img src="${pageContext.request.contextPath}/images/queding.png"  height="" width=""/> 
	</div>	
	
	<div id="main" style="position: absolute;top:1745px;left:395px;">
			<img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
	</div>
	<%-- <div id="next" style="position: absolute;top:1728px;left:545px;">
			<img src="${pageContext.request.contextPath}/images/next.png" res_img="${pageContext.request.contextPath}/" height="" width=""/> 
	</div>	 --%>
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
  	var cardNO;//卡号
	var qrcode;//二维码串
	$(document).keydown(function(event){
		if(event.keyCode==13){
			qrcode=$("#ewm").val();
			readCard();
		}
	})
	function getQrcode(){
		$("#ewm").focus();
	}
	var bStart=true;
	var IDReader=window.parent.IDReader;
	function readIdCard(){
		var Ret = IDReader.ReadCard();
		if(Ret.RetVal=="111001"){			
			bStart = false;			
			qrcode = IDReader.GetCardInfo(5).Value;
			readCard();			
		}
		if (bStart){
			setTimeout("readIdCard();", 500);
		}
	}
	
  	function readCard(){
  		var type=window.parent.ttype;
  		var trcode;
  		if(type==3){
  			trcode="010105";
  		}else if(type==1 || type==2){
  			trcode="010101";
  		}else{
  			trcode="000000";
  		}
  		 var datas = {"funcid":"M07.02.01.80",	
				      "qrcode":qrcode,
				      "trcode":trcode};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				//url:"${pageContext.request.contextPath}/Test/test.do",
				success:function(json){
						Data = eval(json);
						if(Data.retcode == "0"){
							if(Data.retbody[0].ret_code=="1"){
								if(Data.retbody[0].ret_msg=="0"){
									$("#tip_div").show();
									$("#error").text("电子健康卡未在本院建档");
								}else{
									var msg=Data.retbody[0].ret_msg.split("^");
									window.parent.cardNo=msg[1];
									window.parent.cardtype="02";
									getBridInfo();
								}
							}else{
								$("#tip_div").show();
								$("#error").text(Data.retbody[0].ret_msg);
							}
						}else{
							$("#tip_div").show();
							$("#error").text(Data.retmsg);
						}
											
				},
				error:function(){
					alert("系统异常，请稍后再试！");
				}
			});	
  	}
  	
  	
  	
		
	
  	function getBridInfo(){
		 var datas = {"funcid":"M07.02.01.02",	
		 			  "yyjgdm":"",							 
				      "cxdm00":window.parent.cardNo,
				      "cxfs00":window.parent.cardtype,
				      "sfybye":""};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				url:window.parent.serverUrl+"?method=ApplyAction",
				//url:"${pageContext.request.contextPath}/Test/test.do",
				success:function(json){
						Data = eval(json);
						if(Data.retcode == "0"){
							window.parent.sfykt0=Data.retbody[0].sfykt0;
							window.parent.pin000=Data.retbody[0].pin000;
							window.parent.lxdh00=Data.retbody[0].lxdh00;
							window.parent.xming0=Data.retbody[0].xming0;
							window.parent.csrq00=Data.retbody[0].csrq00;
							window.parent.yjjye0=Data.retbody[0].yjjye0;
							window.parent.brid00=Data.retbody[0].brid00;
							window.parent.brnl00=Data.retbody[0].brnl00;
							window.parent.xbie00=Data.retbody[0].xbie00;
							window.parent.ynzhye=Data.retbody[0].ynzhye;
							window.parent.bryblb=Data.retbody[0].bryblb;
							window.parent.jzhsfjd=Data.retbody[0].jzhsfjd;
							window.parent.zdbh00=Data.retbody[0].zdbh00;
							//log.WriteLog("卡号:"+window.parent.cardNo+"获取个人信息");
							if(window.parent.bryblb=="0"){
								var type=window.parent.ttype;
								if(type==1){
									window.location.href="${pageContext.request.contextPath}/jsp/mzgh/ghkeshi.jsp";
								}else if(type==2){
									window.location.href="${pageContext.request.contextPath}/jsp/mzyy/mzyy.jsp";
								}else if(type==3){
									window.location.href="${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
								}else if(type==5){
									window.location.href="${pageContext.request.contextPath}/jsp/pay/payway.jsp";
								}else if(type==6){
									//window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
								}else if(type==7){
									//window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
								}else if(type==8){
									//window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqx.jsp";
								}
							}else{
								$("#tip_div").show();
								$("#error").text("医保患者暂时不能在本机办理！");
							}
						}else{
							$("#tip_div").show();
							$("#error").text(Data.retmsg);
						}
											
				},
				error:function(){
					alert("系统异常，请稍后再试！");
				}
			});
  	}
  	getQrcode();
  	$("#main").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
  	$("#qdb").bind("click dbclick", function() {
  		qrcode=$("#ewm").val();
  		if(qrcode==""){
  			$("#tip_div").show();
			$("#error").text("二维码串不能为空");
  		}else{
  			readCard();
  		}
		
	});
  	
  	$("#next").bind("click dbclick", function() {
		window.location.href="${pageContext.request.contextPath}/jsp/main/readCardType.jsp";
	});
  	readIdCard();
</script>
</html>
