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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<script type="text/javascript">
function preview() { 
		$("#wdf").css("display","block");
	 	var printHtml=document.getElementById('usePrint').innerHTML,
        newWindow=window.open("",'newWindow');
        $("#wdf").css("display","none");
        newWindow.document.body.innerHTML = printHtml; 
        newWindow.print();  
 }
</script>



<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	background:url(../../images/m_mz_mzbl/mzbl_query.jpg) no-repeat;
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
<div id="name00" style="position:absolute;"></div>
<div id="idCard" style="position:absolute;"></div>
<div id="yjjyexs" style="position:absolute;"></div>
<div id="confirm" style="position:absolute;"></div>
<div id="main" style="position:absolute;"></div>
<div id="pre" style="position:absolute;"></div>
<div id="usePrint">
	<img id="wdf" src="" style="display: none">
</div>
<!--打印内容结束-->
<!--endprint1-->
<!-- <input type='button' name='button_export' title='打印1' onclick=preview() value='打印1'> -->

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
			var	jcdh00;//检查单号
			var	bglx00;//报告类型
			var	bgxh00;//报告序号
			var	ftpurl;//报告下载地址
			var	bgrq00;//报告日期
			var	bgzt00;//报告状态
			var	pdfstr;//base64流
			var	pdfurl;//pdfurl
			var	pdfname;//pdf名称

	document.getElementById('wdf').setAttribute( 'src','');
	function init(){
		$("#name00").text("岳帅锋");
		$("#idCard").text("000000000");
		$("#yjjyexs").text("8888.8888");
		event();
		
	}
	//病历本打印成功
	function successPrintBLB(){
		var datas = {
				"funcid" : "M07.02.08.03",
				"yyjgdm":"",//医院机构代码
				"cxdm00" : window.parent.cardNo,		//查询代码		
				"cxfs00" : window.parent.cardtype,		//查询方式
				"brid00" : window.parent.brid00, 		//病人id
			 	"zdbh00" : window.parent.zdbh00,		//终端编号
			 	"czybh0" : "",							//操作员编号
			 	"kflx00" : "2",							//扣费类型 2
			 	"ctype0" : window.parent.cardtype,
				/* "xbie00" : window.parent.xbie00,		//性别
				"blblx0" : "1"   	                    //病历本类型 1-普通病历本2-产科病历本 */
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
						
					},
					error : function() {
						$("#waiting").css("display","none");
						$("#tip_div").show();
						$("#error").text("系统数据错误。");	
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
							window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
						});
					}
			});	
				
				
	}
	//获取病历本首页PDF
	function getReportInformation(){
		var datas = {
				"funcid" : "M07.02.08.02",
				"cxdm00" : "001482173",							//查询代码		
				"cxfs00" : "1",		//查询方式
			 	"zdbh00" : "123",		//终端编号
				"xbie00" : "男",		//性别
				"blblx0" : "1"   	                    //病历本类型 ：    1-普通病历本     2-产科病历本
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
					var Data = eval(json);
					if(Data.retcode== "0"){
						pdfurl=Data.retbody[0].pdfurl;
						jylsh0=Data.retbody[0].jylsh0;
						var blbpdf = Data.retbody[0].pdfstr;
						//downloadFile(pdfurl);
					}else{
						$("#waiting").css("display","none");
						$("#tip_div").show();
						$("#error").text(Data.retmsg);	
						$("#tip_s").on("click", function() {
							$("#tip_div").hide();
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
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					});
				}
			});		
	};
	//下载pdf文件
	function downloadFile(url) {   
        try{ 
            var elemIF = document.createElement("iframe");   
            elemIF.src = url;   
            elemIF.style.display = "none";   
            document.body.appendChild(elemIF);   
        }catch(e){ 
 
        } 
    }
	//页面事件
	function event(){
		$("#confirm").bind("click dbclick", function() {
			if($("#yjjyexs").html()<1){
				$("#tip_div").show();
				$("#error").text("卡内余额不足,请充值.");	
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href = "${pageContext.request.contextPath}/jsp/pay/lypayway.jsp";
				});
			}else{
				//调用打印工本费1元接口
				 getReportInformation();
			}
		});
		
		$("#main").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
	}
	init();
</script>
</html>
