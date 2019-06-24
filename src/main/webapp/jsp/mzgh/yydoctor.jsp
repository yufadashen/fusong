<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" name="plugin"
            classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <title>门诊预约-医生</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
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
            background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
        }
    </style>
</head>
<body scroll="no">
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="stepByKeshi" class="ui-stepBar-wrap"
     style="display:none;width:90%;height:100px;position:absolute;top:255px;left:57px;background-color:#f7fcff">
    <div class="ui-stepBar">
        <div class="ui-stepProcess"></div>
    </div>
    <div class="ui-stepInfo-wrap">
        <table class="ui-stepLayout" border="0" cellpadding="0"
               cellspacing="0">
            <tr>
                <td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
                    <p class="ui-stepName">选择科室</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
                    <p class="ui-stepName">选择医生</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
                    <p class="ui-stepName">选择日期</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
                    <p class="ui-stepName">选择时间</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">5</a>
                    <p class="ui-stepName">填写电话</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">6</a>
                    <p class="ui-stepName">预约</p></td>
            </tr>
        </table>
    </div>
</div>
<div id="stepByRiqi" class="ui-stepBar-wrap"
     style="display:none;width:90%;height:100px;position:absolute;top:1200px;left:57px;background-color:#f7fcff">
    <div class="ui-stepBar">
        <div class="ui-stepProcess"></div>
    </div>
    <div class="ui-stepInfo-wrap">
        <table class="ui-stepLayout" border="0" cellpadding="0"
               cellspacing="0">
            <tr>
                <td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
                    <p class="ui-stepName">选择日期</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
                    <p class="ui-stepName">选择科室</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
                    <p class="ui-stepName">选择医生</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
                    <p class="ui-stepName">选择时间</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">5</a>
                    <p class="ui-stepName">填写电话</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">6</a>
                    <p class="ui-stepName">预约</p></td>
            </tr>
        </table>
    </div>
</div>
<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:465px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:145px;left:4px"/>
</div>
<div style="z-index:60;position:absolute;top:160px;left:480px;">
    <img id="title"
         src="${pageContext.request.contextPath}/images/yytitle.png"/>
</div>
<div id="doctor"
     style="z-index:30;position:absolute;left:130px;top:400px;display:block;text-align:center">
    <table id="doctor1" style="table-layout:fixed;cellspacing:2px">
        <thead>
        <%--<tr
                style="height:80px;background-color:#E0FFFF;border:1px solid black;">
            <td
                    style="width:190px;height:60px;border:1px solid black;font-size:25px;text-align:center">医生姓名
            </td>
            <td
                    style="width:190px;height:60px;border:1px solid black;font-size:25px;text-align:center">医生职称
            </td>
            &lt;%&ndash;            <td
                                style="width:190px;height:60px;border:1px solid black;font-size:35px;text-align:center">挂号费用
                        </td>&ndash;%&gt;
            &lt;%&ndash;<td
                    style="width:190px;height:60px;border:1px solid black;font-size:35px;text-align:center">剩余号源
            </td>&ndash;%&gt;
            <td
                    style="width:190px;height:60px;border:1px solid black;font-size:25px;text-align:center">操作
            </td>
        </tr>--%>
        </thead>
        <tbody id="info1"></tbody>
        <tfoot>
        <tr>
            <td colspan="2"
                style="width:200px;height:100px;font-size:35px;text-align:center;">
                <button id="pageup" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.prePage();">上一页
                </button>
            </td>
            <td colspan="3"
                style="width:200px;height:100px;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.nextPage();">下一页
                </button>
            </td>
        </tr>
        </tfoot>
    </table>
</div>
<div id="main" style="position: absolute;top:800px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
<div id="pre" style="position: absolute;top:790px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script type="text/javascript">
    var cardNo = window.parent.cardNo;//卡号
    var xming0 = window.parent.xming0;//患者名称
    var xbie00 = window.parent.xbie00;//患者性别
    var csrq00 = window.parent.csrq00;//出生日期
    var brnl00 = window.parent.brnl00;//病人年龄
    var brid00 = window.parent.brid00;//病人ID
    var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用）
    var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
    var doctor; //医生
    var ysid00;//医生ID
    var pbid00;//排班ID
    var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
    var ghzfy0 = ""; //挂号价格
    var log = document.getElementById("AVFOCX");
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;

    //$("#tip_div").show();

    //自动倒计时，计时时间为0时，
    function returnTime() {
        myVar = setInterval(
            function () {
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
    Page.prototype.__init__ = function () {
        this.__oTable__ = document.getElementById(this.tableId); //获取table引用
        this.__oTBody__ = this.__oTable__.tBodies[this.tBodyId]; //获取tBody引用
        this.__dataRows__ = this.__oTBody__.rows;
        this.rowCount = this.__dataRows__.length;
        try {
            this.absolute = (this.absolute <= 0) || (this.absolute > this.rowCount) ? this.rowCount : this.absolute;
            this.pageCount = parseInt(this.rowCount % this.absolute == 0
                ? this.rowCount / this.absolute : this.rowCount / this.absolute + 1);
        } catch (exception) {
        }

        this.__updateTableRows__();
    };
    /*
    下一页
    */
    Page.prototype.nextPage = function () {
        if (this.pageIndex + 1 < this.pageCount) {
            this.pageIndex += 1;
            this.__updateTableRows__();
        }
    };
    /*
    上一页
    */
    Page.prototype.prePage = function () {
        if (this.pageIndex >= 1) {
            this.pageIndex -= 1;
            this.__updateTableRows__();
        }
    };
    /*
    首页
    */
    Page.prototype.firstPage = function () {
        if (this.pageIndex != 0) {
            this.pageIndex = 0;
            this.__updateTableRows__();
        }
    };
    /*
    尾页
    */
    Page.prototype.lastPage = function () {
        if (this.pageIndex + 1 != this.pageCount) {
            this.pageIndex = this.pageCount - 1;
            this.__updateTableRows__();
        }
    };
    /*
    页定位方法
    */
    Page.prototype.aimPage = function (iPageIndex) {
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
    Page.prototype.__updateTableRows__ = function () {
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
    Page.prototype.__cloneRows__ = function () {
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


    $("#main").bind("click dbclick", function () {
        if (typeof ($.session) != "undefined"){
            $.session.clear();
        }
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#pre").bind("click dbclick", function () {
        window.history.back();
    });
    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
        window.history.go(-1);
    });


    function stepshow() {
        $("#stepByKeshi").show();
        $(function () {
            stepBar.init("stepByKeshi", {
                step: 2,
                change: false,
                animation: false
            });
        });
        getDoctor();
    }

    function getDateAfterNumber(AddDayCount) {
        var dd = new Date();
        dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
        var y = dd.getFullYear();
        var m = (dd.getMonth()+1)<10 ? ('0'+(dd.getMonth()+1)) : (dd.getMonth()+1);
        var d = dd.getDate() <10 ? ('0'+ dd.getDate()) :dd.getDate();
        return y+"-"+m+"-"+d;
    }

    function getDoctor() {
        var timeKssj00 = getDateAfterNumber(1) + " 00:00:00";
        var timeJssj00 = getDateAfterNumber(10) + " 23:59:59";
        var datas = {
            "funcid": "M07.02.04.04",
            "mzksbh": $.session.get('ksid00'),
            "hbbm00": $.session.get("setParamHbbm00"),
            "kscxdm": "",
            "kssj00": timeKssj00,
            "jssj00": timeJssj00,
            "yywbmc": "",
            "sfxsqb": "1",
            "dqcxy0": "",
            "pageSize": ""
        };
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success: function (json) {
                $("#jz").hide();
                Data = eval(json);

                if (Data.retcode == "0") {
                    var length = Data.retbody.length;
                    for (var i = 0; i < length; i = i + 4) {
                        if (typeof (Data.retbody[i].mzyszc) == "undefined") {
                            Data.retbody[i].mzyszc = " ";
                        }
                        if (i + 3 < length) {
                            $("#info1").append(
                                "<tr style=\"height:80px;\">"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzysxm + "-" + Data.retbody[i].mzyszc + "-" + Data.retbody[i].hyzs00 + "-" + Data.retbody[i].syghs0 + "*" + Data.retbody[i].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i+1].mzysxm + "-" + Data.retbody[i+1].mzyszc + "-" + Data.retbody[i+1].hyzs00 + "-" + Data.retbody[i+1].syghs0 + "*" + Data.retbody[i+1].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i+1].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i+1].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i+2].mzysxm + "-" + Data.retbody[i+2].mzyszc + "-" + Data.retbody[i+2].hyzs00 + "-" + Data.retbody[i+2].syghs0 + "*" + Data.retbody[i+2].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i+2].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i+2].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i+3].mzysxm + "-" + Data.retbody[i+3].mzyszc + "-" + Data.retbody[i+3].hyzs00 + "-" + Data.retbody[i+3].syghs0 + "*" + Data.retbody[i+3].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i+3].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i+3].mzyszc+"</span></button></td>"
                                + "</tr>"
                            );
                        } else if (i + 2 < length) {
                            $("#info1").append(
                                "<tr style=\"height:80px;\">"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzysxm + "-" + Data.retbody[i].mzyszc + "-" + Data.retbody[i].hyzs00 + "-" + Data.retbody[i].syghs0 + "*" + Data.retbody[i].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzysxm +"<br>" + " <span style='font-size: small'>"+Data.retbody[i].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i+1].mzysxm + "-" + Data.retbody[i+1].mzyszc + "-" + Data.retbody[i+1].hyzs00 + "-" + Data.retbody[i+1].syghs0 + "*" + Data.retbody[i+1].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i+1].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i+1].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i+2].mzysxm + "-" + Data.retbody[i+2].mzyszc + "-" + Data.retbody[i+2].hyzs00 + "-" + Data.retbody[i+2].syghs0 + "*" + Data.retbody[i+2].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i+2].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i+2].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"></td>"
                                + "</tr>"
                            );
                        } else if (i + 1 < length) {
                            $("#info1").append(
                                "<tr style=\"height:80px;\">"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzysxm + "-" + Data.retbody[i].mzyszc + "-" + Data.retbody[i].hyzs00 + "-" + Data.retbody[i].syghs0 + "*" + Data.retbody[i].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i+1].mzysxm + "-" + Data.retbody[i+1].mzyszc + "-" + Data.retbody[i+1].hyzs00 + "-" + Data.retbody[i+1].syghs0 + "*" + Data.retbody[i+1].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i+1].mzysxm +"<br>" + " <span style='font-size: small'>"+ Data.retbody[i+1].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"></td>"
                                + "</tr>"
                            );
                        } else if (i < length) {
                            $("#info1").append(
                                "<tr style=\"height:80px;\">"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzysxm + "-" + Data.retbody[i].mzyszc + "-" + Data.retbody[i].hyzs00 + "-" + Data.retbody[i].syghs0 + "*" + Data.retbody[i].mzysbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzysxm +"<br>" + " <span style='font-size: small'>"+Data.retbody[i].mzyszc+"</span></button></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"></td>"
                                + "<td style=\"width:190px;height:60px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:25px;text-align:center\"></td>"
                                + "</tr>"
                            );
                        }
                    }
                    page = new Page(5, "doctor1", "info1");


                }else if (Data.retcode == "-1"){
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                } else {
                    //log.WriteLog("卡号为:"+cardNo+"获取医生列表失败");
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常,请稍后再试!");
            }
        });
    }

    function clickKeshi(obj) {
        //alert($(obj).val());
        //舒丽莎-主任医师-58-58*C3338B91-FE4A-44C5-922D-FCF851EE2210
        doctor = $(obj).val().split("-")[0];
        // console.log(doctor);
        ghzfy0 = $(obj).val().split("-")[1];
        // console.log(ghzfy0)
        ysid00 = $(obj).val().split("-")[2];
        // console.log(ysid00)
        pbid00 = $(obj).val().split("-")[3];
        // console.log(pbid00)
        mzysbh = $(obj).val().split("*")[1];
        // console.log(mzysbh)

        //医生剩余号源
        var doctoryMessage = $(obj).val().split("*");
        var docInfo = doctoryMessage[0];
        var strings1 = docInfo.split("-");
        var doctroyResidueNum = strings1[3];
        //alert(doctroyResidueNum);
        //将医生编号放入session 中
        $.session.set('doctor', doctor);
        $.session.set('ghzfy0', ghzfy0);
        $.session.set('ysid00', ysid00);
        $.session.set('pbid00D', pbid00);
        $.session.set("mzysbh", mzysbh);

        //医生剩余号>0 跳转到日期,增加提示效果
        if (doctroyResidueNum > 0) {
            window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/yyriqi.jsp";
        } else {
            //返回页面
            //window.history.go(-1);
            //window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yytime.jsp";
            $("#tip_div").show();
            $("#error").text("暂无号源");
            $("#tip_s").bind("click dbclick",function () {
                $("#tip_div").hide();
            })

        }
    }

    function dateOrTime(obj) {
        console.log($(obj).val());
        doctor = $(obj).val().split("-")[0];
        console.log(doctor);
        ghzfy0 = $(obj).val().split("-")[1];
        console.log(ghzfy0)
        ysid00 = $(obj).val().split("-")[2];
        console.log(ysid00)
        pbid00 = $(obj).val().split("-")[3];
        console.log(pbid00)
        mzysbh = $(obj).val().split("*")[1];
        console.log(mzysbh)

        //医生剩余号源
        var doctoryMessage = $(obj).val().split("*");
        var docInfo = doctoryMessage[0];
        var strings1 = docInfo.split("-");
        var doctroyResidueNum = strings1[3];

        //将医生编号放入session 中
        $.session.set('doctor', doctor);
        $.session.set('ghzfy0', ghzfy0);
        $.session.set('ysid00', ysid00);
        $.session.set('pbid00D', pbid00);
        $.session.set("mzysbh", mzysbh);

        //医生剩余号>0 跳转到日期,增加提示效果
        if (doctroyResidueNum > 0) {
            window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/yyriqi.jsp";
        } else {
            //返回页面
            window.history.go(-1);
            //window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yytime.jsp";
        }
    }

    stepshow();
</script>
</html>




