
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
<head>
<title>门诊缴费</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	text-align: center;
	background:url(../../images/bgn.jpg) no-repeat;
}

#titleArea {
	font-size: 50px;
	background-color: #3f7dac;
	color: white;
	padding-left: 25px;
	height: 60px;
	text-align: left;
	vertical-align: text-bottom;
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
	behavior: url(../../js/PIE.htc);
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

#confirmBtn {
	border: 2px solid #3f7dac;
	width: 180px;
	height: 60px;
	line-height: 60px;
	border-radius: 10px;
	margin-left: 20px;
	behavior: url(../../js/PIE.htc);
}
#tff{
	margin-top:10px;
	margin-bottom:10px;
}
#showArea {
	
	border-radius: 10px;
	width: 995px;
	height: 570px;
	margin-left: 0px;
	margin-top: 20px;
	behavior: url(../../js/PIE.htc);
}
table th {
	color: white;
	background-color: #3f7dac;
}
#wxts {
	position: absolute;
	font-size: 30px;
	margin-left:40px;
	margin-top: 0px;
	text-align:center;
}

#yycg {
	position: absolute;
	margin-left: 364px;
	font-size: 68px;
	margin-top: 209px;
}

#confirmApp {
	margin-top: 450px;
	margin-left: 378px;
	behavior: url(../../js/PIE.htc);
}
span{
	
	text-align:center;
}
</style>
</head>
<body scroll="no" id="info">
	
	<div id="time"
		style="position:absolute;top:5px;left:800px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">门诊缴费明细</font>
	</div>
	<div id="showArea">
		<div id="wxts">
			
			<span>账户余额：</span>
			<input readonly="readonly" id="yjjye0" type="text"
						style="height:25px;width:150px;height:40px;border:none;background: none;color:red;">
			<span>未付金额：</span>
			<input readonly="readonly" id="wfje00" type="text"
						style="height:25px;width:150px;height:40px;border:none;background: none;color:red;">
			<span>需充值金额：</span>
			<input readonly="readonly" id="needmoney" type="text"
						style="height:25px;width:150px;height:40px;border:none;background: none;color:red;">
			
						
		</div>
	<div id="mzsfcx"
		style="z-index:30;position:absolute;left:15px;top:135px;display:block;text-align:center">
		<table id="mzsfcx1" style="table-layout:fixed;cellspacing:0px">
			<thead>
				<tr
					style="height:40px;background-color:#3f7dac;border:1px solid black;color:white;">
					<td
						style="width:70px;height:40px;border:1px solid black;font-size:25px;font-coloer:white;text-align:center">序号</td>
					<td
						style="width:300px;height:40px;border:1px solid black;font-size:25px;text-align:center">开单日期</td>
					<td
						style="width:150px;height:40px;border:1px solid black;font-size:25px;text-align:center">名称</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">金额</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">类别</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">收费状态					
						</td>
				</tr>
			</thead>
			<tbody id="info1">

			</tbody>
			<tfoot>
				<tr>
					<td colspan="6"
						style="width:200px;height:6px;font-size:35px;text-align:center;">
						<div id="tff">
							<button id="pageup" style="font-size:35px;height:50px"
								class="layui-btn layui-btn-primary layui-btn-radius"
								onclick="page.prePage();">上一页</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button id="confirmBtn"></button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button id="pagedown" style="font-size:35px;height:50px"
								class="layui-btn layui-btn-primary layui-btn-radius"
								onclick="page.nextPage();">下一页</button>
						<div/>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
		
	</div>
	<div id="bottomArea">
		<span style="margin-left:620px;"> <img id="btnMain"
			style="margin-top:8px;"
			src="${pageContext.request.contextPath}/images/index.png" res_img="" />
		</span> <span style="margin-left:40px;"> <img id="btnReturn"
			style="margin-top:6px;"
			src="${pageContext.request.contextPath}/images/return.png" res_img="" />
		</span>
	</div>

</body>
<script src="../../js/page.js"></script>
<script type="text/javascript">
	//<img src="../../images/bgn">查看详情的图片
	// var zjlx00 = window.parent.cardtype; //证件类型 ：01、02、5
	// var zjbm00 = window.parent.cardNo; //证件编号
	var xming0 = window.parent.xming0; //患者姓名
	//var sfzhao = window.parent.sfzhao; //身份证号
	var yjjye0 = window.parent.yjjye0; //卡内余额
	// var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
	// var sfykt0 = window.parent.sfykt0; //是否为一卡通
	// var money; //预交金金额
	var wfje00;//费用金额
	var needmoney;//需交金额
	var time1 = 30;
	//初始化倒计时时间：60秒
	var time = 60;
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
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
		time = 60;
	}
	//returnTime();
	
	function logicBusiness() {
		$("#yjjye0").val(window.parent.yjjye0);
	}
	/*
	*获取该账户的所有收费项目zdbh00
	yyjgdm
	sflsh0
	*/
	function getAllSF(){
		//收费查询参数
		var datas = {
			"funcid" : "M07.02.05.04",
			"zdbh00" : window.parent.zdbh00,
			"brid00" : window.parent.brid00
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				//$("#info1").empty();//清空列表
				wfje00 = Data.retbody[0].wfje00 //未付费用金额
				$("#wfje00").val(wfje00);
				needmoney = Data.retbody[0].bjje00 //需交金额
				$("#needmoney").val(needmoney);
				setDataSF();
				//window.location.href = "${pageContext.request.contextPath}/jsp/cxym/mzsfcxerror.jsp";
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
			}
		})
		
	}
	/*
	* 渲染方法
	*/
	function setDataSF(){
		if (Data.retcode == "0") {
			var length = 0;
			for(var key in  Data.retbody[0]){
				length++;
			}
		
			var rowlength = (length - 3)/6;
			if(rowlength<1){
				window.location.href = "${pageContext.request.contextPath}/jsp/cxym/mzsfcxerror.jsp";
			}else{
				var j = 1;
			for (var i = 1; i <= rowlength; i++) {
				var kfrq = "kfrq00"+i;
				var xmmc = "xmmc00"+i;
				var xmfy = "xmfy00"+i;
				var xmlb = "xmlb00"+i;
				var sfbz = "sfbz00"+i;
				if (j <= 8) {
					var kfrq00 = Data.retbody[0][kfrq];
					var xmmc00 = Data.retbody[0][xmmc];
					var xmfy00 = Data.retbody[0][xmfy];
					var xmlb00 = Data.retbody[0][xmlb];
					var sfbz00 = Data.retbody[0][sfbz];
					$("#info1").append(
						"<tr style=\"height:50px;border:1px solid black;\">"
						+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + j + "</th>"
						+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + kfrq00+"</td>"
						+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + xmmc00+"</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + xmfy00+"</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + xmlb00+"</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + sfbz00+"</td>"
						+ "</tr>");
					j++;
				} else {
					j = 1;
					//i--;
				}
			}
			var duochurow =rowlength % 8
			empt = 8 - duochurow;
			var xh = duochurow+1;
			if(empt==8){
			//正好查询出整页
			}else{//填充非整页页面数据
				for (var k = 1; k <= empt; k++) {
					
					$("#info1").append(
						"<tr style=\"height:50px;border:1px solid black;\">"
						+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" +xh+ "</th>"
						+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + " " + "</td>"
						+ "</tr>");
					xh++;
				}
			}
			
			page = new Page(8, "mzsfcx1", "info1");
			$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
			}
			
		} else {
			$("#info1").append(
				"<tr style=\"height:50px;border:1px solid black;\">"
				+ "<td colspan='6' style='width:200px;height:80px;font-size:35px;text-align:center;'>" + Data.retmsg + "</td>"
				+ "</tr>");
		}
	
	}
	
	
	/**
	*初始化操作
	**/
	var init = function() {
		logicBusiness();
		getAllSF();
		$("#btnMain").bind("click dbclick", function() { //返回主页
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() { //返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});
		$("#confirmApp").on("click", function() { //确认完毕返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});
		returnTime(); //倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	//PrintTicket();打印小票//TODO
	}
	init();
</script>
</html>

