<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" name="plugin"
            classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <object width="0" height="0" id="printer"
            classid="clsid:01678147-0761-4E43-AA5C-C96BAEF52461"></object>
    <title>门诊预约</title>
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
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>

<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:365px;">
    <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
         width="90" height="43" style="position:relative;top:180px;left:450px"/>
</div>
<div id="word" style="width:100%;z-index:60;position:absolute;top:270px;">
    <span style="width:100%;font-size:60px;text-align:center;color:red">取号成功,请在下方取走凭条</span>
</div>
<div style="z-index:60;position:absolute;top:1095px;left:380px;">
    <img id="title"
         src="${pageContext.request.contextPath}/images/yyqh.png"/>
</div>
<div id="yyInfo"
     style="z-index:50;position:absolute;top:400px;left:110px;text-align:center;display:block">
    <table style="table-layout:fixed;width:1000px;border:1px solid #000;background-color:#B4EEB4;font-size:50px;cellspacing:2px"
           id="info2">
        <tr style="height:50px;border:1px solid #000;">
            <td style="width:300px;border:1px solid #000;">预约科室</td>
            <td id="yykeshi" style="width:650px;border:1px solid #000;"></td>
        </tr>
        <tr style="height:50px;border:1px solid #000;">
            <td style="width:300px;border:1px solid #000;">预约医生</td>
            <td id="yyyisheng" style="width:650px;border:1px solid #000;"></td>
        </tr>
        <tr style="height:50px;border:1px solid #000;">
            <td style="width:300px;border:1px solid #000;">预约日期</td>
            <td id="yyriqi" style="width:650px;border:1px solid #000;"></td>
        </tr>
        <tr style="height:50px;border:1px solid #000;">
            <td style="width:300px;border:1px solid #000;">预约时间</td>
            <td id="yyshijian" style="width:650px;border:1px solid #000;"></td>
        </tr>
    </table>
</div>
<div id="main" style="position: absolute;top:800px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
</body>
<script type="text/javascript">
    var printDateTime = $.session.get('yysj00');
    var keshi = $.session.get('mzksmc'); //科室
    var riqi = $.session.get('yysj00').split(" ")[0]; //日期
    var shijian = $.session.get('yysj00').split(" ")[1]; //时间
    var doctor = $.session.get('mzysxm'); //医生
    //var log = document.getElementById("AVFOCX");

    //排队序号
    var pdxh00 = $.session.get("pdxh00");
    //个人支付额
    var GRZFE0 = $.session.get("GRZFE0")
    //医保登记号
    var AKC190 = $.session.get("AKC190");
    //挂号流水号
    var ghlsh0 = $.session.get("ghlsh0");
    //等待人数
    var ddrs00 = $.session.get("ddrs00");
    //联系电话
    var lxdh00 = $.session.get("lxdh00");
    //结算收费日
    var JSSFRQ = $.session.get("JSSFRQ");
    //单据流水号
    var djlsh0 = $.session.get("djlsh0");
    //医保账户支付额
    var zhzfe0 = $.session.get("zhzfe0");
    //统筹基金支付金额
    var jjzfe0 = $.session.get("JJZFE0");
    //上下午
    var wbmc00 = $.session.get("wbmc00");
    var hbmc00 = $.session.get("hbmc00");

    /*var ghsj = $.session.get("ghsj");
    if (ghsj == "a") {
        ghsj = "上午";
    } else if (ghsj == "p") {
        ghsj = "下午";
    } else {
        ghsj = ghsj;
    }*/

    //returnTime();
    //初始化倒计时时间：60秒
    var time = 15;

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
        time=15;
    }

    returnTime();

    // function undefiConvertToNull(str) {
    //     var temp;
    //     if (typeof (str) == "undefined") {
    //         temp = " ";
    //     }else{
    //         temp = str;
    //     }
    //     return temp;
    // }

    function yyInfo() {
        $("#yyInfo").show();
        $("#yykeshi").text(keshi);
        $("#yyyisheng").text(doctor);
        $("#yyriqi").text(riqi);
        $("#yyshijian").text(shijian);

        //调用打印机
        $("#jz").show();
        var temp = $.session.get("jzdz00");
        if(temp == "undefined"){
            temp = " ";
        }
        $.session.set("jzdz00",temp);
        if(window.parent.cardtype==0){
            //医保卡打印
            printYb();
        }else{
            print();
        }
        $("#jz").hide();
    }


    function print() {
        var Printer = window.parent.KPrinter; //打印机
        Printer.SetFontModeAndTypeX(0x08, 0x01); //设置字体
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("  挂号凭证");
        Printer.WriteTextLineX("  （当次有效  概不退号）");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("                                    序号：" + pdxh00);
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.SetTextModeX(0); //设置中文模式
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.WriteTextLineX("  姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID 号：" + window.parent.brid00);
        Printer.WriteTextLineX("  号类：" + hbmc00);
        Printer.WriteTextLineX("  科室：" + keshi);
        Printer.WriteTextLineX("  医生：" + doctor);
        Printer.WriteTextLineX("  诊查费：" + GRZFE0 + " 元");
        if (window.parent.cardtype == 1) {
            //扫码支付
            Printer.WriteTextLineX("  扫码支付：" + GRZFE0 + " 元");
        } else if (window.parent.cardtype == 0) {
            //使用社保卡
            Printer.WriteTextLineX("  扫码支付：" + GRZFE0+ "元" +  "  统筹支付：" + jjzfe0 + "元");
        }
        Printer.WriteTextLineX("  就诊时间：" + " " + printDateTime + "     " + wbmc00);
        Printer.WriteTextLineX("  流水号：" + ghlsh0);
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));
        Printer.LFX(2); //多行送纸
        //Printer.SetTextModeX(1); //设置中文模式
        Printer.SetFontModeAndTypeX(0x08, 0x01); //设置字体
        Printer.WriteTextLineX("  就诊位置：" + $.session.get("jzdz00"));
        Printer.WriteTextLineX("  提醒：我院医生均在我院内坐诊");
        Printer.WriteTextLineX("        概不外出 谨防上当受骗!!!");
        Printer.WriteTextLineX("   就诊时间仅供参考");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  挂号诊病当日一次有效 继续就诊应重新挂号");
        Printer.WriteTextLineX("  备注: 如需挂号收据请和工作人员索取");
        Printer.WriteTextLineX("  如需退号或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }

 function printYb() {
        var Printer = window.parent.KPrinter; //打印机
        Printer.SetFontModeAndTypeX(0x08, 0x01); //设置字体
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("  挂号凭证");
        Printer.WriteTextLineX("  （当次有效  概不退号）");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("                                    序号：" + pdxh00);
        Printer.PrintBarCodeX(73, 100, 4, window.parent.brid00);
        Printer.SetTextModeX(0); //设置中文模式
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.WriteTextLineX("  姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID 号：" + window.parent.brid00);
        Printer.WriteTextLineX("  号类：" + hbmc00);
        Printer.WriteTextLineX("  科室：" + keshi);
        Printer.WriteTextLineX("  医生：" + doctor);
        Printer.WriteTextLineX("  诊查费：" + $.session.get("ghfy00") + " 元");
        if (window.parent.cardtype == 1) {
            //扫码支付
            Printer.WriteTextLineX("  扫码支付：" + GRZFE0 + " 元");
        } else if (window.parent.cardtype == 0 && $.session.get("zhzfe0") != "0") {
            //使用社保卡
            Printer.WriteTextLineX("  统筹支付：" + jjzfe0 + "元" + " 账户支付：" + $.session.get("zhzfe0") + "元" + "  扫码支付：" + GRZFE0 + "元");
        } else if (window.parent.cardtype == 0) {
            Printer.WriteTextLineX("  统筹支付：" + jjzfe0 + "元" + "  扫码支付：" + GRZFE0 + "元");
        }
        Printer.WriteTextLineX("  就诊时间：" + " " + printDateTime + "     " + wbmc00);
        Printer.WriteTextLineX("  流水号：" + ghlsh0);
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));
        Printer.LFX(2); //多行送纸
        //Printer.SetTextModeX(1); //设置中文模式
        Printer.SetFontModeAndTypeX(0x08, 0x01); //设置字体
        Printer.WriteTextLineX("  就诊位置：" + $.session.get("jzdz00"));
        Printer.WriteTextLineX("  提醒：我院医生均在我院内坐诊");
        Printer.WriteTextLineX("        概不外出 谨防上当受骗!!!");
        Printer.WriteTextLineX("   就诊时间仅供参考");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  挂号诊病当日一次有效 继续就诊应重新挂号");
        Printer.WriteTextLineX("  备注: 如需挂号收据请和工作人员索取");
        Printer.WriteTextLineX("  如需退号或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
}
    $("#main").bind("click dbclick", function () {
        $.session.clear();
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    yyInfo();
</script>
</html>

