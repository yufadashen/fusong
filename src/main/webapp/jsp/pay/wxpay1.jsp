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
    <title>微信充值</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=8">
    <!--以IE8模式渲染-->
    <meta http-equiv="X-UA-Compatible" content="IE=7">
    <!--以IE7模式渲染-->
    <style>
        body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
        }
    </style>
</head>
<body scroll="no" id="info">
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:465px;">
    <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong>充值成功，请在下方取走凭条</strong></span>
    </div>
    <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
         width="90" height="43" style="position:relative;top:125px;left:286px"/>
</div>
<div id="cardinfo" style="position:absolute;top:290px;left:285px">
    <span style="font-size:40px">姓名:</span><span id="xming0" style="font-size:40px;color:#0000FF"></span>
    <span style="font-size:40px">卡号:</span><span id="carNo" style="font-size:40px;color:#0000FF"></span>
    <span style="font-size:40px">支付金额:</span><span id="zfye" style="font-size:40px;color:#0000FF"></span>
</div>
<div id="title"
     style="z-index:60;display:block;position:absolute;top:160px;left:490px;">
    <img id="tip1"
         src="${pageContext.request.contextPath}/images/smpaytitle.png"/>
</div>
<div id="word" style="width:100%;z-index:60;position:absolute;top:680px;left:180px;">
    <span style="width:100%;font-size:40px;text-align:center;color:red">请在倒计时结束前完成支付，倒计时结束请勿支付</span>
</div>
<div id="shuru"
     style="display:none;position:absolute;left:300px;top:1303px;">
    <span id="tip2" style="font-size:40px;color:#EE7700">需支付金额为:</span>
</div>
<div id="inputmoney"
     style="display:none;position:absolute;left:610px;top:300px;">
    <input name="value" id="value" type="text" maxlength="7"
           style="width:200px;height:50px;text-align:center;font-size:40px">
</div>
<div id="erweima"
     style="z-index:60;display:none;position:absolute;top:374px;left:500px;">
</div>
<div id="quxiao"
     style="z-index:60;display:none;position:absolute;top:750px;left:564px;">
    <img id="tip3"
         src="${pageContext.request.contextPath}/images/quxiao.png"
         res_img="${pageContext.request.contextPath}/images/quxiao1.png" height="" width=""/>
</div>
<div id="main" style="position:absolute;top:845px;left:520px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/" height="" width=""/>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script type="text/javascript">
    //初始化倒计时时间：60秒
    var time = 120;
    var queryOrderTimeout;
    //自动倒计时，计时时间为0时，
    function returnTime() {
        myVar = setInterval(
            function () {
                time--;
                $("#time").text(time);
                  if(time<4 && time>0){
                    cancleOrder();
                    queryOrderTimeout = setTimeout("queryOrder()", 1000);//查询订单状态
                }else if(time==0){
                    //跳转页面
                   // cancleOrder();
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                }
            }, 1000);
    }

    //用户点击或按键等操作时，倒计时重新计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;

    function timeAgin() {
        time = 120;
    }

    returnTime();

    //定义
    var value = window.parent.money;//充值金额
    var jylsh = ""; //交易流水号
    var yhkhao = ""; //银行卡号
    var xming0 = window.parent.xming0;	//姓名
    var brid00 = window.parent.brid00;  //病人ID
    var xbie00 = window.parent.xbie00;//病人性别
    var cardNo = window.parent.cardNo; //卡号
    var cardtype = window.parent.cardtype; //卡类型
    var ptqqls;//平台请求流水
    var jylsh0;//交易流水号
    var xtgzh0;//系统跟踪号
    var ptddls;//平台订单流水
    var czztbz;//充值状态标识  返回czztbz=3则付款成功跳到成功界面，czztbz=5则支付成功但是HIS充值失败，打印失败凭条；czztbz=其他继续等待
    var czsucc;//充值成功   1为成功
    var cztype = window.parent.cztype;//1.正常充值  2.结算时金额不足充值   3.挂号时挂号费不足充值  4.取号时金额不足充值  5预约时金额不足充值
    var yjjye0 = window.parent.yjjye0;//院内账户余额

 	//阻止键盘退格事件
    $(document).keydown(function(event){
        if(event.keyCode==8){
		return false;	
        }
    })


    //微信充值下单
    function wxorder() {
        $("#xming0").text(window.parent.xming0);
        $("#carNo").text(window.parent.brid00);
        if(window.parent.cardtype==0){
        	$("#zfye").text(window.parent.money+"元，基金支付:"+$.session.get("jjzfe0"));
        }else{
        	$("#zfye").text(window.parent.money);
        }
        var datas = {
            "funcid": "M07.02.03.29",
            "cxdm00": cardNo,
            "cxfs00": cardtype,
            "brid00": brid00,
            "czje00": value,
            "cardno": "",
            "sfzhao": "",
            "xming0": xming0,
            "xbie00": xbie00,
            "ddbt00": "",
            "bankid": "",
            "czmzzy": "01",
            "klxbh0": "",
            "yylsh0":$.session.get("yylsh0")
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
                    //log.WriteLog("微信下单成功，金额为"+value);
                    var qrcode = Data.retbody[0].qrcode;//二维码串
                    ptddls = Data.retbody[0].ptddls;//平台订单流水
                    jylsh0 = Data.retbody[0].jylsh0;//交易流水号
                    xtgzh0 = Data.retbody[0].xtgzh0;//系统跟踪号
                    ptqqls = Data.retbody[0].ptqqls;//平台请求流水
                    cgjysj = Data.retbody[0].cgjysj;//交易时间
                    pjh000 = Data.retbody[0].pjh000;//票据号
                    $.session.set('ptqqls', ptqqls);
                    $.session.set('ptddls', ptddls);
                    $.session.set('jylsh0', jylsh0);
                    //将二维码串转换为图片
                    $("#erweima").qrcode({
                        render: "table",
                        width: 300,
                        height: 300,
                        text: qrcode
                    })
                    $("#shuru").hide();
                    $("#inputmoney").hide();
                    $("#money").hide();
                    $("#erweima").show();
                    $("#quxiao").show();
                    queryOrderTimeout = setTimeout("queryOrder()", 1000);//查询订单状态
                } else {
                    $("#tip_div").show();
                    $("#error").text("扫码付下单失败，请重试");
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    //微信充值查询订单状态
    function queryOrder() {
        //$("#jz").show();
        var datas = {
            "funcid": "M07.02.03.30",
            "cxdm00": cardNo,
            "cxfs00": cardtype,
            "brid00": brid00,
            "czje00": value,
            "klxbh0": "",
            "xming0": xming0,
            "sfzhao": "",
            "ptqqls": ptqqls,
            "khsrpz": "",
            "cshsj0": "",
            "jylsh0": jylsh0,
            "xtgzh0": xtgzh0,
            "ddlx00": "0",
	    "yylsh0":$.session.get("yylsh0")
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
                    czztbz = Data.retbody[0].czztbz;//充值状态标识
                    switch (czztbz) {
                        case "3":
                            window.parent.sffs = "17";
                            //log.WriteLog("卡号"+cardNo+"成功通过过微信充值"+value+"元");
                            $("#erweima").hide();
                            $("#quxiao").hide();
                            time = 90;
                            getNewInfo();
                            break;
                        case "5":
                            //微信充值成功但his充值失败，打印失败凭条
                            $("#erweima").hide();
                            $("#quxiao").hide();
                            $("#tip_div").show();
                            $("#error").text("微信充值成功但HIS充值失败，请取走凭条");
                            $("#tip_s").on("click", function () {
                                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                            });
                            //log.WriteLog("卡号"+cardNo+"成功通过过微信充值"+value+"元,，但HIS充值失败");
                            //print();
                            break;
                        default:
                            if (time == 0) {
                                cancleOrder(0);
                                window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                            } else {
                                queryOrderTimeout = setTimeout("queryOrder()", 1000);
                            }
                    }
                } else {
                    $("#erweima").hide();
                    $("#quxiao").hide();
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function () {
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#jz").hide();
                //log.WriteLog("卡号"+cardNo+"查询订单状态失败");
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    function getNewInfo() {
        if (cztype == 1) {
            czsucc = 1;
            window.parent.czsucc = czsucc;//充值成功
            window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/qhsucc.jsp";
        } else if (cztype == 2) {
            czsucc = 1;
            window.parent.czsucc = czsucc;//充值成功
            window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
        } else if (cztype == 3) {
            czsucc = 1;
            window.parent.czsucc = czsucc;//充值成功
            window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/qhsucc.jsp";
        } else if (cztype == 4) {//充值缴费功能flag,充值完成之后再跳转到 mzjs 页面
            czsucc = 1;
            window.parent.czsucc = czsucc;//充值成功
            window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
        } else if (cztype == 5) {
            czsucc = 1;
            window.parent.czsucc = czsucc;//充值成功
            window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yyinfo.jsp";
        } else if (cztype == 6) {
            czsucc = 1;
            window.parent.czsucc = czsucc;//充值成功
            window.location.href = "${pageContext.request.contextPath}/jsp/zzfk/fkkf.jsp";
        }
    }


    $("#quxiao").bind("click dbclick", function () {
        $("#erweima").hide();
        $("#quxiao").hide();
        //关闭定时器查询
	
//1为用户主动撤销，0为定时器到时
        cancleOrder(1);
    });

    //微信充值撤销订单
    function cancleOrder(flag) {
        
        $("#jz").show();
        var datas = {
            "funcid": "M07.02.03.31",
            "cxdm00": cardNo,
            "cxfs00": cardtype,
            "jylsh0": jylsh0,
            "ptqqls": ptqqls,
            "czje00": value,
            "brid00": brid00,
            "czmzzy": "01"
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
                $("#jz").hide();
                Data = eval(json);
                //Data = {"retbody":[{"ynzhye":"0","cgjysj":"20180924060812","ptddls":"20180924061719003587","jylsh0":"2018112010049H"}],"retmsg":"","retcode":"0"};
                if (Data.retcode == "0") {
			clearTimeout(queryOrderTimeout);
                    
			if(flag==1){
			$("#tip_div").show();
                    $("#error").text("取消订单成功");
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
			}

                    /*$("#tip_div").show();
                    $("#error").text("取消订单成功");
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });*/
                } else {
                    //$("#tip_div").show();
                    //$("#error").text("取消订单失败");
                   // $("#tip_s").on("click", function () {
                      //  $("#tip_div").hide();
                       // window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                   // });
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    $("#main").bind("click dbclick", function () {
        cancleOrder();
        //window.location.href="${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

    wxorder();
</script>
</html>

