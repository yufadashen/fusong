<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>	
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>	
<object width="" height="" id="printbmp" classid="clsid:1691CDA2-0C31-47DB-BFCB-26ECC899AFC5">
</object>
<title>PDF展示Demo</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"
	charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(../../images/waiting.jpg) no-repeat;
}
#name00{
	top:120px;
	left:270px;
	width: 160px;
	height: 40px;
	text-align: center;
	font-size: 35px;
}
#idCard{
	top:120px;
	left:550px;
	width: 260px;
	height: 40px;
	text-align: center;
	font-size: 35px;
}
#yjjyexs{
	top:220px;
	left:540px;
	width: 165px;
	height: 40px;
	text-align: center;
	font-size: 35px;
}
#confirm{
	top:598px;
	left:396px;
	width: 240px;
	height: 56px;
	text-align: center;
	font-size: 35px;
}
#main{
	top:707px;
	left:683px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}
#pre{
	top:707px;
	left:852px;
	width: 150px;
	height: 50px;
	text-align: center;
	font-size: 35px;
}

</style>
</head>
<body>
<!--展示的div-->
<div id="tip_div"  style="margin: 385px 319px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:176px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:554px" />
   </div> 
<div id="waiting"  style="margin: -529px 0px 0px 0px;display:block;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
	 <img src="${pageContext.request.contextPath}/images/waiting.gif" >
   </div>
</body>
<script type="text/javascript" src="../../js/jcpfree.js"></script>
<script type="text/javascript">
			var	jcdh00;//检查单号 
			var cxdm00;//查询代码
			var	bglx00;//报告类型
			var	bgxh00;//报告序号
			var	ftpurl;//报告下载地址
			var	bgrq00;//报告日期
			var	bgzt00;//报告状态
			var bgztmc;//报告状态名称
			var	pdfstr;//base64流
			var	bmpurl;//bmpurl图片地址
			var	pdfname;//pdf名称
			var statusret; //打印机状态
			var printType02 =  $.session.get("printType02");
			var logger = window.parent.Logger;
			var xdtcxfs = 1;//心电图查询方式
function init(){
	$("#waiting").show();
		dayinpanduan();
		//event();
	}
function event(){
	$("#waiting").hide();
	$.session.set("statusret",statusret);
	window.location.href = "${pageContext.request.contextPath}/jsp/bgddy/printresult.jsp";
}
function dayinpanduan(){	
		//打印类型获取成功
		if(printType02){
				
				if(printType02 == "blbgdysrblh"){//输入病例号打印方式，1
					cxdm00 = $.session.get("printblh00");
					blbgPrintPDF();//获取病理报告打印PDF
				}else if(printType02 == "blbgdytmsm"){//条形码扫码打印方式，2
					cxdm00 = $.session.get("printtmsm");
					blbgPrintPDF();//获取病理报告打印PDF
				}else if(printType02 == "xdtbgdysrblh"){//输入病例号打印方式，1
					xdtcxfs = 5;
					cxdm00 = $.session.get("printblh00");
					xdbgPrintPDF();//获取心电报告打印PDF
				}else if(printType02 == "xdtbgdytmsm"){//条形码扫码打印方式，2
					xdtcxfs = 5;
					cxdm00 = $.session.get("printtmsm");
					xdbgPrintPDF();//获取心电报告打印PDF
				}else if(printType02 == "xdtbgdysrzyh"){//输入住院号打印方式，3
					xdtcxfs = 4;
					cxdm00 = $.session.get("printzyh00");
					xdbgPrintPDF();//获取心电报告打印PDF
				}else if(printType02 == "xdtbgdyduka"){//读卡打印方式，4
					cxdm00 = window.parent.cardNo;
					xdtcxfs = 1;
					xdbgPrintPDF();//获取心电报告打印PDF
				}else if(printType02 == "jybgddyduka"){//读卡打印方式，1
					cxdm00 ="2@"+window.parent.cardNo+"@CLOSE";
					jybgdPrintPDF();//获取检验报告单打印PDF
				}else if(printType02 == "jybgddysrblh"){//输入病例号打印方式，2
					cxdm00 ="1@"+$.session.get("printblh00")+"@CLOSE";
					jybgdPrintPDF();//获取检验报告单打印PDF
				}else if(printType02 == "jybgddytmsm"){//条形码扫码打印方式，3
					cxdm00 ="3@"+$.session.get("printtmsm")+"@CLOSE";
					jybgdPrintPDF();//获取检验报告单打印PDF
				}else{
					$("#waiting").hide();
					$("#tip_div").show();
					$("#error").text("打印方式错误！");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
		}else{
			$("#waiting").hide();
			$("#tip_div").show();
			$("#error").text("打印类型获取失败");
			$("#tip_s").on("click", function() {
				$("#tip_div").hide();
				$.session.clear();
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
		}
	}

	//获取病理报告打印 PDF
	function blbgPrintPDF(){
		var datas = {
				"funcid" : "M07.02.18.01",
				"cxdm00" : cxdm00,		//查询代码		
				"cxfs00" : "1",		//查询方式
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
					$("#waiting").hide();
					Data = eval(json);
					if(Data.retcode== "0"){
						
						if(Data.retbody.length > 0){
							bmpurl=Data.retbody[0].pdfurl;//pdf的地址
							jcdh00=Data.retbody[0].jcdh00;//检查单号
							bglx00=Data.retbody[0].bglx00;//报告类型
							bgxh00=Data.retbody[0].bgxh00;//报告序号
							bgzt00=Data.retbody[0].bgxh00;//报告状态
							$.session.set("cxdm00",cxdm00);
							$.session.set("jcdh00",jcdh00);
							$.session.set("bglx00",bglx00);
							$.session.set("bgxh00",bgxh00);
							$.session.set("bgzt00",bgzt00);
							//bgztmc=Data.retbody[0].bgztmc;//报告状态名称
							blbgprint(bmpurl);	
						}else{
							$("#waiting").css("display","none");
							$("#tip_div").show();
							$("#error").text("获取病理报告单失败，查无此["+cxdm00+"]病人信息");	
							$("#tip_s").on("click", function() {
								$("#tip_div").hide();
								$.session.clear();
								window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
							});
						}
						
					}else{
						$("#waiting").css("display","none");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);	
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
					
				},
				error : function() {
					$("#waiting").css("display","none");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);	
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			});		
	};
	//获取检验报告单   vps
	function jybgdPrintPDF(){
		logger.WriteLog("检验报告单查询参数:"+cxdm00)
		$.session.set("cxdm00", cxdm00);  //cxdm00:查询代码传入vps
		window.location.href = "${pageContext.request.contextPath}/jsp/bgddy/jybgdvps.jsp";
	};
	//获取心电图 打印 PDF
	function xdbgPrintPDF(){
		$.session.set("xdtcxfs",xdtcxfs);
		var datas = {
				"funcid" : "M07.02.18.03",
				"zdbh00" : window.parent.zdbh00,
				"yyjgdm" : "",
				"cxdm00" : cxdm00,		//查询代码		
				"cxfs00" : xdtcxfs,			//查询方式
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
					//$("#waiting").css("display","none");
					Data = eval(json);
					if(Data.retcode== "0"){
						bmpurl=Data.retbody[0].pdfurl;//pdf下载地址
						var xmmc00=Data.retbody[0].xmmc00;//报项目名
						var dycs00=Data.retbody[0].dycs00;//打印次数
						var dybz00=Data.retbody[0].dybz00;//打印标志
						var xmzt00=Data.retbody[0].xmzt00;//项目状态
						//$.session.set("xmbh00", xmbh00); 
						$.session.set("cxdm00",cxdm00);
						if(dycs00<1){
							xdbgprint(bmpurl);	
						}else{
							$("#tip_div").show();
							$("#error").text("该报告已打印，请勿重复打印！");	
							$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
						}
					}else{
						$("#waiting").css("display","none");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);	
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							$.session.clear();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
				},
				error : function() {
					$("#waiting").css("display","none");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);	
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			});		
	};
	//心电报告打印方法
	function xdbgprint(bmpurl){
		bmpurl = "http://188.188.28.81:7001/lyrmzzjserver/pdf"+bmpurl;
		console.log(bmpurl);
		
		var obj = document.getElementById("printbmp");
		var ret;
		ret = obj.InitPrinter("HP PageWide Pro 452dw Printer UPD PCL 6");
		//alert("InitPrinter(\"HP PageWide Pro 452dw Printer UPD PCL 6\") ret = " + ret);

		statusret = obj.CheckPrinterStatus("HP PageWide Pro 452dw Printer UPD PCL 6");
		//alert("CheckPrinterStatus(\"HP PageWide Pro 452dw Printer UPD PCL 6\") statusret = " + statusret);

		//bmpurl = "http://188.188.28.81:7001"+bmpurl;
		ret = obj.DownloadFile(bmpurl, "C:/xdtbgd.pdf", 5000);
		
		ret = obj.ShellPrint("C:/xdtbgd.pdf");
		//alert("ShellPrint() ret = " + ret);
		obj.DeleteFile("C:/xdtbgd.pdf");
		
		setTimeout("yanchi();",6000);

 }
 //病理报告打印方法
 function blbgprint(bmpurl){
	 //bmpurl = "http://188.188.28.81:7001/lyrmzzjserver/pdf"+bmpurl;
	//$("#waiting").hide();
	//alert(123);

	var obj = document.getElementById("printbmp");
	//alert(456);
	var ret;
	
	statusret = obj.CheckPrinterStatus("HP PageWide Pro 452dw Printer UPD PCL 6");

	ret = obj.DownloadFile(bmpurl, "C:/blbgd.pdf", 5000);
	//alert("DownloadFile() ret = " + ret);
	
	ret = obj.ShellPrint("C:/blbgd.pdf");
	
	obj.DeleteFile("C:/blbgd.pdf");
	//alert("DeleteFile() ret = " + ret);
	//alert(statusret);
	setTimeout("yanchi();",6000);

 }
 function  yanchi(){
			$("#waiting").hide();
			//statusret = 0;
			$.session.set("statusret",statusret);
			window.location.href = "${pageContext.request.contextPath}/jsp/bgddy/printresult.jsp";
		}
	init();
</script>
</html>
