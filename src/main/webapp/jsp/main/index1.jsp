<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
 <head>
 	<OBJECT classid=clsid:D21F6E52-42EA-44B5-A3EA-F2D069C2B9E5 width=0 height=0 align="center"  id="CHeNanCPUCtrl" HSPACE=0 VSPACE=0></OBJECT>
    <title>吉林大学白求恩第一医院—检测硬件</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
    <style>
    body {
        width: 1080px;
        height: 1920px;
        overflow: hidden;
        background: url(${pageContext.request.contextPath}/images/bg.jpg) no-repeat; 
    }
    </style>
   </head>
 <body scroll="no">
	<div id="error">
		<span id="error_msg">系统初始化中，请稍后 ...... </span>
	</div>
</body>
 <script type="text/javascript">
 	$(document).ready(function(){
 		function getDevice(){
 			window.parent.openDevices();
			//检查硬件状态
			var CardReader = window.parent.Card;
			var Ret = CardReader.GetDeviceStatus();
			var retCode = (""+Ret.RetVal).substr(0,3);
			if(retCode=="109")
			{
				if(Ret.RetVal != 109000)
				{
					CardReader.Eject();
					CardReader.DisEntry();
				}					
				var PinObj = window.parent.Pad;
				var PinRet = PinObj.GetDeviceStatus();	
				if(PinRet.RetVal==103000){
					var cashBV = window.parent.CashBV;
					var castatus = cashBV.GetDeviceStatus().RetVal;
					if(castatus=="110000"){
						var re4 = document.getElementById("CHeNanCPUCtrl").CloseDevice();
						window.location.href="/jsp/main/main.jsp";
					}else{
						$("#error_msg").text("识币器异常：，请联系营业员！");
					}
					
				}else{
					$("#error_msg").text("密码键盘异常："+PinRet.RetVal+"，请联系营业员！");
				}
			}else{
				$("#error_msg").text("读卡器异常："+Ret.RetVal+"，请联系营业员！");
			}
		}
 			
 		getDevice();
 		//window.location.href="/jsp/main/main.jsp";
 		
 	});
 </script>
</html>
