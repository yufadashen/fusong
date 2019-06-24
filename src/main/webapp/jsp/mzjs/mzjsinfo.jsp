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
    <title>门诊结算信息展示</title>
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
<div id="word" style="width:100%;z-index:60;position:absolute;top:270px;">
    <span style="width:100%;font-size:60px;text-align:center;color:red">请取走凭条</span>
</div>
<!-- <div id="word"
    style="z-index:60;display:block;position:absolute;top:1255px;left:460px;">
    <span id="tip2" style="font-size:40px">结算明细</span>
</div> -->
<%--<div id="cardinfo" style="position:absolute;top:200px;left:240px">
    <span style="font-size:40px">姓名:</span><span id="xming0" style="font-size:40px;color:#0000FF"></span>
    &lt;%&ndash;<span style="font-size:40px">卡内余额:</span><span id="yjjye0" style="font-size:40px;color:#0000FF"></span>&ndash;%&gt;
    <span style="font-size:40px">I D:</span><span id="carNo" style="font-size:40px;color:#0000FF"></span>
</div>--%>
<%--<div id="jsinfo"
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
        &lt;%&ndash;<tr>&ndash;%&gt;
        &lt;%&ndash;<td colspan="3" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">费用总额</td>&ndash;%&gt;
        &lt;%&ndash;<td id="mzfyze" style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;"></td>&ndash;%&gt;
        &lt;%&ndash;</tr>&ndash;%&gt;
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
</div>--%>
<div id="detail"
     style="width:1060px;position:absolute;top:360px;left:220px;display:none">
    <table id="idData" style="width:800px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr style="width:1050px;height:60px;background-color:#E0FFFF;border:1px solid black;">
            <td style="width:200px;border:1px solid black;font-size:35px;text-align:center">姓名</td>
            <td style="width:200px;border:1px solid black;font-size:35px;text-align:center">ID号</td>
            <td style="width:200px;border:1px solid black;font-size:35px;text-align:center">本次费用总额</td>
        </tr>
        </thead>
        <tbody id="detailinfo"></tbody>
        <tfoot>
        <%--<tr>
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
        </tr>--%>
        <%--<tr style="width:1050px;height:60px;border:1px solid black">
            <td colspan="6" style="width:320px;border:1px solid black;font-size:35px;text-align:center">
                <button id="close" class="layui-btn layui-btn-sm layui-btn-normal"
                        style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">返回
                </button>
            </td>
            <!-- <td style="width:320px;border:1px solid black;font-size:35px;text-align:center"><button  id="pagedown" class="layui-btn layui-btn-sm layui-btn-normal" style="width:190px;height:50px;font-size:35px;background-color:#4d9cfa">结算</button></td> -->
        </tr>--%>
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
    //var time = window.parent.reTime;
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
    var bcfyze;

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
        time = 15;
    }

    returnTime();

    $("#jiesuan").hide();

    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });


    function steup() {
        //加载患者打印信息
        $("#jz").hide();
        $("#detail").show();

        var money =  $.session.get("grzfe0");
        var status = $.session.get("mzjssucc");
        if (status=="1") {
            //结算成功
            $("#detailinfo").append(
                "<tr style=\"width:1050px;height:50px;border:1px solid black;\">"
                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + window.parent.xming0 + "</td>"
                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + window.parent.brid00 + "</td>"
                + "<td style=\"width:25%;border:1px solid black;font-size:25px;text-align:center\">" + money + "元" + "</td>"
                + "</<tr>");
            var detailStr = $.session.get("detailStr");
            var Data2 = JSON.parse(detailStr);
            if(window.parent.cardtype==0){
            	printYB(Data2);
            }else{
            	print(Data2);
            }
        }else{
            //结算失败
            $("#tip_div").show();
            $("#error").text("缴费失败,请取凭条");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
                if (typeof($.session) != "undefined"){
                    $.session.clear();
                }
                //window.history.go(0);
                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
            });

            var detailStr = $.session.get("detailStr");
            var Data2 = JSON.parse(detailStr);
            if(window.parent.cardtype==0){
            	print2YB(Data2);
            }else{
            	print2(Data2);
            }
        }

    }

    //获得年月日，时分
    function getNowHourMinuteSeconds(Date) {
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
        return Y + "-" + M+"-" + D +" "+ H + ':' + Mi;
    }

    //缴费时间：年月日时分
    var nowHourMinuteSeconds = getNowHourMinuteSeconds(new Date());

    function print(Data) {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("门诊结算成功");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.SetTextModeX(0); //设置中文模式
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.WriteTextLineX("  结算时间：" + nowHourMinuteSeconds);
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        //Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("   项目名称         数量    单价");
        for (i = 0; i < Data.retbody.length; i++) {
            if (i==0){
                Printer.WriteTextLineX("                                   "+Data.retbody[i].exec_name);
                Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) +"   "+ editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
            }else{
                if (Data.retbody[i].exec_name!=Data.retbody[i-1].exec_name){
                    Printer.WriteTextLineX("                                   "+Data.retbody[i].exec_name);
                    Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) +"   "+ editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
                } else{
                    Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) +"   "+ editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
                }
            }
        }
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }
    
    
    function printYB(Data) {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("门诊结算成功");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.SetTextModeX(0); //设置中文模式
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("bcfyze") + "元");
        Printer.WriteTextLineX("  统筹支付：" + $.session.get("jjzfe0") + "元");
        Printer.WriteTextLineX("  账户支付：" + $.session.get("zhzfe0") + "元");
        Printer.WriteTextLineX("  扫码支付：" + $.session.get("grzfe0") + "元");
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.WriteTextLineX("  结算时间：" + nowHourMinuteSeconds);
        Printer.SetFontModeAndTypeX(0x08, 0x00);
       //Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("   项目名称         数量    单价");
        for (i = 0; i < Data.retbody.length; i++) {
            if (i==0){
                Printer.WriteTextLineX("                                   "+Data.retbody[i].exec_name);
                Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) +"   "+ editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
            }else{
                if (Data.retbody[i].exec_name!=Data.retbody[i-1].exec_name){
                    Printer.WriteTextLineX("                                   "+Data.retbody[i].exec_name);
                    Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) +"   "+ editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
                } else{
                    Printer.WriteTextLineX("   " + editStr(Data.retbody[i].xmmc00) +"   "+ editStr1(Data.retbody[i].xmsl00) + " " + Data.retbody[i].xmdj00 + "元");
                }
            }
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
        var newTemp;
        var temp = String(originStr);
        if (temp.length >= 10) {
            //截取前五个字符
            newTemp = temp.substring(0,9);
        }
        if (temp.length < 10) {
            temp += "                 ";
            newTemp = temp.substring(0,9);
        }
        return newTemp;
    }
    function editStr1(originStr) {
        var newTemp;
        var temp = String(originStr);
        if (temp.length >= 8) {
            //截取前五个字符
            newTemp = temp.substring(0,8);
        }
        if (temp.length < 5) {
            temp = temp + "                 ";
            newTemp = temp.substring(0,8);
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
        Printer.WriteTextLineX("门诊结算失败");
        Printer.LFX(2); //多行送纸
        Printer.SetFontModeAndTypeX(0x00, 0x01);//设置字体
        Printer.SetTextModeX(0); //设置中文模式
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  就诊卡号：" + window.parent.brid00);
        Printer.SetFontModeAndTypeX(0x00, 0x00);
        //Printer.SetTextModeX(1); //设置中文模式
        var detailStr = $.session.get("detailStr");
        var Data = JSON.parse(detailStr)
        Printer.WriteTextLineX("  项目名称  项目数量  项目单价");
        for (i = 0; i < Data.retbody.length; i++) {//xmspm0
            Printer.WriteTextLineX("  "+editStr(Data.retbody[i].xmmc00) + editStr(Data.retbody[i].xmsl00) + Data.retbody[i].xmdj00 + "元");
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
    
    function print2YB() {
        $("#jz").show();
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("门诊结算失败");
        Printer.LFX(2); //多行送纸
        Printer.SetFontModeAndTypeX(0x00, 0x01);//设置字体
        Printer.SetTextModeX(0); //设置中文模式
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  就诊卡号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("bcfyze") + "元");
        Printer.WriteTextLineX("  统筹支付：" + $.session.get("jjzfe0") + "元");
        Printer.WriteTextLineX("  账户支付：" + $.session.get("zhzfe0") + "元");
        Printer.WriteTextLineX("  扫码支付：" + $.session.get("grzfe0") + "元");
        Printer.SetFontModeAndTypeX(0x00, 0x00);
        //Printer.SetTextModeX(1); //设置中文模式
        var detailStr = $.session.get("detailStr");
        var Data = JSON.parse(detailStr)
        Printer.WriteTextLineX("  项目名称  项目数量  项目单价");
        for (i = 0; i < Data.retbody.length; i++) {//xmspm0
            Printer.WriteTextLineX("  "+editStr(Data.retbody[i].xmmc00) + editStr(Data.retbody[i].xmsl00) + Data.retbody[i].xmdj00 + "元");
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
