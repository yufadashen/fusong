<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>读卡</title>
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
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:425px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:150px;left:300px"/>
</div>
<div id="title"
     style="text-align:center;position:absolute;top:212px;left:400px;">
    <span id="error" style="font-size:40px;color:#EE7700;"><strong>请输入手机号，完善个人信息</strong></span>
</div>
<div style="text-align:center;position:absolute;top:370px;left:450px;">
    <input id="phone" style="width:350px;height:60px;font-size:30px;" maxlength="11">
</div>
<div id="main" style="position: absolute;top:850px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/"
         height="" width=""/>
</div>
<div id="next" style="position: absolute;top:840px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png" res_img="${pageContext.request.contextPath}/"
         height="" width=""/>
</div>

<div id="money"
     style="position: absolute;top:470px;left:450px;">
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
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
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

    $("#jz").hide();

    returnTime();
    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
    });

    //输入金额
    $('img[name="numKey"]').on("click", function () {
        var valStr = $("#phone").val();
        if (valStr == "" || valStr == "0") {
            $("#phone").val($(this).attr("value"));
        } else {
            if ($("#phone").val().length == 11) {
                //todo 阻止界面号码按钮事件
            }else{
                $("#phone").val(valStr + $(this).attr("value"));
            }
        }
    });
    //修改
    $("#modify").on("click", function () {
        var num = $("#phone").val();
        var newstr = num.substring(0, num.length - 1);
        $("#phone").val(newstr);
    });

    //确认
    $("#sure").bind("click dbclick", function () {
        var phoneno = $("#phone").val();
        if (phoneno.length == 11) {
            window.parent.lxdh00 = phoneno;
            updateInfo();
        } else {
            $("#phone").val("");
            $("#tip_div").show();
            $("#error").text("手机号格式不正确");
        }

    });

    function updateInfo() {
        $("#jz").show();
        var datas = {
            "funcid": "M07.02.01.04",
            "cxfs00": window.parent.cardtype,
            "cxdm00": window.parent.cardNo,
            "brid00": window.parent.brid00,
            "sfzhao": window.parent.sfzhao,
            "xming0": window.parent.xming0,
            "xbie00": window.parent.xbie00,
            "csrq00": window.parent.csrq00,
            "lxdh00": window.parent.lxdh00
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
                    $("#tip_div").show();
                    $("#error").text("更新信息成功");
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#next").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/readIdcard.jsp";
    });
    //readCard();
</script>
</html>
