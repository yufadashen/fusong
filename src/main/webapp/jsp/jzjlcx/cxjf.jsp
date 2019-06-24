<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>缴费记录查询</title>
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

<div id="jsinfo"
     style="width:1060px;position:absolute;top:180px;left:110px;display:block">
    <table id="jiesuaninfo" style="width:800px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px">
            <td style="width:160px;height:60px;border:	1px solid black;font-size:25px;text-align:center">单据流水号</td>
            <td style="width:240px;height:60px;border:1px solid black;font-size:25px;text-align:center">姓名</td>
            <td style="width:200px;height:60px;border:1px solid black;font-size:25px;text-align:center">费用</td>
            <td style="width:300px;height:60px;border:1px solid black;font-size:25px;text-align:center">日期</td>
            <td style="width:100px;height:60px;border:1px solid black;font-size:25px;text-align:center">操作</td>
        </tr>
        </thead>
        <tbody id="info"></tbody>
        <tfoot>
        <tr>
            <td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pageup" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.prePage();">上一页
                </button>
            </td>
            <td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.nextPage();">下一页
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
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#next").bind("click dbclick", function () {
               window.history.go(-1);
    });

    function getDateAfterNumber(AddDayCount) {
        var dd = new Date();
        dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期
        var y = dd.getFullYear();
        var m = (dd.getMonth() + 1) < 10 ? ('0' + (dd.getMonth() + 1)) : (dd.getMonth() + 1);
        var d = dd.getDate() < 10 ? ('0' + dd.getDate()) : dd.getDate();
        return y + "-" + m + "-" + d;
    }


    function stepUp() {
        var kssj = getDateAfterNumber(-30);//开始时间为30天之前
        var jssj = getDateAfterNumber(0);//结束时间为今天
        $("#jz").show();
        var datas = {
            funcid: "M07.02.06.04",
            cxfs00: window.parent.cardtype,
            cxdm00: window.parent.cardNo,
            brid00: window.parent.brid00,
            ksrq00: kssj,
            jzrq00: jssj
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
                //解析json,渲染到Html 上，依次显示单据流水号,姓名，费用，日期
                var Data = eval(json);
                if (Data.retcode=="0"){
                    for (var i = 0; i < Data.retbody.length; i++) {
                        $("#info").append(
                            "<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
                            + "<td style=\"width:160px;border:1px solid black;font-size:25px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\">" + Data.retbody[i].sflsh0 + "</td>"
                            + "<td style=\"width:240px;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xming0 + "</td>"
                            + "<td style=\"width:200px;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].bcfyze + "</td>"
                            + "<td style=\"width:300px;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].jssfrq + "</td>"
                            + "<td style=\"width:100px;border:1px solid black;font-size: 25px;5px;text-align:center\"><button class=\"layui-btn layui-btn-sm layui-btn-normal\" style=\"width:100px;height:50px;font-size: 25px;background-color:#4d9cfa\" value=\"" + "\" onclick=\'detail("+JSON.stringify(Data.retbody[i])+")\'>详情</button></td>"
                            + "</tr>");
                    }
                    page = new Page(8, "jiesuaninfo", "info");
                }else{
                    $("#jz").hide();
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").bind("click dbclick",function () {
                        //查询缴费记录失败，跳转到功能选择页面
                        //window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        window.history.go(-1);
                    })
                }

            },
            error: function (json) {
                $("#jz").hide();
                var Data = eval(json);
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").bind("click dbclick",function () {
                    //查询缴费记录失败，跳转到功能选择页面
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                })
            }
        });

    }

    //查询每一条缴费信息的详情
    function detail(obj) {

        var temp1 = eval(obj);
        //收费流水号
        $.session.set("sflsh0",temp1.sflsh0);
        //单据流水号
        $.session.set("djlsh0",temp1.djlsh0);
        //本次费用总额
        $.session.set("bcfyze",temp1.bcfyze);
        //支付平台请求流水号,暂无
        //$.session.set("ptqqls",temp1.ptqqls);
        //结算收据SN,暂无
        //$.session.set("ricpsn",temp1.ricpsn);
        //交易类别,暂无
        //$.session.set("jyzflx",temp1.jyzflx);
        //结算收费日期
        $.session.set("jssfrq",temp1.jssfrq);
        window.location.href = "${pageContext.request.contextPath}/jsp/jzjlcx/cxjfDetail.jsp";
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


    stepUp();



</script>
</html>
