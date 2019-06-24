<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>				
<title>自助发卡读取身份证</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
<style type="text/css">
body {
	background: url(${pageContext.request.contextPath}/images/ssfz.gif) no-repeat;
	width: 1280px;
	height: 1024px;
	overflow: hidden;
	text-align: center;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no" onselectstart="return false;">
<div id="waiting" style="margin:444px 0px 0px 351px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
	<div id="time"
		style="position:absolute;top:30px;left:1161px;font-size:60px;color: #FF0000;">
	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:280px;top:465px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div>
	<!-- 返回主頁面 -->
	<div id="main" style="position: absolute;top:880px;left:550px;">
		<img src="${pageContext.request.contextPath}/images/main.png" />
	</div>
	
</body>
<script type="text/javascript">	
	//var log = window.parent.Logger;	
	var idCarder=window.parent.IdCard;
	var cardPrinter = window.parent.cardPrinter;
	//1。获取卡数量
	function getCardNum(){
		//返回值为四位字符串
		//第1位：0 = 卡机中无卡（包含插卡口），1 = 插卡口处有卡，2 = 卡机中有卡
		//第2位：0 = 回收盒未满，1 = 回收盒收卡已满
		//第3位：0 = 卡栈内有卡，1 = 卡栈内无卡
		//第4位：0 = 卡栈卡足够，1 = 卡栈卡不足
		var status = cardPrinter.GetStatus();
		if(status.slice(0,1)=="0"){//第1位：0 = 卡机中无卡（包含插卡口），1 = 插卡口处有卡，2 = 卡机中有卡
			cardPrinter.MoveCard(0);//把卡从卡栈移动到操作位
			cardPrinter.MoveCard(1);//=移动卡到RF位
		}else if(status.slice(0,1)=="1"){
			message("请先取走插卡出口的卡片，然后重新操作！");
		}else if(status.slice(0,1)=="2"){
			cardPrinter.MoveCard(1);//=移动卡到RF位
		}
		window.parent.cardNo = cardPrinter.ReadCard()//读卡
		//log.WriteLog("移动卡到读卡位，卡号为："+ window.parent.cardNo);
		var cardNo =  window.parent.cardNo;
		if(cardNo && cardNo.length == 10){
			setTimeout(function(){
				readCard();
			},2000);
		}else{
			message("发卡器读卡失败，请重试！");
		}
	}
	
	//读取身份证信息
	function readCard(){
		/*
		window.parent.xming0 = "岳帅锋";
		window.parent.xbie00 = "男";
		window.parent.sfzhao = "410327199011276410";
		window.parent.csrq00 = "19901127";
		checksign();
		*/
		var status=idCarder.OpenDeviceAndReadCard(9,500);
		//log.WriteLog("打开身份证读卡："+status);
		if(status=="0"){
			window.parent.xming0 = idCarder.GetCardInfo(0);
			window.parent.xbie00 = idCarder.GetCardInfo(1);
			window.parent.sfzhao = idCarder.GetCardInfo(5);
			window.parent.csrq00 = idCarder.GetCardInfo(3);
			//addr = idCarder.GetCardInfo(4);
			//log.WriteLog("读取身份证信息："+window.parent.xming0+window.parent.sfzhao);
			if(window.parent.xming0 && window.parent.sfzhao){
				$("#waiting").show();
				checksign();
			}else{
				message("身份证读取失败！请联系工作人员！");
			}
		}else{
			setTimeout("readCard();", 1000);
		}
		 
	}
	//判断是否已建档：M07.02.02.01。
	function checksign(){
		var datas = {
		 	"funcid": "M07.02.02.01",
            "sfhqkh": "2",//是否获取卡号(是1 否2)
            "cxdm00": window.parent.sfzhao,//身份证号
            "cxfs00": "3"//卡类型 查询方式，卡类型：0：社保卡 1：IC卡（新、旧就诊卡都传1）2：磁条卡（暂时不用）3：身份证 4：住院号
		}
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            success: function (json) {
            	var Data = eval(json);
				if (Data.retcode == "0") {
					var brid00 = Data.retbody[0].brid00;
					if(brid00 && brid00.length>0){//是否已建档
						message("该卡号已建档，请到窗口进行补卡办理！");
					}else{
						checkdup();//判断介质号是否重复 M07.02.02.09
					}
				} else {
					message(Data.retmsg);
				}
            },
            error: function () {
                message("系统异常，请稍后再试！");
            }
        });	
	}
	//判断介质号是否重复 M07.02.02.09
	function checkdup(){
		var datas = {
		 	"funcid": "M07.02.02.09",
            "sfhqkh": "2",//是否获取卡号(是1 否2)
            "cxdm00": window.parent.cardNo,//卡号
            "cxfs00": "1"//卡类型 
		}
		$.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            success: function (json) {
            	var Data = eval(json);
				if (Data.retcode == "0") {
					var isreg00 = Data.retbody[0].isreg00;
					if(isreg00 == "0"){//是否重复（0未重复，1重复）
						window.location.href = "zzfkoperation.jsp";
					}else{
						//如果重复需要把当前卡片放入回收槽，移动下一张卡片
						removeCard();
					}
				} else {
					message(Data.retmsg);
				}
            },
            error: function () {
                message("系统异常，请稍后再试！");
            }
        });
	}
	function removeCard(){
		cardPrinter.MoveCard(2);//移动卡到回收箱
		var status = cardPrinter.GetStatus();
		//log.WriteLog("获取卡数量"+status);
		if(status.slice(2,3)=="0"){//卡栈内有卡
			cardPrinter.MoveCard(0);//把卡从卡栈移动到操作位
			cardPrinter.MoveCard(1);//=移动卡到RF位
			window.parent.cardNo = cardPrinter.ReadCard()//读卡
			//log.WriteLog("移动卡到读卡位，卡号为："+ window.parent.cardNo);
			checkdup();//继续判断卡号是否重复
		}else{
			message("就诊卡数量为空，请联系工作人员!");
		}
	}
	//提示信息
	function message (msg){
		$("#waiting").hide();
		 $("#tip_div").show();
         $("#error").text(msg);
	}
	
	function event(){//事件
		$("#tip_s").on("click", function () {
            $("#tip_div").hide();
            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
        });
		
		$("#main").bind("click dbclick", function() {
			$.session.clear();
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	
	}
	//初始化
	function init(){
		event();//事件
		returnTime();//倒计时
		getCardNum();
	}
	
	var time = 60;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 60;
	}
	setTimeout(function(){
		init();
		$("#waiting").hide();
	},1000);
</script>
</html>