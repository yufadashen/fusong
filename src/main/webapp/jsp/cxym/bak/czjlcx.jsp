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
<title>预交金交易记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
<script src="${pageContext.request.contextPath}/js/laydate.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/laydate.css" media="all">
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
	margin-top: 588px;
	line-height: 60px;
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
	font-size: 20px;
}
#pageup{
	background: #3f7dac;
	color: white;
	behavior:url(../../js/PIE.htc);
}
#pagedown{
	background: #3f7dac;
	color: white;
	behavior:url(../../js/PIE.htc);
}
</style>

</head>
<body scroll="no" id="info">
	<div id="biaotou">预交金交易记录</div>
	<div id="time"
		style="position:absolute;top:30px;right:50px;font-size:30px;color: #FF0000;">
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
		<button class="layui-btn" onclick="selectcx()">
			<img id="do_search"
				src="${pageContext.request.contextPath}/images/query.png">
		</button>
	</div>
	<div id="czjlcx"
		style="z-index:30;position:absolute;left:25px;top:135px;display:block;text-align:center">
		<table id="czjlcx1" style="table-layout:fixed;cellspacing:2px">
			<thead>
				<tr
					style="height:40px;background-color:#3f7dac;border:1px solid black;color:white;">
					<td
						style="width:70px;height:40px;border:1px solid black;font-size:25px;font-coloer:white;text-align:center">序号</td>
					<td
						style="width:300px;height:40px;border:1px solid black;font-size:25px;text-align:center">缴费日期</td>
					<td
						style="width:150px;height:40px;border:1px solid black;font-size:25px;text-align:center">缴费金额</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">缴费方法</td>
					<td
						style="width:120px;height:40px;border:1px solid black;font-size:25px;text-align:center">支付标志</td>
					<td
						style="width:180px;height:40px;border:1px solid black;font-size:25px;text-align:center">交易流水号</td>
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
  <div id="waiting"  style="margin: -529px 0px 0px 0px;display:none;z-index:1000;width:576px;height:321px;background-image:url('${pageContext.request.contextPath}/images/waiting.gif');position:absolute;left:212px;">
   </div>
</body>

<script>

	var init = function() {
		$("#waiting").show();
		returnTimeStart();
		cxjlcxNormal();
		event();
	}
	//设置倒计时功能
	function returnTimeStart() {
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

	}
	//充值记录查询
	function cxjlcxNormal() {
		laydate.render({
			elem : '#qsrq00', //指定元素
			format : 'yyyyMMdd', //可任意组合
			value : new Date(new Date().getTime() - 2592000000),
			maxDate : new Date(),
			isInitValue : false //是否允许填充初始值，默认为 true,isInitValue: false //是否允许填充初始值，默认为 true
		});
		laydate.render({
			elem : '#jzrq00', //指定元素
			format : 'yyyyMMdd', //可任意组合
			value : new Date(),
			maxDate : new Date(),
			isInitValue : false //是否允许填充初始值，默认为 true
		});
		
		var qsrq00init = document.getElementById("qsrq00").value;
		var jzrq00init  = document.getElementById("jzrq00").value;
		var datas = {
			"funcid" : "M07.02.06.01",
			"zdbh00" : window.parent.zdbh00,
			"yyjgdm" : "",
			"cxfs00" : window.parent.cardtype,
			"brid00" : window.parent.brid00,
			"cxdm00" : window.parent.cardNo,
			"qsrq00" : qsrq00init,
			"jzrq00" : jzrq00init
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
				//$("#waiting").hide();
				Data = eval(json);
				setDataZL();
			},
			error : function() {
				$("#waiting").hide();
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
			}
		})
	}

	//充值信息条件查询
	function selectcx() {
		
		var qsrq00tj = document.getElementById("qsrq00").value;
		var jzrq00tj = document.getElementById("jzrq00").value;
		
		var datatj = {
			"funcid" : "M07.02.06.01",
			"zdbh00" : window.parent.zdbh00,
			"yyjgdm" : "",
			"cxfs00" : window.parent.cardtype,
			"brid00" : window.parent.brid00,
			"cxdm00" : window.parent.cardNo,
			"qsrq00" : qsrq00tj,
			"jzrq00" : jzrq00tj
		};
		$.ajax({
			async : false,
			type : "post",
			data : datatj,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url : window.parent.serverUrl + "?method=ApplyAction",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			success : function(json) {
				Data = eval(json);
				$("#info1").empty();//清空列表
				setDataZL();
			},
			error : function() {
				$("#tip_div").show();
				$("#error").text("系统异常,请稍后再试!");
			}
		})

	}
	//渲染table数据
	function setDataZL() {
		$("#waiting").hide();
		if (Data.retcode == "0") {
			var length = Data.retbody.length;
			var j = 1;
			for (var i = 0; i < length; i++) {
				if (j <= 8) {
						$("#info1").append(
							"<tr style=\"height:50px;border:1px solid black;\">"
							+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" + j + "</th>"
							+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].jyrq00 + "</td>"
							+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].jyje00 + "元</td>"
							+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].jyfs00 + "</td>"
							+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].zfbz00 + " </td>"
							+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\">" + Data.retbody[i].jylsh0 + " </td>"
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
						+ "<th style=\"width:70px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" +xh+ "</th>"
						+ "<td style=\"width:300px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:150px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" + " " + "</td>"
						+ "<td style=\"width:120px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" + " " + " </td>"
						+ "<td style=\"width:180px;height:50px;border:1px solid black;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:35px;text-align:center\">" + " " + " </td>"
						+ "</tr>");
						xh++;
				}
			}
			
			page = new Page(8, "czjlcx1", "info1");
			$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
		} else {
			$("#info1").append(
				"<tr style=\"height:50px;border:1px solid black;\">"
				+ "<td colspan='6' style='width:200px;height:80px;font-size:35px;text-align:center;'>" + Data.retmsg + "</td>"
				+ "</tr>");
		}
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
			this.pageCount = parseInt(this.rowCount % this.absolute == 0
				? this.rowCount / this.absolute : this.rowCount / this.absolute + 1);
		} catch (exception) {}

		this.__updateTableRows__();
	};
	/*
	下一页
	*/
	Page.prototype.nextPage = function() {
		if (this.pageIndex + 1 < this.pageCount) {
			this.pageIndex += 1;
			this.__updateTableRows__();
		}
		$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
	};
	/*
	上一页
	*/
	Page.prototype.prePage = function() {
		if (this.pageIndex >= 1) {
			this.pageIndex -= 1;
			this.__updateTableRows__();
		}
		$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
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
	

	
	function  event(){
		$("#do_search").bind("click dbclick", function() {
		
			selectcx();
		});
		$("#main").bind("click dbclick", function() {
		
			window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
		});
		$("#pre").bind("click dbclick", function() {
		
			window.location.href = "${pageContext.request.contextPath}/jsp/cxym/xxcx.jsp";
		});
		
	}
	
	init();
</script>
</html>

