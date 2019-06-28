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
<title>PDF展示Demo</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"
	charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
 <script type="text/javascript" src="../../js/jcpfree.js"></script> 
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
/* 	background:url(../../images/m_mz_mzbl/mzbl_query.jpg) no-repeat; */
}

</style>
<script type="text/javascript">
  $(function () {
		var pdfurl = $.session.get("pdfurl");
        var purl = pdfurl;//要展示的文件路径
        // 下面代码都是处理IE浏览器的情况 
        if (window.ActiveXObject || "ActiveXObject" in window) {
          //判断是否为IE浏览器，"ActiveXObject" in window判断是否为IE11
          //判断是否安装了adobe Reader
          for (x = 2; x < 10; x++) {
            try {
              oAcro = eval("new ActiveXObject('PDF.PdfCtrl." + x + "');");
              if (oAcro) {
                flag = true;
              }
            } catch (e) {
                flag = false;
            }
          }
            try {
              oAcro4 = new ActiveXObject('PDF.PdfCtrl.1');
                if (oAcro4) {
                  flag = true;
                }
            } catch (e) {
                flag = false;
            }
            try {
              oAcro7 = new ActiveXObject('AcroPDF.PDF.1');
              if (oAcro7) {
                flag = true;
              }
            } catch (e) {
              flag = false;
            }

            if (flag) {//支持
              pdfShow(purl);//调用显示的方法

            }else {//不支持
              $("#page1").append("对不起,您还没有安装PDF阅读器软件呢,为了方便预览PDF文档,请选择安装！");
              alert("对不起,您还没有安装PDF阅读器软件呢,为了方便预览PDF文档,请选择安装！");
              location = "http://ardownload.adobe.com/pub/adobe/reader/win/9.x/9.3/chs/AdbeRdr930_zh_CN.exe";
            }
        }else {
                    pdfShow(purl);//调用显示的方法
                    doPrint();
        }
    });
 function doPrint() {  
  	 var jcp = getJCP(); 	 
     var printerselect ;
	 jcp.getDefaultPrinters(function(printer){
		 printerselect = printer;
	 });
     var myDoc = {  
         settings : {  
             // 设置要输出的打印机  
             printer : printerselect,
             paperName : "A4",  
             portrait : true, 
             copies : 1, // 打印份数
             pageFrom : 1,
             pageTo : 1  
         },  
         documents : document.getElementById("myframe").contentWindow.document, 
         copyrights : '杰创软件拥有版权  www.jatools.com'  
     }; 	 
     jcp.print(myDoc, false); // 不弹出对话框打印  
 }  
    //显示文件方法，就是将文件展示到div中
    function pdfShow(url){
        $("#page1").append('<iframe id="myframe" style="height:100%;width:100%;" src="'+url+'"></iframe>');
    }

</script>

</head>
</head>
<body>
 	<!--展示的div-->
 	<div style="display:block;">
	    <div id="page1" style="width:1000px;height: 768px;">
	    </div>
    </div>
    
</body>
<script type="text/javascript">
 
</script>  
</html>
