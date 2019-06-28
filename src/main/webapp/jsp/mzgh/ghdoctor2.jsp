<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>

<title>门诊挂号</title>
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
	margin-top:40px;
	line-height:60px;
}
#showArea{
	border:1px black solid; 
	border-radius:10px; 
	width:995px;
	height:570px;
	margin-left:11px;
	margin-top:20px;
	behavior:url(../../js/PIE.htc);
}
.models{
	width:210px;
	height:190px;
	background-color:#599CE0;
	border-radius:10px;
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    font-size: 22px;
    behavior:url(../../js/PIE.htc);
}
td{
	padding:7px;
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
.modifyInput{
	margin:4px 0px 0px 0px;
	height: 105px;
	width: 350px;
}
.chooseType{
	margin: 0px 0px 0px -180px;
	font-size: 28px;
	color: grey;
}
.chooseType1{
	margin: 0px 0px 0px -180px;
	font-size: 28px;
	color: #599CE0;
}
.modifys{
	background-color:#599CE0;
	position:absolute;
	height:60px;
	width:91px;
	margin:-55px 0px 0 189px;
	font-size:30px;
	color:white;
	line-height:55px;
}
.modifys1{
	background-color:grey;
	position:absolute;
	height:60px;
	width:91px;
	margin:-55px 0px 0 189px;
	font-size:30px;
	color:white;
	line-height:55px;
}
.chooseContent{
	width:182px;
	height:40px;
	margin-left:-93px;
	border:none;
	font-size:28px;
	margin-top:15px;
}
.contentBox{
	position:absolute;
	height:60px;
	width:280px;
	border-radius:5px;
	border:1px #599CE0 solid;
	margin-top:0px;
	behavior:url(../../js/PIE.htc);
}
/*医生姓名*/
.DrName{
	position:absolute;
	color:#04fd02;
	font-size: 33px;
    margin: -96px 0px 0px 52px;
    text-align: center;
    width:120px;
}
/*医生职称*/
.RegLevelName{
	position:absolute;
	margin:-39px 0px 0px 47px;
	color: red;
	text-align: center;
	font-size:20px;
	width:126px;
}
/*午别*/
.noon{
	position:absolute;
	margin: -6px 0px 0px 35px;
	color:blue;
	text-align: center;
	font-size:21px;
}
/*剩余挂号数*/
.syghs0{
	position:absolute;
	margin: 24px 0px 0px 60px;
	color: #00fdff;
	text-align: center;
}
/*挂号费*/
.TotalFee{
	position:absolute;
	margin: 60px 0px 0px 40px;
	color: white;
}
</style>
</head>
<body scroll="no"  onselectstart="return false">
   <div id="waiting"  style="margin: 229px 0px 0px 0px;display:block;z-index:9001;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">选择挂号医生</font>
	</div>
	<div id="showArea">
		<div style="font-size:44px;margin-top:3px;"><span style="margin-left:-170px;">请选择要挂号的医生!</span></div>
		<table id="keshi_t" style="table-layout:fixed;cellspacing:20px;margin-left:15px;">
			<tbody id="info_t" >
			</tbody>
			<tfoot>
				<tr>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.prePage($('#confirmBtn'))">上一页</div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px; text-align:center;">
						<div id="confirmBtn" ></div>
					</td>
					<td colspan="" style="width:200px;height:80px;font-size:30px;color:white; text-align:center;">
						<div class="pageButton" onclick="page.nextPage($('#confirmBtn'))">下一页</div>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<div style="position: absolute;margin:-569px 0px 0px 720px;width:350px;">
		<div class="modifyInput">
			<span class="chooseType">选择挂号科别</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseKb" type="text"  readonly="readonly">
				<div class="modifys1" id="ghkebie">修改</div>
			</div>
		</div>

		<div class="modifyInput">
			<span class="chooseType" >选择挂号医生</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseDoc" type="text"  readonly="readonly">
				<div class="modifys" id="ghdoctor2">修改</div>
			</div>
		</div>
	
	</div>
	
	<div id="bottomArea">
		<span style="margin-left:20px;">姓名：<span id="cusName"></span></span>
		<span style="margin-left:60px;">患者编号：<span id="cusBalance"></span></span>
		<div style="margin-left:50px;position:absolute;margin: -62px 0px 0px 700px;">
			<img id="btnMain" style="margin-top:8px;" src="${pageContext.request.contextPath}/images/yue/mzgh_index_y.png" res_img="" height="" width=""/>
		</div>
		<div style="margin-left:20px;position:absolute;margin: -61px 0px 0px 855px;">
			<img id="btnReturn" style="margin-top:6px;" src="${pageContext.request.contextPath}/images/yue/mzgh_return_y.png" res_img="" height="" width=""/>
		</div>
	</div>
	
	<div id="tip_div"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:4px" />
   </div> 
 
</body>
<script type="text/javascript">
	var RegNo;//号点
	var time = 120;//初始化倒计时时间：120秒
	//自动倒计时，计时时间为0时，
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
		time = 120;
	}
	returnTime();
	
	function getDate(){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
        if(hours<10){
        	hours="0"+hours;
        }
        if(minutes<10){
        	minutes="0"+day;
        }
        if(seconds<10){
        	seconds="0"+seconds;
        }
		return year+""+month+""+day;
	}
	
	function confirmOp (msg){
		$("#waiting").hide();
		$("#tip_div").show();
		$("#tip_div").show();
		$("#error").text(msg);
	}
	
	
	function clickDoctor(obj) {
		var sysl = $.trim(obj.children[3].innerText);
		if(sysl == "已满"){
			message("当前预约已满，请重新选择。");
			return;
		}else{
			
			var ysxm00 = obj.children[0].innerText;
			$("#chooseDoc").val(ysxm00);
			
			var ScheduleId = obj.children[5].innerText;//号点id
			var RegLevelId = obj.children[6].innerText;//挂号级别id
			var TotalFee = obj.children[7].innerText;//挂号级别id
			var ghDate = obj.children[8].innerText;//挂号日期
			$.session.set("TotalFee", TotalFee);
			var OutpatientId = window.parent.OutpatientId;//病人id
			var DeptId = $.session.get("kbid00");
			//根据患者确认信息，然后进行占号操作
			var datas = {
				"ScheduleId" : ScheduleId,
				"RegLevelId" : RegLevelId,
				"OutpatientId" :OutpatientId,
				"DeptId" : DeptId,
				"ScheduleTime" : ghDate
			};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"OccupyRegPoint",
				success : function(json) {
					$("#waiting").hide();
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						RegNo = Data.Departments[0].RegNo;
						$.session.set("RegNo",RegNo);
						var TotalFee = Data.Departments[0].TotalFee;
						var DiagnoseFee = Data.Departments[0].DiagnoseFee;
						var RegFee = Data.Departments[0].RegFee;
						var InspectFee = Data.Departments[0].InspectFee;
						var SpclFee = Data.Departments[0].SpclFee;
						var CouponInfo = Data.Departments[0].CouponInfo;
						var RmngNum = Data.Departments[0].RmngNum;
						if(RegNo){
							window.location.href = "../pay/lypayway.jsp";
						}else{
							message("号点为空！");
						}
					}else{
						message("占号点时出错！");
					}	
				},
				error : function() {
					goError("系统异常,请稍后再试!");		
				}
			}); 
		}
	}
	//释放占号
	function sfzhOp(){
		var datas = {
			"RegNo" : $.session.get("RegNo")
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"ReleaseRegPoint",
			success : function(json) {
				var Data = JSON.parse(json)
				if (Data.Code == "0") {
					//log("释放成功！号点："+RegNo);
				}	
			},
			error : function() {
				goError("释放号点时系统异常,请稍后再试!");		
			}
		}); 
	}
	//提示信息
	function message(msg){
		$("#waiting").hide();
		$("#tip_div").show();
		$("#error").text(msg);
	}
	//记录日志
	function log(info){
		log.writeLog(info);
	}
	//获取医生信息
	function getDoctors() {
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
		var datas = {
				"DeptId" : $.session.get("kbid00"),
				"OperatorType" : "1",
				"day" : 1
			};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"GetSchedules",
				success : function(json) {
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						var length = Data.Departments.length;
						for (var i = 0; i < length; i = i + 3) {
							if (i + 2 < length) {
								var ss = Data.Departments[i].RmngNum=="0"?"已满":"剩余"+Data.Departments[i].RmngNum+"号";
								var ss1 = Data.Departments[i+1].RmngNum=="0"?"已满":"剩余"+Data.Departments[i+1].RmngNum+"号";
								var ss2 = Data.Departments[i+2].RmngNum=="0"?"已满":"剩余"+Data.Departments[i+2].RmngNum+"号";
								
								var dd = Data.Departments[i].EndTime.slice(0, 4)+"年"+Data.Departments[i].EndTime.slice(4, 6)+"月"+Data.Departments[i].EndTime.slice(6, 8)+"日";
								var dd1 = Data.Departments[i+1].EndTime.slice(0, 4)+"年"+Data.Departments[i+1].EndTime.slice(4, 6)+"月"+Data.Departments[i+1].EndTime.slice(6, 8)+"日";
								var dd2 = Data.Departments[i+2].EndTime.slice(0, 4)+"年"+Data.Departments[i+2].EndTime.slice(4, 6)+"月"+Data.Departments[i+2].EndTime.slice(6, 8)+"日";
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\">"
										+"<div class=\"DrName\">" + Data.Departments[i].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + dd +"</div>"
										+"<div class=\"syghs0\">"+ ss + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i].TotalFee + "元</div>" 
										+"<span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										
										+"<td><div class=\"models\"  >"
										+"<div class=\"DrName\">" + Data.Departments[i+1].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i+1].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + dd2 +"</div>"
										+"<div class=\"syghs0\">"+ ss1 + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i+1].TotalFee + "元</div>" 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i+1].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i+1].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										
										+"<td><div class=\"models\"  >"
										+"<div class=\"DrName\">" + Data.Departments[i+2].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i+2].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + dd2 +"</div>"
										+"<div class=\"syghs0\">"+ ss2 + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i+2].TotalFee + "元</div>" 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i+2].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+2].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+2].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i+2].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										+"</tr>");
							} else if (i + 1 < length) {
								var sss = Data.Departments[i].RmngNum=="0"?"已满":"剩余"+Data.Departments[i].RmngNum+"号";
								var sss1 = Data.Departments[i+1].RmngNum=="0"?"已满":"剩余"+Data.Departments[i+1].RmngNum+"号";
								
								var ddd = Data.Departments[i].EndTime.slice(0, 4)+"年"+Data.Departments[i].EndTime.slice(4, 6)+"月"+Data.Departments[i].EndTime.slice(6, 8)+"日";
								var ddd1 = Data.Departments[i+1].EndTime.slice(0, 4)+"年"+Data.Departments[i+1].EndTime.slice(4, 6)+"月"+Data.Departments[i+1].EndTime.slice(6, 8)+"日";
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\">"
										+"<div class=\"DrName\">" + Data.Departments[i].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + ddd +"</div>"
										+"<div class=\"syghs0\">"+ sss + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i].TotalFee + "元</div>" 
										+"<span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										
										+"<td><div class=\"models\"  >"
										+"<div class=\"DrName\">" + Data.Departments[i+1].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i+1].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + ddd1 +"</div>"
										+"<div class=\"syghs0\">"+ sss1 + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i+1].TotalFee + "元</div>" 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i+1].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i+1].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										+"</tr>");
							} else if (i < length) {
								var ssss = Data.Departments[i].RmngNum=="0"?"已满":"剩余"+Data.Departments[i].RmngNum+"号";
								
								var dddd = Data.Departments[i].EndTime.slice(0, 4)+"年"+Data.Departments[i].EndTime.slice(4, 6)+"月"+Data.Departments[i].EndTime.slice(6, 8)+"日";
								$("#info_t").append(
										"<tr>"
											+"<td><div class=\"models\">"
											+"<div class=\"DrName\">" + Data.Departments[i].DrName + "</div>" 
											+"<div class=\"RegLevelName\">" + Data.Departments[i].RegLevelName + "</div>" 
											+"<div class=\"noon\">" + dddd +"</div>"
											+"<div class=\"syghs0\">"+ ssss + "</div>" 
											+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i].TotalFee + "元</div>" 
											+"<span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i].ScheduleId+"</span>"
											+"<span style=\"display:none;\">"+Data.Departments[i].RegLevelId+"</span>"
											+"<span style=\"display:none;\">"+Data.Departments[i].TotalFee+"</span>"
											+"<span style=\"display:none;\">" + Data.Departments[i].EndTime.slice(0, 8) +"</span>"
											+"</div></td>"
										+"</tr>");
							}
						}
						page = new Page(2, "keshi_t", "info_t");
						$('#confirmBtn').text((page.pageIndex+1)+"/"+page.pageCount);
						
						$(".models").bind("click", function(){
							clickDoctor(this);
						});
						
				} else {
					$("#tip_div").show();
					$("#error").text(Data.Message);			
				}
				$("#waiting").hide();
			//});
			},
			error : function() {
				goError("系统异常,请稍后再试!");		
			}
		}); 
	}	
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="${pageContext.request.contextPath}/jsp/main/error.jsp";
	}
	//根据input框内容是否存在值，确认是否进行过该页面的操作，如果有操作，可以进行修改，如果没有，置灰 不可修改
	function initStyle(){
		var inputs = $(".chooseContent");
		$.each(inputs,function(index,temp){
			if(temp.value){
				$(this).parent().css("border","1px #599CE0 solid");
				$(this).parent().prev().removeClass();
				$(this).parent().prev().addClass("chooseType1");//蓝色可点击  
				$(this).next().removeClass();
				$(this).next().addClass("modifys");
				$(this).next().click(goModify);
			}else{
				$(this).parent().css("border","1px grey solid");
				$(this).parent().prev().removeClass();
				$(this).parent().prev().addClass("chooseType");
				$(this).next().removeClass();
				$(this).next().addClass("modifys1");//置灰不可点击
				$(this).next().unbind();//不可点击
			}
		});
	}
	function goModify(){
		var pageName = $(this).attr("id");
		window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/"+pageName+".jsp";
		$("#waiting").show();
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		getDoctors();
		$("#chooseKb").val($.session.get('kebie'));
		$("#chooseKs").val($.session.get('keshi'));
		$("#chooseNoon").val($.session.get('noon'));
		
		
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghkebie.jsp";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		
		$("#cusName").text(window.parent.Name);
		$("#cusBalance").text(window.parent.OutpatientId);
		initStyle();
	}
	init();
</script>
</html>