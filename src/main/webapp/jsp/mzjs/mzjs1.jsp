<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>			
<title>门诊结算</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css"  media="all">
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
	<!-- 显示返回主页面倒计时时间 -->
 	<div id="time" style="position:absolute;top:1130px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="tip_div"  style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;z-index:10">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div>
	<div id="title"
		style="z-index:60;display:block;position:absolute;top:1095px;left:380px;">
		<img id="tip1"
			src="${pageContext.request.contextPath}/images/jstitle.png"/>
	</div>
	<!-- <div id="word"
		style="z-index:60;display:block;position:absolute;top:1255px;left:460px;">
		<span id="tip2" style="font-size:40px">结算明细</span>
	</div> -->
	<div id="cardinfo" style="position:absolute;top:1211px;left:185px">
		<span style="font-size:40px">姓名:</span><span id="xming0" style="font-size:40px;color:#0000FF"></span>
		<span style="font-size:40px">卡内余额:</span><span id="yjjye0" style="font-size:40px;color:#0000FF"></span> 
		<span style="font-size:40px">卡号:</span><span id="carNo" style="font-size:40px;color:#0000FF"></span>
	</div>
	<div id="jsinfo"
		style="width:1060px;position:absolute;top:1335px;left:140px;display:block">
		<table id="jiesuaninfo" style="width:800px;border:1px solid black;table-layout:fixed">
			<thead>		
				<tr style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px">
					<td style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center">就诊医生</td>
					<td style="width:240px;height:60px;border:1px solid black;font-size:35px;text-align:center">项目</td>
					<td style="width:200px;height:60px;border:1px solid black;font-size:35px;text-align:center">金额</td>
					<td style="width:200px;height:60px;border:1px solid black;font-size:35px;text-align:center">详细</td>
				</tr>
			</thead>
			<tbody id="info"></tbody>
			<tfoot>
				<tr>
					<td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">费用总额</td>
					<td id="mzfyze" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;"></td>
				</tr>
				<tr>
					<td colspan="2" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
						<button id="pageup" style="font-size:35px;height:60px" class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.prePage();">上一页</button>						
					</td>
					<td colspan="2" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
						<button id="pagedown" style="font-size:35px;height:60px" class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.nextPage();">下一页</button>
					</td>
				</tr>
			</tfoot>		
		</table>
	</div>
	<div id="detail"
		style="width:1060px;position:absolute;top:1320px;left:140px;display:none">
		<table id="idData" style="width:800px;border:1px solid black;table-layout:fixed">
			<thead>
				<tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
					<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">项目</td>
					<td style="width:320px;border:1px solid black;font-size:35px;text-align:center">单项金额</td>				
				</tr>
			</thead>
			<tbody id="detailinfo"></tbody>
			<tfoot>
				<tr>
					<td style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
						<button id="pageup" style="font-size:35px;height:60px" class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.prePage();">上一页</button>						
					</td>
					<td style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
						<button id="pagedown" style="font-size:35px;height:60px" class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.nextPage();">下一页</button>
					</td>
				</tr>
				<tr style="width:1050px;height:60px;border:1px solid black">
					<td colspan="2" style="width:320px;border:1px solid black;font-size:35px;text-align:center"><button  id="close" class="layui-btn layui-btn-sm layui-btn-normal" style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">关闭</button></td>
					<!-- <td style="width:320px;border:1px solid black;font-size:35px;text-align:center"><button  id="pagedown" class="layui-btn layui-btn-sm layui-btn-normal" style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">结算</button></td> -->
				</tr>
			</tfoot>
		</table>
	</div>	
	<div id="mma" style="position:absolute;top:1360px;left:385px;display:none">
		<span id="qingcharu" style="font-size:60px;color:#4169E1;"><strong>请输入密码</strong></span>
	</div>
	<div id="login_pa" style="position:absolute;top:1460px;left:320px;display:none">
		<input id="KeyValue" type="password" maxlength="6"
			style="width:400px;height:60px;text-align:center;font-size:40px"/>
	</div>
	<div id="sure" style="position:absolute;top:1585px;left:415px;display:none">
		<img src="${pageContext.request.contextPath}/images/queding.png"
				res_img="${pageContext.request.contextPath}/images/queding1.png"
				height="" width="" />
	</div>
	<div id="sfcz"
		style="display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">	
		<div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error1" style="font-size:30px;color:#EE7700;"><strong>余额不足，请充值</strong></span>
        </div>
        <img id="back" src="${pageContext.request.contextPath}/images/no.png" 
        width="90" height="43" style="position:relative;top:125px;left:-30px" />
        <img id="chongzhi" src="${pageContext.request.contextPath}/images/yes.png" 
        width="90" height="43" style="position:relative;top:125px;left:30px" />		
	</div>
	<div id="main" style="position: absolute;top:1728px;left:425px;">
		<img src="${pageContext.request.contextPath}/images/main.png"
			res_img="${pageContext.request.contextPath}/" height="" width="" />
	</div>
	<div id="jiesuan" style="position: absolute;top:1729px;left:545px;">
		<img src="${pageContext.request.contextPath}/images/jiesuan.png"
			res_img="${pageContext.request.contextPath}/" height="" width="" />
	</div>
</body>
<script type="text/javascript">
	 	var xming0=window.parent.xming0;//姓名
	 	var cardNo=window.parent.cardNo;//卡号
	 	var yjjye0=window.parent.yjjye0;//卡内余额
		var mzfyze="30.00"; //门诊费用总额
		var money=0;//充值金额默认为0
		var sqysxm=""; //申请医生姓名
		var sqxmmc=""; //项目
		var sfje00=""; //单项收费金额
	 	var Pad = window.parent.Pad;
	 	var bStop =true;
	 	var pinData;
	 	var log = document.getElementById("AVFOCX");
	 	var jzid;//就诊ID
	 	var sqdbh;//申请单编号
	 	var fyjsxx;
	 	var pin000=window.parent.pin000;//密码
	 	var jstype=window.parent.jstype; //1是直接结算   2是挂号结算检查费   3是取号时结算特殊费用
		var czsucc =window.parent.czsucc;//充值成功 1为成功
	 	//初始化倒计时时间：60秒
		var time = window.parent.reTime;
	 	var Dataa;
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
			time = 60;
		}
		returnTime();
			
		
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		

		//查询门诊待缴费信息记录
		function getJSInfo(){
			 var datas = {"funcid":"M07.02.05.01",
			 			  "cxfs00":"5",							 
					      "cxdm00":"242080006",					     
					      "brid00":window.parent.brid00,
					      "sfybye":""};
				$.ajax({
					async:false,
					type:"post",
					data:datas,
					dataType:"json",
					contentType: "application/x-www-form-urlencoded; charset=utf-8", 
					url:window.parent.serverUrl + "?method=ApplyAction",
					//url:"${pageContext.request.contextPath}/Test/test.do",
					success:function(json){
						var Data = eval(json);		
						Dataa=Data;
						if(Data.retcode=="0"){
							//费用总额需要所有条加一起
							mzfyze=Data.retbody[0].mzfyze; //门诊费用总额
							$("#mzfyze").text(mzfyze);
							window.parent.mzfyze=mzfyze;
							sqysxm=Data.retbody[0].sqysxm; //申请医生姓名
							sfje00=Data.retbody[0].sfje00; //单项收费金额
							sqysxm=Data.retbody[0].sqxmmc; //项目名称
							jzid=Data.retbody[0].jzid00;   //就诊ID
							sqdbh=Data.retbody[0].sqdbh0;  //申请单编号
							fyjsxx="#"+sqdbh+"@"+jzid;
						 	$("#xming0").text(xming0);
							$("#yjjye0").text(yjjye0);
							$("#carNo").text(cardNo);						
							//把信息添加到表格中
							if(Data.retbody.length!="0"){
								if(czsucc==1){
									inputpassword();
								}else{
									for(var i=0;i<Data.retbody.length;i++){				
										$("#info").append(
										"<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
										+"<td style=\"width:160px;border:1px solid black;font-size:35px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\">"+Data.retbody[i].sqysxm+"</td>"
										+"<td style=\"width:240px;border:1px solid black;font-size:35px;text-align:center\">"+Data.retbody[i].sqxmmc+"</td>"
										+"<td style=\"width:200px;border:1px solid black;font-size:35px;text-align:center\">"+Data.retbody[i].sfje00+"</td>"
										+"<td style=\"width:200px;border:1px solid black;font-size:35px;text-align:center\"><button class=\"layui-btn layui-btn-sm layui-btn-normal\" style=\"width:100px;height:50px;background-color:#4d9cfa\" onclick=\"detail(this)\">明细</button></td>"
										+"</tr>")
									}
									page = new Page(3,"jiesuaninfo","info");
								}								
							//log.WriteLog("获取结算信息成功");
							}else{
								$("#tip_div").show();
	              				$("#error").text("您无需要结算的费用");
	              				
							}
						}else{							
							$("#tip_div").show();
              				$("#error").text(Data.retmsg);
							//log.WriteLog("获取结算信息失败");
						}						
					},	
					 error:function(){						
						$("#tip_div").show();
              			$("#error").text("系统异常，请稍后再试！");
					}
				});	
		}
		
		//点击详情
		function detail(obj){
			$("#jsinfo").hide();
			$("#detail").show();			
			getPayDetail();
			//log.WriteLog("开始获取结算详情");
		}
		
		//查询门诊待缴费信息明细
		function getPayDetail(){
			var datas = {"funcid":"M07.02.05.04",							 
					      "cxdm00":"242080006",
					      "cxfs00":"5",
					      "brid00":window.parent.brid00,
					      "jzid00":jzid,
					      "sqdbh0":sqdbh,
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
						//Data = {"retcode":"0","retbody":[{"zdrq00":"","ch0000":"","mxfyze":"30.00","jzid00":"131079534","bqid00":"","jd0000":"","csrq00":"","hyzk00":"","cxbjfh":"QDE001","sfcg00":"AA","brxm00":"","yysflb":"非检验","jtdh00":"","jysj00":"","hzlx00":"","sqxmdm":"","sqxmmc":"裂隙灯检查","sfje00":"18.00","fbmc00":"","ckhyqk":"OK","xh0000":"","zxry00":"34","fh0000":"","xb0000":"0","qqxxid":"QRY_DetailExpenses_Return-20180924053707406","ybzxmc":"0","xxcxmc":"K11^QRY_DetailExpenses^HL7","zdlx00":"","bgdh00":"","sqdbh0":"1176330845","bryblx":"131079534&","sqysxm":"孔玉娇","glid00":"","sqysid":"","ksid00":"眼科"},{"xh0000":"","mxfyze":"30.00","jzid00":"131079534","zxry00":"34","jysj00":"","yysflb":"非检验","sqdbh0":"1176330845","sqxmmc":"普通视力检查","sqxmdm":"","glid00":"","sqysxm":"孔玉娇","sfje00":"2.00","sqysid":""},{"xh0000":"","mxfyze":"30.00","jzid00":"131079534","zxry00":"34","jysj00":"","yysflb":"非检验","sqdbh0":"1176330845","sqxmmc":"眼底检查","sqxmdm":"","glid00":"","sqysxm":"孔玉娇","sfje00":"10.00","sqysid":""}],"retmsg":""}; 
						if(Data.retcode=="0"){							
							$("#totalmoney").text(Data.retbody[0].mxfyze);
							//把信息添加到表格中
							if($("#detailinfo").html()=="" && $("#detailinfo").length==0){
								for(var i=0;i<Data.retbody.length;i++){				
									$("#detailinfo").append(
									"<tr style=\"width:1050px;height:50px;border:1px solid black;\">"
									+"<td style=\"width:25%;border:1px solid black;font-size:35px;text-align:center\">"+Data.retbody[i].sqxmmc+"</td>"								
									+"<td style=\"width:25%;border:1px solid black;font-size:35px;text-align:center\">"+Data.retbody[i].sfje00+"</td>"								
									+"</<tr>")
								}
								page = new Page(2,"idData","detailinfo");								
							}else{
								$("#detailinfo").empty();
								for(var i=0;i<Data.retbody.length;i++){				
									$("#detailinfo").append(
									"<tr style=\"width:1050px;height:50px;border:1px solid black;\">"
									+"<td style=\"width:25%;border:1px solid black;font-size:35px;text-align:center\">"+Data.retbody[i].sqxmmc+"</td>"								
									+"<td style=\"width:25%;border:1px solid black;font-size:35px;text-align:center\">"+Data.retbody[i].sfje00+"</td>"								
									+"</<tr>")
								}
								page = new Page(2,"idData","detailinfo");							
							}																
						}else{							
							$("#tip_div").show();
              				$("#error").text(Data.retmsg);
							//log.WriteLog("获取结算详情失败");
              				
						}						
					},	
					error:function(){
						$("#tip_div").show();
              			$("#error").text("系统异常，请稍后再试！");
					}
				});	 
		}
		
		//关闭详细弹窗
		$("#close").bind("click dbclick", function() {
			$("#detail").hide();
			$("#jsinfo").show();			
		});
		//点击结算
		$("#jiesuan").bind("click dbclick", function() {
			//log.WriteLog("卡号:"+carNo+"开始结算");
			testmoney();
			//log.WriteLog("开始判断卡号:"+carNo+"卡内余额是否充足");
		});
		//判断卡内余额是否充足
		function testmoney(){
	 		if(parseFloat(yjjye0)>=parseFloat(mzfyze)){
	 			inputpassword();
	 			//log.WriteLog("卡号:"+carNo+"卡内余额充足，开始输入密码");
	 		}else{
	 			$("#sfcz").show();	 			
	 			//log.WriteLog("卡号:"+carNo+"卡内余额不足，提示是否充值");
	 		}	
 		}	
 		//点击取消充值
 		$("#back").bind("click dbclick", function() {
			$("#sfcz").hide();
			//log.WriteLog("卡号:"+carNo+"取消充值");
		});
		//点击确定充值
		$("#chongzhi").bind("click dbclick", function() {
			money=(parseFloat(mzfyze)-parseFloat(yjjye0)).toFixed(2);
			window.parent.money=money;
			window.parent.cztype="2";
			window.location.href="${pageContext.request.contextPath}/jsp/pay/payway.jsp";
			//log.WriteLog("卡号:"+carNo+"确认充值,跳转到充值方式界面");
		});
 		//输入密码
		function inputpassword(){
			$("#jsinfo").hide();
			$("#detail").hide();
			$("#jiesuan").hide();			
			$("#mma").show();
			$("#login_pa").show();
			$("#sure").show();
			$("#KeyValue").focus();
			//OpenPinPad();						
		}
		/* //打开密码键盘
		function OpenPinPad() {
			log.WriteLog("打开密码键盘");
			window.parent.SetPan(window.parent.cardNo);//设置加密参数 卡号
			log.WriteLog("设置加密参数");
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
			if (bStop){
				setTimeout("GetNextKey();", 100);
			}				
		} 
		function GetPIN() {
			var Ret = Pad.GetPIN();
			if (Ret.RetVal == 0) {
				bStop =true;
				pinData = Ret.pData;
				mzjiesuan();				
				//window.parent.pinData = pinData;
			}
		} */
		//自费结算
		function mzjiesuan(){
			//log.WriteLog("卡号:"+carNo+"开始自费结算");
			var datas = {"funcid":"M07.02.05.03",								 
					      "cxdm00":"242080006",
					      "cxfs00":"5",					      
					      "fyjsxx":fyjsxx,					    
					      "brid00":window.parent.brid00,
					      "passwd":pin000,
					      "pin000":pin000,
					      "sfybye":"0",
					      "mzfyze":mzfyze,
					      "count0":"",
					      "xming0":xming0,
					      "xbie00":window.parent.xbie00,
					      "csrq00":window.parent.csrq00,
					      "yjjye0":window.parent.yjjye0,
					      "brnl00":window.parent.brnl00,
					      "sfykt0":window.parent.sfykt0,
					      "ynzhye":window.parent.ynzhye,
					      "jzid00":jzid};
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
						if(Data.retcode=="0"){
							//log.WriteLog("卡号:"+carNo+"自费结算成功");
							$("#mma").hide();
							$("#login_pa").hide();
							$("#sure").hide();							
							//yjjye0=parseFloat(yjjye0)-parseFloat(mzfyze);
							getNewInfo();										              																	
						}else{
							//log.WriteLog("卡号:"+carNo+"自费结算失败");
							$("#tip_div").show();
			              	$("#error").text(Data.retmsg);
						}
					 },	
					error:function(){
						$("#tip_div").show();
			            $("#error").text("系统异常，请稍后再试！");
					}
				});	
		}
	
	function getNewInfo(){
	 		var datas = {"funcid":"M07.02.01.02",								 
				      "cxfs00":"5",
				      "cxdm00":cardNo,
					  "sfybye":"5"};
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
						if(Data.retcode=="0"){							
							yjjye0 = Data.retbody[0].yjjye0;
							window.parent.yjjye0=yjjye0;
							$("#yjjye0").text(yjjye0);
							//log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");
							print();
							$("#tip_div").show();
							$("#error").text("结算成功，请在下方取走凭条");
							$("#tip_s").on("click", function() {
								if(jstype=="1"){
									window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
								}else if(jstype=="2"){
									window.location.href="${pageContext.request.contextPath}/jsp/mzgh/ghsucc.jsp";
								}else if(jstype=="3"){									
									window.location.href="${pageContext.request.contextPath}/jsp/yyqh/qhsucc.jsp";
								}								
							});	
						}else{
							//log.WriteLog("卡号为:"+cardNo+"获取病人信息失败");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);							
						}
				},
				error:function(){
					$("#tip_div").show();
					$("#error").text("系统异常，请稍后再试！");					
				}
			});	
	 	}
	
	function print(){
		var Printer = window.parent.KPrinter;
		//log.WriteLog("打印机端口设置成功");
		Printer.SetFontModeAndTypeX(0x20,0x01);//设置字体						 			
		Printer.SetTextModeX(2);//设置中文模式						
		Printer.WriteTextLineX("吉林大学白求恩第一医院");
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("门诊结算");
		Printer.LFX(2); //多行送纸
		Printer.WriteTextLineX("");
		Printer.SetFontModeAndTypeX(0x20, 0x00); //设置字体
		for(i=0;i<Dataa.retbody.length;i++){
			Printer.WriteTextLineX("  收费名称："+Dataa.retbody[i].sqxmmc);
			Printer.WriteTextLineX("");
			Printer.WriteTextLineX("  费用金额："+Dataa.retbody[i].sfje00+"元");
			Printer.WriteTextLineX("");
		}
		Printer.WriteTextLineX("  患者姓名："+window.parent.xming0);
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  就诊卡号："+window.parent.brid00);
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  卡内余额："+yjjye0+"元");
		Printer.LFX(2); //多行送纸
		Printer.SetTextModeX(1); //设置中文模式
		Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
		Printer.WriteTextLineX("");
		Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
		Printer.LFX(3); //多行送纸
		Printer.CeTCutX(); //切纸						
	}
	 
	//密码错误3次提示稍后再试
	var num=0;
	$("#sure").bind("click dbclick", function() {
		if(num==3){
			$("#tip_div").show();
  			$("#error").text("密码错误，错误次数已达上限，请稍后再试!");
  			$("#tip_s").on("click", function() {
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}else{
			var mm=$("#KeyValue").val();
			if(mm==pin000){
				mzjiesuan();
			}else{
				num++;
				$("#KeyValue").val("");
				$("#KeyValue").focus();
				$("#tip_div").show();
	  			$("#error").text("密码错误，当前错误次数:"+num+"，错误三次后请稍后再试!");			
			}
		}
	});
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});
	$("#main").bind("click dbclick", function() {
		$.session.clear();
		window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	
	
	/**
* js分页类
* @param iAbsolute 每页显示记录数
* @param sTableId 分页表格属性ID值，为String
* @param sTBodyId 分页表格TBODY的属性ID值,为String,此项为要分页的主体内容
* @Version 1.0.0
* @author 辛现宝 2007-01-15 created
* var __variable__; private
* function __method__(){};private
*/
function Page(iAbsolute,sTableId,sTBodyId)
{
this.absolute = iAbsolute; //每页最大记录数
this.tableId = sTableId;
this.tBodyId = sTBodyId;
this.rowCount = 0;//记录数
this.pageCount = 0;//页数
this.pageIndex = 0;//页索引
this.__oTable__ = null;//表格引用
this.__oTBody__ = null;//要分页内容
this.__dataRows__ = 0;//记录行引用
this.__oldTBody__ = null;
this.__init__(); //初始化;
};
/*
初始化
*/
Page.prototype.__init__ = function(){
this.__oTable__ = document.getElementById(this.tableId);//获取table引用
this.__oTBody__ = this.__oTable__.tBodies[this.tBodyId];//获取tBody引用
this.__dataRows__ = this.__oTBody__.rows;
this.rowCount = this.__dataRows__.length;
try{
this.absolute = (this.absolute <= 0) || (this.absolute>this.rowCount) ? this.rowCount : this.absolute; 
this.pageCount = parseFloat(this.rowCount%this.absolute == 0 
? this.rowCount/this.absolute : this.rowCount/this.absolute+1);
}catch(exception){}

this.__updateTableRows__();
};
/*
下一页
*/
Page.prototype.nextPage = function(){
if(this.pageIndex + 1 < this.pageCount){
this.pageIndex += 1;
this.__updateTableRows__();
}
};
/*
上一页
*/
Page.prototype.prePage = function(){
if(this.pageIndex >= 1){
this.pageIndex -= 1;
this.__updateTableRows__();
}
};
/*
首页
*/
Page.prototype.firstPage = function(){
if(this.pageIndex != 0){
this.pageIndex = 0;
this.__updateTableRows__();
} 
};
/*
尾页
*/
Page.prototype.lastPage = function(){
if(this.pageIndex+1 != this.pageCount){
this.pageIndex = this.pageCount - 1;
this.__updateTableRows__();
}
};
/*
页定位方法
*/
Page.prototype.aimPage = function(iPageIndex){
if(iPageIndex > this.pageCount-1){
this.pageIndex = this.pageCount - 1;
}else if(iPageIndex < 0){
this.pageIndex = 0;
}else{
this.pageIndex = iPageIndex;
}
this.__updateTableRows__();
};
/*
执行分页时，更新显示表格内容
*/
Page.prototype.__updateTableRows__ = function(){
var iCurrentRowCount = this.absolute * this.pageIndex;
var iMoreRow = this.absolute+iCurrentRowCount > this.rowCount ? this.absolute+iCurrentRowCount - this.rowCount : 0;
var tempRows = this.__cloneRows__();
//alert(tempRows === this.dataRows);
//alert(this.dataRows.length);
var removedTBody = this.__oTable__.removeChild(this.__oTBody__);
var newTBody = document.createElement("TBODY");
newTBody.setAttribute("id", this.tBodyId);

for(var i=iCurrentRowCount; i < this.absolute+iCurrentRowCount-iMoreRow; i++){
newTBody.appendChild(tempRows[i]);
}
this.__oTable__.appendChild(newTBody);
/*
this.dataRows为this.oTBody的一个引用，
移除this.oTBody那么this.dataRows引用将销失,
code:this.dataRows = tempRows;恢复原始操作行集合.
*/
this.__dataRows__ = tempRows;
this.__oTBody__ = newTBody;
//alert(this.dataRows.length);
//alert(this.absolute+iCurrentRowCount);
//alert("tempRows:"+tempRows.length);

};
/*
克隆原始操作行集合
*/
Page.prototype.__cloneRows__ = function(){
var tempRows = [];
for(var i=0; i<this.__dataRows__.length; i++){
/*
code:this.dataRows[i].cloneNode(param), 
param = 1 or true:复制以指定节点发展出去的所有节点,
param = 0 or false:只有指定的节点和它的属性被复制.
*/
tempRows[i] = this.__dataRows__[i].cloneNode(1);
}
return tempRows;
};
//页面加载执行
	getJSInfo();
		//log.WriteLog("开始获取结算信息");
</script>
</html>
