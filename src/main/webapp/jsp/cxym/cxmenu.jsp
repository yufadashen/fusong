<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>

<title>查询目录列表</title>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(${pageContext.request.contextPath}/images/bgn.jpg) no-repeat;
}

#ypjgcx {
	height: 138px;
	left: 40px;
	top: 313px;
	width: 301px;
}

#zlxxcx {
	height: 138px;
	left: 362px;
	top: 313px;
	width: 301px;
}

#czjlcx {
	height: 138px;
	left: 684px;
	top: 132px;
	width: 301px;
}

#myddc {
	height: 138px;
	left: 684px;
	top: 313px;
	width: 301px;
}
#yecx {
	height: 138px;
	left: 40px;
	top: 132px;
	width: 301px;
}
#pdfTest{
	height: 138px;
	left: 362px;
	top: 495px;
	width: 301px;
}
#zjpb {
	height: 138px;
	left: 37px;
	top: 493px;
	width: 301px;
}
#mzsfcx{
	height: 138px;
	width: 301px;
	top: 132px;
	left: 362px;
}
#main {
	height: 49px;
	left: 684px;
	top: 709px;
	width: 148px;
}

#pre {
	height: 49px;
	left: 852px;
	top: 708px;
	width: 148px;
}
div{
	border:1px red solid;
}
.menuss{
	position:absolute;
	color:white;
	font-size: 33px;
    text-align: center;
    line-height: 138px;
    border-radius: 14px;
}
</style>
</head>
<body scroll="no" id="info">
	<div id="yecx" class="menuss" style="background-color: #F89C35;">挂号信息查询</div>
	<div id="zjpb" class="menuss" style="background-color: #3D72A6;"></div>
	<div id="czjlcx" class="menuss" style="background-color: #3D72A6;">住院收费信息</div>
	<div id="myddc" class="menuss" style="background-color: #F89C35;"></div>
	<div id="mzsfcx" class="menuss" style="background-color: #6BAC14;"></div>
	<div id="pdfTest" class="menuss" style="background-color: #F89C35;"></div>
	<div id="ypjgcx" class="menuss" style="background-color: #E37655;">
	</div>
	<div id="zlxxcx" class="menuss" style="background-color: #2A547E;"></div>
	<div id="main" style="position:absolute;">
		<img alt="" src="../../images/yue/mzgh_index_y.png">
	</div>
	<div id="pre" style="position:absolute;">
		<img alt="" src="../../images/yue/mzgh_return_y.png">
	</div>
	<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>

<script>
	var mainnumber = window.parent.mainnumber;
	function event(){
		$("#ypjgcx").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/ypzlcx.jsp";
		});
		$("#zlxxcx").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/zlxxcx.jsp";
		});
		$("#czjlcx").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/cxzyInfo_b.jsp";
		});
		$("#yecx").bind("click dbclick", function() {
			window.parent.ttype=30;
			window.location.href = "${pageContext.request.contextPath}/jsp/main/readcard.jsp";
		});
		$("#zjpb").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/zjpb.jsp";
		});
		$("#myddc").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/myddc.jsp";
		});
		$("#mzsfcx").bind("click dbclick", function() {
			window.parent.ttype=10;
				window.location.href = "${pageContext.request.contextPath}/jsp/main/readcard.jsp";
			
		});

		$("#main").bind("click dbclick", function() {
			
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
			
				window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
		
		
		function init(){
			//$("#waiting").show();
			event();
		}
		init();
</script>
</html>

