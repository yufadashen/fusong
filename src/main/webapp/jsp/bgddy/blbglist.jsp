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
<title>病理报告打印</title>
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
<link rel="stylesheet" type="text/css" href="../../css/normalize.css" />
<link rel="stylesheet" type="text/css" href="../../css/htmleaf-demo.css">
<link rel="stylesheet" href="../../dist/jqkeyboard.css" />
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->

<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	background:url(../../images/bgn.jpg) no-repeat;
}

#bottomArea {
	background-color: #3f7dac;
	width: 100%;
	height: 60px;
	margin-left: 0px;
	text-align: left;
	font-size: 50px;
	color: white;
	margin-top: 558px;
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
	table-layout:fixed;
	border: solid 1px #3f7dac;
	padding-left: 20PX;
}

table th {
	color: white;
	background-color: #3f7dac;
}
td{
	word-wrap:break-word;
}
label {
	color: black;
	font-size: 30px;
	height: 50px;
}

#tff{
	margin-top:10px;
	margin-bottom:10px;
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
	<div id="biaotou">报告单打印列表</div>
	<div id="time"
		style="position:absolute;top:30px;right:50px;font-size:30px;color: #FF0000;">
	</div>
	<div class="layui-inline">
		<div class="layui-input-inline">
		<label class="layui-form-label"
			style="width: 150px;padding-top: 30px;">姓名:</label>
		
			<input id="xming0" style="margin-top: 25px;padding-top: 12px;">
		</div>
		<div class="layui-input-inline">
		<label class="layui-form-label"
			style="width:100px;padding-top: 30px;">年龄:</label>
	
			<input id="nling" style="margin-top: 25px;padding-top: 12px;">
		</div>
		<div class="layui-input-inline">
		<label class="layui-form-label"
			style="width: 100px;padding-top: 30px;">性别:</label>
			<input id="xbie" style="margin-top: 25px;padding-top: 12px;">
		</div>
	</div>
 	 
	<div id="ypzlcx"
		style="z-index:30;position:absolute;left:14px;top:135px;display:block;text-align:center;width: 980px;">
		<table id="ypzlcx1" style="table-layout:fixed;cellspacing:2px">
			<thead>
				<tr
					style="height:40px;background-color:#3f7dac;border:1px solid black;color:white;">
					<td
						style="width:5%;height:40px;border:1px solid black;font-size:15px;font-coloer:white;text-align:center">序号</td>
					<td
						style="width:35%;height:40px;border:1px solid black;font-size:15px;text-align:center">送检项目名称</td>
					<td
						style="width:20%;height:40px;border:1px solid black;font-size:15px;text-align:center">送检科室</td>
					<td
						style="width:10%;height:40px;border:1px solid black;font-size:15px;text-align:center">送检医生</td>
					<td
						style="width:10%;height:40px;border:1px solid black;font-size:15px;text-align:center">送检时间</td>
					<td
						style="width:10%;height:40px;border:1px solid black;font-size:15px;text-align:center">状态</td>
					<td
						style="width:10%;height:40px;border:1px solid black;font-size:15px;text-align:center">接受时间</td>
					<td
						style="width:10%;height:40px;border:1px solid black;font-size:15px;text-align:center">打印操作</td>
				</tr>
			</thead>
			<tbody id="info1">

			</tbody>
			<tfoot>
				<tr>
					<td colspan="8"
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
							<button id = "dyall"
							style="font-size:35px;height:70px;border: none;"
								class="layui-btn layui-btn-primary layui-btn-radius"><img  src="../../images/m_mz_bgdy/dyall.jpg"></button>
						<div/>
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

	 <div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;position:absolute;left:212px;">
	 <img src="${pageContext.request.contextPath}/images/waiting.gif" >
   </div>
</body>


<script type="text/javascript">
	var qsym00 = 1;//起始页码
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
						window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
					}
				}, 1000);
		}
		
		
	
	
	//页面跳转方法	
function jump() {
		$("#main").bind("click dbclick", function() {
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});
		
	}
function getTableContent(node){
			// 按钮的父节点的父节点是tr。  
            var tr1 = node.parentNode.parentNode;
            alert(tr1.rowIndex + tr1.childNodes[1].innerHTML); //获取的方法一  
}
	//获取病理报告，渲染方法	
function getblbgAll() {
		//获取初始化页面参数
		var datas = {
			"funcid" : "M07.02.06.04",
			"zdbh00" : window.parent.zdbh00,
			"cxdm00" : window.parent.cardNo,
			"cxfs00" : "1",
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
				$("#info1").empty();//清空列表
				if (Data.retcode == "0") {
					var length = Data.retbody.length;
					if(length!=0){
						var j = 1;
					var i ;
					for (i = 0; i < length; i++) {
						if (j <= 8) {
							$("#info1").append(
								"<tr style=\"height:50px;border:1px solid black;\">"
								+ "<th style=\"width:70px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + j + "</th>"
								+ "<td style=\"width:200px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + Data.retbody[i].xmmc00 + "</td>"
								+ "<td style=\"width:120px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + Data.retbody[i].xmgg00 + "</td>"
								+ "<td style=\"width:120px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + Data.retbody[i].xmdw00 + "</td>"
								+ "<td style=\"width:120px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + Data.retbody[i].xmje00 + "</td>"
								+ "<td style=\"width:180px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + Data.retbody[i].zfbL00 + "</td>"
								+ "<td style=\"width:180px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\">" + Data.retbody[i].zfbL00 + "</td>"
								+ "<td style=\"width:180px;height:51px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:20px;text-align:center\"><img  src=\"../../images/m_mz_bgdy/dyButten.jpg\"onclick=\"getTableContent(this)\">></td>"
								+ "</tr>");
							j++;
						} else {
							j = 1;
							i--;
						}
					}
					var duochurow =i % 8
					empt = 8 - duochurow;
					if(empt==8){
					//正好查询出整页
					}else{//填充非整页页面数据
						var xh = duochurow+1;
						for (var k = 1; k <= empt; k++) {
							$("#info1").append(
								"<tr style=\"height:50px;border:1px solid black;\">"
								+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + xh + "</th>"
								+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + "</td>"
								+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + "</td>"
								+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + "</td>"
								+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + " </td>"
								+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + " </td>"
								+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + " </td>"
								+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + " " + " </td>"
								+ "</tr>");
							xh++;
						}
					}
					page = new Page(8, "ypzlcx1", "info1");
					$("#confirmBtn").text(qsym00);
					}
					
				} else {
					--qsym00;
					if(qsym00!=0){
						getYaoPinAll();
					}else{
						$("#info1").append(
							"<tr style=\"height:400px;border:1px solid #3f7dac;\">"
							+ "<td colspan='6' style='width:200px;height:80px;font-size:35px;text-align:center;'>" +  Data.retmsg + "</td>"
							+ "</tr>");
					}
				}
			},
			error : function() {
				$("#waiting").css("display","none");
				$("#info1").append(
					"<tr style=\"height:400px;border:1px solid #3f7dac;\">"
					+ "<td colspan='6' style='width:200px;height:80px;font-size:35px;text-align:center;'>" + Data.retmsg  + "</td>"
					+ "</tr>");
			}
		});
	}
/**
	* js分页类
	* @param iAbsolute 每页显示记录数
	* @param sTableId 分页表格属性ID值，为String
	* @param sTBodyId 分页表格TBODY的属性ID值,为String,此项为要分页的主体内容
	* @Version 1.0.0
	* @author 辛现宝 2007-01-15 created
	* var __variable__; private
	* function __method__(){};private
	*/
	function Page(iAbsolute, sTableId, sTBodyId) {
		this.absolute = iAbsolute; //每页最大记录数
		this.tableId = sTableId;
		this.tBodyId = sTBodyId;
		this.rowCount = 0; //记录数
		this.pageCount = 0; //页数
		this.pageIndex = 0; //页索引
		this.__oTable__ = null; //表格引用
		this.__oTBody__ = null; //要分页内容
		this.__dataRows__ = 0; //记录行引用
		this.__oldTBody__ = null;
		this.__init__(); //初始化;
	}
	;
	/*
	初始化
	*/
	Page.prototype.__init__ = function() {
		this.__oTable__ = document.getElementById(this.tableId); //获取table引用
		this.__oTBody__ = this.__oTable__.tBodies[this.tBodyId]; //获取tBody引用
		this.__dataRows__ = this.__oTBody__.rows;
		this.rowCount = this.__dataRows__.length;
		try {
			this.absolute = (this.absolute <= 0) || (this.absolute > this.rowCount) ? this.rowCount : this.absolute;
			this.pageCount = parseFloat(this.rowCount % this.absolute == 0
				? this.rowCount / this.absolute : this.rowCount / this.absolute + 1);
		} catch (exception) {}

		this.__updateTableRows__();
	};
	/*
	下一页
	*/
	Page.prototype.nextPage = function() {
			qsym00++;
			$("#waiting").css("display","block");
			getYaoPinAll();
	};
	/*
	上一页
	*/
	Page.prototype.prePage = function() {
		
			qsym00--;
			if (qsym00 > 0){
				$("#waiting").css("display","block");
				getYaoPinAll();
			}else{
				qsym00=1;
				$("#waiting").css("display","block");
				getYaoPinAll();
			}

	};
	/*
	首页
	*/
	Page.prototype.firstPage = function() {
		if (this.pageIndex != 0) {
			this.pageIndex = 0;
			this.__updateTableRows__();
		}
	};
	/*
	尾页
	*/
	Page.prototype.lastPage = function() {
		if (this.pageIndex + 1 != this.pageCount) {
			this.pageIndex = this.pageCount - 1;
			this.__updateTableRows__();
		}
	};
	/*
	页定位方法
	*/
	Page.prototype.aimPage = function(iPageIndex) {
		if (iPageIndex > this.pageCount - 1) {
			this.pageIndex = this.pageCount - 1;
		} else if (iPageIndex < 0) {
			this.pageIndex = 0;
		} else {
			this.pageIndex = iPageIndex;
		}
		this.__updateTableRows__();
	};
	/*
	执行分页时，更新显示表格内容
	*/
	Page.prototype.__updateTableRows__ = function() {
		var iCurrentRowCount = this.absolute * this.pageIndex;
		var iMoreRow = this.absolute + iCurrentRowCount > this.rowCount ? this.absolute + iCurrentRowCount - this.rowCount : 0;
		var tempRows = this.__cloneRows__();
		//alert(tempRows === this.dataRows);
		//alert(this.dataRows.length);
		var removedTBody = this.__oTable__.removeChild(this.__oTBody__);
		var newTBody = document.createElement("TBODY");
		newTBody.setAttribute("id", this.tBodyId);

		for (var i = iCurrentRowCount; i < this.absolute + iCurrentRowCount - iMoreRow; i++) {
			newTBody.appendChild(tempRows[i]);
		}
		this.__oTable__.appendChild(newTBody);
		/*
		this.dataRows为this.oTBody的一个引用，
		移除this.oTBody那么this.dataRows引用将销失,
		code:this.dataRows = tempRows;恢复原始操作行集合.
		*/
		this.__dataRows__ = tempRows;
		this.__oTBody__ = newTBody;
		//alert(this.dataRows.length);
		//alert(this.absolute+iCurrentRowCount);
		//alert("tempRows:"+tempRows.length);

	};
	/*
	克隆原始操作行集合
	*/
	Page.prototype.__cloneRows__ = function() {
		var tempRows = [];
		for (var i = 0; i < this.__dataRows__.length; i++) {
			/*
			code:this.dataRows[i].cloneNode(param), 
			param = 1 or true:复制以指定节点发展出去的所有节点,
			param = 0 or false:只有指定的节点和它的属性被复制.
			*/
			tempRows[i] = this.__dataRows__[i].cloneNode(1);
		}
		return tempRows;
	};	
		
var init = function() {
		$("#waiting").css("display","block");
		var qsym00 = 1; //起始页码
		getblbgAll(); //获取所有药品列表
		jump(); //跳转页面方法	
		returnTime(); //倒计时方法
		//用户点击或按键等操作时，倒计时重新计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		
	};
	init();
</script>
</html>

