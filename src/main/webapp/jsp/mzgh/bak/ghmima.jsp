
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<title>门诊挂号</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}
</style>
</head>
<body scroll="no">
	<div id="stepByKeshi" class="ui-stepBar-wrap"
		style="display:block;width:90%;height:100px;position:absolute;top:1200px;left:57px;background-color:#f7fcff">
		<div class="ui-stepBar">
			<div class="ui-stepProcess"></div>
		</div>
		<div class="ui-stepInfo-wrap">
			<table class="ui-stepLayout" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
						<p class="ui-stepName">选择科室</p></td>
					<td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
						<p class="ui-stepName">选择时间</p></td>
					<td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
						<p class="ui-stepName">选择医生</p></td>
					<td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
						<p class="ui-stepName">挂号</p></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div style="z-index:60;position:absolute;top:1095px;left:380px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/ghtitle.png" />
	</div>
	<div id="mma"
		style="position: absolute;top:1400px;left:300px;display:block">
		<span id="qingcharu" style="font-size:50px;color:#4169E1;"><strong>请输入密码:</strong></span>
	</div>
	<div id="login_pa"
		style="position: absolute;top:1410px;left:600px;display:block">
		<input id="KeyValue" type="password" maxlength="6"
			style="width:200px;height:50px;text-align:center;font-size:40px" />
	</div>
	<div id="sure1" style="position:absolute;top:1530px;left:454px;display:block">
		<img src="${pageContext.request.contextPath}/images/queding.png"
				res_img="${pageContext.request.contextPath}/images/queding1.png"
				height="" width="" />
	</div>
	<div id="main" style="position: absolute;top:1730px;left:425px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/images/main1.png"
			height="" width="" />
	</div>
	<div id="pre" style="position: absolute;top:1718px;left:600px;">
		<img src="${pageContext.request.contextPath}/images/pre.png"
			res_img="${pageContext.request.contextPath}/images/pre1.png"
			height="" width="" />
	</div>
</body>
<script type="text/javascript">
	//returnTime();
	var cardNo = window.parent.cardNo;//卡号
	var pin000 = window.parent.pin000;//密码
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var csrq00 = window.parent.csrq00;//出生日期
	var brnl00 = window.parent.brnl00;//病人年龄
	var brid00 = window.parent.brid00;//病人ID
	var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用）
	var log = document.getElementById("AVFOCX");
	var Pad = window.parent.Pad;
	var jzwz00; //就诊位置
	var pdxh00; //排队序号              
	var ghrqsj; //挂号日期和时间
	var ksid00=$.session.get('ksid00');
	//初始化倒计时时间：120秒
	var time = 120;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}

	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 60;
	}


	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});	
	//密码错误3次提示稍后再试
	var num=0;
	$("#sure1").bind("click dbclick", function() {
		if(num==3){
			$("#tip_div").show();
  			$("#error").text("密码错误，错误次数已达上限，请稍后再试!");
  			$("#tip_s").on("click", function() {
  				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}else{
			var mm=$("#KeyValue").val();
			if(mm==pin000){
				//log.WriteLog("卡号为:"+cardNo+"密码输入正确");
				guahaoPay();
			}else{
				num++;
				$("#KeyValue").val("");
				$("#tip_div").show();
	  			$("#error").text("密码错误，当前错误次数:"+num+"，错误三次后请稍后再试!");				
			}
		} 
	});
	
	function stepshow() {
			$(function() {
				stepBar.init("stepByKeshi", {
					step : 4,
					change : false,
					animation : false
				});
			});
			$("#KeyValue").focus();
			//OpenPinPad();
	}
	
	/* //打开密码键盘
	function OpenPinPad() {
		//log.WriteLog("打开密码键盘");
		window.parent.SetPan(window.parent.cardNo); //设置加密参数 卡号
		//log.WriteLog("设置加密参数");
		Pad.SetWorkMode(1);
		GetNextKey();
	}
	function GetNextKey() {
		var Ret1 = Pad.GetNextKey();
		var KeyValueInfo1 = document.getElementById("KeyValue");
		if (Ret1.RetVal == 13) {
			if (KeyValueInfo1.value.length < 6) {
				document.getElementById("KeyValue").value = "";
				Pad.SetWorkMode(1);
				setTimeout("GetNextKey();", 100);
				return;
			}
			bStop = false;
			setTimeout("GetPIN();", 100);
			return;
		} else if (Ret1.RetVal == 27) //取消
		{
			document.getElementById("KeyValue").value = "";
			Pad.SetWorkMode(1);
			setTimeout("GetNextKey();", 100);
			return;
		} else if (Ret1.RetVal == 8) //删除
		{
			document.getElementById("KeyValue").value = "";
			setTimeout("GetNextKey();", 100);
			return;
		}
		if (Ret1.RetVal != 0) { //收到值
			document.getElementById("KeyValue").value += "*";
		}
		if (bStop) {
			setTimeout("GetNextKey();", 100);
		}
	}
	function GetPIN() {
		var Ret = Pad.GetPIN();
		if (Ret.RetVal == 0) {
			bStop = true;
			pinData = Ret.pData;
			guahaoPay();
		}
	} */
	
	//挂号收费
	function guahaoPay() {
		//log.WriteLog("卡号为:"+cardNo+"确认挂号收费初始化");
		var datas = {
			"funcid" : "M07.02.04.04",
			"yyjgmc" : "吉大一医院",
			"cxdm00" : cardNo,
			"cxfs00" : window.parent.cardtype,
			"sfybye" : "",
			"xming0" : xming0,
			"brid00" : brid00,
			"pbid00" : $.session.get('pbid00'),
			"sjdbh0" : $.session.get('sjdbh0'),
			"ksid00" : $.session.get('ksid00'),
			"ysid00" : $.session.get('ysid00'),
			"ysxm00" : $.session.get('doctor'),
			"hyid00" : "",
			"czyid0" : "",
			"passwd" : "",
			"pin000" : window.parent.pin000};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			//url : window.parent.serverUrl + "?method=ApplyAction",
			url:"${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				//Data ={"retcode":"0","retbody":[{"sfcg00":"AA","yyjgdm":"","ghrqsj":"20180924070138","pdxh00":"4","brxm00":"","xxkzid":"QRY_Rescheduling_Return-20180924070138230","xlh000":"","jzwz00":"四楼\t    ","hylx00":"","lxdh00":"","hyid00":""}],"retmsg":""};
				if (Data.retbody[0].sfcg00 == "AA") {
					//log.WriteLog("卡号为:"+cardNo+"挂号收费成功，需进一步判断该科室是否有检查费");					
					jzwz00 = Data.retbody[0].jzwz00; //就诊位置
					pdxh00 = Data.retbody[0].pdxh00; //排队序号
					ghrqsj = Data.retbody[0].ghrqsj; //挂号日期和时间
					var time1=ghrqsj.substr(0,4);
					var time2=ghrqsj.substr(4,2);
					var time3=ghrqsj.substr(6,2);
					var time4=ghrqsj.substr(8,2);
					var time5=ghrqsj.substr(10,2);
					var time6=ghrqsj.substr(12,2);
					ghrqsj=time1+"年"+time2+"月"+time3+"日"+time4+":"+time5+":"+time6;					
					$.session.set('jzwz00', jzwz00);
					$.session.set('pdxh00', pdxh00);
					$.session.set('ghrqsj', ghrqsj);
					if(ksid00=="000599"||ksid00=="0015"||ksid00=="000867"||ksid00=="000865"||ksid00=="000866"||ksid00=="000920"||ksid00=="000921"||ksid00=="000899"||ksid00=="000729"||ksid00=="000730"||ksid00=="000728"||ksid00=="000922"){					
						//log.WriteLog("卡号为:"+cardNo+"挂号收费成功，但需结算检查费，即将开始结算");
						$("#tip_div").show();
              			$("#error").text("该科室需要结算检查费用");
              			window.parent.jstype="2";
              			$("#tip_s").on("click", function() {
              				getBridInfo();													
						});																
					}else{
						window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghsucc.jsp";											
					}					
				} else {
					//log.WriteLog("卡号为:"+cardNo+"挂号收费失败");
					$("#tip_div").show();
              		$("#error").text(Data.retmsg);					
				}
			},
			error : function() {
				$("#tip_div").show();
              	$("#error").text("系统异常，请稍后再试！");				
			}
		});
	}
	
	function getBridInfo(){
		 var datas = {"funcid":"M07.02.01.02",	
		 			  "yyjgdm":"",							 
				      "cxdm00":window.parent.cardNo,
				      "cxfs00":"5",
				      "sfybye":""};
			$.ajax({
				async:false,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				//url:window.parent.serverUrl+"?method=ApplyAction",
				url:"${pageContext.request.contextPath}/Test/test.do",
				success:function(json){
						Data = eval(json);						
						window.parent.yjjye0=Data.retbody[0].yjjye0;						
						window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";															
				},
				error:function(){
					alert("系统异常，请稍后再试！");
				}
			});
  	}
	
	stepshow();
</script>
</html>





