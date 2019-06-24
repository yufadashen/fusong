<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>读卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
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
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:1365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:160px;left:300px" />
	</div>
	<div id="pay" style="display:block;margin-top:350px;margin-left:300px;">
			<img src="${pageContext.request.contextPath}/images/print/qsk.png"  height="343" width="621"/> 
	</div>	
	<!-- <div id="title"
			style="text-align:center;position:absolute;top:230px;left:400px;">
			<span id="error" style="font-size:40px;color:#EE7700;"><strong>请刷院内就诊卡</strong></span>
	</div> -->
	<div id="main" style="position: absolute;top:750px;left:550px;">
			<img src="${pageContext.request.contextPath}/images/fanhui.png" res_img="${pageContext.request.contextPath}/" height="67" width="161"/> 
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
	
	var reader=window.parent.CardReader;
  	function readCard(){
  		var card = reader.ReadCard();
  		if(card.length>6 && card !=undefined){
			//log.WriteLog("读取卡号:"+carNo);
			window.parent.brid00=card;
			//window.parent.cardNo=card;
			//window.parent.cardtype="02";
			//log.WriteLog("读取卡号、类型:"+1);
			//getBridInfo();
			reader.MoveCardX(2);
			var type=window.parent.ttype;
			if(type==1){
				window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohome.jsp";
			}else if(type==2){
				window.location.href="${pageContext.request.contextPath}/jsp/printOf/infohomeLis.jsp";
			}
		}else{
			setTimeout("readCard();", 500);
		}
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
							window.parent.jzhsfjd=Data.retbody[0].jzhsfjd
							window.parent.zdbh00=Data.retbody[0].zdbh00;
							//log.WriteLog("卡号:"+window.parent.cardNo+"获取个人信息");
							var type=window.parent.ttype;
							reader.MoveCardX(2);
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
  	$("#main").bind("click dbclick", function() {
  		reader.MoveCardX(2);
  		/* window.location.href = "http://172.16.11.34:9080/htmz/ShowMedicalRecordsInfoZJJ.jsp?pid=1172764546"; */
  		window.location.href = "${pageContext.request.contextPath}/jsp/printOf/printMain.jsp"; 
	});
  	readCard();
</script>
</html>
