<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>检验单条码扫描</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script language="javascript" src="DriverJS/json2.js"></script>
    <!-- <script language="javascript" src="DriverJS/ReceiptPrinter.js"></script> -->
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>

    <meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染-->
    <meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
    <style>
        body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url(${pageContext.request.contextPath}/images/smjzk.gif) no-repeat;
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
<div style="text-align:center;position:absolute;top:782px;left:400px;">
    <span style="font-size:40px;color:#EE7700;"><strong>卡号:</strong></span>
    <input id="ewm" style="width:350px;height:40px;font-size:30px;">
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

    $("#ewm").focus();
    $(document).keydown(function (event) {
        if (event.keyCode == 13) {
            window.parent.cardNo = $("#ewm").val();
            window.parent.cardtype = "1";
            if (cardNO.length > 9) {
                getBridInfo();
            }
        }
        if (event.keyCode == 8) {
            //alert(8);
            $("#idName").one("click", function () {
                //todo
            });
        }
    });

    /*扫描条形码*/
    function readCard() {
        cardNO = $("#ewm").val();
        if (cardNO.length == 10) {
            //扫描到检验条码，调用lis 程序
            printLis(cardNO);
        } else {
            setTimeout("readCard();", 1000);
        }
    }

    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#next").bind("click dbclick", function () {
        window.history.go(-1);
    });

    /*调用Lis 程序*/
    function printLis(num) {
        var lis = window.parent.ListEXE;
        lis.CallLis("D:\\autolis\\print.exe", num);
    }
    readCard();
</script>
</html>
