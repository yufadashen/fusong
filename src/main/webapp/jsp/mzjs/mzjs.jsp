<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" name="plugin"
            classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
    <object width="0" height="0" id="printer"
            classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"></object>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <title>门诊结算</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
    <script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
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
<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:465px;">
    <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
    </div>
    <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
         width="90" height="43" style="position:relative;top:125px;left:4px"/>
</div>
<div id="title"
     style="z-index:60;display:block;position:absolute;top:1095px;left:380px;">
    <img id="tip1"
         src="${pageContext.request.contextPath}/images/jstitle.png"/>
</div>
<!-- <div id="word"
    style="z-index:60;display:block;position:absolute;top:1255px;left:460px;">
    <span id="tip2" style="font-size:40px">结算明细</span>
</div> -->
<div id="cardinfo" style="position:absolute;top:200px;left:240px">
    <span style="font-size:40px">姓名:</span><span id="xming0" style="font-size:40px;color:#0000FF"></span>
    <%--<span style="font-size:40px">卡内余额:</span><span id="yjjye0" style="font-size:40px;color:#0000FF"></span>--%>
    <span style="font-size:40px">I D:</span><span id="carNo" style="font-size:40px;color:#0000FF"></span>
</div>
<div id="jsinfo"
     style="width:1060px;position:absolute;top:280px;left:210px;display:block">
    <table id="jiesuaninfo" style="width:800px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px">
            <td style="width:160px;height:60px;border:	1px solid black;font-size:25px;text-align:center">就诊医生</td>
            <td style="width:240px;height:60px;border:1px solid black;font-size:25px;text-align:center">科室</td>
            <td style="width:200px;height:60px;border:1px solid black;font-size:25px;text-align:center">就诊日期</td>
            <td style="width:200px;height:60px;border:1px solid black;font-size:25px;text-align:center">结算</td>
        </tr>
        </thead>
        <tbody id="info"></tbody>
        <tfoot>
        <%--<tr>--%>
        <%--<td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">费用总额</td>--%>
        <%--<td id="mzfyze" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;"></td>--%>
        <%--</tr>--%>
        <tr>
            <td colspan="2" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
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
        </tfoot>
    </table>
</div>
<div id="detail"
     style="width:1060px;position:absolute;top:310px;left:220px;display:none">
    <table id="idData" style="width:800px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
            <td style="width:300px;border:1px solid black;font-size:35px;text-align:center">名称</td>
            <td style="width:100px;border:1px solid black;font-size:35px;text-align:center">单位</td>
            <td style="width:100px;border:1px solid black;font-size:35px;text-align:center">数量</td>
            <td style="width:100px;border:1px solid black;font-size:35px;text-align:center">单价(元)</td>
            <td style="width:100px;border:1px solid black;font-size:35px;text-align:center">金额(元)</td>
            <td style="width:100px;border:1px solid black;font-size:35px;text-align:center">备注</td>
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
            <td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius" onclick="page.nextPage();">下一页
                </button>
            </td>
        </tr>
        <tr style="width:1050px;height:60px;border:1px solid black">
            <td colspan="6" style="width:320px;border:1px solid black;font-size:35px;text-align:center">
                <button id="close" class="layui-btn layui-btn-sm layui-btn-normal"
                        style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">返回
                </button>
            </td>
            <!-- <td style="width:320px;border:1px solid black;font-size:35px;text-align:center"><button  id="pagedown" class="layui-btn layui-btn-sm layui-btn-normal" style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">结算</button></td> -->
        </tr>
        </tfoot>
    </table>
</div>
<div id="main" style="position: absolute;top:800px;left:425px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/" height="" width=""/>
</div>
<div id="jiesuan" style="position: absolute;top:800px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/jiesuan.png"
         res_img="${pageContext.request.contextPath}/" height="" width=""/>
</div>
<%--&lt;%&ndash;进度条logo--%>
<%--<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">--%>
<%--<img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"--%>
<%--style="position: absolute;top:320px;left:490px;"/>--%>
<%--<br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>--%>
<%--</div>&ndash;%&gt;--%>
<%--<div id="pre" style="position: absolute;top:790px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script type="text/javascript">
    var xming0 = window.parent.xming0;//姓名
    var cardNo = window.parent.cardNo;//卡号
    var brid00 = window.parent.brid00;//卡号
    var yjjye0 = window.parent.yjjye0;//卡内余额
    var mzfyze = ""; //门诊费用总额,本次费用总额
    var money = 0;//充值金额默认为0
    var sqysxm = ""; //申请医生姓名
    var sqxmmc = ""; //项目
    var sfje00 = ""; //单项收费金额
    var Pad = window.parent.Pad;
    var bStop = true;
    var pinData;
    var log = document.getElementById("AVFOCX");
    var jzid;//就诊ID
    var sqdbh;//申请单编号
    var fyjsxx = "";
    var pin000 = window.parent.pin000;//密码
    var jstype = window.parent.jstype; //1是直接结算   2是挂号结算检查费   3是取号时结算特殊费用
    var czsucc = window.parent.czsucc;//充值成功 1为成功
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;
    //var Data;     //用以打印清单时使用
    var sfkjs = 1; //是否有未结算费用  1：有  0：没有

    var tfje;    //退费金额
    var tkddls;  //退款订单流水号
    var tkqqls;	 //退款请求流水号
    var tsxx;    //提示信息
    var tsxx2 = ""; //提示信息2

    var djlsh0;  //单据流水号
    var ghlsh0; //挂号流水号
    var mzlsh0;  //门诊流水号
    var grzfe0;   //个人支付额
    var sflsh0;  //收费记录流水号
    var djlsh0;   //'单据流水号
    var bcfyze;
    var akc190;//医保登记好，在预结算后解析可以取得值


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

    $("#jiesuan").hide();

    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

    //undefined转换成“”
    function ex(data) {
        var newdate = data;
        if (newdate == "undefined" || newdate == undefined) {
            newdate = "";
        }
        return newdate;
    }

    function steup() {
        $.session.set("yylsh0", "");

        if (window.parent.czsucc == 1) {
            //调用正式结算
            if (window.parent.cardtype == 0) {
                ybZsjs();
            } else {
                zsjs();
            }
            //window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
        } else {
            getJSInfo();
        }
    }

    //查询门诊待缴费信息记录
    function getJSInfo() {
        var datas = {
            "funcid": "M07.02.05.01",
            "cxfs00": window.parent.cardtype,
            "cxdm00": window.parent.cardNo,
            "brid00": window.parent.brid00,
            "ksrq00": "",
            "jzrq00": ""
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
                var Data = eval(json);
                $("#xming0").text(xming0);
                $("#carNo").text(brid00);
                if (Data.retcode == "0") {
                    //费用总额需要所有条加一起

                    mzfyze = Data.retbody[0].bcfyze; //门诊费用总额
                    $("#mzfyze").text(mzfyze);
                    window.parent.mzfyze = mzfyze;
                    //jzid=Data.retbody[0].jzid00;   //就诊ID?
                    //sqysxm=Data.retbody[0].sqysxm; //申请医生姓名
                    //sfje00=Data.retbody[0].sfje00; //单项收费金额
                    //sqysxm=Data.retbody[0].sqxmmc; //项目名称
                    //sqdbh=Data.retbody[0].sqdbh0;  //申请单编号
                    //fyjsxx="#"+sqdbh+"@"+jzid;
                    //把信息添加到表格中
                    if (Data.retbody.length != "0") {

                        for (var i = 0; i < Data.retbody.length; i++) {
                            fyjsxx += "#" + Data.retbody[i].sqdbh0 + "@" + Data.retbody[i].jzid00
                        }
                        ;
                        if (czsucc == 1) {
                            //充值状态在父页面置为0
                            if (mzfyze == window.parent.money) {
                                mzjiesuan();
                            } else {
                                tfje = window.parent.money;
                                sbtf();
                            }
                        } else {
                            for (var i = 0; i < Data.retbody.length; i++) {
                                var jzrq = Data.retbody[i].mzjzrq.split("T")[0];
                                $("#info").append(
                                    "<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
                                    + "<td style=\"width:160px;border:1px solid black;font-size:25px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align:center\">" + Data.retbody[i].mzysxm + "</td>"
                                    + "<td style=\"width:240px;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].mzksmc + "</td>"
                                    + "<td style=\"width:200px;border:1px solid black;font-size:25px;text-align:center\">" + jzrq + "</td>"
                                    // +"<td style=\"width:200px;border:1px solid black;font-size:25px;text-align:center\"><button class=\"layui-btn layui-btn-sm layui-btn-normal\" style=\"width:100px;height:50px;background-color:#4d9cfa\" value=\""+Data.retbody[i].jzid00+"-"+Data.retbody[i].sqdbh0+"\" onclick=\"detail(this)\">明细</button></td>"
                                    + "<td style=\"width:200px;border:1px solid black;font-size: 25px;5px;text-align:center\"><button class=\"layui-btn layui-btn-sm layui-btn-normal\" style=\"width:100px;height:50px;font-size: 25px;background-color:#4d9cfa\" value=\"" + Data.retbody[i].ghlsh0 + "-" + Data.retbody[i].djlsh0 + "-" + Data.retbody[i].times0 + "-" + Data.retbody[i].mzksmc + "-" + Data.retbody[i].mzysxm + "-" + Data.retbody[i].mzksbh + "-" + Data.retbody[i].mzysbh + "\" onclick=\"detail(this)\">结算</button></td>"
                                    + "</tr>");
                            }
                            page = new Page(4, "jiesuaninfo", "info");
                        }
                        //log.WriteLog("获取结算信息成功");
                    } else {
                        sfkjs = 0;
                        $("#tip_div").show();
                        $("#error").text("您无需要结算的费用");

                    }
                } else {
                    sfkjs = 0;
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    //log.WriteLog("获取结算信息失败");
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
            }
        });
    }

    //点击详情
    function detail(obj) {
        $("#jsinfo").hide();
        $("#detail").show();
        //挂号流水号
        ghlsh0 = $(obj).val().split("-")[0];
        djlsh0 = $(obj).val().split("-")[1];
        var times0 = $(obj).val().split("-")[2];
        var mzksmc = $(obj).val().split("-")[3];
        var mzysxm = $(obj).val().split("-")[4];
        var mzksbh = $(obj).val().split("-")[5];
        var mzysbh = $(obj).val().split("-")[6];
        $.session.set("ghlsh0", ghlsh0);
        $.session.set("djlsh0", djlsh0);
        $.session.set("times0", times0);
        $.session.set("mzksmc", mzksmc);
        $.session.set("mzysxm", mzysxm);
        $.session.set("mzksbh", mzksbh);
        $.session.set("mzysbh", mzysbh);
        getPayDetail();
    }

    //查询门诊待缴费信息明细
    function getPayDetail() {
        var datas = {
            "funcid": "M07.02.05.02",
            "cxfs00": window.parent.cardtype,
            "cxdm00": window.parent.cardNo,
            "djlsh0": "",
            "ghlsh0": ghlsh0,
            "brid00": window.parent.brid00,
            "times0": $.session.get("times0"),
            "yllb00": "11"
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
                $("#jiesuan").show();
                var Data = eval(json);

                if (Data.retcode == "0") {


                    if (Data.retbody.length > 50 && window.parent.cardtype == 0) {//医保限制50条，自费不限制
                        $("#tip_div").show();
                        $("#error").text("社保局规定报销费用明细超过50条，请窗口办理，谢谢！");
                        $("#tip_s").off().on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                        return;
                    }


                    var detailStr = JSON.stringify(Data);
                    //console.log(detailStr);
                    $.session.set("detailStr", detailStr);
                    //var temp = $.session.get("detailStr");
                    //var Data1 = JSON.parse(temp)
                    //console.log(Data1);

                    sflsh0 = Data.retbody[0].sflsh0;//收费记录流水号
                    $.session.set("sflsh0", sflsh0);
                    djlsh0 = Data.retbody[0].djlsh0;//单据流水号
                    $.session.set("djlsh0", djlsh0);
                    var jszje = 0;  //结算总金额
                    for (var i = 0; i < Data.retbody.length; i++) {
                        jszje += parseFloat(Data.retbody[i].xmje00);
                        jszje = Math.round(jszje * 100) / 100;
                    }
                    $("#carNo").text(brid00 + "          费用总额：" + jszje);
                    //把信息添加到表格中
                    if ($("#detailinfo").html() == "" && $("#detailinfo").length == 0) {
                        for (var i = 0; i < Data.retbody.length; i++) {//
                            $("#detailinfo").append(
                                "<tr style=\"width:1050px;height:50px;border:1px solid black;\">"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmmc00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmdw00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmsl00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmdj00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + Data.retbody[i].xmje00 + "</td>"
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + "无" + "</td>"
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
                                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + "无" + "</td>"
                                + "</<tr>");
                        }
                        page = new Page(4, "idData", "detailinfo");
                    }
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    //log.WriteLog("获取结算详情失败");
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
            }
        });
    }

    //关闭详细弹窗
    $("#close").bind("click dbclick", function () {
        $("#detail").hide();
        $("#jsinfo").show();
    });
    //点击结算
    $("#jiesuan").one("click", function () {

        //结算页面，使得结算按钮只能点击一遍
        //$("#jiesuan").off("click dbclick");

        //先调用预结算，再调用正式结算
        if (window.parent.cardtype == 0) {
            $("#jz").show();
            ybYjs();
        } else {
            yjs();
        }
        /*if(sfkjs==0){
               $("#tip_div").show();
               $("#error").text("无待缴费费用!");
               $("#tip_s").on("click", function() {
                   window.location.href="


        ${pageContext.request.contextPath}/jsp/main/main.jsp";
            });
        }else{
            window.parent.money=mzfyze;
            window.parent.cztype="2";
            window.location.href="


        ${pageContext.request.contextPath}/jsp/pay/payway.jsp";
        }*/
        //yjs();
    });

    //门诊预结算（医保卡）
    function ybYjs() {
        var datas = {
            funcid: "M07.02.19.01",
            dllmethod: "MzYuJieSuan",
            xming0: window.parent.xming0,
            cxdm00: window.parent.cardNo,
            cxfs00: window.parent.cardtype,
            brid00: window.parent.brid00,
            xzbs00: $.session.get("xzbs00"),
            yllb00: "11",
            akc190: "",
            djlsh0: djlsh0,
            ghlsh0: ex(ghlsh0),
            mzksmc: $.session.get("mzksmc"),
            mzysxm: $.session.get("mzysxm"),
            mzksbh: $.session.get("mzksbh"),
            mzysbh: $.session.get("mzysbh"),
            times0: $.session.get("times0")
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
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0") {
                    ybxml = convertFromXml(Data.retbody[0].ybreqx);
	            $.session.set("ybinput",ybxml);
                    var readCardResult = window.parent.yiBao.MzYuJieSuan(ybxml, 40000);
					
                    if (readCardResult.substring(0, 1) == '0') {
                        var s = readCardResult.substring(readCardResult.indexOf('<'), readCardResult.indexOf('</result></root>') + 16)
                        analyzeYbXml(s)
                    } else {
			var dataOtherAnalyze = readCardResult.substring(readCardResult.indexOf('ERROR="')+7,readCardResult.indexOf('|'));
                        $("#tip_div").show();
			$("#error").text(dataOtherAnalyze);
                        //$("#error").text("预结算异常，请重试");
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                    }

                } else if (Data.retcode == "-1") {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function () {
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function (json) {
                //如果解析失败，返回功能选择页面
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    function convertFromXml(str) {
        var s = "";
        if (str.length == 0) return "";
        s = str.replace(/&amp;/g, "&");
        s = s.replace(/&lt;/g, "<");
        s = s.replace(/&gt;/g, ">");
        s = s.replace(/&nbsp;/g, " ");
        s = s.replace(/&#39;/g, "\'");
        s = s.replace(/&quot;/g, "\"");
        return s;
    }

    //解析医保动态库预结算返回的报文
    function analyzeYbXml(ybxml) {
        var datas = {
            funcid: "M07.02.19.02",
            dllmethod: "MzYuJieSuan",
            ybgetx: ybxml,
 	    ybinput:$.session.get("ybinput")
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
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0") {
                    grzfe0 = Data.retbody[0].grzfe0;//个人支付额
                    $.session.set("grzfe0", grzfe0);
                    var bcfyze = Data.retbody[0].bcfyze;//本次费用总额
                    $.session.set("bcfyze", bcfyze);
                    var zhzfe0 = Data.retbody[0].zhzfe0;//医保账户支付额
                    $.session.set("zhzfe0", zhzfe0);
                    var jjzfe0 = Data.retbody[0].jjzfe0;//统筹基金支付额
                    $.session.set("jjzfe0", jjzfe0);
                    djlsh0 = Data.retbody[0].djlsh0;//单据流水号
                    $.session.set("djlsh0", djlsh0);
                    window.parent.money = grzfe0;
                    //akc190 = Data.retbody[0].AKC190;
                    $.session.set("akc190", Data.retbody[0].AKC190);

                    $("#tip_div").show();
                    $("#error").text("基金支付:" + $.session.get("jjzfe0") + "元       账户支付:" + $.session.get("zhzfe0") + "元       个人支付：" + window.parent.money + "元");
                    $("#tip_s").off().on("click", function () {
                        $("#tip_div").hide();
                        if (grzfe0 > 0) {
                            window.parent.cztype = 4;
                            $.session.set("sendInfoToPlantForm","1");
                            window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                        } else {
                            $.session.set("ptqqls", "00000000000");
                            ybZsjs();  //测试逻辑
                        }
                    });
                    /*
                    if(grzfe0>0){
                        window.parent.cztype = 4;
                        window.location.href = "
                    ${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                    }else{
						$.session.set("ptqqls","00000000000");
                        ybZsjs();  //测试逻辑
                    }*/
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function (json) {
                //如果解析失败，返回功能选择页面
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    //门诊正式结算（医保卡）
    function ybZsjs() {
        $("#jz").show();
        var datas = {
            funcid: "M07.02.19.01",
            dllmethod: "MzJieSuan",
            xming0: window.parent.xming0,
            cxdm00: window.parent.cardNo,
            cxfs00: window.parent.cardtype,
            brid00: window.parent.brid00,
            xzbs00: $.session.get("xzbs00"),
            yllb00: "11",
            akc190: $.session.get("akc190"),
            grzfe0: $.session.get("grzfe0"),
            jyje00: window.parent.money,
            ptqqls: $.session.get("ptqqls"),
            ptddls: $.session.get("ptddls"),
            jyzflx: "ONE_QR",
            sflsh0: ex($.session.get("sflsh0")),
            djlsh0: $.session.get("djlsh0"),
            mzlsh0: "",
            ghlsh0: ex($.session.get("ghlsh0")),
            times0: $.session.get("times0")
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
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0") {

                    ybxml = convertFromXml(Data.retbody[0].ybreqx);
		    $.session.set("ybinput",ybxml);
                    var readCardResult = window.parent.yiBao.MzJieSuan(ybxml, 60000);
                    if (readCardResult.substring(0, 1) == '0') {
                        var s = readCardResult.substring(readCardResult.indexOf('<'), readCardResult.indexOf('</result></root>') + 16)
                        analyzeYbXmlZSJS(s)
                    } else if (readCardResult.substring(0, 2) == '-4') {
			printJSSB();
                        $("#tip_div").show();
                        $("#error").text("网络异常!请到服务窗口处理！");
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                    } else if(readCardResult.substring(0, 2) == '-1'){
                        if ($.session.get("ptqqls") != "00000000000") {
                            sbtf();
                        }
                        $("#tip_div").show();
                        $("#error").text(readCardResult);
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                    }else{
			printJSSB();
		    	$("#tip_div").show();
                        $("#error").text("医保正式结算异常!请到服务窗口处理！");
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
		    }
                } else if (Data.retcode == "-1") {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function () {
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function (json) {
                //如果解析失败，返回功能选择页面
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    //解析医保动态库正式结算返回的报文
    function analyzeYbXmlZSJS(ybxml) {
        var datas = {
            funcid: "M07.02.19.02",
            dllmethod: "MzJieSuan",
            ybgetx: ybxml,
            ybinput:$.session.get("ybinput")
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
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0") {
                    $("#jz").hide();
                    // $("#tip_div").show();
                    // $("#error").text("缴费成功，请取走凭条");

                    djlsh0 = Data.retbody[0].djlsh0;
                    $.session.set("djlsh0", djlsh0);
                    grzfe0 = Data.retbody[0].grzfe0;
                    $.session.set("grzfe0", grzfe0);

                    var ricpsn = Data.retbody[0].ricpsn;
                    $.session.set("ricpsn", ricpsn);

                    var detailStr = $.session.get("detailStr");
                    var Data2 = JSON.parse(detailStr);
                    //跳转到门诊结算info 页面，展示一下同时打印
                    $.session.set("mzjssucc", "1");
                    window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjsinfo.jsp";

                } else {
                    $("#jz").hide();
                    $.session.set("mzjssucc", "0");
                    window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjsinfo.jsp";
                }
            },
            error: function (json) {
                //如果解析失败，返回功能选择页面
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }


    //医保动态库正式结算失败自动退费
    function sbtf() {
        var datas = {
            funcid: "M07.02.03.33",
            cxdm00: window.parent.cardNo,
            cxfs00: window.parent.cardtype,
            ptqqls: $.session.get("ptqqls"),
            ptddls: $.session.get("ptddls"),
            jylsh0: $.session.get("jylsh0"),
            tkje00: $.session.get("grzfe0"),
            brid00: window.parent.brid00,
            czmzzy: "01"
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
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0") {
                    printTF();
                } else {
                    printTFSB();
                }
            },
            error: function (json) {
                //如果解析失败，返回功能选择页面
                printTFSB();
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }


    function printTF() {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("结算退费成功");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73, 100, 4, window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  平台订单流水：" + $.session.get("ptddls"));
        Printer.WriteTextLineX("  交易流水：" + $.session.get("jylsh0"));
        //Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }

    function printTFSB() {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("结算退费失败");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73, 100, 4, window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  平台订单流水：" + $.session.get("ptddls"));
        Printer.WriteTextLineX("  交易流水：" + $.session.get("jylsh0"));
        Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }
	
    function printJSSB(){
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("医保缴费正式结算失败");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73, 100, 4, window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  平台订单流水：" + $.session.get("ptddls"));
        Printer.WriteTextLineX("  交易流水：" + $.session.get("jylsh0"));
        Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }
    /*
    预结算
     */
    function yjs() {
        var datas = {
            funcid: "M07.02.05.04",
            brid00: window.parent.brid00,
            ghlsh0: ghlsh0,
            djlsh0: djlsh0,
            akc190: "",
            xzbs00: "",
            yllb00: "",
            cxfs00: window.parent.cardtype,
            cxdm00: window.parent.cardNo,
            times0: $.session.get("times0")
        };
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            success: function (json) {
                $("#jz").hide();
                var Data = eval(json);
                if (Data.retcode == "0") {
                    //个人支付额
                    grzfe0 = Data.retbody[0].grzfe0;
                    $.session.set("grzfe0", grzfe0);
                    djlsh0 = Data.retbody[0].djlsh0;
                    $.session.set("djlsh0", djlsh0);
                    window.parent.money = grzfe0;

                    window.parent.cztype = 4;
		    $.session.set("sendInfoToPlantForm","1");
                    window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function (json) {
                $("#jz").hide();
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
            }
        })
    }

    /*
        正式结算
     */
    function zsjs() {
        var datas = {
            funcid: "M07.02.05.05",
            cxfs00: window.parent.cardtype,
            cxdm00: window.parent.cardNo,
            brid00: window.parent.brid00,
            sflsh0: "",
            ghlsh0: $.session.get("ghlsh0"),
            djlsh0: $.session.get("djlsh0"),
            mzlsh0: "",
            ptqqls: $.session.get("ptqqls"),//支付平台请求流水号
            grzfe0: $.session.get("grzfe0"),
            xzbs00: "",
            yllb00: "",
            AKC190: "",
            jyzflx: "ONE_QR",
            ptqqls: $.session.get("ptqqls"),
            ptddls: $.session.get("ptddls"),
            jyje00: $.session.get("grzfe0"),
            jyrq00: "",
            jysj00: "",
            yhkh00: "",
            yhshh0: "",
            yhzdh0: "",
            jyckh0: "",
            yhsqh0: "",
            qsrq00: "",
            yhpch0: "",
            times0: $.session.get("times0")
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
                var Data1 = eval(json);
                if (Data1.retcode == "0") {
                    $("#jz").hide();
                    // $("#tip_div").show();
                    // $("#error").text("缴费成功，请取走凭条");

                    djlsh0 = Data1.retbody[0].djlsh0;
                    $.session.set("djlsh0", djlsh0);
                    grzfe0 = Data1.retbody[0].grzfe0;
                    $.session.set("grzfe0", grzfe0);

                    var ricpsn = Data1.retbody[0].ricpsn;
                    $.session.set("ricpsn", ricpsn);

                    var detailStr = $.session.get("detailStr");
                    var Data2 = JSON.parse(detailStr);
                    //跳转到门诊结算info 页面，展示一下同时打印
                    $.session.set("mzjssucc", "1");
                    window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjsinfo.jsp";

                    // $("#jz").show();
                    // print(Data2);
                    // $("#jz").hide();
                } else {
                    $("#jz").hide();
                    $.session.set("mzjssucc", "0");
                    window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjsinfo.jsp";
                    // $("#tip_div").show();
                    // $("#error").text(Data1.retmsg);
                    // $("#jz").show();
                    // print2();
                    // $("#jz").hide();
                }
            },
            error: function (json) {
                //请求正式结算失败，打印失败凭条
                $("#tip_div").show();
                $("#error").text("结算失败");
            }
        });
    }

    //自费结算
    function mzjiesuan() {
        //log.WriteLog("卡号:"+carNo+"开始自费结算");
        var datas = {
            "funcid": "M07.02.05.03",
            "cxdm00": window.parent.cardNo,
            "cxfs00": window.parent.cardtype,
            "fyjsxx": fyjsxx,
            "brid00": window.parent.brid00,
            "passwd": pin000,
            "pin000": pin000,
            "sfybye": "0",
            "mzfyze": mzfyze,
            "count0": "",
            "xming0": xming0,
            "xbie00": window.parent.xbie00,
            "csrq00": window.parent.csrq00,
            "yjjye0": window.parent.yjjye0,
            "brnl00": window.parent.brnl00,
            "sfykt0": window.parent.sfykt0,
            "ynzhye": window.parent.ynzhye,
            "jzid00": jzid,
            "zffs00": "1",
            "sffs00": window.parent.sffs,
            "ptqqls": window.parent.ptqqls
        };
        $.ajax({
            async: false,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success: function (json) {
                var Data = eval(json);
                Dataa = Data;
                if (Data.retcode == "0") {
                    //log.WriteLog("卡号:"+carNo+"自费结算成功");
                    getNewInfo();
                } else {
                    //log.WriteLog("卡号:"+carNo+"自费结算失败");
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    print2();
                }
            },
            error: function () {
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
            }
        });
    }

    function getNewInfo() {
        var datas = {
            "funcid": "M07.02.01.02",
            "cxfs00": window.parent.cardtype,
            "cxdm00": cardNo,
            "sfybye": "5"
        };
        $.ajax({
            async: false,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success: function (json) {
                Data = eval(json);
                if (Data.retcode == "0") {
                    yjjye0 = Data.retbody[0].yjjye0;
                    window.parent.yjjye0 = yjjye0;
                    $("#yjjye0").text(yjjye0);
                    //log.WriteLog("卡号为:"+cardNo+"获取病人信息成功");
                    $("#tip_div").show();
                    $("#error").text("结算成功，请在下方取走凭条");
                    $("#tip_s").on("click", function () {
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                    print();
                    setTimeout(function () {
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    }, 10000);
                    $("#tip_s").on("click", function () {
                        if (jstype == "1") {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        } else if (jstype == "2") {
                            window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ghsucc.jsp";
                        } else if (jstype == "3") {
                            window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/qhsucc.jsp";
                        }
                    });
                } else {
                    //log.WriteLog("卡号为:"+cardNo+"获取病人信息失败");
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function () {
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
            }
        });
    }


    function print(Data) {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("门诊结算成功");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(65, 100, 3, window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("    项目名称    项目数量  项目单价");
        for (i = 0; i < Data.retbody.length; i++) {
            Printer.WriteTextLineX("    " + editStr(Data.retbody[i].xmspm0) + "   " + editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
        }
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }

    function editStr(originStr) {
        var temp = String(originStr);
        if (temp.length > 5) {
            //截取前五个字符
            var newTemp = temp.substring(0, 5);
        }
        if (temp.length < 5) {
            temp += "                 ";
            var newTemp = temp.substring(0, 5);
        }
        return newTemp;
    }

    function editStr1(originStr) {
        var temp = String(originStr);
        if (temp.length > 8) {
            //截取前五个字符
            var newTemp = temp.substring(0, 8);
        }
        if (temp.length < 5) {
            temp = temp + "                 ";
            var newTemp = temp.substring(0, 8);
        }
        return newTemp;
    }

    function print2() {
        $("#jz").show();
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("门诊结算失败");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(65, 100, 3, window.parent.brid00);
        Printer.SetFontModeAndTypeX(0x20, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  就诊卡号：" + window.parent.brid00);
        Printer.SetFontModeAndTypeX(0x20, 0x00);
        //Printer.SetTextModeX(1); //设置中文模式
        var detailStr = $.session.get("detailStr");
        var Data = JSON.parse(detailStr)
        Printer.WriteTextLineX("  项目名称  项目数量  项目单价");
        for (i = 0; i < Data.retbody.length; i++) {//xmspm0
            Printer.WriteTextLineX("  " + editStr(Data.retbody[i].xmmc00) + editStr(Data.retbody[i].xmsl00) + Data.retbody[i].xmdj00 + "元");
        }
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        Printer.WriteTextLineX("  平台请求流水号：" + $.session.get('ptqqls'));
        Printer.WriteTextLineX("  平台订单流水号：" + $.session.get('ptddls'));
        Printer.WriteTextLineX("  交易流水号：" + $.session.get('jylsh0'));
        Printer.WriteTextLineX("");
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：请持此小票前往四楼人工窗口进行退费。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
        $("#jz").hide();
    }

    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#main").bind("click dbclick", function () {
        $.session.clear();
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
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
    //页面加载执行
    //getJSInfo();
    steup();
    //log.WriteLog("开始获取结算信息");
</script>
</html>
