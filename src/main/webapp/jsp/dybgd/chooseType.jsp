<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>打印报告单-选择扫描方式(新旧 就诊卡，医保卡，检验单条码)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
    <script src="${pageContext.request.contextPath}/js/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/easing.js"></script>
    <script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
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
<div id="time" style="position:absolute;top:20px;right:40px;font-size:70px;color: #FF0000;">
</div>
<div id="word" style="width:100%;z-index:60;position:absolute;top:200px;left:0px;">
    <span style="width:100%;font-size:40px;text-align:center;color:#FF0000;">请选择方式</span>
</div>
<div style="position: absolute;left:12px;">
    <div id="tip_div"
         style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:465px;">
        <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
            <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
        </div>
        <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
             width="90" height="43" style="position:relative;top:145px;left:280px"/>
    </div>
    <%--新版就诊卡--%>
    <div id="jbjzk" style="position: absolute;top:420px;left:160px;">
        <img src="${pageContext.request.contextPath}/images/cardOld.png"
             res_img="${pageContext.request.contextPath}/images/cardOld.png" height="200" width="200"/>
    </div>
    <%--旧版就诊卡--%>
    <div id="xbjzk" style="position: absolute;top:420px;left:410px;">
        <img src="${pageContext.request.contextPath}/images/cardNew.png"
             res_img="${pageContext.request.contextPath}/images/cardNew.png" height="200" width="200"/>
    </div>
    <%--医保卡--%>
    <div id="ybk" style="position: absolute;top:420px;left:660px;">
        <img src="${pageContext.request.contextPath}/images/yiBaoKaCustomer.png"
             res_img="${pageContext.request.contextPath}/images/yiBaoKaCustomer.png" height="200" width="200"/>
    </div>
    <%--扫描 检验单条码--%>
    <div id="jydtm" style="position: absolute;top:420px;left:910px;">
        <img src="${pageContext.request.contextPath}/images/tiaoxingma.png"
             res_img="${pageContext.request.contextPath}/images/tiaoxingma.png" height="200" width="200"/>
    </div>

</div>
<div id="main" style="position: absolute;top:800px;left:500px;">
    <img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/"
         height="" width=""/>
</div>
<div id="next" style="position: absolute;top:790px;left:630px;">
    <img src="${pageContext.request.contextPath}/images/pre.png" res_img="${pageContext.request.contextPath}/"
         height="" width=""/>
</div>
</body>
<script language="javascript">
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

    /*旧版就诊卡*/
    $("#jbjzk").bind("click dbclick", function () {
        window.parent.cardtype = "02";
 $.session.set("backTo","1");
        window.location.href = "${pageContext.request.contextPath}/jsp/main/readcard.jsp";
    });
    /*新版就诊卡*/
    $("#xbjzk").bind("click dbclick", function () {
        window.parent.cardtype = "02";
 $.session.set("backTo","1");
        window.location.href = "${pageContext.request.contextPath}/jsp/main/readNewVersoinCard.jsp";
    });
    /*医保卡*/
    $("#ybk").bind("click dbclick", function () {
 $.session.set("backTo","1");
        window.location.href = "${pageContext.request.contextPath}/jsp/main/IsEmployeeOrCivilian.jsp";
    });
    /*检验单条码*/
    $("#jydtm").bind("click dbclick",function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/dybgd/scannTm.jsp";
    });

    /*底部按钮点击事件*/
    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#next").bind("click dbclick", function () {
        window.history.go(-1);

    });

</script>
</html>