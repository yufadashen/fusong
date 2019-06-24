<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
    <title>预约取消</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
    <script src="${pageContext.request.contextPath}/js/layui.js"
            charset="utf-8"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/layui.css" media="all">
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
    </style>
</head>
<body scroll="no">
<div id="title"
     style="z-index:60;display:block;position:absolute;top:195px;left:460px;">
    <img id="tip1"
         src="${pageContext.request.contextPath}/images/yyqx.png" />
</div>
<div id="cancleWarningTitle" hidden="hidden">
    <span style="color: red;font-size: 35px;top:280px;left:440px;display:block;position:absolute;">您是否要取消以下预约信息</span>
</div>
<div id="yyqxinfo"
     style="width:1060px;position:absolute;top:290px;left:110px;display:block">
    <table id="yyInfo" style="width:860px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr
                style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px">
            <td
                    style="width:330px;height:60px;border:1px solid black;font-size:35px;text-align:center">预约科室</td>
            <td
                    style="width:200px;height:60px;border:1px solid black;font-size:35px;text-align:center">专家</td>
            <td
                    style="width:200px;height:60px;border:1px solid black;font-size:35px;text-align:center">日期</td>
            <td
                    style="width:200px;height:60px;border:1px solid black;font-size:35px;text-align:center">时间</td>
            <td
                    style="width:100px;height:60px;border:1px solid black;font-size:35px;text-align:center">取消</td>
        </tr>
        </thead>
        <tbody id="info">
        </tbody>
        <tfoot>
        <tr>
            <td colspan="2"
                style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pageup" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.prePage();">上一页</button>
            </td>
            <td colspan="3"
                style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.nextPage();">下一页</button>
            </td>
        </tr>
        </tfoot>
    </table>
</div>
<!-- 删除成功提示页面 -->
<div id="del_div"
     style="display:none;width:800px;height:400px;background-image:url('${pageContext.request.contextPath}/images/dck3.png');position:absolute;left:228px;top:335px;">
    <div id="del_divInfo"
         style="text-align:center;position:relative;top:100px">

        <form>
            <span style="font-size:30px;color:balck;"><strong>预约科室:</strong></span><input
                id="yyks" value=""
                style="width:350px;height:40px;font-size:30px;" readonly="readonly"><br />
            <span style="font-size:30px;color:balck;"><strong>预约医生:</strong></span>
            <input id="yyys"
                   style="width:350px;height:40px;font-size:30px;" readonly="readonly"><br />
            <span style="font-size:30px;color:balck;"><strong>预约日期:</strong></span>
            <input id="yyrq"
                   style="width:350px;height:40px;font-size:30px;" readonly="readonly"><br />
            <span style="font-size:30px;color:balck;"><strong>预约时间:</strong></span>
            <input id="yysj"
                   style="width:350px;height:40px;font-size:30px;" readonly="readonly"><br />
        </form>

        <span id="del_error" style="font-size:30px;color:#EE7700;"><strong></strong></span>

    </div>
    <img id="del_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="120"
         height="50" style="position:relative;top:150px;left:-80px" /> <img
        id="del_c" src="${pageContext.request.contextPath}/images/quxiao.png"
        width="120" height="50"
        style="position:relative;top:150px;left:110px" />

</div>
<!-- 提示错误信息界面 -->
<div id="tip_div"
     style="display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:465px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong>获取成功</strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:125px;left:4px" />
</div>
<div id="confirmSpan" style="top: 120px;left: 460px;"> <span style="color: red;font-size: 35px;top:230px;left:800px;display:block;position:absolute;">已缴费的请到窗口退费</span> </div>
<%--主页按钮--%>
<div id="main" style="position: absolute;top:800px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
<%--返回上一步按钮--%>
<div id="pre" style="position: absolute;top:790px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script>

    var dataLength;
    var ksmc00 = "";
    var ysxm00 = "";
    var sd0000 = "";
    var jzsjd0 = "";
    var ghfy00 = "";
    //页面加载
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;
    //自动倒计时，计时时间为0时，
    function returnTime() {
        myVar = setInterval(
            function() {
                time--;
                $("#time").text(time);
                if (time == 0) {
                    if (typeof ($.session)!="undefined"){
                        $.session.clear();
                    }
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


    window.onload = function() {
        getYYInfo();
    }
    function getYYInfo() {
        $("#jz").show();
        var datas = {
            "funcid" : "M07.02.04.08",
            "mzlxbh" : "",
            "ksrq00" : "",
            "jzrq00" : "",
            "yyzt00" : "1",
            "cxdm00" : window.parent.cardNo,
            "cxfs00" : window.parent.cardtype,
            "brid00" : window.parent.brid00
        };
        $.ajax({
            async : true,
            type : "post",
            data : datas,
            dataType : "json",
            contentType : "application/x-www-form-urlencoded; charset=utf-8",
            //url : "${pageContext.request.contextPath}/Test/test.do",
            url:window.parent.serverUrl+"?method=ApplyAction",
            success : function(json) {
                $("#jz").hide();
                Data = eval(json);
                dataLength = Data.retbody.length;
                if (Data.retcode == "0") {
                    //把信息添加到表格中
                    //log.WriteLog("证件编码为："+zjbm00+"获取个人预约信息成功！");
                    for (var i = 0; i < Data.retbody.length; i++) {
                        $("#info").append(
                            "<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
                            + "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].mzksmc + "</td>"
                            + "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].mzysxm + "</td>"
                            + "<td style=\"width:200px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].yysj00.substring(0,10) + "</td>"
                            + "<td style=\"width:200px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].yysj00.substring(11,20) + "</td>"
                            + "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">"
                            + "<img  src='${pageContext.request.contextPath}/images/close2.png' value='Data.retbody[i].yylsh0' "
                            + "id='s" + i + "' height='60px' width='60px' onclick='cancelRes(this)'/>"
                            + "</td>"
                            + "</tr>")
                    };page = new Page(5,"yyInfo","info");
                } else {
                    //log.WriteLog("证件编码为："+zjbm00+"获取个人预约信息失败！");
                    $("#yyqxinfo").hide();
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function() {
                        $("#tip_div").hide();
                    });
                }
            },
            error : function() {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
                $("#tip_s").on("click", function() {
                    $("#tip_div").hide();
                });
            }
        });
    }
    //取消预约记录
    function cancelRes(obj) {
        $("#cancleWarningTitle").show();
        ksmc00 = Data.retbody[parseInt(obj.getAttribute("id").substr(1, 1))].mzksmc;
        ysxm00 = Data.retbody[parseInt(obj.getAttribute("id").substr(1, 1))].mzysxm;
        sd0000 = Data.retbody[parseInt(obj.getAttribute("id").substr(1, 1))].yysj00.substring(0,10);
        jzsjd0 = Data.retbody[parseInt(obj.getAttribute("id").substr(1, 1))].yysj00.substring(11,20);

        document.getElementById("yyks").value = ksmc00; //挂号科室
        document.getElementById("yyys").value = ysxm00; //医生姓名
        document.getElementById("yyrq").value = sd0000; //预约日期
        document.getElementById("yysj").value = jzsjd0; //預約时间段
        $("#yyqxinfo").hide();
        $("#del_div").show();
        $("#del_s").on("click", function() {
            $("#jz").show();
            var datas = {
                "funcid" : "M07.02.04.09",
                "yyjgdmyypt" : "",
                "yylsh0" : Data.retbody[parseInt(obj.getAttribute("id").substr(1, 1))].yylsh0
            };
            $.ajax({
                async : true,
                type : "post",
                data : datas,
                dataType : "json",
                contentType : "application/x-www-form-urlencoded; charset=utf-8",
                //url : "${pageContext.request.contextPath}/Test/test.do",
                url:window.parent.serverUrl+"?method=ApplyAction",
                success : function(json) {
                    $("#jz").hide();
                    $("#cancleWarningTitle").show();
                    Data1 = eval(json);
                    if (Data1.retcode == "0") { //0代表成功
                        //log.WriteLog("取消预约单号为："+yydh00+"操作成功");
                        $("#del_div").hide();
                        $("#tip_div").show();
                        $("#error").text("取消预约信息成功");
                        $("#tip_s").on("click", function() {
                            /*getYYInfo();
                            if (dataLength>0){
                                window.history.go(0);
                            }else{
                                $("#tip_div").hide();
                                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                            }*/

                            if (dataLength>0){
                                getYYInfo();
                                window.history.go(0);
                            }else{
                                $("#tip_div").hide();
                                //window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                                window.history.go(0);
                            }
                        });

                    } else {
                        $("#tip_div").show();
                        $("#error").text(Data1.retmsg);
                        $("#tip_s").on("click", function() {
                            $("#tip_div").hide();
                            if (dataLength > 0) {
                                window.history.go(0);
                            }else{
                                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                            }

                        });
                        //提示删除预约失败
                        //log.WriteLog("取消预约单号为："+yydh00+"操作失败");
                        /*$("#yyqxinfo").hide();
                        $("#del_div").show();
                        $("#del_div").show();
                        $("#del_s").on("click", function() {
                            $("#del_div").hide();
                            $("#tip_div").show();
                            $("#error").text(Data.retmsg);
                            $("#tip_s").on("click", function() {
                                $("#tip_div").hide();
                                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                            });
                        });*/
                    }
                },
                error : function() {
                    $("#jz").hide();
                    $("#cancleWarningTitle").show();
                    $("#tip_div").show();
                    $("#error").text("系统异常，请稍后再试！");
                    $("#tip_s").on("click", function() {
                        $("#tip_div").hide();
                    });
                }
            });
        });
        $("#del_c").on("click", function() { //点击取消返回预约信息列表
            $("#del_div").hide();
            $("#yyqxinfo").show();
        });
    }
    $("#main").bind("click dbclick", function() {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#pre").bind("click dbclick", function () {
        window.history.go(-1);
        //window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

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
