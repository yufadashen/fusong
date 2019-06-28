<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>查询挂号信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<script src="${pageContext.request.contextPath}/js/pageOper.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	behavior:url(../../js/PIE.htc);
	background:url(../../images/yue/bgn.jpg) no-repeat;
}
#titleArea{
	background-color:#3f7dac; 
	width:1024px;
	height:68px;
	text-align:left;
	font-size:44px;
	color:white;
	margin-top:0px;
}
#bottomArea{
	background-color:#3f7dac; 
	width:1024px;
	height:68px;
	text-align:left;
	font-size:24px;
	color:white;
	margin-top:0px;
	line-height:60px;
}
#showArea{
	/* border:1px black solid;  */
	border-radius:10px; 
	width:995px;
	height:570px;
	margin-left:11px;
	margin-top:20px;
	behavior:url(../../js/PIE.htc);
}
td{
	padding:3px;
}
.pageButton{
	width:180px;
	height:60px;
	border:1px black solid; 
	border-radius:10px; 
	background-color:#85c531;
	line-height:60px;
	margin-left:20px;
	behavior:url(../../js/PIE.htc);
}
#confirmBtn{
	border:2px solid #3f7dac;
	width:180px;
	height:60px;
	line-height:60px;
	border-radius:10px; 
	margin-left:20px;
	behavior:url(../../js/PIE.htc);
}
.theads{
	height:35px;
	border:1px solid #3f7dac;
	font-size:25px;
	text-align:center;
	color: white;
}
.tb_tr{
	height:35px;
	border:1px solid #3f7dac;
	margin:10px;
}
.tb_td{
	border:1px solid #3f7dac;
	font-size:20px;
	text-align:center;
	height:35px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">查询挂号信息</font>
	</div>
	<div id="showArea">
		<div style="width: 995px;height: 414px;">
			<table id="keshi_t" style="width:960px;margin-top:60px;margin-left:20px;">
				<tr style="width:100%; background-color:#3f7dac;border:1px solid black;">
					<td class="theads" style="width:6%;">序号</td>
					<td class="theads" style="width:15%;">预约日期</td>
					<td class="theads" style="width:30%;">预约科室</td>
					<td class="theads" style="width:15%;">预约医生</td>
					<td class="theads" style="width:15%;">候诊时间</td>
					<td class="theads" style="width:15%;">操作</td>
				</tr>
				<tbody id="info_t" >
				</tbody>
			</table>
		</div>
			
	    <table style="margin-top:20px;margin-left: 149px;">
			<tfoot>
				<tr>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.prePage($('#confirmBtn'))">上一页</div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px; text-align:center;">
						<div id="confirmBtn"></div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.nextPage($('#confirmBtn'))">下一页</div>
					</td>
				</tr>
			</tfoot>
		</table>
		
	</div>
	
	<div id="bottomArea">
		
		<span style="margin-left:660px;">
			<img id="btnMain" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" height="" width=""/>
		</span>
		<span style="margin-left:40px;">
			<img id="btnReturn" style="margin-top:4px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" height="" width=""/>
		</span>
	</div>
	
	<div id="tip_div"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
   	<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>
<script type="text/javascript">

	var time = 120;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 120;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					$.session.clear();
					//跳转页面
					window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			},1000);
	}
	//获取预约信息
	function getAppInfo() {
			var datas = {
				"funcid" : "M07.02.04.08",
				"cxdm00" : window.parent.cardNo//患者卡号
			};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"GetRegInfos",
				success : function(json) {
					var data = eval(json);
					var tbody = document.getElementsByTagName("tbody")[1];
					var table = document.getElementById("keshi_t");
					table.removeChild(tbody);
					var nbody = document.createElement("tbody");
					nbody.id="info_t";
					table.appendChild(nbody);
					if (data.retcode == "0") {
						var length = data.retbody.length;
						
						for (var i = 0; i < length; i++) {
							$("#info_t").append(
									"<tr class=\"tb_tr\">"
									+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
									+ "<td class=\"tb_td\">"+data.retbody[i].yyrq00+"</td>"
									+ "<td class=\"tb_td\">"+data.retbody[i].mzksmc+"</td>"
									/* + "<td class=\"tb_td\"><input type=\"text\" style=\"background:none;border:0px;\" value=\""+data.retbody[i].mzksmc+"\"></td>" */
									+ "<td class=\"tb_td\">"+data.retbody[i].mzysxm+"</td>"
									+ "<td class=\"tb_td\">"+data.retbody[i].yysj00+"</td>"//预约时间
									
									+ "<td style=\"display:none;\">"+data.retbody[i].yylsh0+"</td>"//预约号码
									+ "<td style=\"display:none;\">"+data.retbody[i].ksbh00+"</td>"//his科室编号
									+ "<td style=\"display:none;\">"+data.retbody[i].ysbh00+"</td>"//his医生编号
									+ "<td style=\"display:none;\">"+data.retbody[i].yysj00+"</td>"//
									
									+ "<td>"
										+ "<img src=\"../../images/yue/yyqx.jpg\" onclick='qxOperation(this)'></img>"
									+ "</td>"
									+ "</tr>")
						}
						page = new Page(8, "keshi_t", "info_t");
						$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
						
				} else {
					goError(data.retmsg);
				}
				$("#waiting").hide();
			},
			error : function() {
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");		
			}
		}); 
	}	
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#btnMain").bind("click dbclick", function() {//返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();
</script>
</html>