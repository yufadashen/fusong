<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" name="plugin"
            classid="clsid:4C5F4B81-B044-4C45-AC9A-26864D324EBA"></object>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"> </object>
    <title>门诊挂号-是否为专家</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            background: url(${pageContext.request.contextPath}/images/bj.jpg)
            no-repeat;
        }
    </style>
</head>
<body scroll="no">
<!-- 页面倒计时js -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<%--科室选择效果--%>
<div id="stepByKeshi" class="ui-stepBar-wrap" style="display:none;width:90%;height:100px;position:absolute;top:270px;left:40px;background-color:#f7fcff">
    <div class="ui-stepBar">
        <div class="ui-stepProcess"></div>
    </div>
    <div class="ui-stepInfo-wrap">
        <table class="ui-stepLayout" border="0" cellpadding="0"
               cellspacing="0">
            <tr>
                <td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
                    <p class="ui-stepName">选择科室</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
                    <p class="ui-stepName">选择医生</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
                    <p class="ui-stepName">选择日期</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
                    <p class="ui-stepName">选择时间</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">5</a>
                    <p class="ui-stepName">填写电话</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">6</a>
                    <p class="ui-stepName">预约</p></td>
            </tr>
        </table>
    </div>
</div>
<%--日期选择效果--%>
<div id="stepByRiqi" class="ui-stepBar-wrap" style="display:none;width:90%;height:100px;position:absolute;top:200px;left:57px;background-color:#f7fcff">
    <div class="ui-stepBar">
        <div class="ui-stepProcess"></div>
    </div>
    <div class="ui-stepInfo-wrap">
        <table class="ui-stepLayout" border="0" cellpadding="0"
               cellspacing="0">
            <tr>
                <td class="ui-stepInfo"><a class="ui-stepSequence">1</a>
                    <p class="ui-stepName">选择日期</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">2</a>
                    <p class="ui-stepName">选择科室</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">3</a>
                    <p class="ui-stepName">选择医生</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">4</a>
                    <p class="ui-stepName">选择时间</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">5</a>
                    <p class="ui-stepName">填写电话</p></td>
                <td class="ui-stepInfo"><a class="ui-stepSequence">6</a>
                    <p class="ui-stepName">预约</p></td>
            </tr>
        </table>
    </div>
</div>
<%--顶部门诊预约 logo--%>
<div style="z-index:60;position:absolute;top:160px;left:480px;">
    <img id="title"
         src="${pageContext.request.contextPath}/images/ghtitle.png" />
</div>
<%--普通医生div--%>
<div id="normalDoctor" style="z-index:60;position:absolute;top:350px;left:240px;">
    <img src="${pageContext.request.contextPath}/images/normal.png" />
</div>
<%--专家医生div--%>
<div id="expert" style="z-index:60;position:absolute;top:350px;left:700px;">
    <img src="${pageContext.request.contextPath}/images/expert.png" />
</div>
<%--返回主页--%>
<div id="main" style="position: absolute;top:800px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width="" />
</div>
<%--后退一步按钮--%>
<div id="pre" style="position: absolute;top:790px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width="" />
</div>
</body>
<script type="text/javascript">
    var cardNo =window.parent.cardNo;//卡号
    var cxfs00=window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
    var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
    var log = document.getElementById("AVFOCX");
    var phone=window.parent.lxdh00;//联系电话
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;
    //自动倒计时，计时时间为0时，
    function returnTime(){
        myVar=setInterval(
            function(){
                time--;
                $("#time").text(time);
                if(time==0){
                    //跳转页面
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                }
            },1000);
    }

    //用户点击或按键等操作时，倒计时重新计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;
    function timeAgin(){
        time = window.parent.reTime;
    }
    returnTime();

    $("#main").bind("click dbclick", function() {
        $.session.clear();
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#pre").bind("click dbclick", function() {
        window.history.back();
    });
    $("#tip_s").bind("click dbclick", function() {
        console.log("触发点击事件");
        setPhone();
    });
    $("#tip_s2").bind("click dbclick", function() {
        $("#tip_div2").hide();
    });

    //普通医生div 点击之后
    $("#normalDoctor").bind("click dbclick",function () {
        //将区别专家和普通医生的编号存入seesion 中
        $.session.set("setParamHbbm00","01");
        //console.log("将跳转到 ")
        window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yydoctor.jsp";
    });
    //专家医生div 点击之后
    $("#expert").bind("click dbclick",function () {
        //将区别专家和普通医生的编号存入seesion 中
        $.session.set("setParamHbbm00","02");
        window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yydoctor.jsp";
    });

</script>
</html>