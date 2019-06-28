<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
 <object id="AVFOCX" classid="clsid:A7C153B2-3299-4474-A6A0-6276739BDAC3" width="0" height="0">
               <param name="s1" value="" />
       </object>
	   
	   <object id="TestOcx" width="" height="" classid="clsid:36F9A108-B13F-4BBA-92D4-FDB1B5D0434B">
</object>
	   
	   
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
<title>检验报告单VPS调用</title>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	/* background:url(../../images/error.jpg) no-repeat; */
}
</style>
</head>
<body>
	<div id="tip_div"  style="margin: 385px 319px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:176px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:554px" />
   </div> 
<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
	 <img src="${pageContext.request.contextPath}/images/waiting.gif" >
   </div>

</body>
<script type="text/javascript">
	var jybgdvpscxdm;
	
	function init(){
		//WriteData1();
		reprint();
		ysfanhui();
	}
	function WriteData1(){
	//alert(123);

	var obj = document.getElementById("TestOcx");
	var ret;
	
	ret = obj.ShellExecute("D:\\rmlis6\\rmlis6_report.exe", "1@12345");
	alert("ShellExecute() return " + ret);
	
	ret = obj.ShellExecuteEx("D:\\rmlis6\\rmlis6_report.exe", "1@12345");
	alert("ShellExecuteEx() return " + ret);
	
	ret = obj.System("D:\\rmlis6\\rmlis6_report.exe 1@12345", "");
	alert("System() return " + ret);
 
		//jybgdvpscxdm = $.session.get("cxdm00");
		
		//var tmp = document.getElementById("TestOcx");
		
		//var xxx="1@"+jybgdvpscxdm;
		
		//var ret = tmp.ShellExecute("D:/rmlis6/rmlis6_report.exe ",xxx);
	
	}
	function exec(command) {
        window.oldOnError = window.onerror;
        window._command = command;
        window.onerror = function (err) {
            if (err.indexOf('utomation') != -1){
                alert('请更改你的IE的安全级别：开始->设置->控制面板->Internet选项->安全->自定义级别->对没有标记为安全的ActiveX控件进行初始化和脚本运行->启用。命令：'+ window._command);
                return true;
            }
            else
                return false;
        };

        var wsh = new ActiveXObject('WScript.Shell');
        if (wsh) wsh.Run(command);
        wsh = null;
        window.onerror = window.oldOnError;		
    }
	function ysfanhui(){

			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
	
	}
    function reprint(){
	  jybgdvpscxdm =$.session.get("cxdm00");
      var weblis="D:\\rmlis6\\rmlis6_report.exe "+jybgdvpscxdm;
      exec(weblis);
    }
	init();
</script>
</html>
