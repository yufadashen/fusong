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
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="stepByKeshi" class="ui-stepBar-wrap"
     style="display:none;width:90%;height:100px;position:absolute;top:270px;left:40px;background-color:#f7fcff">
    <div class="ui-stepBar">
        <div class="ui-stepProcess"></div>
    </div>
    <div class="ui-stepInfo-wrap">
        <table class="ui-stepLayout" border="0" cellpadding="0" cellspacing="0">
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
<div id="stepByRiqi" class="ui-stepBar-wrap"
     style="display:none;width:90%;height:100px;position:absolute;top:250px;left:57px;background-color:#f7fcff">
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
<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:440px;">
    <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
         width="90" height="43" style="position:relative;top:145px;left:4px"/>
</div>
<div id="tip_div1"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:440px;">
    <div id="tip_divInfo1" style="text-align:center;position:relative;top:82px">
        <span id="error1" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s1" src="${pageContext.request.contextPath}/images/qdmix.png"
         width="90" height="43" style="position:relative;top:125px;left:4px"/>
</div>
<div id="word" style="width:100%;z-index:60;position:absolute;top:1210px;">
    <span style="width:100%;font-size:40px;text-align:center">请确认预约信息</span>
</div>
<div style="z-index:60;position:absolute;top:160px;left:480px;">
    <img id="title"
         src="${pageContext.request.contextPath}/images/ghtitle.png"/>
</div>
<div id="yyInfo"
     style="z-index:50;position:absolute;top:380px;left:140px;text-align:center;display:block">
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
        <tr style="height:70px;border:1px solid #000;">
            <td colspan="2" style="border:1px solid #000;">
                <button id="qryy" class="layui-btn layui-btn-primary"
                        style="font-size:35px;height:50px;width:175px;background-color:#4d9cfa" onclick="mzyyGhdj()">
                    确认预约
                </button>
            </td>
        </tr>
    </table>
</div>
<div id="main" style="position: absolute;top:800px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
<div id="pre" style="position: absolute;top:790px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script type="text/javascript">
    var xming0 = window.parent.xming0;//患者名称
    var brid00 = window.parent.brid00; //病人id
    var xbie00 = window.parent.xbie00; //病人性别
    var cardNo = window.parent.cardNo;//卡号
    var zjbm00 = window.parent.cardNo; //证件编号
    var zjlx00 = window.parent.cardtype; //证件类型 ：01、02、5
    var keshi = $.session.get('keshi'); //科室
    var riqi = $.session.get('riqi'); //日期
    var shijian = $.session.get('shijian'); //时间
    var doctor = $.session.get('doctor'); //医生
    var ksid00 = $.session.get('ksid00'); //科室id
    var ysid00 = $.session.get('ysid00'); //医生ID
    var jzwz00;//就诊位置
    var pdxh00;//排队序号
    var yyid00; //预约id
    var pbid00; //排班ID
    var tsfei0 = $.session.get('tsfei0'); //特殊费用
    var ghzfy0 = parseFloat($.session.get('ghzfy0')) + parseFloat(tsfei0); //挂号总费用
    var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用）
    var pin000 = window.parent.pin000; //密码
    var ksrqsj; //开始日期时间
    var jsrqsj; //结束日期时间
    var sjdbh0; //时间点编号
    var cztype = 5;//充值方式
    var czsucc = window.parent.czsucc;//充值成功 1为成功
    var money = 0;//默认充值金额
    var lxdh00 = $.session.get('phone');//手机号
    var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
    var log = document.getElementById("AVFOCX");
    var fyjsxx = "";
    var mzfyze;//门诊费用总额

    var tfje;    //退费金额
    var tkddls;  //退款订单流水号
    var tsxx;    //提示信息
    var tsxx2 = ""; //提示信息2
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;

    var mzksbh;//门诊科室编号
    var mzksmc;//门诊科室名称
    var mzysxm;//门诊医生姓名
    var ghhb00;//
    var yysj00;//预约时间
    var ghlx00;//
    var ghsj00;
    var pbbh00;
    var yylsh0;
    var jzdz00;
    var mzysbh;//门诊医生编号
    var wbbh00;//am/pm



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

    $("#main").bind("click dbclick", function () {
        if (typeof ($.session) != "undefined") {
            $.session.clear();
        }
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

    $("#pre").bind("click dbclick", function () {
        window.history.back();
    });
    $("#tip_s").on("click", function () {
        $("#tip_div").hide();
    });


    function stepshow() {
        $("#stepByRiqi").show();
        pbid00 = $.session.get('pbid00D');
        $(function () {
            stepBar.init("stepByRiqi", {
                step: 6,
                change: false,
                animation: false
            });
        });
        if (czsucc == 1) {
            yyInfo();
        } else {
            yyInfo();
        }
    }

    function yyInfo() {
        $("#jz").hide();
        $("#yykeshi").text(keshi);
        $("#yyyisheng").text(doctor);
        $("#yyriqi").text(riqi);
        var begin = $.session.get("kssj00").split(" ")[1];
        var end = $.session.get("jssj00").split(" ")[1];
        $("#yyshijian").text(begin + "~~" + end);
    }

    function mzyyGhdj() {
        $("#jz").show();
        var datas = {
            "funcid": "M07.02.04.07",								//方法名
            "cxdm00": cardNo,										//患者卡号
            "mzksbh": $.session.get('ksid00'),						//科室编号
            "pbid00": $.session.get('pbid00T'),				    	//排班id
            "yysjid": "",											//预约时间id
            "brid00": window.parent.brid00,					    	//病人id
            "lxdh00": window.parent.lxdh00,						    //联系电话
            "yyrq00": $.session.get('riqi'),						//预约日期
            "csrq00": window.parent.csrq00,					    	//出生日期
            "sfzhao": window.parent.sfzhao,					    	//身份证号
            "xming0": window.parent.xming0,							//姓名
            "kssj00":$.session.get("kssj00"),                       //开始结束时间
            "jssj00":$.session.get("jssj00")
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
                Data = eval(json);
                if (Data.retcode == "0") {
                    if (Data.retbody[0].jgbm00 == "1") {
                        $.session.set("yylsh0", Data.retbody[0].yylsh0);
                        mzysxm = Data.retbody[0].mzysxm;
                        $.session.set("mzysxm",mzysxm);
                        mzksmc = Data.retbody[0].mzksmc;
                        $.session.set("mzksmc",mzksmc);
                        mzksbh = Data.retbody[0].mzksbh;
                        $.session.set("mzksbh",mzksbh);
                        yysj00 = Data.retbody[0].yysj00;
                        $.session.set("yysj00",yysj00);
                        ghhb00 = Data.retbody[0].ghhb00;
                        $.session.set("ghhb00",ghhb00);
                        ghlx00 = Data.retbody[0].ghlx00;
                        $.session.set("ghlx00",ghlx00);
                        ghsj00 = Data.retbody[0].ghsj00;
                        $.session.set("ghsj00",ghsj00);
                        pbbh00 = Data.retbody[0].pbbh00;
                        $.session.set("pbbh00",pbbh00);
                        yylsh0 = Data.retbody[0].yylsh0;
                        $.session.set("yylsh0",yylsh0);
                        ghlsh0 = Data.retbody[0].ghlsh0;
                        $.session.set("ghlsh0",ghlsh0);
                        hbmc00 = Data.retbody[0].hbmc00;
                        $.session.set("hbmc00",hbmc00);
                        //wbmc00
                        wbmc00 = Data.retbody[0].wbmc00;
                        $.session.set("wbmc00",wbmc00);
                        //排队序号
                        pdxh00 = Data.retbody[0].pdxh00;
                        $.session.set("pdxh00",pdxh00);
                        jzdz00 = Data.retbody[0].jzdz00;
                        $.session.set("jzdz00",jzdz00);
                        wbbh00 = Data.retbody[0].wbbh00;
                        $.session.set("wbbh00",wbbh00);
                         mzysbh = Data.retbody[0].mzysbh;
                        $.session.set("mzysbh",mzysbh);
                        if (window.parent.cardtype == 0) {
                            ybYjs();
                        }else{
                            yjs();
                        }
                    } else {
                        $("#tip_div").show();
                        $("#error").text(Data.retmsg);
                    }
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function (json) {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
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

  function ybYjs() {
        var datas = {
            funcid: "M07.02.19.01",
            dllmethod: "GhYuJieSuan",
            xming0:window.parent.xming0,
            cxdm00:window.parent.cardNo,
            cxfs00:window.parent.cardtype,
            brid00:window.parent.brid00,
            mzksbh:mzksbh,
            mzysxm:mzysxm,
            mzksmc:mzksmc,
	    	mzysbh:mzysbh,
            isvj00:"",
            yyrq00:yysj00.split(" ")[0],
            ghsj00:wbbh00,
            ghhb00:ghhb00,
            pbbh00:pbbh00,
            yylsh0:yylsh0,
            ghlx00:ghlx00,
            xzbs00:$.session.get("xzbs00"),
            yllb00: "11",
            akc190:"",
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
                if (Data.retcode == "0"){
                    //调用M07.02.19.02时候增加个入参，传调用M07.02.19.01的出参ybreqx。 这样后台把你调用医保动态库的入参和出参都记录下来，方便以后查问题。
                   
                    ybxml = convertFromXml(Data.retbody[0].ybreqx);
 		    $.session.set("ybinput",ybxml);
                    var readCardResult = window.parent.yiBao.GHYuJieSuan(ybxml,40000);
                    if(readCardResult.substring(0,1)=='0'){
                    	var s = readCardResult.substring(readCardResult.indexOf('<?xml'),readCardResult.indexOf('</result></root>')+16)
                        analyzeYbXml(s)
                    }else{
		        analyzeYbXml1(readCardResult);
			yyqx();
			var dataOtherAnalyze = readCardResult.substring(readCardResult.indexOf('ERROR="')+7,readCardResult.indexOf('|'));
                    	$("#tip_div").show();
			$("#error").text(dataOtherAnalyze);
                        //$("#error").text("预结算异常，请重试");
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                    }
                }else if(Data.retcode == "-1"){
			yyqx();
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


 /*
        预约取消接口
     */
    function yyqx() {
        var datas = {
            funcid : "M07.02.04.09",
            yyjgdmyypt:"", //可以为空
            yylsh0:yylsh0
        }
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            success:function (json) {

            },
            error:function (json) {

            }
        })
    }
    

    //解析医保动态库预结算返回的报文
    function analyzeYbXml(ybxml) {
        var datas = {
            funcid:"M07.02.19.02",
            dllmethod:"GhYuJieSuan",
            ybgetx:ybxml,
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
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0"){
                    window.parent.money = Data.retbody[0].grzfe0;//个人支付额
                    $.session.set("grzfe0",Data.retbody[0].grzfe0);
                    //ghfy00  挂号费用
                    $.session.set("ghfy00",Data.retbody[0].ghfy00);
                    //jjzfe0  基金支付额
                    $.session.set("jjzfe0",Data.retbody[0].jjzfe0);
                    $.session.set("djlsh0",Data.retbody[0].djlsh0);
                    $.session.set("akc190",Data.retbody[0].akc190);
                    $.session.set("zhzfe0",Data.retbody[0].zhzfe0);
                    
		    $("#tip_div").show();
                    $("#error").text("基金支付:" + Data.retbody[0].jjzfe0 + "元       账户支付:" + Data.retbody[0].zhzfe0 + "元       个人支付：" + window.parent.money + "元");
		    $("#tip_s").bind("click",function () {
			 if (Data.retbody[0].grzfe0 > 0) {
                        //个人支付额大于0使用微信支付，否则直接调用正式结算
                     		   window.parent.cztype = 2;
                      		  window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                    	}else{
                       		 window.parent.czsucc = 1
                      	 	 $.session.set("ptqqls","00000000000");
                      		  window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
                    	}
			

                    });	

                   
                }else if(Data.retcode == "-1"){
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
	
    /*发送日志到后台*/
    function analyzeYbXml1(ybxml) {
        var datas = {
            funcid:"M07.02.19.02",
            dllmethod:"GhYuJieSuan",
            ybgetx:ybxml,
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
            success: function (json) {},
            error: function (json) {}
        });
    }


    /*
        查询患者预约记录
     */
    function QueryLog() {
        var datas = {
            "funcid": "M07.02.04.08",
            "mzlxbh": "",
            "ksrq00": "",
            "jzrq00": "",
            "cxfs00": "",
            "cxdm00": "",
            "brid00": window.parent.brid00
        };

        $.ajax({
            async: false,
            type: "post",
            data: datas,
            url: window.parent.serverUrl + "?method=ApplyAction",
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: datas,
            dataType: "json",
            success: function (data) {
                Data = eval(data);
                if (Data.retcode == "0") {

                    if (Data.retbody.length == 1) {
                        mzysxm = Data.retbody[0].mzysxm;
                        $.session.set("mzysxm",mzysxm);
                        mzksmc = Data.retbody[0].mzksmc;
                        $.session.set("mzksmc",mzksmc);
                        mzksbh = Data.retbody[0].mzksbh;
                        yysj00 = Data.retbody[0].yysj00;
                        $.session.set("yysj00",yysj00);
                        ghhb00 = Data.retbody[0].ghhb00
                        $.session.set("ghhb00",ghhb00);
                        ghlx00 = Data.retbody[0].ghlx00;
                        $.session.set("ghlx00",ghlx00);
                        ghsj00 = Data.retbody[0].ghsj00;
                        $.session.set("ghsj00",ghsj00);
                        pbbh00 = Data.retbody[0].pbbh00;
                        $.session.set("pbbh00",pbbh00);
                        yylsh0 = Data.retbody[0].yylsh0;
                        $.session.set("yylsh0",yylsh0);
                        hbmc00 = Data.retbody[0].hbmc00;
                        $.session.set("hbmc00",hbmc00);
                        //wbmc00
                        wbmc00 = Data.retbody[0].wbmc00;
                        $.session.set("wbmc00",wbmc00);
                        pdxh00 = Data.retbody[0].pdxh00;
                        $.session.set("pdxh00",pdxh00);

                        yjs();
                    } else if (Data.retbody.length > 1) {
                        window.location.href = "${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
                    }
                } else {
                    $("#detai").hide();
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        if (typeof ($.session) != "undefined") {
                            $.session.clear();
                        }
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    if (typeof ($.session) != "undefined") {
                        $.session.clear();
                    }
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    //门诊预结算
    function yjs() {
        $("#jz").show();
        var datas = {
            "funcid": "M07.02.04.10",
            "cxfs00": window.parent.cardtype,
            "cxdm00": window.parent.cardNo,
            "brid00": window.parent.brid00,
            "yyxh00": "",
            "dlid00": "",
            "mzksbh": mzksbh,
            "mzksmc": mzksmc,
            "mzysxm": mzysxm,
            "ghhb00": ghhb00,
            "yysj00": yysj00,      //预约时间
            "ghlx00": ghlx00,
            "ghsj00": ghsj00,
            "pbbh00": pbbh00,
            "yylsh0": yylsh0,
            "xzbs00": "",
            "yllb00": "",
            "akc190": ""
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
                Data = eval(json);
                if (Data.retcode == "0") {
                    //预交费接口返回成功
                    //预交费接口返回成功
                    window.parent.money = Data.retbody[0].grzfe0;
                    window.parent.money = Data.retbody[0].grzfe0;
                    $.session.set("GRZFE0",Data.retbody[0].grzfe0);
                    $.session.set("akc190",Data.retbody[0].akc190);
                    $.session.set("zhzfe0",Data.retbody[0].zhzfe0);
                    $.session.set("jjzfe0",Data.retbody[0].jjzfe0);
                    $.session.set("jssfrq",Data.retbody[0].jssfrq);
                    $.session.set("ddrs00",Data.retbody[0].ddrs00);
                    $.session.set("ghfy00",Data.retbody[0].ghfy00);
                    $.session.set("lxdh00",Data.retbody[0].lxdh00);
                    $.session.set("djlsh0",Data.retbody[0].djlsh0);

                    window.parent.cztype = 2;
                    window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function (json) {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常,请稍后再试!");
            }
        })
    }

    $("#tip_s1").bind("click dbclick", function () {
        $("#tip_div1").hide();
        $("#tip_s1").hide();
        inputpassword();
        $("#mma").show();
        $("#login_pa").show();
        $("#sure").show();
    });

    stepshow();
</script>
</html>




