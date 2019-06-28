<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>查询挂号信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>

<script src="${pageContext.request.contextPath}/js/laydate.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/laydate.css" media="all">

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
	margin-top:-53px;
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
#jfInfo{
	margin: 9px 0px 0px 414px;
    font-size: 22px;
    color: red;
    position: absolute;
    width:auto;
}
.privteInfo{
	margin: 26px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">查询住院信息</font>
	</div>
	
	<div class="layui-form-item">
		<br />&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="layui-inline">
			&nbsp;&nbsp;<label class="layui-form-label">起始时间</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="qsrq00"
					placeholder="yyyy-MM-dd" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">截止时间</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="jzrq00"
					placeholder="yyyy-MM-dd" />
			</div>
		</div>
		<button class="layui-btn" onclick="getAppInfo()">
			<img id="do_search"
				src="${pageContext.request.contextPath}/images/query.png">
		</button>
	</div>
	
	
	<div id="jfInfo">
		<span class="privteInfo">住院号：<span id="zyNum"></span></span>
		<span class="privteInfo">总费用：<span id="zyfy"></span>元</span>
	</div>
	
	<div id="showArea">
		<div style="width: 995px;height: 414px;">
			<table id="keshi_t" style="width:960px;margin-top:60px;margin-left:20px;">
				<tr style="width:100%; background-color:#3f7dac;border:1px solid black;">
					<td class="theads" style="width:6%;">序号</td>
					<td class="theads" style="width:35%;">收费项目</td>
					<td class="theads" style="width:10%;">数量</td>
					<td class="theads" style="width:10%;">单价</td>
					<td class="theads" style="width:25%;">规格</td>
					<td class="theads" style="width:10%;">金额</td>
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
	
	<div id="bottomArea" style="position: absolute;">
		
		<span style="margin-left:660px;">
			<img id="btnMain" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</span>
		<span style="margin-left:40px;">
			<img id="btnReturn" style="margin-top:4px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
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
	
	laydate.render({
		elem : '#qsrq00', //指定元素
		format : 'yyyy-MM-dd', //可任意组合
		value : new Date(new Date().getTime() - 2592000000),
		maxDate : new Date(),
		isInitValue : false //是否允许填充初始值，默认为 true,isInitValue: false //是否允许填充初始值，默认为 true
	});
	laydate.render({
		elem : '#jzrq00', //指定元素
		format : 'yyyy-MM-dd', //可任意组合
		value : new Date(),
		maxDate : new Date(),
		isInitValue : false //是否允许填充初始值，默认为 true
	});
	
	//获取日期
	function GetDateStr(days) { 
	   var dd = new Date();
	   dd.setDate(dd.getDate()+days);//获取days天后的日期
	   var y = dd.getFullYear(); 
	   var m = (dd.getMonth()+1)<10?"0"+(dd.getMonth()+1):(dd.getMonth()+1);//获取当前月份的日期，不足10补0
	   var d = dd.getDate()<10?"0"+dd.getDate():dd.getDate();//获取当前几号，不足10补0
	   return y+""+m+""+d; 
	}
	//查询住院信息
	var sumJFJE=0;
	function getAppInfo() {
		$("#waiting").show();
		var reg = new RegExp( '-' , "g" )
		var startTime = $("#qsrq00").val().replace(reg, "");
		var endTime  = $("#jzrq00").val().replace(reg, "");
		var datas = {
			"InpatientSeriNo" : $.session.get("zyNum"),//住院号
			"UpdateDateStart" : startTime,//时间段开始
			"UpdateDateEnd" : endTime//时间段结束
			//"UpdateDateStart" : "20130727",//时间段开始
			//"UpdateDateEnd" : "20130816"//时间段结束
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"GetInpatientFeeList",
			success : function(json) {
				sumJFJE=0;
				var data = JSON.parse(json);
				if (data.Code == "0") {
					var length = data.Departments.length;
					if(length>0){
						$("#info_t").empty();
						for (var i = 0; i < length; i++) {
							$("#info_t").append(
									"<tr class=\"tb_tr\">"
									+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 8px;border-radius:3px;width:40px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
									+ "<td class=\"tb_td\">"+data.Departments[i].ItemName+"</td>"
									+ "<td class=\"tb_td\">"+data.Departments[i].ItemNum+"</td>"
									+ "<td class=\"tb_td\">"+data.Departments[i].ItemPrice+"</td>"
									+ "<td class=\"tb_td\">"+data.Departments[i].ItemSpec+"</td>"//预约时间
									+ "<td class=\"tb_td\">"+data.Departments[i].TotalCost+"</td>"//预约时间
									+ "</tr>")
							sumJFJE += parseFloat(data.Departments[i].TotalCost);
						}
						sumJFJE = Math.floor(sumJFJE * 100) / 100;//总金额取小数点后两位
						$("#zyfy").text(sumJFJE);//表头显示总价
						
						page = new Page(8, "keshi_t", "info_t");
						$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
					}else{
						$("#info_t").empty();
						message("未查询住院信息！");
					}
					
				} else {
					$.session.set("errormsg",data.retmsg);
					window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
				}
				$("#waiting").hide();
			},
			error : function() {
				goError("系统异常,请稍后再试!");		
			}
		}); 
	}	
	function message(msg){
		$("#waiting").hide();
		$("#tip_div").show();
		$("#error").text(msg);
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
		$("#zyNum").text($.session.get("zyNum"));
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/cxzyInfo_b.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		setTimeout("getAppInfo()", 200);
	}
	init();
</script>
</html>