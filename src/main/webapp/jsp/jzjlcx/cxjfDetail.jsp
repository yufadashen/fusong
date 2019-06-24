﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>缴费记录明细</title>
    <object id="AVFOCX" classid="clsid:28DF5A67-DFD2-4309-97E9-0601C4C54411" width="0" height="0">
        <param name="s1" value=""/>
    </object>
    <object width="0" height="0" id="AVFOCXLOG"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script language="javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染-->
    <meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
    <style>
        body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
        }
    </style>
</head>

<body scroll=no>
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:425px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:150px;left:300px"/>
</div>

<%--密码输入框--%>
<div id="password"
     style="z-index:1000;display:block;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:80px;top:480px;display: none">
    <div id="password1" style="text-align:center;position:relative;top:82px">
        <span id="password2" style="font-size:30px;color:#EE7700;"><strong>请输入密码&nbsp</strong></span>
        <input id="password3" type="text" maxlength="11"
               style="width:300px;height:50px;font-size:40px;text-align:center;">
    </div>
</div>

<%--密码键盘--%>
<div id="money"
     style="position: absolute;top:465px;left:830px; display: none;">
    <img src="${pageContext.request.contextPath}/images/kb/1.png"
         res_img="images/kb/1_1.png" width="102" height="65" value="1"
         name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/2.png"
        res_img="images/kb/2_1.png" width="102" height="65" value="2"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/3.png"
        res_img="images/kb/3_1.png" width="102" height="65" value="3"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> </br> <img
        src="${pageContext.request.contextPath}/images/kb/4.png"
        res_img="images/kb/4_1.png" width="102" height="65" value="4"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/5.png"
        res_img="images/kb/5_1.png" width="102" height="65" value="5"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/6.png"
        res_img="images/kb/6_1.png" width="102" height="65" value="6"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> </br> <img
        src="${pageContext.request.contextPath}/images/kb/7.png"
        res_img="images/kb/7_1.png" width="102" height="65" value="7"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/8.png"
        res_img="images/kb/8_1.png" width="102" height="65" value="8"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/9.png"
        res_img="images/kb/9_1.png" width="102" height="65" value="9"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> </br> <img
        src="${pageContext.request.contextPath}/images/kb/10.png"
        res_img="images/kb/10_1.png" width="102" height="65" value="10"
        id="modify" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/0.png"
        res_img="images/kb/0_1.png" width="102" height="65" value="0"
        name="numKey" style="margin-right:15px;margin-bottom:10px"/> <img
        src="${pageContext.request.contextPath}/images/kb/11.png"
        res_img="images/kb/11_1.png" width="102" height="65" value="11"
        id="sure" style="margin-right:15px;margin-bottom:10px"/>
</div>


<%--缴费条目明细--%>
<div id="detail"
     style="width:1060px;position:absolute;top:200px;left:170px;">
    <table id="idData" style="width:800px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
            <td style="width:300px;border:1px solid black;font-size:35px;text-align:center">名称</td>
            <td style="width:150px;border:1px solid black;font-size:35px;text-align:center">单位</td>
            <td style="width:150px;border:1px solid black;font-size:35px;text-align:center">数量</td>
            <td style="width:150px;border:1px solid black;font-size:35px;text-align:center">单价(元)</td>
            <td style="width:150px;border:1px solid black;font-size:35px;text-align:center">金额(元)</td>
        </tr>
        </thead>
        <tbody id="detailinfo"></tbody>
        <tfoot>
        <tr>
            <td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pageup" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.prePage();">上一页
                </button>
            </td>
            <td colspan="2" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.nextPage();">下一页
                </button>
            </td>
        </tr>
        <tr style="width:1050px;height:60px;border:1px solid black">
            <td colspan="6" style="width:320px;border:1px solid black;font-size:35px;text-align:center">
                <button id="close" class="layui-btn layui-btn-sm layui-btn-normal"
                        style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">补打凭条
                </button>
            </td>
        </tr>
        </tfoot>
    </table>
</div>

<div id="main" style="position: absolute;top:870px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/"
         height="" width=""/>
</div>
<div id="next" style="position: absolute;top:860px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png" res_img="${pageContext.request.contextPath}/" height=""
         width=""/>
</div>
<div id="main_box" style="text-align:center;">
    <div id="pay" style="display:block;margin-top:300px;">
        <%--<img src="${pageContext.request.contextPath}/images/queding.png" res_img="${pageContext.request.contextPath}/queding1.png" height="" width=""/>--%>
    </div>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:800px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script language="javascript">
    $("#jz").hide();
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;
    var printData;//打印对象
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
    $("#tip_s").on("click", function () {
        window.history.go(-1);
    });

    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#next").bind("click dbclick", function () {
        window.history.go(-1);

    });

    function stepUp() {
        $("#jz").show();
        var datas = {
            funcid: "M07.02.06.05",
            sflsh0: $.session.get("sflsh0"),
            djlsh0: $.session.get("djlsh0")
        }
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

                //解析json,渲染到Html 上，依次显示单据流水号,姓名，费用，日期
                var Data = eval(json);
                if (Data.retcode == "0") {
                    printData = Data;
                    if ($("#detailinfo").html() == "" && $("#detailinfo").length == 0) {
                        for (var i = 0; i < Data.retbody.length; i++) {
                            $("#detailinfo").append(
                                "<tr style=\"width:1050px;height:50px;border:1px solid black;\">"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmmc00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmdw00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmsl00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmdj00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmje00 + "</td>"
                                // + "<td style=\"width:25%;background-color:#EE7700;border:1px solid black;font-size:25px;text-align:center\" onclick=\'bdpt(" + JSON.stringify(Data.retbody[i]) + ")\'>" + "无" + "</td>"
                               
                                + "</<tr>");
                        }
                        page = new Page(6, "idData", "detailinfo");
                    } else {
                        $("#detailinfo").empty();
                        for (var i = 0; i < Data.retbody.length; i++) {
                            $("#detailinfo").append(
                                "<tr style=\"width:1050px;height:50px;border:1px solid black;\">"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmmc00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmdw00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmsl00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmdj00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmje00 + "</td>"
                                // + "<td style=\"width:25%;background-color:#EE7700;border:1px solid black;font-size:25px;text-align:center\" onclick=\'bdpt(" + JSON.stringify(Data.retbody[i]) + ")\'>" + "无" + "</td>"
                                

                                + "</<tr>");
                        }
                        page = new Page(6, "idData", "detailinfo");
                    }
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    //log.WriteLog("获取结算详情失败");
                }
            },
            error: function (json) {
                $("#jz").hide();

                var Data = eval(json);
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").bind("click dbclick", function () {
                    //查询缴费记录失败，跳转到功能选择页面
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                })
            }
        });
    }

    stepUp();

    $("#close").bind("click dbclick", function () {
        //将密码框展示，并且将付费详情隐藏
        $("#password").show();
        $("#money").show();
        $("#detail").hide();

        //获取密码框输入，如果匹配规则，则调用打印方法，否则后退一步

    })


    //输入金额
    $('img[name="numKey"]').on("click", function () {
        var valStr = $("#password3").val();
        if (valStr == "" || valStr == "0") {
            $("#password3").val($(this).attr("value"));
        } else {
            if ($("#password3").val().length == 11) {
                //todo 阻止界面号码按钮事件
            } else {
                $("#password3").val(valStr + $(this).attr("value"));
            }
        }
    });
    //修改
    $("#modify").on("click", function () {
        var num = $("#password3").val();
        var newstr = num.substring(0, num.length - 1);
        $("#password3").val(newstr);
    });

    //虚拟键盘确认
    $("#sure").bind("click dbclick", function () {
        //前端密码验证，如果密码为8为并且以8开头8结尾，则为通过验证
        var phoneno = $("#password3").val();
        if (phoneno.substr(0, 1) == "8" && phoneno.length == 8) {
            //通过验证
            $("#password3").val("");

            bdpt();
            window.history.go(-1);
        } else {
            //未通过验证，跳转到主页
              $("#password").hide();
            $("#money").hide();
            $("#password3").val("");
            $("#tip_div").show();
            $("#error").text("密码不正确");
        }

    });


    function bdpt() {
        print(printData);
    }

    /*
        门诊缴费凭条补打
     */
    function print(Data) {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x00, 0x01);//设置字体
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("结算凭条补打(负数为已退费)");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73, 100, 4, window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x00, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("bcfyze") + "元");
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
        //Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        //Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.WriteTextLineX("  结算时间：" + $.session.get("jssfrq"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(0); //设置中文模式
        Printer.WriteTextLineX("   项目名称         数量    单价");
        for (i = 0; i < Data.retbody.length; i++) {
            Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) + "   " + editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
        }
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(0); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }


    function editStr(originStr) {
        var newTemp;
        var temp = String(originStr);
        if (temp.length >= 10) {
            //截取前五个字符
            newTemp = temp.substring(0, 9);
        }
        if (temp.length < 10) {
            temp += "                 ";
            newTemp = temp.substring(0, 9);
        }
        return newTemp;
    }

    function editStr1(originStr) {
        var newTemp;
        var temp = String(originStr);
        if (temp.length >= 8) {
            //截取前五个字符
            newTemp = temp.substring(0, 8);
        }
        if (temp.length < 5) {
            temp = temp + "                 ";
            newTemp = temp.substring(0, 8);
        }
        return newTemp;
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
        this.rowCount = 0;//记录数
        this.pageCount = 0;//页数
        this.pageIndex = 0;//页索引
        this.__oTable__ = null;//表格引用
        this.__oTBody__ = null;//要分页内容
        this.__dataRows__ = 0;//记录行引用
        this.__oldTBody__ = null;
        this.__init__(); //初始化;
    };
    /*
    初始化
    */
    Page.prototype.__init__ = function () {
        this.__oTable__ = document.getElementById(this.tableId);//获取table引用
        this.__oTBody__ = this.__oTable__.tBodies[this.tBodyId];//获取tBody引用
        this.__dataRows__ = this.__oTBody__.rows;
        this.rowCount = this.__dataRows__.length;
        try {
            this.absolute = (this.absolute <= 0) || (this.absolute > this.rowCount) ? this.rowCount : this.absolute;
            this.pageCount = parseFloat(this.rowCount % this.absolute == 0
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


</script>
</html>
