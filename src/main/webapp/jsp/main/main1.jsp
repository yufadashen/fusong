<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <OBJECT classid=clsid:D21F6E52-42EA-44B5-A3EA-F2D069C2B9E5 width=0 height=0 align="center" id="CHeNanCPUCtrl"
            HSPACE=0 VSPACE=0></OBJECT>
    <title>二级页面-四个功能,当日挂号，门诊预约，预约取号，预约取消</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>

    <style>
        body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
        }
    </style>
</head>
<body scroll="no">
<!-- 显示返回主页面倒计时时间 -->
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
         height="43" style="position:relative;top:160px;left:300px"/>
</div>
<%--当日挂号--%>
<div id="drgh" style="position:absolute;left:170px;top:260px;">
    <img title="当日挂号" src="${pageContext.request.contextPath}/images/Zdrgh.png"
         res_img="${pageContext.request.contextPath}/images/Zdrgh.png" height="" width=""/>
</div>
<%--门诊预约--%>
<div id="mzyy" style="position:absolute;left:750px;top:260px;">
    <img title="门诊预约" src="${pageContext.request.contextPath}/images/Zmzyy.png"
         res_img="${pageContext.request.contextPath}/images/Zmzyy.png" height="" width=""/>
</div>
<%--预约取号--%>
<div id="yyqh" style="position:absolute;left:170px;top:600px;">
    <img title="预约取号" src="${pageContext.request.contextPath}/images/Zyyqh.png"
         res_img="${pageContext.request.contextPath}/images/Zyyqh.png" height="" width=""/>
</div>
<%--预约取消--%>
<div id="yyqx" style="position:absolute;left:750px;top:600px;">
    <img title="预约取消" src="${pageContext.request.contextPath}/images/Zyyqx.png"
         res_img="${pageContext.request.contextPath}/images/Zyyqx.png" height="" width=""/>
</div>

<div id="main" style="position: absolute;top:850px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
<div id="pre" style="position: absolute;top:840px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>
</body>
<script type="text/javascript">
    var shutdown = window.parent.shutdown;
    var KPrinter = window.parent.KPrinter;
    var faka = window.parent.faka;
    var status = "00000000";

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

    //定时关机任务
   /* function shutdownt() {
        var date = new Date();
        var h = parseInt(date.getHours());
        var m = parseInt(date.getMinutes());
        if ((h > 15 && m > 29) || h > 16 || (h < 8 && m < 30)) {
            shutdown.ShutdownFunc();
        } else {
            setTimeout(function () {
                shutdownt();
            }, 60000);
        }
    }*/

    $('img').mouseover(function () {
        imgSrc = $(this).attr("src");
        $(this).attr("src", $(this).attr("res_img"));
    });

    $('img').mouseout(function () {
        $(this).attr("src", imgSrc);
    });
    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
    });
    $(document).keydown(function (event) {
        if (event.keyCode == 8) {
            //alert(8);
            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
        }
        if (event.keyCode == 13) {
            //alert(13);
        }
    })

    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#pre").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp"
    });

    /*当日挂号按钮点击事件*/
    $("#drgh").bind("click dbclick", function () {
         //添加五点以后不能挂当日号码逻辑
        var date = new Date();
        var h = parseInt(date.getHours());
        var week = new Date().getDay();
        if (week == 6 && h >= 11) {
            //周六上午11点之后，不能使用当日挂号功能
            $("#tip_div").show();
            $("#error").text("周六上午11点后不允许挂号");
            $("#tip_s").bind("click dbclick", function () {
                $("#tip_div").hide();
                if (typeof ($.session) != "undefined") {
                    $.session.clear();
                }
                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
            });
        } else if (h >= 17) {
            //如果时间是下午五点，则屏蔽挂号按钮
            $("#tip_div").show();
            $("#error").text("17点之后不允许挂号");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
                if (typeof ($.session) != "undefined") {
                    $.session.clear();
                }
                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
            });
        } else {
            window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yykeshi.jsp";
        }
    });
    /*门诊预约按钮点击事件*/
    $("#mzyy").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/yykeshi.jsp";
    });
    $("#yyqh").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
    });
    $("#yyqx").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqx.jsp";
    });

</script>
</html>

