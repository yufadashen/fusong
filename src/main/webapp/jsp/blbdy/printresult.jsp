<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>病历本打印结果</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<object id="TestOcx" width="" height="" classid="clsid:1691CDA2-0C31-47DB-BFCB-26ECC899AFC5">
</object>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->

<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(../../images/error.jpg) no-repeat; 
}
#result{
	position:absolute;
	top:300px;
	left:0px;
	width:1024px;
	height:120px;
	text-align:center;
	font-size: 55px;
	color:red;
}

#mainPage{
position:absolute;
	top:707px;
	left:682px;
	width:1024px;
	height:120px;
	text-align:center;
	font-size: 55px;
	color:red;
}
#backPage{
position:absolute;
	top:707px;
	left:851px;
	width:1024px;
	height:120px;
	text-align:center;
	font-size: 55px;
	color:red;
}
</style>
</head>
<body>
	<div id="time"
		style="position:absolute;top:12px;left:888px;font-size:40px;color: #FF0000;z-index: 20000">
		</div>
	<div id="result">正在打印病历本，请稍后...</div>
	<div id="tip_div"  style="margin: 385px 319px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:176px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:554px" />
   </div> 
	<div id="mainPage" style="width: 149px;height: 50px;">
		
	</div>
	<div id="backPage" style="width: 149px;height: 50px;">
		
	</div>
</body>
<script type="text/javascript">
	
	
	/**
	*初始化操作
	**/
	var init = function(){
		event();
		$("#result").text("正在打印病历本，请稍后...");	
		var dyflag = $.session.get("resultblbdy");
		//alert(dyflag);
		if(dyflag=="true"){
			//$("#result").text("病历本打印已完成！");	
			//alert("正确");
			setTimeout("dyUpdate()",3000);
		}else{
			//alert("错误");
			$("#tip_div").show();
			$("#error").text("病历本打印失败，本次打印不计费。");	
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	//初始化倒计时时间：120秒
	var time = 15;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 15;
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
	function event(){
		$("#mainPage").bind("click dbclick", function() {//返回主页
			//跳转页面
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			//跳转页面
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		
	}
	function dyUpdate(){
		//病历本打印成功
			//alert(22);
			var datas = {
					"funcid" : "M07.02.08.03",
					"cxdm00" : window.parent.cardNo,		//查询代码		
					"cxfs00" : window.parent.cardtype,		//查询方式
					"jylsh0" : $.session.get("jylsh0"),     //病历本流水号
					"brid00" : window.parent.brid00, 		//病人id		//终端编号
					"czybh0" : "",							//操作员编号
					"kflx00" : "2",							//扣费类型 2
					"ctype0" : window.parent.cardtype       //卡类型
					};
					$.ajax({
						async : false,
						type : "post",
						data : datas,
						dataType : "json",
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						url : window.parent.serverUrl + "?method=ApplyAction",
						//url : "${pageContext.request.contextPath}/Test/test.do",
						success : function(json) {
							//alert(33);
							Data = eval(json);
							var dysj00 = Data.retbody[0].dysj00//打印时间
							if(dysj00){
								$("#result").text("病历本打印成功，本次打印计费1元。");	
								window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
							}
						},
						error : function() {
							//alert(44);
							$("#tip_div").show();
							$("#error").text(Data.retmsg);	
							$("#tip_s").on("click", function() {
								$("#tip_div").hide();
								window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
							});
						}
				});		
		
	}
	
	init();
</script>

</html>
