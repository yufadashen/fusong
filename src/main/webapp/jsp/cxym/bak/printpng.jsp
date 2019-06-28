<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>PDF展示Demo</title>
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
	background:url(../../images/m_mz_bgdy/bgdy_success.jpg) no-repeat; 
}
</style>
	
</head>
<body>

</body>
<script type="text/javascript">
	var jylsh0=$.session.get("jylsh0");//病历本流水号
	
	function Test(){
	//alert(123);

	var obj = document.getElementById("TestOcx");
	//alert(456);
	var ret;
	
	ret = obj.InitPrinter("Seaory S21");
	//alert("InitPrinter(\"MS-STT420\") ret = " + ret);
	
	obj.CheckPrinterStatus("MS-STT420");
	//alert("CheckPrinterStatus(\"MS-STT420\") ret = " + ret);
	
	ret = obj.StartPrinting();
	//alert("StartPrinting() ret = " + ret);
	var pngurl = $.session.get("pngurl");
	//alert(pngurl);
	ret = obj.DownloadFile(pngurl, "C:/aa.bmp", 5000);
	//alert("DownloadFile() ret = " + ret);
	
	obj.PrintImage(100, 0, 1665, 1188, "C:/aa.bmp");
	//alert("PrintImage() ret = " + ret);
	
	obj.DeleteFile("C:/aa.bmp");
	//alert("DeleteFile() ret = " + ret);
	
	ret = obj.EndPrinting();
	//alert("EndPrinting() ret = " + ret);
	
	event();
 }
	function event(){
		//病历本打印成功
		function successPrintBLB(){
			var datas = {
					"funcid" : "M07.02.08.03",
					
					"cxdm00" : window.parent.cardNo,		//查询代码		
					"cxfs00" : window.parent.cardtype,		//查询方式
					"jylsh0" : jylsh0,                      //病历本流水号
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
						//url : window.parent.serverUrl + "?method=ApplyAction",
						url : "${pageContext.request.contextPath}/Test/test.do",
						success : function(json) {
							$("#waiting").css("display","none");
							Data = eval(json);
							var dysj00 = Data.retbody[0].dysj00//打印时间
							if(dysj00){
								window.location.href = "${pageContext.request.contextPath}/jsp/blbdy/printresult.jsp";
							}
						},
						error : function() {
							$("#waiting").css("display","none");
							$("#tip_div").show();
							$("#error").text(Data.retmsg);	
							$("#tip_s").on("click", function() {
								$("#tip_div").hide();
								window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
							});
						}
				});		
		}
	}
	function init(){
		Test();
		
	}
	init();
</script>
</html>
