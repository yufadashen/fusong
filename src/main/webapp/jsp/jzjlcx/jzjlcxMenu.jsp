<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>就诊记录查询菜单</title>
    <object id="AVFOCX" classid="clsid:28DF5A67-DFD2-4309-97E9-0601C4C54411" width="0" height="0">
        <param name="s1" value=""/>
    </object>
    <object width="0" height="0" id="AVFOCXLOG"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script language="javascript" src="DriverJS/json2.js"></script>
    <!-- <script language="javascript" src="DriverJS/ReceiptPrinter.js"></script> -->
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
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url
             ('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:425px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:150px;left:300px"/>
</div>
<div id="cxjf" style="position: absolute;top:300px;left:180px;width: 200px;height: 100px;">
    <img src="${pageContext.request.contextPath}/images/jfjlcx.png">
</div>
<div id="cxyygh" style="position: absolute;top:300px;left:720px;width: 200px;height: 100px;">
    <img src="${pageContext.request.contextPath}/images/yyyghcx.png">
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
        window.location.href = "${pageContext.request.contextPath}/jsp/main/readCardType.jsp";
    });

    //缴费记录查询点击事件
    $("#cxjf").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/jzjlcx/cxjf.jsp";
    });
    //预约挂号记录查询,将会跳转到挂号和预约是否就诊的选择button 页面
    $("#cxyygh").bind("click dbclick", function () {
        //window.location.href="${pageContext.request.contextPath}/jsp/jzjlcx/yyghIsFinishMenu.jsp";
        window.location.href = "${pageContext.request.contextPath}/jsp/jzjlcx/cxyygh.jsp";
    })
</script>
</html>
