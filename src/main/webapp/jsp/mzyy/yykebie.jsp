<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>门诊挂号科别选择</title>
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
	height:110px;
	background-color:#599CE0;
	border-radius:10px;
    display: table-cell;
    vertical-align: middle;
    text-align: center;
    font-size: 22px;
	color:white;
    behavior:url(../../js/PIE.htc);
}
.ksWz{
	padding-top:44px;
	padding-left:20px;
	padding-right:20px;
	font-size:22px;
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
	border-radius:10px; 
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
.kbbh{
	display: none;
}
</style>
</head>
<body scroll="no" onselectstart="return false">
<div id="time" style="position:absolute;top:3px;left:900px;font-size:60px;color: #FF0000;"></div>
	<div id="titleArea">
		<font style="margin-left:40px;">选择预约科别</font>
	</div>
	<div id="showArea">
		<div style="font-size:44px;margin-top:25px;"><span style="margin-left:-170px;">请选择要预约的科别!</span></div>
		<table id="keshi_t" style="table-layout:fixed;cellspacing:20px;margin-left:15px;">
			<tbody id="info_t" >
			</tbody>
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
   	<div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>
<script type="text/javascript">
	//returnTime();
	//var xbie00="男";
	//var brnl00="25";
	var kebie; //科室
	var kbid00;//科室代码
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
	returnTime();
	/**
	* //TODO
	* 点击当前科别信息的时候，截取需要的文本内容
	* 赋值给变量，并存入session中，在页面之间进行
	* 切换的时候的初始化该值
	**/
	function clickKebie(obj) {//点击的时候 把改方框内的文本取出，按照内容复制给需要的变量
		kebie = obj.children[0].innerText;
		kbid00 = obj.children[1].innerText;
		$.session.set('kebie', kebie);
		$.session.set('kbid00', kbid00);
		if (kbid00 == "lyrm_center_fckmz") {//妇科
			if (window.parent.xbie00 == "男") {
				$("#tip_div").show();
				$("#error").text("男士不可选择该科室");
			} else {				
				window.location.href = "yykeshi.jsp";
				$("#waiting").show();
			}
		}  else if (kbid00 == "lyrm_center_rkmz") {//儿科
			if (parseInt(window.parent.brnl00) > 14) {
				$("#tip_div").show();
				$("#error").text("儿科门诊挂号年龄小于14岁，请使用儿童本人就诊卡预约挂号");				
			} else {
				window.location.href = "yykeshi.jsp";
				$("#waiting").show();
			}
		} else {
			window.location.href = "yykeshi.jsp";
			$("#waiting").show();
		}  
	}
	
	
	//获取预约科别信息
	function getKebie() {
		var datas = {
			"funcid" : "M07.02.04.02",// 获取可别信息接口
			"isgh00":"1",//是否挂号，1-预约，0-挂号。待定，先不传
			"yyyqdm":"2"//院区代码，医院ID,本院为2,南医12,东医13,北医14,眼科医院15,北部新城16
		/* 	
			"funcid" : "M07.02.04.01",
			"ghyylx" : "G",
			"pbbz00" : "",
			"fssj00" : fssj00,
			"ksczrq" : ksczrq,
			"jsczrq" : jsczrq
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
					
				//	$.getJSON("../mzgh/kebie.json",function(json){//测试数据
					var Data = eval(json);
					if (Data.retcode == "0") {
						var length = Data.retbody.length;
						for (var i = 0; i < length; i = i + 3) {
							if (i + 2 < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\">" + Data.retbody[i].kbmc00 + "</span><span class=\"kbbh\">" + Data.retbody[i].kbbh00 + "</span></div></td>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\">" + Data.retbody[i+1].kbmc00 + "</span><span class=\"kbbh\">" + Data.retbody[i+1].kbbh00 + "</span></div></td>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\">" + Data.retbody[i+2].kbmc00 + "</span><span class=\"kbbh\">" + Data.retbody[i+2].kbbh00 + "</span></div></td>"
										+"</tr>");
							} else if (i + 1 < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\">" + Data.retbody[i].kbmc00 + "</span><span class=\"kbbh\">" + Data.retbody[i].kbbh00 + "</span></div></td>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\">" + Data.retbody[i+1].kbmc00 + "</span><span class=\"kbbh\">" + Data.retbody[i+1].kbbh00 + "</span></div></td>"
										+"</tr>");
							} else if (i < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\">" + Data.retbody[i].kbmc00 + "</span><span class=\"kbbh\">" + Data.retbody[i].kbbh00 + "</span></div></td>"
										+"</tr>");
							}
						}
						page = new Page(3, "keshi_t", "info_t");
						$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
						$(".models").bind("click", function(){
							clickKebie(this);
						});
				} else {
					$("#tip_div").show();
					$("#error").text(Data.retmsg);			
				}
				$("#waiting").hide();
				//});
			},
			error : function() {
				$("#waiting").hide();
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
	function initCusBasicInfo(){
		$("#cusName").text(window.parent.xming0);
		$("#cusCardNo").text(window.parent.cardNo);
		$("#cusBalance").text(window.parent.yjjye0);
		
	}
	function privateInfoRecord(){
		//身份证号码 和手机号码 如果有一个为空就提示补录
		$.session.set("backyemianname","yykebie");
		var sfyzfalg = $.session.get("shenfenyanzheng");
		var phoneNo = window.parent.lxdh00;//联系电话
		var idCard = window.parent.sfzhao;//身份证号
		
		if (!phoneNo || !idCard){//有一个为空
				if(sfyzfalg!="true"){
					window.location.href = "privateInfoRebuild.jsp";
					$("#waiting").show();
				}
		}
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		privateInfoRecord();//如果信息不完善，补录个人信息
		setTimeout("getKebie();",500);
		initStyle();
		initCusBasicInfo();
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyoperation.jsp";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$(".models").bind("click", function(){
			clickKebie(this);
		});
	}
	init();
</script>
</html>


