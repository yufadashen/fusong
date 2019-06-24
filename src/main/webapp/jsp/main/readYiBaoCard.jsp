<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>读医保卡</title>
    <object id="AVFOCX" classid="clsid:28DF5A67-DFD2-4309-97E9-0601C4C54411" width="0" height="0">
        <param name="s1" value=""/>
    </object>
    <object width="0" height="0" id="AVFOCXLOG"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <script language="javascript" src="DriverJS/json2.js"></script>
    <!-- <script language="javascript" src="DriverJS/ReceiptPrinter.js"></script> -->
    <meta http-equiv="X-UA-Compatible" content="IE=8"> <!--以IE8模式渲染-->
    <meta http-equiv="X-UA-Compatible" content="IE=7"> <!--以IE7模式渲染-->
    <style>
        body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url(${pageContext.request.contextPath}/images/cybk.gif) no-repeat;
        }
    </style>
</head>

<body scroll=no>
<!-- 显示返回主页面倒计时时间 -->
<div id="time" style="position:absolute;top:20px;right:40px;font-size:60px;color: #FF0000;">
</div>
<div id="word" style="width:100%;z-index:60;position:absolute;top:200px;">
		<span  style="width:100%;font-size:60px;text-align:center;color:red">请插入医保卡</span>
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
<%--<div style="text-align:center;position:absolute;top:782px;left:400px;">
    <span style="font-size:40px;color:#EE7700;"><strong>卡号:</strong></span>
    <input id="ewm" style="width:350px;height:40px;font-size:30px;">
</div>--%>
<div id="main" style="position: absolute;top:870px;left:450px;">
    <img src="${pageContext.request.contextPath}/images/main.png" res_img="${pageContext.request.contextPath}/"
         height="" width=""/>
</div>
<div id="next" style="position: absolute;top:870px;left:650px;">
    <img src="${pageContext.request.contextPath}/images/pre.png" res_img="${pageContext.request.contextPath}/" height=""
         width=""/>
</div>
<div id="main_box" style="text-align:center;">
    <div id="pay" style="display:block;margin-top:300px;">
        <%--<img src="${pageContext.request.contextPath}/images/queding.png" res_img="${pageContext.request.contextPath}/queding1.png" height="" width=""/>--%>
    </div>
</div>
<%--进度条logo--%>
<div id="jz" style="width:1280px;height:800px;backgroud-corlor:red;position:absolute;top:0px;left:0px;z-index:100;">
    <img src="${pageContext.request.contextPath}/images/huanchong.gif" height="300" width="300" 
         style="position: absolute;top:320px;left:490px;"/>
    <br><span style="font-size:50px;color:#EE7700;position: absolute;top:620px;left:420px;">正在加载请稍后......</span>
</div>
</body>
<script language="javascript">
    //初始化倒计时时间：60秒
    var time = window.parent.reTime;
    var ybflag = false;//医保返回标志
    var ybxml;
    var yibao = window.parent.yiBao;

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

    //定时器读取医保卡,如果医保返回true,就不再执行定时器
    function readCard() {
        if (ybflag == true) {
            if (type == 1) {
                window.location.href = "${pageContext.request.contextPath}/jsp/mzgh/ybgh.jsp";
            } else if (type == 2) {
                window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/ybyy.jsp";
            } else if (type == 3) {
                window.location.href = "${pageContext.request.contextPath}/jsp/mzjs/ybjs.jsp";
            }
        }else{
            setTimeout("testYb();",1000)
        }

        //analyzeYbXml();
    }

    $("#main").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
    });
    $("#next").bind("click dbclick", function () {
        window.location.href = "${pageContext.request.contextPath}/jsp/main/IsEmployeeOrCivilian.jsp";
    });

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

    //获取调用动态库需要医保报文
    function testYb() {

    	$("#jz").show();
        var datas = {
            funcid: "M07.02.19.01",
            ybsflx: window.parent.ybsflx,
            dllmethod: "ReadCardTrade",
            yllb00: "11"
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
                var Data = eval(json);
                if (Data.retcode == "0") {
                    //获得调用医保动态库所需要的报文xml
                    ybxml = convertFromXml(Data.retbody[0].ybreqx);
                    var readCardResult = yibao.ReadCard(ybxml,40000);
                    $("#jz").hide();
			
                    if(readCardResult.substring(0,1)=='0'){
                    	var s = readCardResult.substring(readCardResult.indexOf('<?xml'),readCardResult.indexOf('</result></root>')+16)
                        analyzeYbXml(s);
                    }else{
			//发送错误信息到后台
			analyzeYbXml1(readCardResult);

			//取日志信息提示具体错误
			var dataOtherAnalyze = readCardResult.substring(readCardResult.indexOf('ERROR="')+7,readCardResult.indexOf('|'));
                    	$("#tip_div").show();
                        //$("#error").text("请检查是否插入医保卡或者医保卡被锁定");
			$("#error").text(dataOtherAnalyze);
                        $("#tip_s").on("click", function () {
                            window.location.href = "${pageContext.request.contextPath}/jsp/main/readYiBaoCard.jsp";
                        });
                    }
                    
                    
                }else{
                    $("#tip_div").show();
                    $("#error").text("请稍后再试");
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

    //解析医保动态库返回的报文
    function analyzeYbXml(ybxml) {
        var datas = {
            funcid:"M07.02.19.02",
            dllmethod:"ReadCardTrade",
            ybgetx:ybxml
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
                    ybflag = true;
                    window.parent.cardNo = Data.retbody[0].cxdm00;
                    window.parent.cardtype = 0; //0代表 为医保卡
                    //判断是否在HIS建档
                    var csrq=Data.retbody[0].csrq00;
                    if(csrq.substring(4,5)!="-"){
                    	csrq=csrq.substring(0,4)+"-"+csrq.substring(4,6)+"-"+csrq.substring(6,8)
                    }
                    $.session.set('sfzhao', Data.retbody[0].sfzhao);
                    $.session.set('xming0', Data.retbody[0].xming0);
                    $.session.set('xbie00', Data.retbody[0].xbie00);
                    $.session.set('rylb00', Data.retbody[0].rylb00);
                    $.session.set('csrq00', csrq);
                    pdjd();
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
	
    //静默将数据发送到后台(读卡失败的时候)
    function analyzeYbXml1(ybxml) {
        var datas = {
            funcid: "M07.02.19.02",
            dllmethod: "ReadCardTrade",
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
            success: function (json) {

            },
            error: function (json) {

            }
        });
    }


    
    function pdjd(){
        var datas = {"funcid":"M07.02.02.01",
        	"sfhqkh":"2",
            "cxdm00":window.parent.cardNo,
            "cxfs00":window.parent.cardtype};
        $.ajax({
            async:true,
            type:"post",
            data:datas,
            dataType:"json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success:function(json){
                $("#jz").hide();
                Data = eval(json);
                if(Data.retcode == "0"){
                    var brid=Data.retbody[0].brid00;//患者id
                   if(brid==""|| brid==undefined){
                	   window.location.href="${pageContext.request.contextPath}/jsp/main/YiBaophone.jsp";
                   }else{
                	   getBridInfo();  
                   }
                    

                }else{
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }

            },
            error:function(){
                alert("系统异常，请稍后再试！");
                $("jz").hide();
            }
        });
    }
    
    
    function getBridInfo(){
        var datas = {"funcid":"M07.02.01.02",
            "cxdm00":window.parent.cardNo,
            "cxfs00":window.parent.cardtype};
        $.ajax({
            async:true,
            type:"post",
            data:datas,
            dataType:"json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            //url:"${pageContext.request.contextPath}/Test/test.do",
            success:function(json){
                $("#jz").hide();
                Data = eval(json);
                if(Data.retcode == "0"){
                    window.parent.brid00=Data.retbody[0].brid00;//患者id
                    window.parent.xming0=Data.retbody[0].xming0;//姓名
                    window.parent.xbie00=Data.retbody[0].xbie00;//性别
                    window.parent.brnl00=Data.retbody[0].brnl00;
                    window.parent.csrq00=Data.retbody[0].csrq00;//出生日期
                    window.parent.yjjxh0=Data.retbody[0].yjjxh0;//
                    window.parent.yjjye0=Data.retbody[0].yjjye0;
                    window.parent.sfzhao=Data.retbody[0].sfzhao;//身份证号
                    window.parent.lxdh00=Data.retbody[0].lxdh00;//联系电话
                    if(Data.retbody[0].sfzhao==""){
                        //如果查出来的患者信息身份证号为空，则跳转到读身份证页面
                        window.location.href="${pageContext.request.contextPath}/jsp/main/readIdcard.jsp";
                    }else{
                        var type=window.parent.ttype;
                        if(type==1){
                            window.location.href="${pageContext.request.contextPath}/jsp/main/main1.jsp";
                        }else if(type==2){
                            window.location.href="${pageContext.request.contextPath}/jsp/mzyy/mzyy.jsp";
                        }else if(type==3){
                            window.location.href="${pageContext.request.contextPath}/jsp/mzjs/mzjs.jsp";
                        }else if(type==5){
                            window.location.href="${pageContext.request.contextPath}/jsp/pay/payway.jsp";
                        }else if(type==6){
                            //window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
                        }else if(type==7){
                            //window.location.href="${pageContext.request.contextPath}/jsp/yyqh/yyqh.jsp";
                        }else if(type==8){
                            window.location.href="${pageContext.request.contextPath}/jsp/main/xxcx.jsp";
                        }else if(type==9){
                            //就诊记录查询:缴费记录，预约挂号记录
                            window.location.href="${pageContext.request.contextPath}/jsp/jzjlcx/jzjlcxMenu.jsp";
                        }else if (type == 10) {
                            //病历单打印
                            window.location.href = "${pageContext.request.contextPath}/jsp/printOf/infohomeLis.jsp";
                        }
                    }

                }else{
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }

            },
            error:function(){
                alert("系统异常，请稍后再试！");

                $("jz").hide();
            }
        });
    }

    readCard();
</script>
</html>
