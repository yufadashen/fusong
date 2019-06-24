<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>读卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染--> 
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
	<style>
    body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: url(${pageContext.request.contextPath}/images/print/printmain.jpg) no-repeat;
    }
    </style>
</head>

<body scroll=no>
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:10px;right:30px;font-size:40px;color: #FF0000;">
   	</div>
   	
   <!-- 	<div id="title"
			style="text-align:center;position:absolute;top:230px;left:400px;">
			<span  style="font-size:40px;color:#EE7700;"><strong>请扫描电子健康卡二维码</strong></span>
	</div> -->
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:160px;left:300px" />
	</div>
	<div id="pay" style="display:block;margin-top:320px;margin-left:300px; ">
			<img src="${pageContext.request.contextPath}/images/print/qsm.png"  height="343" width="621"/> 
	</div>	
	
	<div style="text-align:center;position:absolute;top:670px;left:330px;">
			<span  style="font-size:30px;color:#EE7700;"><strong>二维码:</strong></span>
			<input id="ewm" style="width:350px;height:30px;font-size:28px;vertical-align:0px;line-height:28px;" >
	</div>
	
	<div id="qdb" style="position:absolute;top:655px;left:800px; ">
			<img src="${pageContext.request.contextPath}/images/queding.png"  height="67" width="161"/> 
	</div>	
	
	<div id="main" style="position: absolute;top:750px;left:550px;">
			<img src="${pageContext.request.contextPath}/images/fanhui.png"  height="67" width="161"/> 
	</div>
</body>

<script language="javascript">
	//初始化倒计时时间：60秒
	var time = 60;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp";
				}
			},1000);
	}
	
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = 60;
	}
	returnTime();
	$("#tip_s").on("click", function() {
		window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp";
	});
  	var cardNO;//卡号
	var qrcode;//二维码串
	$(document).keydown(function(event){
		if(event.keyCode==13){
			qrcode=$("#ewm").val();
			reb();
		}
	})
	function reb(){
		if(qrcode.length>5 && qrcode.length<11){
			window.parent.brid00=qrcode;
			if(window.parent.ttype==1){
				window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohome.jsp";
			}else{
				window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohomeLis.jsp";
			}
		}else{
			readCard();
		}
	}
	function getQrcode(){
		$("#ewm").focus();
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
							var type=window.parent.ttype;
							if(type==1){
								window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohome.jsp";
							}else if(type==2){
								window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohomeLis.jsp";
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
  		//window.location.href = "${pageContext.request.contextPath}/jsp/printOf/infohome.jsp";
  		window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp";
	});
  	$("#qdb").bind("click dbclick", function() {
  		qrcode=$("#ewm").val();
  		if(qrcode==""){
  			$("#tip_div").show();
			$("#error").text("二维码串不能为空");
  		}else if(qrcode.length>5 && qrcode.length<11){
  			window.parent.brid00=qrcode;
			window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohome.jsp";
  		}else{
  			readCard();
  		}
		
	});
  	
</script>
</html>
