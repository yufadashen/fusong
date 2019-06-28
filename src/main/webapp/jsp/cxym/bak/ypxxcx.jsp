<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<object width="0" height="0" id="printer"
	classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"> </object>
<title>药品目录列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->

<style type="text/css">
body {
	margin: 0px;
	width: 100%;
	height: 100%;
	overflow: hidden;
	text-align: center;
	background:url(../../images/bgn.jpg) no-repeat;
}

#bottomArea {
	background-color: #3f7dac;
	width: 100%;
	height: 65px;
	margin-left: 0px;
	text-align: left;
	font-size: 50px;
	color: white;
	margin-top: 50px;
	line-height: 30px;
}

#showArea {
	border: 1px black solid;
	border-radius: 10px;
	width: 995px;
	height: 570px;
	margin-left: 11px;
	margin-top: 20px;
	behavior: url(../../js/PIE.htc);
}

#biaotou {
	font-size: 50px;
	background-color: #3f7dac;
	color: white;
	padding-left: 50px;
	height: 60px;
	text-align: left;
	vertical-align: text-bottom;
}

#rebuildArea {
	position: absolute;
	border: 1px black solid;
	height: 300px;
	width: 550px;
	margin: 100px 0px 0px 245px;
	border-radius: 5px;
	behavior: url(../../js/PIE.htc);
}

.pageButton {
	width: 260px;
	height: 60px;
	border-radius: 10px;
	background-color: #85c531;
	margin-left: 350px;
	margin-top: 440px;
	line-height: 60px;
	font-size: 30px;
	color: white;
	behavior: url(../../js/PIE.htc);
}

#confirmBtn {
	border: 2px solid #3f7dac;
	width: 180px;
	height: 60px;
	line-height: 60px;
	border-radius: 10px;
	margin-left: 20px;
	behavior: url(../../js/PIE.htc);
}
</style>

</head>
<body scroll="no" id="info">
	<div id="biaotou">药品目录查询</div>

	<div id="showArea">
		<div id="wxts"></div>
		<div id="rebuildArea">
			<div style="margin-top: 50px;font-size: 20px;">
				<font style="font-size: 30px;">请&nbsp;输&nbsp;入&nbsp;正&nbsp;确&nbsp;的&nbsp;&nbsp;“<span
					style="font-size: 30px;color: red;">药&nbsp;品&nbsp;名&nbsp;称</span>”&nbsp;!
				</font>
			</div>
			<div style="margin-top: 100px;font-size: 25px;">
				药&nbsp;品&nbsp;名&nbsp;称：<font color="#85c531">_______________________</font>
				<div
					style="position: absolute;margin-left: 230px; margin-top: -27px;">
					<input id="xmmc00" type="text"
						style="height:25px;width:190px;border:none;background: none;margin-left: -35px;margin-top: -5px;">
						<img id="keyinsert" src="../../images/keyboard.jpg">
				</div>
			</div>
			<div id="warning" style="margin-top:50px;font-size: 20px;display: none;">
				<img src="../../images/warning.jpg">
				<font style="font-size: 30px;">请&nbsp;输&nbsp;入&nbsp;“<span
					style="font-size: 30px;color: red;">汉&nbsp;字</span>”&nbsp;!
				</font>
			</div>
		</div>
		<div class="pageButton" id="#confirmBtn">确&nbsp;&nbsp;认&nbsp;&nbsp;查&nbsp;&nbsp;询</div>
	</div>
	<div id="bottomArea">
		<span style="margin-left:620px;"> <img id="main"
			style="margin-top:8px;"
			src="${pageContext.request.contextPath}/images/index.png" res_img="" />
		</span> <span style="margin-left:40px;"> <img id="pre"
			style="margin-top:6px;"
			src="${pageContext.request.contextPath}/images/return.png" res_img="" />
		</span>
	</div>

</body>

<script language="javascript">
	var init = function() {
		 jump();
	}
	function jump(){
			$("#main").bind("click dbclick", function() {
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
			});
			$("#pre").bind("click dbclick", function() {
				window.location.href = "${pageContext.request.contextPath}/jsp/cxym/ypzlcx.jsp";
				});
			$(".pageButton").bind("click dbclick", function() {
				var xmmc00 = $("#xmmc00").val(); 
				if(xmmc00 != null && xmmc00 != " "){
					window.location.href = "${pageContext.request.contextPath}/jsp/cxym/ypzlcx2.jsp?xmmc00="+xmmc00;
				}else{
					window.location.href = "${pageContext.request.contextPath}/jsp/cxym/ypzlcx.jsp";
				}
			});
			$("#keyinsert").bind("click dbclick",function(){
				show();
				document.getElementById("xmmc00").focus();
				
			}); 
	}
	
	function show() {
		/* alert(document.getElementById("warning").style);
		alert(document.getElementById("warning").style.display); */
		document.getElementById("warning").style.display = "";
	   /*  alert(document.getElementById("warning").style.display); */
	}
	init();
</script>
</html>

