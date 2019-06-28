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
</body>
<script type="text/javascript">
    var logger = window.parent.Logger;//日志OCX对象
	var jylsh0=$.session.get("jylsh0");//病历本流水号
	var pngurl = $.session.get("pngurl");//获取病历本BMPurl
	var flag = false;
	//var obj = window.parent.TestOcx;
	var obj = window.parent.BLBDYOcx;//病历本打印机OCX
	var ret;
	var ret2;//下载标识
	
	function Test()
 {
	//alert(123);
	//obj = document.getElementById("TestOcx2");
	logger.WriteLog("普通病历本打印，PDF下载中。。。");

	// DownloadFile第三个参数为超时时间，以毫秒为单位。下载超时不会调用DownloadFinished
	// 第二个参数可以传不存在的路径，ocx会自动创建文件夹
	ret2 = obj.DownloadFileBlock(pngurl, "C:\\blbbmp.bmp", 5000);
	logger.WriteLog(ret2==0?"普通病历本打印，PDF下载完成。":"普通病历本打印，PDF下载失败！");
	//alert("DownloadFile() ret = " + ret);
	// 下载完成
	//alert("DownloadOK, FilePath = " +"C:/TempBMP/aa.bmp");
	setTimeout("printBMP()",1000);
 }
 function printBMP(){
	 // 打印下载完成的图片
	
	obj.InitPrinter();//打印机名字
	
	obj.PrintBmp(220, 0, -1, -1, "C:\\blbbmp.bmp");
	
	//ret = obj.EndPrinting();
	var csNumber=0;
	var blbxh = setInterval(function (){
				ret = obj.GetStatus();
				logger.WriteLog("二次获取病历本打印机状态："+ret);
				if(ret == 8){
					csNumber=0;
					flag=true;
					clearInterval(blbxh);
					$.session.set("resultblbdy",flag);
					logger.WriteLog("打印病历本状态："+flag+"标识，代表成功打印!");
					window.location.href = "${pageContext.request.contextPath}/jsp/blbdy/printresult.jsp";
				}else{
					csNumber++;
					if(csNumber>=50){
						clearInterval(blbxh);
						$.session.set("resultblbdy",flag);
						logger.WriteLog("打印病历本状态："+flag+"标识，代表打印超时!");
						window.location.href = "${pageContext.request.contextPath}/jsp/blbdy/printresult.jsp";
					}
				}
			},200);
	// 打印完成，删除图片
	var ret = obj.DeleteFile("C:/blbbmp.bmp");
	//alert("DeleteFile() ret = " + ret);
 }
	function init(){
		Test();
	}
	init();
</script>
</html>
