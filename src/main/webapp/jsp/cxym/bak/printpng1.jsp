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
/* 	background:url(../../images/m_mz_mzbl/mzbl_query.jpg) no-repeat; */
}
</style>

</head>
</head>
<body>
 	<!--展示的div-->
 	<div id="page1" style="display:block;">
	    
    </div>
</body>
<script type="text/javascript" src="../../js/jcpfree.js"></script>
<script type="text/javascript">
	function doPrint() { 
	 	var jcp = getJCP();   
      	var myDoc = {  
      	 	settings : {  
             	// 设置要输出的打印机  
             	//printer : "MS-STT420",
             	paperName : "A4",  
            	portrait : false, //纵向是TRUE 横向是FALSE
                copies : 1, // 打印份数
             	pageFrom : 1,
             	pageTo : 1  
         	},  
         	documents : document,  
         	copyrights : '杰创软件拥有版权  www.jatools.com'  
      	};  
		/*jcp.getPapers("MS-STT420",function(papers){
			for(var i; i < papers.length; i++){
				console.log(papers[i].name);
			}
		})*/
      	//alert(myDoc.settings.paperName);
		/*jcp.print(myDoc,{ 
			done:function(){
				window.location.href = "${pageContext.request.contextPath}/jsp/cxym/printsuccess.jsp";
			}	
		});  // 不弹出对话框打印 */
		jcp.print(myDoc,false);
     	/* getJCP().printDocument('api.pdf', {
			fileType : 'pdf',
			done : function() {
				hideLoading();
				alert("打印结束！")
			}
		}); */
 }  

	function init(){
		var pngurl = $.session.get("pngurl");
		$("#page1").append("<img id='testpng' src='"+pngurl+"'>");
		var falg = $("#testpng")[0].src;
		if(falg){
			doPrint();
		}
	}
	init();
</script>
</html>
