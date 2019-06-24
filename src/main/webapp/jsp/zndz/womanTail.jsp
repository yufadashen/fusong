
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<object width="0" height="0" name="plugin"
	classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
<object width="0" height="0" id="AVFOCX"
	classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
<title>智能导诊</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
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
	width: 100%;
	height: 100%;
	overflow: hidden;
	text-align: center;
	background: url(${pageContext.request.contextPath}/images/bj.jpg)
		no-repeat;
}

#pageup {
	margin-right: 100px;
}
</style>
</head>
<body scroll="no">
	<div id="time" style="position:absolute;top:30px;right:80px;font-size:60px;color: #FF0000;">
   	</div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:465px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/zndz/qdmix.png" width="90"
			height="43" style="position:relative;top:125px;left:4px" />
	</div>
	<div style="z-index:60;position:absolute;top:160px;left:460px;">
		<img id="title"
			src="${pageContext.request.contextPath}/images/zndz/zndztitle.png" />
	</div>
	<div id="man_info" style="display:block">
		<!-- 人體圖片 -->
		<div id="man"
			style="z-index:40;position:absolute;top:300px;left:350px">
			<img id="manFront"
				src="${pageContext.request.contextPath}/images/zndz/womanTail.png"
				res_img="${pageContext.request.contextPath}/images/zndz/womanTail.png"
				height="" width="" />
		</div>
		<!-- 正反面按鈕 -->
		<div id="button"
			style="z-index:40;position:absolute;top:300px;left:930px">
			<img id="tailButton"
				src="${pageContext.request.contextPath}/images/zndz/tail.png"
				res_img="${pageContext.request.contextPath}/images/zndz/tail.png"
				height="" width="" />
		</div>
		<!-- 人體反面部位開始********** -->
		<div id="lubu"
			style="position: absolute;top:316px;left:760px;z-index:999;">
			<img src="${pageContext.request.contextPath}/images/zndz/lubu.png"
				res_img="${pageContext.request.contextPath}/images/zndz/lubu.png"
				value="14" onclick="getId(this)" />
		</div>
		<div id="yaobu"
			style="position: absolute;top:496px;left:254px;z-index:999;">
			<img src="${pageContext.request.contextPath}/images/zndz/yaobu.png"
				res_img="${pageContext.request.contextPath}/images/zndz/yaobu.png"
				value="6" onclick="getId(this)" />
		</div>
		<div id="beibu"
			style="position: absolute;top:465px;left:851px;z-index:999;">
			<img src="${pageContext.request.contextPath}/images/zndz/beibu.png"
				res_img="${pageContext.request.contextPath}/images/zndz/beibu.png"
				value="13" onclick="getId(this)" />
		</div>
		<div id="tunbu"
			style="position: absolute;top:560px;left:295px;z-index:999;">
			<img src="${pageContext.request.contextPath}/images/zndz/tunbu.png"
				res_img="${pageContext.request.contextPath}/images/zndz/tunbu.png"
				value="5" onclick="getId(this)" />
		</div>
		<div id="quanshen"
			style="position: absolute;top:408px;left:284px;z-index:999;">
			<img
				src="${pageContext.request.contextPath}/images/zndz/quanshen.png"
				res_img="${pageContext.request.contextPath}/images/zndz/quanshen.png"
				value="12" onclick="getId(this)" />
		</div>
	</div>
	<!-- 返回主頁面 -->
	<div id="main" style="position: absolute;top:850px;left:320px;">
		<img src="${pageContext.request.contextPath}/images/zndz/main.png"
			res_img="${pageContext.request.contextPath}/images/zndz/main1.png"
			height="" width="" />
	</div>
	<!-- 返回上一步 -->
	<div id="pre" style="position: absolute;top:840px;left:760px;">
		<img src="${pageContext.request.contextPath}/images/zndz/pre.png"
			res_img="${pageContext.request.contextPath}/images/zndz/pre1.png"
			height="" width="" />
	</div>
	<!--  提示信息选择症状-->
	<div id="word"
		style="width:600px;z-index:60;position:absolute;top:310px;left:320px;display:none">
		<span style="width:600px;font-size:60px;text-align:center;color:red">请选择您的症状</span>
	</div>
	<!--  提示信息选择科室-->
	<div id="word1"
		style="width:600px;z-index:60;position:absolute;top:310px;left:320px;display:none">
		<span style="width:600px;font-size:60px;text-align:center;color:red">建议以下科室就诊</span>
	</div>
	<!-- 查询所有症状 -->
	<div id="zndzinfo"
		style="width:1060px;position:absolute;top:400px;left:195px;display:none">
		<table id="dzInfo"
			style="width:760px;border:1px solid black;table-layout:fixed">
			<thead>
				<tr
					style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px;">
					<td
						style="width:150px;height:60px;border:1px solid black;font-size:35px;text-align:center">症状编号</td>
					<td
						style="width:550px;height:60px;border:1px solid black;font-size:35px;text-align:center">症状名称</td>
					<td
						style="width:150px;height:60px;border:1px solid black;font-size:35px;text-align:center">查询科室</td>
				</tr>
			</thead>
			<tbody id="info">
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3"
						style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
						<button id="pageup" style="font-size:35px;height:50px"
							class="layui-btn layui-btn-primary layui-btn-radius"
							onclick="page.prePage();">上一页</button>
						<button id="pagedown" style="font-size:35px;height:50px"
							class="layui-btn layui-btn-primary layui-btn-radius"
							onclick="page.nextPage();">下一页</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<!-- 查询对应科室 -->
	<div id="dyksinfo"
		style="width:1060px;position:absolute;top:400px;left:245px;display:none">
		<table id="ksInfo"
			style="width:760px;border:1px solid black;table-layout:fixed">
			<thead>
				<tr
					style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px;">
					<td
						style="width:150px;height:60px;border:1px solid black;font-size:35px;text-align:center">科室编号</td>
					<td
						style="width:550px;height:60px;border:1px solid black;font-size:35px;text-align:center">科室名称</td>
				</tr>
			</thead>
			<tbody id="ksBody">
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"
						style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
						<button id="pageup" style="font-size:35px;height:50px"
							class="layui-btn layui-btn-primary layui-btn-radius"
							onclick="page.prePage();">上一页</button>
						<button id="pagedown" style="font-size:35px;height:50px"
							class="layui-btn layui-btn-primary layui-btn-radius"
							onclick="page.nextPage();">下一页</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
<script type="text/javascript">
	//returnTime();
	var xbbh00 = "2"; //性别编号,进入此页面默认为1
	var bwbh00; //部位编号
	var zzbh00; //症状编号
	//初始化倒计时时间：120秒
	var time = window.parent.reTime;
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				}
			}, 1000);
	}
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = window.parent.reTime;
	}
	returnTime();
	/* 查询所有症状  获取症状编号 */
	function getId(obj) {
		bwbh00 = obj.getAttribute("value");
		var datas = {
			"funcid" : "M07.02.20.01",
			"xbbh00" : xbbh00,
			"bwbh00" : bwbh00
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			url:window.parent.serverUrl+"?method=ApplyAction",
			success : function(json) {
				Data = eval(json);
				if (Data.retcode == "0") {
					for (var i = 0; i < Data.retbody.length; i++) {
						$("#info").append(
							"<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
							+ "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].zzbh00 + "</td>"
							+ "<td style=\"width:260px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].zzmc00 + "</td>"
							+ "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + "<img  src='${pageContext.request.contextPath}/images/zndz/queding.png' "
							+ "id='s" + i + "' height='50px' width='120px' onclick='cxks(this)'/>"
							+ "</td>"
							+ "</tr>")
					}
					;page = new Page(5, "dzInfo", "info");
					$("#man_info").hide();
					$("#word").show();
					$("#zndzinfo").show();
				} else {
					$("#man_info").hide();
					$("#tip_div").show();
					$("#error").text("页面找不到了，请稍后再试！");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.reload();
					});
				}
			},
			error : function() {
				$("#man_info").hide();
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}
	/* 查询科室 */
	function cxks(obj) {
		zzbh00 = Data.retbody[parseInt(obj.id.substr(1, 1))].zzbh00;
		var datas = {
			"funcid" : "M07.02.20.02",
			"xbbh00" : xbbh00,
			"bwbh00" : bwbh00,
			"zzbh00" : zzbh00
		};
		$.ajax({
			async : false,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			//url : "${pageContext.request.contextPath}/Test/test.do",
			url:window.parent.serverUrl+"?method=ApplyAction",
			success : function(json) {
				Data1 = eval(json);
				if (Data1.retcode == "0") {
					for (var i = 0; i < Data1.retbody.length; i++) {
						$("#ksBody").append(
							"<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
							+ "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + Data1.retbody[i].ksbh00 + "</td>"
							+ "<td style=\"width:260px;border:1px solid black;font-size:35px;text-align:center\">" + Data1.retbody[i].ksmc00 + "</td>"
							+ "</tr>")
					}
					;page = new Page(5, "ksInfo", "ksBody");
					$("#word").hide();
					$("#zndzinfo").hide();
					$("#word1").show();
					$("#dyksinfo").show();
				} else {
					$("#man_info").hide();
					$("#tip_div").show();
					$("#error").text("页面找不到了，请稍后再试！");
					$("#tip_s").on("click", function() {
						$("#tip_div").hide();
						window.location.reload();
					});
				}
			},
			error : function() {
				$("#man_info").hide();
				$("#tip_div").show();
				$("#error").text("系统异常，请稍后再试！");
				$("#tip_s").on("click", function() {
					$("#tip_div").hide();
					window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
				});
			}
		});
	}
	$("#main").bind("click dbclick", function() {
		window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
	});
	$("#pre").bind("click dbclick", function() {
		window.history.back();
	});
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});
	//点击反面 返回女士正面    
	$("#tailButton").bind("click dbclick", function() {
		window.location.href = "woman.jsp";
	})
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
	};
	/*
	上一页
	*/
	Page.prototype.prePage = function() {
		if (this.pageIndex >= 1) {
			this.pageIndex -= 1;
			this.__updateTableRows__();
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
</script>
</html>



