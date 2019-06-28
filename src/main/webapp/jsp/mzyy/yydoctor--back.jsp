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
	margin-top:35px;
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
.ksWz{
	
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

</style>
</head>
<body scroll="no" onselectstart="return false">
<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">选择预约医生</font>
	</div>
	<div id="showArea">
		<div style="font-size:44px;margin-top:3px;"><span style="margin-left:-170px;">请选择要预约的医生!</span></div>
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
	<div style="position: absolute;margin-top:-569px;margin-left:720px;width:350px;">
		<div class="modifyInput">
			<span class="chooseType">选择预约科别</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseKb" type="text"  readonly="readonly">
				<div class="modifys1" id="yykebie">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType">选择预约科室</span>
			<div class="contentBox">
				<input class="chooseContent"  id="chooseKs" type="text"  readonly="readonly">
				<div class="modifys" id="yykeshi">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType">选择预约日期</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseNoon" type="text"  readonly="readonly">
				<div class="modifys" id="yydate">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType" >选择预约医生</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseDoc" type="text"  readonly="readonly">
				<div class="modifys" id="yydoctor">修改</div>
			</div>
		</div>
		<div class="modifyInput">
			<span class="chooseType">选择预约时间</span>
			<div class="contentBox">
				<input class="chooseContent" id="chooseTime" type="text"  readonly="readonly">
				<div class="modifys" id="yytime" >修改</div>
			</div>
		</div>
	</div>
	
	<div id="bottomArea">
		<span style="margin-left:20px;">姓名：<span id="cusName">name</span></span>
		<span style="margin-left:60px;">卡号：<span id="cusCardNo">0</span></span>
		<span style="margin-left:60px;">余额：<span id="cusBalance">0.00</span></span>
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
	<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
		<img src="../../images/waiting.gif">
   </div>
</body>
<script type="text/javascript">
	//returnTime();
	//var xbie00="男";
	//var brnl00="25";
	var keshi; //科室
	var ksid00;//科室代码
	var cardNo = window.parent.cardNo;
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var brnl00 = window.parent.brnl00;//病人年龄
	var log = document.getElementById("AVFOCX");
	var fssj00;//发送时间
	var	ksczrq;//开始日期时间
	var	jsczrq;//结束日期时间
	var sjdms01;//时间点编号
	//初始化倒计时时间：120秒
	var time = 120;
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

	function clickDoctor(obj) {
		keshi = obj.children[0].innerHTML.toLowerCase().split("<br>")[0];
		var pbid00 = obj.children[1].innerText;
		var sysl = $.trim(obj.children[0].innerText.split("挂号费")[0].split("剩余数量：")[1]);
		if(sysl == 0){
			$("#tip_div").show();
			$("#error").text("号源已满！");
			return;
		}
		
		$.session.set('yydoctor', keshi);
		$.session.set('pbid00', pbid00);
		window.location.href = "yytime.jsp";
		$("#waiting").show();
	}
	
	
	
	//获取预约医生信息
	function getDoctors() {
		var datas = {
				"funcid" : "M07.02.04.04",
				"mzksbh" : $.session.get('ksbh00'),
				"yyrq00" : $.session.get('yydate')//挂号类别，挂号类别0=普通，1=急诊，2=专家，3=点名专家，4=特殊挂号，5=义诊，6=外宾挂号,7=免挂号费, 8=免费挂号 
				
			/* 	
				"funcid" : "M07.02.04.02",
				"ghyylx" : "G",
				"ksid00" : $.session.get('ksid00'),
				"ksmc00" : $.session.get('keshi'),
				"sjdbh0" : $.session.get('sjdbh0'),
				"sjdms01" : $.session.get('sjdms01'),
				"pbbz00" : "",
				"ksczrq" : $.session.get('ksczrq'),
				"jsczrq" : $.session.get('jsczrq')
			 */	
		};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url : window.parent.serverUrl + "?method=ApplyAction",
				//url:"${pageContext.request.contextPath}/Test/test.do",
				success : function(json) {
					$("#waiting").hide();
					//$.getJSON("../mzgh/yydoctors.json",function(json){//测试数据
					var Data = eval(json);
					if (Data.retcode == "0") {
						var length = Data.retbody.length;
						for (var i = 0; i < length; i = i + 3) {
							if (i + 2 < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickDoctor(this)\"> <span class=\"ksWz\">" 
										+ Data.retbody[i].mzysxm + "<br><br>" 
										+ Data.retbody[i].mzyszc + "<br><br>" 
										+ Data.retbody[i].yywbmc +"  剩余数量： "+ Data.retbody[i].syghs0 + "<br><br>挂号费："
										+ Data.retbody[i].ghfei0
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.retbody[i].pbid00+"</span></div></td>"
										
										+"<td><div class=\"models\" onclick=\"clickDoctor(this)\"> <span class=\"ksWz\">" 
										+ Data.retbody[i+1].mzysxm + "<br><br>" 
										+ Data.retbody[i+1].mzyszc + "<br><br>" 
										+ Data.retbody[i+1].yywbmc +"  剩余数量： "+ Data.retbody[i+1].syghs0 + "<br><br>挂号费："
										+ Data.retbody[i+1].ghfei0 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.retbody[i+1].pbid00+"</span></div></td>"
										
										
										+"<td><div class=\"models\" onclick=\"clickDoctor(this)\"> <span class=\"ksWz\">" 
										+ Data.retbody[i+2].mzysxm + "<br><br>" 
										+ Data.retbody[i+2].mzyszc + "<br><br>" 
										+ Data.retbody[i+2].yywbmc +"  剩余数量： "+ Data.retbody[i+2].syghs0 + "<br><br>挂号费："
										+ Data.retbody[i+2].ghfei0
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.retbody[i+2].pbid00+"</span></div></td>"
										
										
										+"</tr>");
							} else if (i + 1 < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickDoctor(this)\"> <span class=\"ksWz\">" 
										+ Data.retbody[i].mzysxm + "<br><br>" 
										+ Data.retbody[i].mzyszc + "<br><br>" 
										+ Data.retbody[i].yywbmc +"  剩余数量： "+ Data.retbody[i].syghs0 + "<br><br>挂号费："
										+ Data.retbody[i].ghfei0
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.retbody[i].pbid00+"</span></div></td>"
										
										+"<td><div class=\"models\" onclick=\"clickDoctor(this)\"> <span class=\"ksWz\">" 
										+ Data.retbody[i+1].mzysxm + "<br><br>" 
										+ Data.retbody[i+1].mzyszc + "<br><br>" 
										+ Data.retbody[i+1].yywbmc +"  剩余数量： "+ Data.retbody[i+1].syghs0 + "<br><br>挂号费："
										+ Data.retbody[i+1].ghfei0 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.retbody[i+1].pbid00+"</span></div></td>"
										+"</tr>");
							} else if (i < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickDoctor(this)\"> <span class=\"ksWz\">" 
										+ Data.retbody[i].mzysxm + "<br><br>" 
										+ Data.retbody[i].mzyszc + "<br><br>" 
										+ Data.retbody[i].yywbmc +"  剩余数量： "+ Data.retbody[i].syghs0 + "<br><br>挂号费："
										+ Data.retbody[i].ghfei0
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.retbody[i].pbid00+"</span></div></td>"
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
					$("#error").text(Data.retmsg);			
				}
				
			//});
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");		
			}
		}); 
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
		window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/"+pageName+".jsp";
		$("#waiting").show();
	}
	/**
	*初始化操作
	**/
	var init = function(){
		
		$("#waiting").show();
		setTimeout("getDoctors();",500);
		//getDoctors();
		$("#chooseKb").val($.session.get('kebie'));
		$("#chooseKs").val($.session.get('keshi'));
		$("#chooseNoon").val($.session.get('yydate'));
		initStyle();
		returnTime();//倒计时
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "yydate.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		
		$("#cusName").text(window.parent.xming0);
		$("#cusCardNo").text(window.parent.cardNo);
		$("#cusBalance").text(window.parent.yjjye0);
	}
	init();
</script>
</html>