<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>预约取消</title>
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
#jfInfo{
	margin: 9px 0px 0px 44px;
    font-size: 22px;
    color: red;
    position: absolute;
    width:auto;
}
.privteInfo{
	margin: 26px;
}
#chooseRegNo{
	border:1px red solid;
	width:1280px;
	height:768px;
	position: absolute;
	margin: -130px 0px 0px -12px;
	background: url(../../images/yue/bgn.jpg) no-repeat;
	font-size:26px;
}
.chooseInfo{
	border:1px red solid;
	margin:100px 0px 0px -500px;
	font-size: 34px;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
	<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">收费项目</font>
	</div>
	<div id="jfInfo">
		<span class="privteInfo">姓名：<span id="cusName"></span></span>
		<span class="privteInfo">患者编号：<span id="cusBalance"></span></span>
		<span class="privteInfo">费用：<span id="zfy"></span>元</span>
		<div id="btnJF" class="privteInfo" style="border:1px red solid; width:116px; height:34px;color:white;background-color:black;float: right;margin:auto;">点击缴费</div>
	</div>
	
	<div id="showArea">
	<div id="chooseRegNo">
		<table id="keshi_s" style="width:960px;margin-top:130px;margin-left:20px;">
				<tr style="width:100%; background-color:#3f7dac;border:1px solid black;">
					<td class="theads" style="width:6%;">序号</td>
					<td class="theads" style="width:35%;">挂号流水号</td>
					<td class="theads" style="width:52%;">就诊时间</td>
					<td class="theads" style="width:7%;">操作</td>
				</tr>
				<tbody id="info_s" >
				</tbody>
		</table>
	</div>
	
	
	
		<div style="width: 995px;height: 414px;">
			<table id="keshi_t" style="width:960px;margin-top:60px;margin-left:20px;">
				<tr style="width:100%; background-color:#3f7dac;border:1px solid black;">
					<td class="theads" style="width:6%;">序号</td>
					<td class="theads" style="width:35%;">收费项目</td>
					<td class="theads" style="width:10%;">数量</td>
					<td class="theads" style="width:15%;">单价</td>
					<td class="theads" style="width:15%;">规格</td>
					<td class="theads" style="width:15%;">金额</td>
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

	//初始化倒计时时间：120秒
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
	var sumJFJE=0;
	var RecipeNos = new Array();
	var Data;
	//获取缴费明细
	function getAppInfo() {
		var datas = {
			"OutpatientIds":window.parent.OutpatientId,
			"PaymentStatus":"0"//支付状态    0: "未支付"; 1: "已支付";2: "已退费"; 3: "部分退费"; 4: "金额错误";5: ”已取消” null 查询全部
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"GetOutpatientIdFeeList",
			success : function(json) {
				Data = JSON.parse(json);
				if (Data.Code == "0") {
					var temp = Data.Departments;
					if(temp){
						var j = 0;
						for(var key in temp){
							j++;
							var temp1 = temp[key];
							var opDate = temp1[0].OperDate.slice(0,4)+"年" +temp1[0].OperDate.slice(4,6)+"月"+temp1[0].OperDate.slice(6,8)+"日 "
											+temp1[0].OperDate.slice(8,10)+":"+temp1[0].OperDate.slice(10,12)+":"+temp1[0].OperDate.slice(12,14);
							$("#info_s").append(
									"<tr class=\"tb_tr\">"
									+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(j)+"</div></td>"
									+ "<td>"+key+"</td>"
									+ "<td>"+opDate+"</td>"
									+ "<td onclick='jfchoose(this)' style=''><div style='width:60px;height:30px;background-color:#3f7dac;border-radius: 7px;line-height: 30px;'>缴费</div></td>"
								+ "</tr>"
							);
						}
					}else{
						$("#waiting").hide();
						$("#tip_div").show();
						$("#error").text("没有查询到收费项目！");	
					}
					
				} else {
					goError(data.retmsg);
				}
				$("#waiting").hide();
			},
			error : function() {
				goError("系统异常,请稍后再试!");
			}
		}); 
	}	
	
	function showOp(regNo){
		if(Data && Data.Departments){
			Data = Data.Departments[regNo];
			var length = Data.length;
			$("#chooseRegNo").hide();
			for (var i = 0; i < length; i++) {
				$("#info_t").append(
					"<tr class=\"tb_tr\">"
						+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemName+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemNum+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemPrice+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemSpec+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].TotalCost+"</td>"
					+ "</tr>")
				sumJFJE += parseFloat(Data[i].TotalCost);
				RecipeNos.push(Data[i].RecipeNo);//取所有收费项目编号放入数组查询订单需要传输的参数
			}
			sumJFJE = Math.floor(sumJFJE * 100) / 100;//总金额取小数点后两位
			$("#zfy").text(sumJFJE);//表头显示总价
			
			page = new Page(8, "keshi_t", "info_t");
			$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
		}
	}
	function jfchoose(obj){
		var regNo = obj.parentNode.childNodes[1].innerHTML;
		showOp(regNo);
	}
	//去重数组
	Array.prototype.unique = function(){
		 var res = [];
		 var json = {};
		 for(var i = 0; i < this.length; i++){
		  	if(!json[this[i]]){
			   	res.push(this[i]);
			   	json[this[i]] = 1;
		  	}
		 }
		 return res;
	}
	//缴费操作
	function jfOperation(){
		if(sumJFJE>0){
			RecipeNos = RecipeNos.unique();
			$.session.set("RecipeNos", RecipeNos);
			$.session.set("TotalFee",sumJFJE);
			window.location.href="${pageContext.request.contextPath}/jsp/pay/lypayway.jsp";
		}
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
		$("#waiting").show();
		$("#cusName").text(window.parent.Name);
		$("#cusBalance").text(window.parent.OutpatientId);
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		
		setTimeout("getAppInfo();",500);//获取预约信息
		$("#btnJF").bind("click dbclick", function() {//点击缴费
			jfOperation()
		});
	}
	init();
</script>
</html>