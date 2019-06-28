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
<title>满意度调查</title>
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
	margin-top: 0px;
	margin-left: 0px;
	width: 100%;
	height: 100%;
	overflow: hidden;
	background: url(../../images/m_mz_myddc/myddc_bg.png) no-repeat;
}

#name00 {
	top: 75px;
	left: 212px;
	width: 160px;
	height: 40px;
	text-align: center;
	font-size: 30px;
}

#yemaView {
	margin-top: 677px;
	height: 44px;
	width: 120px;
	margin-left: 75px;
	text-align: center;
	font-size: 30px;
}

#btn_prev {
	position: absolute;
	margin-bottom: 485px;
	padding-bottom: -69px;
	top: 686px;
	width: 150px;
	height: 53.833px;
	margin-left: 208px;
}

#btn_next {
	position: absolute;
	margin-bottom: 485px;
	padding-bottom: -69px;
	top: 686px;
	margin-left: 379px;
	width: 150px;
	height: 53.833px;
}

#btn_cancel {
	position: absolute;
	margin-bottom: 485px;
	padding-bottom: -69px;
	top: 686px;
	margin-left: 628px;
	width: 150px;
	height: 53.833px;
}

#btn_confirm {
	position: absolute;
	margin-bottom: 485px;
	padding-bottom: -69px;
	margin-left: 801px;
	top: 686px;
	width: 150px;
	height: 53.833px;
}

#zlmyd0 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -517px;
	position:absolute;
  top: 572px;	
}

#zlmyd1 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -426px;
	position:absolute;
	top: 575px;
}

#zlmyd2 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -335px;
	position:absolute;
	top: 570px;
}

#zlmyd3 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -244px;
	position:absolute;
	top: 575px;
}

#zlmyd4 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -149px;
	position:absolute;
	top: 568px;
}
#zlmyd5 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -517px;
	position:absolute;
	top: 572px;
}

#zlmyd6 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -426px;
	position:absolute;
	top:  570px;
}

#zlmyd7 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -335px;
	position:absolute;
	top: 575px;
}

#zlmyd8 {
	text-align: left;
	font-size: 25px;
	letter-spacing: 5px;
	margin-left: 40px;
	margin-top: -244px;
	position:absolute;
	top: 568px;
}

.checks {
	width: 30px;
	height: 30px;
	text-align:center;
	border: 2px solid white;
    content: "\2714";
    color: red;
}
.fxk{
	
}
</style>

</head>
<body scroll="no" id="info">
	<div id="name00" style="position:absolute;"></div>
	<div id="time"
		style="position:absolute;top:30px;right:50px;font-size:30px;color: #FF0000;">
	</div>
	<div id="yemaView"></div>
	<img id="btn_prev" style="position:absolute;"
		src="../../images/m_mz_myddc/btn_prev.png">
	<img id="btn_next" style="position:absolute;"
		src="../../images/m_mz_myddc/btn_next.png">
	<img id="btn_cancel" style="position:absolute;"
		src="../../images/m_mz_myddc/btn_cancel.png">
	<img id="btn_confirm" style="position:absolute;"
		src="../../images/m_mz_myddc/btn_confirm.png">

	<div id="myddc"
		style="z-index:30;position:absolute;left:14px;top:209px;display:block;">
		<table id="myddc" style="width: 1024px; font-size: 25px; margin-top: 10px; margin-left: 87px; table-layout: fixed; cellspacing: 2px;">
		
			<tbody id="info1">

			</tbody>
			
		</table>
	</div>

	<div id="tip_div" style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:350px;">
         <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
           <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
         </div>
      <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png" 
        width="90" height="43" style="position:relative;top:125px;left:520px" />
   </div> 
	<div id="waiting"
		style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
		<img src="${pageContext.request.contextPath}/images/waiting.gif">
	</div>
</body>

<script>
	var qsym0 = 1;//起始页码
	var count = 2;//共有页数
	var result = {};    //满意度结果集
	var ansListQstr ;//满意度结果集
	//初始化倒计时时间：120秒
	var time = 120;
	function timeAgin() {
		time = 120;
	}
	//自动倒计时，计时时间为0时，
function returnTime() {
			myVar = setInterval(
				function() {
					time--;
					$("#time").text(time);
					if (time == 0) {
						//跳转页面
						$.session.clear();
						window.location.href="${pageContext.request.contextPath}/jsp/main/"+window.parent.mainflag+".jsp";
					}
				}, 1000);
		}
		
		
	
	
	//页面跳转方法	
function jump() {
		$("#btn_cancel").bind("click dbclick", function() {
			$.session.set("msg","取消了本次满意度调查")
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/mydpj.jsp";
		});
		$("#btn_confirm").bind("click dbclick", function() {
			ansListQstr = "";
			var arrayList = Object.keys(result);
            for(var i=0;i<arrayList.length;i++){
            	if(arrayList[i]){
            		questionid =arrayList[i];
            		ansListQstr=ansListQstr+reportid+","+questionid+","+result[questionid]+";";
            	}
            	//console.log(ansListQstr);
            }
            
			if(countSX(result)==9){
				
				tjpingjia();
				
			}else{
				$("#tip_div").show();
				$("#error").text("您还有评价未完成.");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					//window.location.href = "${pageContext.request.contextPath}/jsp/cxym/myddc.jsp";
				});
			}
		});
		$()
		$("#btn_next").bind("click dbclick", function() {
			if(qsym0==1){
				qsym0=2;
				getListAll();
				$("#yemaView").text("第"+qsym0+"/"+count+"页");
				$("#zlmyd0").hide();
				$("#zlmyd1").hide();
				$("#zlmyd2").hide();
				$("#zlmyd3").hide();
				$("#zlmyd4").hide();
				$("#zlmyd5").show();
				$("#zlmyd6").show();
				$("#zlmyd7").show();
				$("#zlmyd8").show();
			} 
		});
		$("#btn_prev").bind("click dbclick", function() {
			if(qsym0==2){
				qsym0=1;
				getListAll();
				$("#yemaView").text("第"+qsym0+"/"+count+"页");
				$("#zlmyd0").show();
				$("#zlmyd1").show();
				$("#zlmyd2").show();
				$("#zlmyd3").show();
				$("#zlmyd4").show();
				$("#zlmyd5").hide();
				$("#zlmyd6").hide();
				$("#zlmyd7").hide();
				$("#zlmyd8").hide();
			} 
		});
	}
	
function test(obj){
	var name ;
    var choose = $("input[name='" + obj.name +"']");
     choose.on("click",function(){
       $.each(choose, function(index,temp){
         temp.checked = false;
       });
       $(this)[0].checked = true;
       //alert($(this)[0].value);
       name = obj.name ;
       result[name] = obj.value;	 
     });
       name = obj.name ;
       result[name] = obj.value;
   }
   //获取对象集合的属性个数
   function countSX(obj) {
		var t = typeof obj;
		if (t == 'string') {
			return obj.length;
		} else if (t == 'object') {
			var n = 0;
			for (var i in obj) {
				n++;
			}
			return n;
		}
		return false;
	}
//获取满意度调查问题列表
function getListAll(){
	var datas = {
			"funcid" : "M07.02.17.01",
			"zdbh00" : window.parent.zdbh00,
			"sfxzcs" : "2",//1：限制，2：不限制
			"mtsxcs" : "9", //不限制是传空
			"cxlb00" : "0"//0:门诊，1住院
			};
	$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
			//	$.getJSON("myddc.json",function(json){
					Data = eval(json);
					if(Data.retcode==0){
					reportid=Data.retbody[0].reportid;
					  $("#info1").empty();
					  var j = qsym0==1?5:9;
					  var i = qsym0==1?0:5;
						for (i ; i < j; i++) {
								$("#info1").append(
								"<tr style=\"height:45px;\"><td id=\"questionid"+i+" style=\"font-size:35px;display:none;\">"
								+ Data.retbody[i].questionname+"<input type=\"text\" style=\"display:none;\" value="+Data.retbody[i].questionid+">"
								+ "</td></tr>"
								+ "<tr style=\"height:45px;\"><td id=\"zlmyd"+i+"\" >"
								+ "<input type=\"checkbox\" class=\"checks\" onclick=\"test(this)\" name=\""+Data.retbody[i].questionid+"\" value="+Data.retbody[i].itemid1+">"+Data.retbody[i].itemname1
								+ "<input type=\"checkbox\" class=\"checks\" onclick=\"test(this)\" name=\""+Data.retbody[i].questionid+"\" value="+Data.retbody[i].itemid2+">"+Data.retbody[i].itemname2
								+ "<input type=\"checkbox\" class=\"checks\" onclick=\"test(this)\" name=\""+Data.retbody[i].questionid+"\" value="+Data.retbody[i].itemid3+">"+Data.retbody[i].itemname3
								+ "<input type=\"checkbox\" class=\"checks\" onclick=\"test(this)\" name=\""+Data.retbody[i].questionid+"\" value="+Data.retbody[i].itemid4+">"+Data.retbody[i].itemname4
								+ "</td></tr>"
								);
						}
					}else{
						$("#info1").append(
						"<tr style=\"width:1024px;height:400px;border:1px solid #3f7dac;\">"
						+ "<td colspan='6' style='width:1024px;height:80px;font-size:35px;text-align:center;'>" + Data.retmsg  + "</td>"
						+ "</tr>");
					}
			//	});
			},
			error : function() {
				$("#waiting").hide();
				$("#info1").append(
					"<tr style=\"width:1024px;height:400px;border:1px solid #3f7dac;\">"
					+ "<td colspan='6' style='width:1024px;height:80px;font-size:35px;text-align:center;'>" + Data.retmsg  + "</td>"
					+ "</tr>");
			}
		});
	}

	function tjpingjia(){
	//console.log("tjpingjia()"+ansListQstr);
		var datas = {
			"funcid" : "M07.02.17.02",
			"ansListQstr":ansListQstr,
			"zdbh00" : window.parent.zdbh00,
			"sfxzcs" : "2",//1：限制，2：不限制
			};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
					Data = eval(json);
					if(Data.retcode==0){
						$.session.set("msg","谢谢您参与本次满意度调查")
						window.location.href = "${pageContext.request.contextPath}/jsp/cxym/mydpj.jsp";
					}else{
						$("#tip_div").show();
						$("#error").text(Data.retmsg);
						$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						//window.location.href = "${pageContext.request.contextPath}/jsp/cxym/myddc.jsp";
						});
					}
						
			},
			error : function() {
				$("#waiting").hide();
				$("#info1").append(
					"<tr style=\"width:1024px;height:400px;border:1px solid #3f7dac;\">"
					+ "<td colspan='6' style='width:1024px;height:80px;font-size:35px;text-align:center;'>" + Data.retmsg  + "</td>"
					+ "</tr>");
			}
		});	
	}
var init = function() {
		getListAll(); //获取满意度调查问题列表
		//$("#waiting").css("display","block");
		//$("#name00").text();
		$("#yemaView").text("第"+qsym0+"/"+count+"页");
		$("#zlmyd0").show();
		$("#zlmyd1").show();
		$("#zlmyd2").show();
		$("#zlmyd3").show();
		$("#zlmyd4").show();
		$(".checks").bind("click",function(){
			test(this);
		});
		jump(); //跳转页面方法	
		returnTime(); //倒计时方法
		//用户点击或按键等操作时，倒计时重新计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	};
	init();
</script>
</html>

