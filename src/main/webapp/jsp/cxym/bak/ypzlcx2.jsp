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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/layui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->

<style type="text/css">
body {
	width: 100%;
	height: 100%;
	overflow: hidden;
}

#bottomArea {
	background-color: #3f7dac;
	width: 100%;
	height: 60px;
	margin-left: 0px;
	text-align: left;
	font-size: 50px;
	color: white;
	margin-top: 648px;
	line-height: 60px;
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

table {
	border: solid 1px #3f7dac;
	padding-left: 20PX;
}

table th {
	color: white;
	background-color: #3f7dac;
}

label {
	color: black;
	font-size: 30px;
	height: 50px;
}

#pageup {
	background: #3f7dac;
	color: white;
	behavior: url(../../js/PIE.htc);
}

#pagedown {
	background: #3f7dac;
	color: white;
	behavior: url(../../js/PIE.htc);
}

.pageButton {
	width: 260px;
	height: 60px;
	border-radius: 10px;
	background-color: #85c531;
	margin-left: 220px;
	margin-top: 120px;
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
	<div id="biaotou">药品目录列表</div>
	<div id="time"
		style="position:absolute;top:30px;right:50px;font-size:30px;color: #FF0000;">
	</div>
	<%-- <div class="layui-inline">
		&nbsp;&nbsp;<label class="layui-form-label"
			style="width: 200px;padding-top: 30px;">药品名称:</label>
		<div class="layui-input-inline">
			<input id="xmmc00" style="margin-top: 25px;padding-top: 12px;"
				placeholder="输入药品名称">
		</div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button id="do_search" class="layui-btn" style="margin-top: 21px;">
			<img src="${pageContext.request.contextPath}/images/query.png">
		</button>
	</div>
 --%>
 	<input id="xmmc00" name="xmmc00" type="text" style="margin-top: 25px;padding-top: 12px;display: none;"
				placeholder="输入药品名称">
	<div id="ypzlcx"
		style="z-index:30;position:absolute;left:25px;top:135px;display:block;text-align:center">
		<table id="ypzlcx1" style="table-layout:fixed;cellspacing:2px">
			<thead>
				<tr
					style="height:40px;background-color:#3f7dac;border:1px solid black;color:white;">
					<td
						style="width:70px;height:40px;border:1px solid black;font-size:25px;font-coloer:white;text-align:center">序号</td>
					<td
						style="width:300px;height:40px;border:1px solid black;font-size:25px;text-align:center">名称</td>
					<td
						style="width:150px;height:40px;border:1px solid black;font-size:25px;text-align:center">规格</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">单位</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">单价</td>
					<td
						style="width:180px;height:40px;border:1px solid black;font-size:25px;text-align:center">自付比例</td>
				</tr>
			</thead>
			<tbody id="info1">

			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"
						style="width:200px;height:6px;font-size:35px;text-align:center;">
						<button id="pageup" style="font-size:35px;height:50px"
							class="layui-btn layui-btn-primary layui-btn-radius"
							onclick="page.prePage();">上一页</button>
					</td>
					<td colspan="2"
						style="width:200px;height:80px;font-size:30px; text-align:center;">
						<div id="confirmBtn"></div>
					</td>
					<td colspan="2"
						style="width:200px;height:60px;font-size:35px;text-align:center;">
						<button id="pagedown" style="font-size:35px;height:50px"
							class="layui-btn layui-btn-primary layui-btn-radius"
							onclick="page.nextPage();">下一页</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

	<div id="bottomArea">
		<span style="margin-left:664px;"> <img id="main"
			style="margin-top:-8px;"
			src="${pageContext.request.contextPath}/images/index.png" res_img="" />
		</span> <span style="margin-left:10px;"> <img id="pre"
			style="margin-top:-8px;"
			src="${pageContext.request.contextPath}/images/return.png" res_img="" />
		</span>
	</div>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/page.js"></script>
<script>
	var init = function() {
	 	var param = getParam("xmmc00");
	 	$("#xmmc00").attr("value", param);
		getYaoPin(); //药品列表
		jump(); //跳转页面方法
		returnTimeStart(); //倒计时方法
		console.log(${xmmc00});
	};
	
	
	/** 
	 * 获取指定的URL参数值 
	 * URL:http://www.quwan.com/index?name=tyler 
	 * 参数：paramName URL参数 
	 * 调用方法:getParam("name") 
	 * 返回值:tyler 
	 */ 
	function getParam(paramName) { 
	    paramValue = "", isFound = !1; 
	    if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=") > 1) { 
	        arrSource = unescape(this.location.search).substring(1, this.location.search.length).split("&"), i = 0; 
	        while (i < arrSource.length && !isFound) arrSource[i].indexOf("=") > 0 && arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase() && (paramValue = arrSource[i].split("=")[1], isFound = !0), i++ 
	    } 
	    return paramValue == "" && (paramValue = null), paramValue 
	}  
	//设置倒计时功能
	function returnTimeStart(){
		//初始化倒计时时间：120秒
		var time = 12111111111110;
		//自动倒计时，计时时间为0时，
		function returnTime() {
			myVar = setInterval(
				function() {
					time--;
					$("#time").text("倒计时：" + time + "S");
					if (time == 0) {
						//跳转页面
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					}
				}, 1000);
		}
		//用户点击或按键等操作时，倒计时重新计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		function timeAgin() {
			time = 121111111110;
		}
		returnTime();
	};
	//页面跳转方法	
	function jump() {
		$("#main").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});

	}

	//获取药品列表方法，渲染方法	
	function getYaoPin() {
		var xmmc00 = $("#xmmc00").val(); 
		alert(xmmc00);
		//获取初始化页面参数
		var datas = {
			"funcid" : "M07.02.06.44",
			"zdbh00" : "",
			"yyjgdm" : "",
			"brid00" : "",
			"xmmc00" : xmmc00 
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			/* url : window.parent.serverUrl + "?method=ApplyAction", */
			url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					var length = Data.retbody.length;
					var j = 1;
					for (var i = 0; i < length; i++) {
						if (j <= 8) {
							$("#info1").append(
								"<tr style=\"height:50px;border:1px solid black;\">"
								+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + j + "</th>"
								+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].xmmc00 + "</td>"
								+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].xmgg00 + "</td>"
								+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].xmdw00 + "</td>"
								+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].xmje00 + "元 </td>"
								+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].xmlb00 + " </td>"
								+ "</tr>");
							j++;
						} else {
							j = 1;
						}
					}
					empt = 8 - i % 8;
					if (empt == 8) {
						//正好查询出整页
					} else { //填充非整页页面数据
						for (var k = 0; k <= empt; k++) {
							$("#info1").append(
								"<tr style=\"height:50px;border:1px solid black;\">"
								+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + j + "</th>"
								+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + "</td>"
								+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + "</td>"
								+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + "</td>"
								+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + " </td>"
								+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + " </td>"
								+ "</tr>");
							j++;
						}
					}
					page = new Page(8, "ypzlcx1", "info1");
					$("#confirmBtn").text((page.pageIndex + 1) + "/" + page.pageCount);
				} else {
					$("#info1").append(
						"<tr style=\"height:400px;border:1px solid #3f7dac;\">"
						+ "<td colspan='6' style='width:200px;height:80px;font-size:35px;text-align:center;'>" + "查找数据无" + "</td>"
						+ "</tr>");
				}
			},
			error : function() {
				$("#info1").append(
					"<tr style=\"height:400px;border:1px solid #3f7dac;\">"
					+ "<td colspan='6' style='width:200px;height:80px;font-size:35px;text-align:center;'>" + "系统异常" + "</td>"
					+ "</tr>");
			}
		});
	}
	init();
</script>
</html>

