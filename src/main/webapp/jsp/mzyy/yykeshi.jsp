<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" name="plugin"
            classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <title>门诊预约-选择科室</title>
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
     style="display:none;width:90%;height:100px;position:absolute;top:250px;left:57px;background-color:#f7fcff">
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
     style="display:none;width:90%;height:100px;position:absolute;top:200px;left:57px;background-color:#f7fcff">
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
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:465px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:145px;left:4px"/>
</div>
<div style="z-index:60;position:absolute;top:150px;left:480px;">
    <img id="title"
         src="${pageContext.request.contextPath}/images/ghtitle.png"/>
</div>
<div id="keshi"
     style="z-index:50;position:absolute;top:360px;left:135px;display:block">
    <table id="keshi1" style="table-layout:fixed;cellspacing:2px">
        <thead></thead>
        <tbody id="info1"></tbody>
        <tfoot>
        <tr>
            <td colspan="2"
                style="width:250px;height:80px;font-size:35px;text-align:center;">
                <button id="pageup" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.prePage();">上一页
                </button>
            </td>
            <td colspan="2"
                style="width:250px;height:80px;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.nextPage();">下一页
                </button>
            </td>
        </tr>
        </tfoot>
    </table>
</div>
<div id="pre" style="position: absolute;top:840px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>
<div id="main" style="position: absolute;top:850px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;position:absolute;top:0px;left:0px;z-index:100;">
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
    var ynzhye = window.parent.ynzhye;//院内账户余额
    var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
    var keshi = ""; //科室
    var ksid00;//科室id
    // var tsfei0 = 0;//特殊费用金额
    // var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
    var log = document.getElementById("AVFOCX");
    var fssj00;
    var ksczrq;
    var jsczrq;
    var sjdms01;
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
        if (typeof ($.session) != "undefined") {
            $.session.clear();
        }
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

    $("#pre").bind("click dbclick", function () {
        window.history.back();
    });

    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
    });

    function stepshow() {
        $("#stepByKeshi").show();
        $(function () {
            stepBar.init("stepByKeshi", {
                step: 1,
                change: false,
                animation: false
            });
        });
        getKeshi();
    }

    function getParma() {
        var date = new Date();
        var date1 = new Date(date);
        var date2 = new Date(date);
        date1.setDate(date.getDate() + 1);
        date2.setDate(date.getDate() + 8);
        var startyear = date1.getFullYear();
        var startmonth = date1.getMonth() + 1;
        var startday = date1.getDate();
        var endyear = date2.getFullYear();
        var endmonth = date2.getMonth() + 1;
        var endday = date2.getDate();

        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var seconds = date.getSeconds();
        if (month < 10) {
            month = "0" + month;
        }
        if (startmonth < 10) {
            startmonth = "0" + startmonth;
        }
        if (endmonth < 10) {
            endmonth = "0" + endmonth;
        }
        if (day < 10) {
            day = "0" + day;
        }
        if (startday < 10) {
            startday = "0" + startday;
        }
        if (endday < 10) {
            endday = "0" + endday;
        }
        if (hours < 10) {
            hours = "0" + hours;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        fssj00 = year + "" + month + "" + day + "" + hours + "" + minutes + "" + seconds + ".000";
        if (pbbz00 != "1") {
            ksczrq = startyear + "" + startmonth + "" + startday + "000000.000";
            jsczrq = endyear + "" + endmonth + "" + endday + "235900.000";
        } else {
            ksczrq = $.session.get('riqi') + "000000.000";
            jsczrq = $.session.get('riqi') + "235900.000";
        }

        sjdms01 = year + "" + month + "" + day;
        $.session.set('sjdms01', sjdms01);
        $.session.set('ksczrq', ksczrq);
        $.session.set('jsczrq', jsczrq);
    }

    //获取科室信息
    function getKeshi() {
        window.parent.dateTimeNow = format(new Date());
        var temp = window.parent.dateTimeNow.split(" ")[0] + " 23:59:59";
        window.parent.dateTimeTonight = temp;
        var datas = {
            "funcid": "M07.02.04.03",
            "kscxdm": "",
            "kssj00": window.parent.dateTimeNow,
            "jssj00": window.parent.dateTimeTonight,
            "yywbmc": "",
            "dqcxy0": "1",
            "pageSize": "5",
            "sfxsqb": "1"
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
                        if (i + 3 < length) {
                            $("#info1").append(
                                "<tr style=\"width:1050px;height:80px\">"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i + 1].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i + 1].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i + 2].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i + 2].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:24px;width:250px;height:80px;\" value=\"" + Data.retbody[i + 3].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i + 3].mzksmc + "</button></td>"
                                + "</tr>");
                        } else if (i + 2 < length) {
                            $("#info1").append(
                                "<tr style=\"width:1050px;height:80px\">"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:20px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:20px;width:250px;height:80px;\" value=\"" + Data.retbody[i + 1].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i + 1].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:20px;width:250px;height:80px;\" value=\"" + Data.retbody[i + 2].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i + 2].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"></td>"
                                + "</tr>");
                        } else if (i + 1 < length) {
                            $("#info1").append(
                                "<tr style=\"width:1050px;height:80px\">"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:20px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:20px;width:250px;height:80px;\" value=\"" + Data.retbody[i + 1].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i + 1].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"></td>"
                                + "</tr>");
                        } else if (i < length) {
                            $("#info1").append(
                                "<tr style=\"width:1050px;height:80px\">"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"><button class=\"layui-btn layui-btn-primary\" style=\"font-size:20px;width:250px;height:80px;\" value=\"" + Data.retbody[i].mzksbh + "\" onclick=\"clickKeshi(this)\">" + Data.retbody[i].mzksmc + "</button></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"></td>"
                                + "<td style=\"width:200px;height:80px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\"></td>"
                                + "</tr>");
                        }
                    }
                    page = new Page(6, "keshi1", "info1");
                } else {
                    /*log.WriteLog("卡号为:"+cardNo+"获取科室列表失败");*/
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
        keshi = obj.innerHTML;
        //如果是便民民诊，则跳过专家和普通选择
        if ("便民门诊"==keshi) {
            ksid00 = $(obj).val();
$.session.set('keshi', keshi);
            $.session.set('ksid00', ksid00);
            $.session.set("setParamHbbm00"," ");
            window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yydoctor.jsp"
        }else{
            $.session.set('keshi', keshi);
            ksid00 = $(obj).val();
            $.session.set('ksid00', ksid00);
            window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyDoctorIsExpert.jsp"
        }
    }

    //今天的时间
    function format(Date){
        var Y = Date.getFullYear();
        var M = Date.getMonth() + 1;
        M = M < 10 ? '0' + M : M;// 不够两位补充0
        var D = Date.getDate();
        D = D < 10 ? '0' + D : D;
        var H = Date.getHours();
        H = H < 10 ? '0' + H : H;
        var Mi = Date.getMinutes();
        Mi = Mi < 10 ? '0' + Mi : Mi;
        var S = Date.getSeconds();
        S = S < 10 ? '0' + S : S;
        return Y + '-' + M + '-' + D + ' ' + H + ':' + Mi + ':' + S;

    }

    //7天后的时间
    function format1(Date){
        var Y = Date.getFullYear();
        var M = Date.getMonth() + 1;
        M = M < 10 ? '0' + M : M;// 不够两位补充0
        var D = Date.getDate()+7;
        D = D < 10 ? '0' + D : D;
        var H = Date.getHours();
        H = H < 10 ? '0' + H : H;
        var Mi = Date.getMinutes();
        Mi = Mi < 10 ? '0' + Mi : Mi;
        var S = Date.getSeconds();
        S = S < 10 ? '0' + S : S;
        return Y + '-' + M + '-' + D + ' ' + H + ':' + Mi + ':' + S;
    }

    stepshow();
</script>
</html>



