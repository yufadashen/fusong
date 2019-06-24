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
<object id="logger" classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA" width="0" height="0"></object>
    <title>预约取号</title>
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
            background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
        }
    </style>
</head>
<body scroll="no" id="info">
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<!-- 预约取号 -->
<div id="title"
     style="z-index:60;display:block;position:absolute;top:195px;left:460px;">
    <img id="tip1"
         src="${pageContext.request.contextPath}/images/ghtitle.png"/>
</div>
<!-- 获取个人信息列表 -->
<div id="detail"
     style="width:1060px;position:absolute;top:300px;left:90px;">
    <table id="idData"
           style="width:800px;border:1px solid black;table-layout:fixed">
        <thead>
        <tr
                style="height:80px;background-color:#E0FFFF;border:1px solid black;margin:10px">
            <td
                    style="width:290px;height:60px;border:1px solid black;font-size:35px;text-align:center">预约科室
            </td>
            <td
                    style="width:150px;height:60px;border:1px solid black;font-size:35px;text-align:center">专家
            </td>
            <td
                    style="width:265px;height:60px;border:1px solid black;font-size:35px;text-align:center">日期
            </td>
            <td
                    style="width:220px;height:60px;border:1px solid black;font-size:35px;text-align:center">时间
            </td>
            <%--<td--%>
            <%--style="width:120px;height:60px;border:1px solid black;font-size:35px;text-align:center">费用--%>
            <%--</td>--%>
            <td
                    style="width:100px;height:60px;border:1px solid black;font-size:35px;text-align:center">取号
            </td>
        </tr>
        </thead>
        <tbody id="infoBody"></tbody>
        <tfoot>
        <tr>
            <td colspan="3"
                style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pageup" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.prePage();">上一页
                </button>
            </td>
            <td colspan="3"
                style="width:160px;height:60px;border:1px solid black;font-size:35px;text-align:center;">
                <button id="pagedown" style="font-size:35px;height:60px"
                        class="layui-btn layui-btn-primary layui-btn-radius"
                        onclick="page.nextPage();">下一页
                </button>
            </td>
        </tr>

        </tfoot>
    </table>
</div>
<!--  页面错误信息提示弹框-->
<div id="tip_div"
     style="display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:310px;top:360px;">
    <div id="tip_divInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:125px;left:250px"/>
</div>
<!-- 返回主頁面 -->
<div id="main" style="position: absolute;top:800px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png"
         res_img="${pageContext.request.contextPath}/images/main1.png"
         height="" width=""/>
</div>
<!-- 返回上一步 -->
<div id="pre" style="position: absolute;top:790px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png"
         res_img="${pageContext.request.contextPath}/images/pre1.png"
         height="" width=""/>
</div>
<div id="tip_did"
     style="display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:212px;top:1365px;">
    <div id="tip_didInfo"
         style="text-align:center;position:relative;top:82px">
        <span id="error1" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_d"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
         height="43" style="position:relative;top:125px;left:250px"/>
</div>
<!-- 是否取号提示页面 -->
<div id="qh_div"
     style="display:none;width:800px;height:389px;background-image:url('${pageContext.request.contextPath}/images/dck3.png');position:absolute;left:220px;top:310px;">
    <div id="qh_divInfo"
         style="text-align:center;position:relative;top:100px">
        <form>
            <span style="font-size:30px;color:balck;"><strong>预约科室:</strong></span><input
                id="yyks" value=""
                style="width:350px;height:40px;font-size:30px;readonly"><br/>
            <span style="font-size:30px;color:balck;"><strong>预约医生:</strong></span>
            <input id="yyys"
                   style="width:350px;height:40px;font-size:30px;readonly"><br/>
            <span style="font-size:30px;color:balck;"><strong>预约日期:</strong></span>
            <input id="yyrq"
                   style="width:350px;height:40px;font-size:30px;readonly"><br/>
            <span style="font-size:30px;color:balck;"><strong>预约时间:</strong></span>
            <input id="yysj"
                   style="width:350px;height:40px;font-size:30px;readonly"><br/>
        </form>

        <span id="qh_error" style="font-size:30px;color:#EE7700;"><strong></strong></span>

    </div>
    <img id="qh_s"
         src="${pageContext.request.contextPath}/images/qdmix.png" width="120"
         height="50" style="position:relative;top:115px;left:220px"/> <img
        id="qh_c" src="${pageContext.request.contextPath}/images/quxiao.png"
        width="120" height="50"
        style="position:relative;top:115px;left:350px"/>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:1024px;backgroud:#fff;position:absolute;top:0px;left:0px;z-index:100">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300"
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>

<script type="text/javascript">
    var log = document.getElementById("logger");//日志
    var zjlx00 = window.parent.cardtype; //证件类型 ：01、02、5
    var zjbm00 = window.parent.cardNo; //证件编号
    var xming0 = window.parent.xming0; //患者姓名
    //var sfzhao = window.parent.sfzhao; //身份证号
    var brid00 = window.parent.brid00; //病人id
    var xbie00 = window.parent.xbie00; //病人性别
    var lxdh00 = window.parent.lxdh00; //联系电话
    var csrq00 = window.parent.csrq00; //出生日期
    var brnl00 = window.parent.brnl00; //年龄
    var czlb00 = window.parent.brnl00; //查找类别
    var pin000 = window.parent.pin000; //密码
    var pbid00; //排班ID
    var ksrqsj; //开始日期时间
    var jsrqsj; //结束日期时间
    var ksid00; //科室ID
    var ysid00; //医生id
    var ysxm00; //医生姓名
    var yyid00; //预约id
    var ghzfy; //挂号费
    var ghzfy1; //挂号总费用
    var sjdbh0; //时间点编号
    var ksmc00; //科室名称
    var yyxh00;  //预约序号
    var pdxh00;	//排队序号
    var jzwz00;	//就诊位置
    var yjjye0 = window.parent.yjjye0; //卡内余额
    var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
    var sfykt0 = window.parent.sfykt0; //是否为一卡通
    var money; //预交金金额
    var time1 = 30;
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;
    var yyrqP;
    var yysjP;
    var mzfyze; //门诊费用总额
    var jzid;   //就诊ID
    var sqdbh;  //申请单编号
    var fyjsxx = "";
    var printtsf;
    //退费参数
    var tfje;    //退费金额
    var tkddls;  //退款订单流水号
    var tsxx;    //提示信息
    var tsxx2 = ""; //提示信息2

    //todo
    var mzksbh;
    var ghhb00; //挂号号别
    var ghlx00;
    var ghsj00;//挂号时间
    var pbbh00; //排班时间明细ID
    var yylsh0;

    //自动倒计时，计时时间为0时，
    function returnTime() {
        myVar = setInterval(
            function () {
                time--;
                $("#time").text(time);
                if (time == 0) {
                    //跳转页面
                    if (typeof($.session) != "undefined"){
                        $.session.clear();
                    }
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

    function init() {
        if (window.parent.czsucc == 1) {
            //充值成功,调用正式结算
            if (window.parent.cardtype==0){
                //如果是医保卡，调用医保卡的正式结算
                ybZsjs();
            }else{
                zsjs();
            }
        } else {
            QueryLog();
        }
    }

    function ybZsjs() {
		$("jz").show();
        var datas = {
            funcid: "M07.02.19.01",
            dllmethod:"GhJieSuan",
            xming0:window.parent.xming0,
            cxdm00:window.parent.cardNo,
            cxfs00:window.parent.cardtype,
            brid00:window.parent.brid00,
            mzksbh:$.session.get("mzksbh"),
            mzksmc:$.session.get("mzksmc"),
            mzysbh:$.session.get("mzysbh"),
            mzysxm:$.session.get("mzysxm"),
            isvj00:"",
            yysj00:$.session.get("yysj00").split(" ")[0],
            ghsj00:$.session.get("wbbh00"),
            ghhb00:$.session.get("ghhb00"),
            pbbh00:$.session.get("pbbh00"),
            yylsh0:$.session.get("yylsh0"),
            ghlx00:$.session.get("ghlx00"),
            xzbs00:$.session.get("xzbs00"),
            yllb00:"11",
            akc190:$.session.get("akc190"),
            grzfe0:$.session.get("grzfe0"),
            ptqqls:$.session.get("ptqqls"),
            jyzflx:"ONE_QR",
            djlsh0:$.session.get("djlsh0")
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
				$("jz").hide();
                //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0"){
			
                    ybxml = convertFromXml(Data.retbody[0].ybreqx);
		    $.session.set("ybinput",ybxml);
                    var readCardResult = window.parent.yiBao.GhJieSuan(ybxml,60000);
                     if(readCardResult.substring(0,1)=='0'){
                    	 var s = readCardResult.substring(readCardResult.indexOf('<?xml'),readCardResult.indexOf('</result></root>')+16)
                         analyzeYbXml(s)
                   }else if(readCardResult.substring(0,2)=='-4'){
			print3();
			analyzeYbXml1(readCardResult);
			log.WriteLog(getCurrentTime(true)+" invoke dll timeout ");
                	   $("#tip_div").show();
                       $("#error").text("网络异常!请到服务窗口处理！");
                       $("#tip_s").on("click", function () {
                           window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                       });
                   }else if(readCardResult.substring(0,2)=='-1'){
			analyzeYbXml1(readCardResult);
                   	if ($.session.get("ptqqls")!="00000000000"){
			   //此处添加log 日志确认错误原因
			    log.WriteLog(getCurrentTime(true)+" invoke dll sbtf() start" + readCardResult);
                            sbtf();
			    log.WriteLog(getCurrentTime(true)+" invoke dll sbtf() end" + readCardResult);
                        }
                   	$("#tip_div").show();
                        $("#error").text("密码错误或网络异常，请重试");
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                	   
                   }else{
			print3();
			analyzeYbXml1(readCardResult);
			log.WriteLog(getCurrentTime(true)+" invoke dll timeout ");
                	   $("#tip_div").show();
                       $("#error").text("取号正式结算异常!请到服务窗口处理！");
                       $("#tip_s").on("click", function () {
                           window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                       });
		   }
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
				$("jz").hide();
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });

    }
	
  	//医保动态库正式结算失败自动退费
    function sbtf(){
        var datas = {
            funcid:"M07.02.03.33",
            cxdm00:window.parent.cardNo,
            cxfs00:window.parent.cardtype,
            ptqqls:$.session.get("ptqqls"),
            ptddls:$.session.get("ptddls"),
            jylsh0:$.session.get("jylsh0"),
            tkje00:window.parent.money,
            brid00:window.parent.brid00,
            czmzzy:"01"
        }
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success: function (json){
                 //后台解析动态库返回医保报文成功
                var Data = eval(json);
                if (Data.retcode == "0"){
                	printTF();               
                }else {
                	printTFSB();
                }
            },
            error: function (json) {
                //如果解析失败，返回功能选择页面
                printTFSB();
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }
  	
  	
    function printTF() {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("挂号退费成功");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("GRZFE0") + "元");
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  平台订单流水：" + $.session.get("ptddls"));
        Printer.WriteTextLineX("  交易流水：" + $.session.get("jylsh0"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }
    
    function printTFSB() {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("挂号退费失败");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  平台订单流水：" + $.session.get("ptddls"));
        Printer.WriteTextLineX("  交易流水：" + $.session.get("jylsh0"));
        Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }

     function print3() {
        var Printer = window.parent.KPrinter;
        //log.WriteLog("打印机端口设置成功");
        Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
        Printer.SetTextModeX(1);//设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("医保取号正式结算失败");
        Printer.LFX(2); //多行送纸
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("  ID    号：" + window.parent.brid00);
        Printer.WriteTextLineX("  费用总额：" + $.session.get("grzfe0") + "元");
        //Printer.WriteTextLineX("  收费记录流水号：" + sflsh0);
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
        Printer.WriteTextLineX("  平台请求流水：" + $.session.get("ptqqls"));
        Printer.WriteTextLineX("  平台订单流水：" + $.session.get("ptddls"));
        Printer.WriteTextLineX("  交易流水：" + $.session.get("jylsh0"));
        Printer.WriteTextLineX("  结算收据：" + $.session.get("ricpsn"));
        Printer.SetFontModeAndTypeX(0x08, 0x00);
        Printer.SetTextModeX(1); //设置中文模式
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
        Printer.WriteTextLineX("  如需退费或打印发票，请到四楼人工窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
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

    //解析医保动态库预结算返回的报文
    function analyzeYbXml(ybxml) {
		$("#jz").show();
        var datas = {
            funcid:"M07.02.19.02",
            dllmethod:"GhJieSuan",
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
				$("#jz").hide();
                var Data = eval(json);
                if (Data.retcode == "0"){
                 $.session.set("GRZFE0",Data.retbody[0].grzfe0);//个人支付额
                    $.session.set("JJZFE0",Data.retbody[0].jjzfe0);//基金支付额
                    $.session.set("ghlsh0",Data.retbody[0].ghlsh0);//挂号流水号
                    $.session.set("zhzfe0",Data.retbody[0].zhzfe0);//账户支付额

                    window.parent.czsucc=0;
                    window.location.href = "qhsucc.jsp";
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
		$("#jz").hide();
                var Data = eval(json);
                $("#tip_div").show();
                $("#error").text(Data.retmsg);
                $("#tip_s").on("click", function () {
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }

    //静默发送数据到后台
    function analyzeYbXml1(ybxml) {
        $("#jz").show();
        var datas = {
            funcid: "M07.02.19.02",
            dllmethod: "GhJieSuan",
            ybgetx: ybxml
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


    //获取患者预约记录
    function QueryLog() {
        $("#jz").show();
        var datas = {
            "funcid": "M07.02.04.08",
            "mzlxbh": "",
            "ksrq00": "",
            "jzrq00": "",
            "cxfs00": "",
            "cxdm00": "",
            "yyzt00":"1",
            "brid00": "",
            "sfzhao": window.parent.sfzhao,
            "yyzt00":"1"
        };

        $.ajax({
            async: true,
            type: "post",
            data: datas,
            //url : "${pageContext.request.contextPath}/Test/test.do",
            url: window.parent.serverUrl + "?method=ApplyAction",
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: datas,
            dataType: "json",
            success: function (data) {
                $("#jz").hide();
                Data = eval(data);
                if (Data.retcode == "0") {
                    if (Data.retbody.length > 0) {
                        for (var i = 0; i < Data.retbody.length; i++) {
                            $("#infoBody").append(
                                "<tr style=\"width:1050px;height:60px;border:1px solid black;margin:10px\">"
                                + "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].mzksmc + "</td>"
                                + "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].mzysxm + "</td>"
                                + "<td style=\"width:200px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].yysj00.substr(0, 4) + "年" + Data.retbody[i].yysj00.substr(5, 2) + "月" + Data.retbody[i].yysj00.substr(8, 2) + "日" + "</td>"
                                + "<td style=\"width:200px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].yysj00.substr(0, 2) + ":" + Data.retbody[i].yysj00.substr(2, 2) + "—" + Data.retbody[i].yysj00.substr(0, 2) + ":" + Data.retbody[i].yysj00.substr(2, 2) + "</td>"
                                // + "<td style=\"width:240px;border:1px solid black;font-size:35px;text-align:center\">" + Data.retbody[i].ghzfy0 + "元" + "</td>"
                                + "<td style=\"width:160px;border:1px solid black;font-size:35px;text-align:center\">"
                                + "<button " + "id='s" + i + "' height='60px' width='60px' onclick='getxxInfo(this)'>" + "取号" + "</button>"
                                + "</td>"
                                + "</tr>")
                        }
                        ;page = new Page(5, "idData", "infoBody");
                    } else {
                        $("#tip_div").show();
                        $("#error").text("无需要取号的记录");
                        $("#tip_s").on("click", function () {
                            $("#tip_div").hide();
                            if (typeof($.session) != "undefined"){
                                $.session.clear();
                            }
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                        });
                    }
                } else {
                    $("#detai").hide();
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        if (typeof($.session) != "undefined"){
                            $.session.clear();
                        }
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#jz").hide();
                ("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    if (typeof($.session) != "undefined"){
                        $.session.clear();
                    }
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });
    }


    function getxxInfo(obj) {
        var mzysbh = Data.retbody[parseFloat(obj.id.substr(1, 1))].mzysbh;
        $.session.set('mzysbh', mzysbh);
        var mzysxm = Data.retbody[parseFloat(obj.id.substr(1, 1))].mzysxm;
        $.session.set('mzysxm', mzysxm);
        var mzksmc = Data.retbody[parseFloat(obj.id.substr(1, 1))].mzksmc;
        $.session.set('mzksmc', mzksmc);
        mzksbh = Data.retbody[parseFloat(obj.id.substr(1, 1))].mzksbh;
        $.session.set('mzksbh', mzksbh);
        //预约时间
        var yysj00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].yysj00;
        //上下午
        var wbmc00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].wbmc00;
        $.session.set("wbmc00",wbmc00);
        $.session.set('yysj00', yysj00);
        ghhb00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].ghhb00;
        $.session.set('ghhb00', ghhb00);//???
        ghlx00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].ghlx00;
        $.session.set('ghlx00', ghlx00);
        ghsj00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].ghsj00;
        $.session.set('ghsj00', ghsj00);
        pbbh00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].pbbh00;
        $.session.set('pbbh00', pbbh00);
        //排班时间明细id
        yylsh0 = Data.retbody[parseFloat(obj.id.substr(1, 1))].yylsh0;
        $.session.set('yylsh0', yylsh0);

        hbmc00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].hbmc00;
        $.session.set('hbmc00', hbmc00);
        //排队序号
        pdxh00 = Data.retbody[parseFloat(obj.id.substr(1, 1))].pdxh00;
        $.session.set('pdxh00', pdxh00);

        var yyrq00 = yysj00.split(" ")[0];
        var yysj01 = yysj00.split(" ")[1];

        document.getElementById("yyks").value = mzksmc; //挂号科室
        document.getElementById("yyys").value = mzysxm; //医生姓名
        document.getElementById("yyrq").value = yysj01; //预约日期
        document.getElementById("yysj").value = yysj00; //預約时间段
        //document.getElementById("ghfy").value = ghzfy; //费用
        $("#detail").hide();
        $("#qh_div").show();
        //确认预约信息后的确认按钮
        $("#qh_s").on("click", function () {
            $("#qh_div").hide();
            yjs();
        });
        //确认预约信息后的取消按钮
        $("#qh_c").on("click", function () { //点击取消返回预约信息列表
            $("#qh_div").hide();
            $("#detail").show();
        });
    };

    /*
    自费预约取号(挂号预结算)
     */
    function yjs() {
        $("#jz").show();
        var datas = ({
            "funcid": "M07.02.04.10",
            "cxfs00": window.parent.cardtype,
            "cxdm00": window.parent.cardNo,
            "brid00": window.parent.brid00,
            "yyxh00": "",
            "dlid00": "",
            "mzksbh": $.session.get('mzksbh'),
            "mzksmc": $.session.get('mzksmc'),
            "mzysxm": $.session.get('mzysxm'),
            "ghhb00": $.session.get('ghhb00'),
            "yysj00": $.session.get('yysj00'),      //预约时间
            "ghlx00": ghlx00,
            "ghsj00": ghsj00,
            "pbbh00": pbbh00,
            "yylsh0": yylsh0,
            "xzbs00": "",
            "yllb00": "",
            "akc190": ""
        });
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url : "${pageContext.request.contextPath}/Test/test.do",
            success: function (json) {
                $("#jz").hide();
                Data2 = eval(json);
                if (Data2.retcode == "0") {
                    //跳转到支付页面
                    window.parent.money = Data2.retbody[0].grzfe0;
                    //将单据流水号放入session 中去
                    var djlsh0 = Data2.retbody[0].djlsh0;
                    var zhzfe0 = Data2.retbody[0].zhzfe0;
                    var jjzfe0 = Data2.retbody[0].jjzfe0;
                    //上下午
                    var ghsj = Data2.retbody[0].ghsj00;

                    $.session.set("djlsh0", djlsh0);
                    $.session.set("zhzfe0",zhzfe0);
                    $.session.set("jjzfe0",jjzfe0);
                    window.parent.cztype = 2;
                    window.location.href = "${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                }else if(Data2.retcode=="-1"){
                    //当前号已完成挂号，预约流水号
                    $("#tip_div").show();
                    $("#error").text(Data2.retmsg);
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        window.history.go(0);
                        //window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                } else {
                    //当前号已完成挂号
                    var errorMsg = Data2.retmsg.split("，")[0];
                    $("#tip_div").show();
                    $("#error").text(errorMsg);
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        if (typeof($.session) != "undefined"){
                            $.session.clear();
                        }
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("交易异常,请稍后再试");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    if (typeof($.session) != "undefined"){
                        $.session.clear();
                    }
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        });

    }

    /*
    自费预约取号（挂号正式结算）
     */
    function zsjs() {
        $("#jz").show();
        var datas = {
            "funcid": "M07.02.04.11",
            "cxdm00": window.parent.cardNo,
            "cxfs00": window.parent.cardtype,
            "brid00": window.parent.brid00,
            "mzksbh": $.session.get('mzksbh'),
            "mzksmc": $.session.get('mzksmc'),
            "mzysbh": $.session.get('mzysbh'),
            "mzysxm": $.session.get('mzysxm'),
            "isvj00": "",//是否为专家
            "yysj00": $.session.get('yysj00'),
            "ghsj00": $.session.get('ghlx00'),
            "ghhb00": $.session.get('ghhb00'),
            "pbbh00": $.session.get('pbbh00'),
            "yylsh0": $.session.get('yylsh0'),
            "xzbs00": "",//险种标识
            "yllb00": "",//医疗类别
            "akc190": "",//医保登记号
            "grzfe0": window.parent.money,//个人支付额
            "ptqqls": $.session.get('ptqqls'),
            "jyzflx": "ONE_QR",
            "djlsh0": $.session.get("djlsh0")
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

                    var GRZFE0 = Data.retbody[0].grzfe0;
                    var AKC190 = Data.retbody[0].akc190;
                    var ghlsh0 = Data.retbody[0].ghlsh0;
                    var ddrs00 = Data.retbody[0].ddrs00;
                    var lxdh00 = Data.retbody[0].lxdh00;
                    var JSSFRQ = Data.retbody[0].jssfrq;
                    var djlsh0 = Data.retbody[0].djlsh0;


                    $.session.set("GRZFE0",GRZFE0);
                    $.session.set("AKC190",AKC190);
                    $.session.set("ghlsh0",ghlsh0);
                    $.session.set("ddrs00",ddrs00);
                    $.session.set("lxdh00",lxdh00);
                    $.session.set("JSSFRQ",JSSFRQ);
                    $.session.set("djlsh0",djlsh0);
                    window.parent.czsucc=0;
                    window.location.href = "qhsucc.jsp";
                } else {
                    //交易失败，打印失败条
                    print2();
                    $("#tip_div").show();
                    $("#error").text("挂号失败,请取凭条!");
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        if (typeof($.session) != "undefined"){
                            $.session.clear();
                        }
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function (json) {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("挂号失败,请取凭条!");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                    if (typeof($.session) != "undefined"){
                        $.session.clear();
                    }
                    window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                });
            }
        })
    }



    function getBridInfo() {
        var datas = {
            "funcid": "M07.02.01.02",
            "yyjgdm": "",
            "cxdm00": window.parent.cardNo,
            "cxfs00": window.parent.cardtype,
            "sfybye": ""
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
                Data = eval(json);
                if (Data.retcode == "0") {
                    window.parent.sfykt0 = Data.retbody[0].sfykt0;
                    window.parent.pin000 = Data.retbody[0].pin000;
                    window.parent.lxdh00 = Data.retbody[0].lxdh00;
                    window.parent.xming0 = Data.retbody[0].xming0;
                    window.parent.csrq00 = Data.retbody[0].csrq00;
                    window.parent.yjjye0 = Data.retbody[0].yjjye0;
                    window.parent.brid00 = Data.retbody[0].brid00;
                    window.parent.brnl00 = Data.retbody[0].brnl00;
                    window.parent.xbie00 = Data.retbody[0].xbie00;
                    window.parent.ynzhye = Data.retbody[0].ynzhye;
                    window.parent.bryblb = Data.retbody[0].bryblb;
                    window.parent.jzhsfjd = Data.retbody[0].jzhsfjd
                    window.parent.zdbh00 = Data.retbody[0].zdbh00;
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }

            },
            error: function () {
                alert("系统异常，请稍后再试！");
            }
        });
    }


    function print() {
        var Printer = window.parent.KPrinter; //打印机
        $("#printtip").show();
        Printer.SetFontModeAndTypeX(0x20, 0x01); //设置字体
        Printer.SetTextModeX(2); //设置中文模式
        Printer.WriteTextLineX("吉林大学白求恩第一医院");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  预约取号成功");
        Printer.WriteTextLineX("");
        Printer.SetFontModeAndTypeX(0x20, 0x00); //设置字体
        Printer.WriteTextLineX("  就诊卡号：" + window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  卡内余额：" + window.parent.yjjye0 + "元");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  预约科室：" + $.session.get('ksmc11'));
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  预约医生：" + $.session.get('ysxm11'));
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  预约日期：" + $.session.get('yyrqP'));
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  预约时间：" + $.session.get('yysjP'));
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  就诊地点：" + jzwz00);
        Printer.WriteTextLineX("");
        /* Printer.WriteTextLineX("  排队序号："+pdxh00);
        Printer.WriteTextLineX(""); */
        Printer.WriteTextLineX("  挂号费用：" + $.session.get('printghf') + "元");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  特殊费用：" + $.session.get('printtsf') + "元");
        Printer.WriteTextLineX("");
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：请持卡到相应分诊台签到，确定排队序号。");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补，如需退号或打印发票，请到收款处窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }

    function print2() {
        var Printer = window.parent.KPrinter; //打印机
        $("#printtip").show();
        Printer.SetFontModeAndTypeX(0x20, 0x01); //设置字体
        Printer.SetTextModeX(2); //设置中文模式
        Printer.WriteTextLineX("河北北方学院附属第一医院");
        Printer.WriteTextLineX("  预约取号失败");
        Printer.WriteTextLineX("");
        Printer.PrintBarCodeX(73,100,4,window.parent.brid00);
        Printer.SetFontModeAndTypeX(0x20, 0x00); //设置字体
        Printer.WriteTextLineX("  就诊卡号：" + window.parent.brid00);
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  患者姓名：" + window.parent.xming0);
        Printer.WriteTextLineX("");
	Printer.WriteTextLineX("  终端编号：" + $.session.get("zdbh00"));//终端编号
	Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  平台请求流水号：" + $.session.get('ptqqls'));
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  平台订单流水号：" + $.session.get('ptddls'));
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  交易流水号：" + $.session.get('jylsh0'));
        Printer.WriteTextLineX("");
        Printer.LFX(2); //多行送纸
        Printer.SetTextModeX(1); //设置中文模式
        Printer.WriteTextLineX("  注  意：请持此小票前往四楼人工窗口进行退费。");
        Printer.WriteTextLineX("");
        Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补，如需退号或打印发票，请到收款处窗口办理。");
        Printer.LFX(3); //多行送纸
        Printer.CeTCutX(); //切纸
    }

    
  

    $("#pre").bind("click dbclick", function () {
        window.history.go(-1);
    });
    $("#main").bind("click dbclick", function () {
        if (typeof($.session) != "undefined"){
            $.session.clear();
        }
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });

    //查询门诊待缴费信息记录
    function getJSInfo() {
        var datas = {
            "funcid": "M07.02.05.01",
            "cxfs00": window.parent.cardtype,
            "cxdm00": window.parent.cardNo,
            "brid00": window.parent.brid00,
            "sfybye": ""
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
                Data = eval(json);
                print();
                if (Data.retcode == "0") {
                    if (Data.retbody.length != "0") {
                        for (var i = 0; i < Data.retbody.length; i++) {
                            fyjsxx += "#" + Data.retbody[i].sqdbh0 + "@" + Data.retbody[i].jzid00
                        }
                        ;
                        mzfyze = Data.retbody[0].mzfyze; //门诊费用总额
                        jzid = Data.retbody[0].jzid00;   //就诊ID
                        sqdbh = Data.retbody[0].sqdbh0;  //申请单编号
                        //fyjsxx="#"+sqdbh+"@"+jzid;
                        getBridInfo();
                        mzjiesuan();
                    } else {
                        tfje = $.session.get('printtsf');
                        tsxx = "取号成功，结算特殊费用失败，已原途径退费。失败原因：" + Data.retmsg;
                        tsxx2 = "取号成功，结算特殊费用失败，退费失败，请前往窗口退费";
                        sbtf();
                    }

                } else {
                    tfje = $.session.get('printtsf');
                    tsxx = "取号成功，结算特殊费用失败，已原途径退费。失败原因：" + Data.retmsg;
                    tsxx2 = "取号成功，结算特殊费用失败，退费失败，请前往窗口退费";
                    sbtf();
                    //log.WriteLog("获取结算信息失败");
                }
            },
            error: function () {
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
            }
        });
    }

    //自费结算
    function mzjiesuan() {
        //log.WriteLog("卡号:"+carNo+"开始自费结算");
        var datas = {
            "funcid": "M07.02.05.03",
            "cxdm00": window.parent.cardNo,
            "cxfs00": window.parent.cardtype,
            "fyjsxx": fyjsxx,
            "brid00": window.parent.brid00,
            "passwd": pin000,
            "pin000": pin000,
            "sfybye": "0",
            "mzfyze": mzfyze,
            "count0": "",
            "xming0": xming0,
            "xbie00": window.parent.xbie00,
            "csrq00": window.parent.csrq00,
            "yjjye0": window.parent.yjjye0,
            "brnl00": window.parent.brnl00,
            "sfykt0": window.parent.sfykt0,
            "ynzhye": window.parent.ynzhye,
            "jzid00": jzid,
            "zffs00": "1",
            "sffs00": window.parent.sffs,
            "ptqqls": window.parent.ptqqls
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
                Data = eval(json);
                if (Data.retcode == "0") {
                    $("#tip_div").show();
                    $("#error").text("取号成功");
                    $("#tip_s").on("click", function () {
                        $("#tip_div").hide();
                        if (typeof($.session) != "undefined"){
                            $.session.clear();
                        }
                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                } else if (Data.hissbbz == "1") {
                    tfje = $.session.get('printtsf');
                    tsxx = "取号成功，结算特殊费用失败，已原途径退费。失败原因：" + Data.retmsg;
                    tsxx2 = "取号成功，结算特殊费用失败，退费失败，请前往窗口退费";
                    sbtf();
                } else {
                    //log.WriteLog("卡号:"+carNo+"自费结算失败");
                    $("#tip_div").show();
                    $("#error").text("取号成功，结算费用失败");
                    $("#tip_s").on("click", function () {

                        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
                    });
                }
            },
            error: function () {
                $("#tip_div").show();
                $("#error").text("系统异常，请稍后再试！");
            }
        });
    }

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
        this.rowCount = 0; //记录数
        this.pageCount = 0; //页数
        this.pageIndex = 0; //页索引
        this.__oTable__ = null; //表格引用
        this.__oTBody__ = null; //要分页内容
        this.__dataRows__ = 0; //记录行引用
        this.__oldTBody__ = null;
        this.__init__(); //初始化;
    }
    ;
    /*
    初始化
    */
    Page.prototype.__init__ = function () {
        this.__oTable__ = document.getElementById(this.tableId); //获取table引用
        this.__oTBody__ = this.__oTable__.tBodies[this.tBodyId]; //获取tBody引用
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
    init();
</script>
</html>

