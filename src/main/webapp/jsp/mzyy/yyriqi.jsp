<%@ page language="java" import="java.util.*" contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <object width="0" height="0" id="AVFOCX"
            classid="clsid:83B1BDC2-E546-4910-9E05-8B352F3FD5BA"></object>
    <title>门诊预约</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <script src="${pageContext.request.contextPath}/js/easing.js"></script>
    <script src="${pageContext.request.contextPath}/js/stepBar.js"></script>
    <link href="${pageContext.request.contextPath}/css/control.css" rel="stylesheet" media="all">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>
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
     style="display:none;width:90%;height:110px;position:absolute;top:290px;left:57px;background-color:#f7fcff">
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
                    <p class="ui-stepName">预约成功</p></td>
            </tr>
        </table>
    </div>
</div>
<div id="stepByRiqi" class="ui-stepBar-wrap"
     style="display:none;width:90%;height:100px;position:absolute;top:290px;left:57px;background-color:#f7fcff">
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
                    <p class="ui-stepName">预约成功</p></td>
            </tr>
        </table>
    </div>
</div>
<div id="tip_div"
     style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:312px;top:465px;">
    <div id="tip_divInfo" style="text-align:center;position:relative;top:82px">
        <span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
    </div>
    <img id="tip_s" src="${pageContext.request.contextPath}/images/qdmix.png"
         width="90" height="43" style="position:relative;top:145px;left:4px"/>
</div>
<div id="word" style="width:100%;z-index:60;position:absolute;top:1340px;">
    <span style="width:100%;font-size:40px;text-align:center">请选择日期，预约时间为未来2-7天</span>
</div>
<div style="z-index:60;position:absolute;top:195px;left:480px;">
    <img id="title"
         src="${pageContext.request.contextPath}/images/ghtitle.png"/>
</div>
<%--显示这个div--%>
<div id="riqi" class="boxshaw" style="position:absolute;top:410px;left:70px;display:none">
</div>
<div id="riqi2" class="boxshaw" style="position:absolute;top:310px;left:70px;display:none">
    <div id="nextday1"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
    <div id="nextday2"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
    <div id="nextday3"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
    <div id="nextday4"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
    <div id="nextday5"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
    <div id="nextday6"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
    <div id="nextday7"
         style="width:190px;height:100px;float:left;margin-bottom:30px;margin-right:30px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:22px;display:inline-block"
         onclick="yyriqi2(this)"></div>
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
<div id="confirmSpan" style="top: 120px;left: 460px;"> <span style="color: red;font-size: 35px;top:150px;left:210px;display:block;position:absolute;">当天11：30后不能挂上午的号，17：00后不能挂下午的号</span> </div>
</body>
<script type="text/javascript">
    var cardNo = window.parent.cardNo;//卡号
    var xming0 = window.parent.xming0;//患者名称
    var xbie00 = window.parent.xbie00;//患者性别
    var csrq00 = window.parent.csrq00;//出生日期
    var brnl00 = window.parent.brnl00;//病人年龄
    var brid00 = window.parent.brid00;//病人ID
    var yjjye0 = window.parent.yjjye0;//预交金余额（结算金额使用）
    var ynzhye = window.parent.ynzhye;//院内账户余额
    var cxfs00 = window.parent.cardtype; //卡类型 ：01(自费卡) 、  02    、5
    var yydate;//选择日期
    var riqi = ""; //预约日期
    var fssj00;//开始时间
    var jssj00;//结束时间
    var pbbz00 = $.session.get('pbbz00');   //类型标志:非1表示按科室排序  1代表:获取yyrq00的值，根据预约日期来获取和显示科室信息
    //var pbbz00="1";
    var log = document.getElementById("AVFOCX");
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
        $("#stepByKeshi").show();
        $(function () {
            stepBar.init("stepByKeshi", {
                step: 3,
                change: false,
                animation: false
            });
        });
        limitRiqi();
        getRqListByKs();
    }

    function limitRiqi() {
        var startdate = new Date();
        var year = startdate.getFullYear();
        var month = startdate.getMonth() + 1;
        if (month < 10) {
            month = "0" + month;
        }
        var day = startdate.getDate() + 1;
        if (day < 10) {
            day = "0" + day;
        }
        fssj00 = year + "" + month + "" + day + "000000.000";
        var enddate = new Date();
        var year2 = parseInt(startdate.getFullYear());
        var month2 = parseInt(startdate.getMonth()) + 1;
        var day2 = parseInt(startdate.getDate()) + 7;
        jssj00 = year2 + "" + month2 + "" + day2 + "235900.000";
    }

    function yyriqi2(obj) {
        //点击日期之后，将进入此方法
        var temp1 = $(obj).text().split("年")[0];
        var temp2 = $(obj).text().split("年")[1].split("月")[0];
        if (temp2.length == "1") {
            temp2 = "0" + temp2;
        }
        var temp3 = $(obj).text().split("月")[1].split("日")[0];
        if (temp3.length == "1") {
            temp3 = "0" + temp3;
        }
        yydate = temp1 + temp2 + temp3;

        $.session.set('riqi', yydate);

        //跳转到选择 时间页面
        window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yytime.jsp";
    }


    //获取时间格式为 yyyy-mm-dd
    function format(Date) {
        var Y = Date.getFullYear();
        var M = Date.getMonth() + 1;
        M = M < 10 ? '0' + M : M;// 不够两位补充0
        var D = Date.getDate();
        D = D < 10 ? '0' + D : D;
        // var H = Date.getHours();
        // H = H < 10 ? '0' + H : H;
        // var Mi = Date.getMinutes();
        // Mi = Mi < 10 ? '0' + Mi : Mi;
        // var S = Date.getSeconds();
        // S = S < 10 ? '0' + S : S;
        //return Y + '-' + M + '-' + D + ' ' + H + ':' + Mi + ':' + S;
        return Y + '-' + M + '-' + D;
    }

     function formatWithHMS(Date) {
        var Y = Date.getFullYear();
        var M = Date.getMonth() + 1;
        M = M < 10 ? '0' + M : M;// 不够两位补充0
        var D = Date.getDate();
        D = D < 10 ? '0' + D : D;
        var H = Date.getHours();
        H = H < 10 ? '0' + H : H;
        var Mi = Date.getMinutes();
        Mi = Mi < 10 ? '0' + Mi : Mi;
        var S = Date.getSeconds();
        S = S < 10 ? '0' + S : S;
        return H + ':' + Mi;

    }


    function getRqListByKs() {
        //请求 获取预约日期，测试只入参时间格式为 yyyy-mm-dd
        var temp = format(new Date());
        var datas = {
            "funcid": "M07.02.04.05",
            "mzksbh": $.session.get('ksid00'),
            "mzysbh": $.session.get('mzysbh'),
            "kssj00": temp,
            "jssj00": temp,
            // "kssj00": window.parent.dateTimeNow,
            // "jssj00": window.parent.dateTimeTonight,
            "yywbmc": "",
            "sfxsqb": "1",
            "dqcxy0": "",
            "pageSize": ""
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
                    for (var i = 0; i < Data.retbody.length; i++) {
                        if (Data.retbody[i].yywbmc == "a") {
                            //11：30后不显示上午的号，17：00后不显示下午的号
                            $("#riqi").append(
                                "<div style=\"width:180px;height:155px;float:left;margin-bottom:30px;margin-right:10px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:15px;font-weight: 900;display:inline-block\" value=\"" + Data.retbody[i].pbid00 +"&"+ Data.retbody[i].yywbmc + "\" onclick=\"yyriqi(this)\">"
                                + "<span>" + "<br>诊查费用:<br>" + Data.retbody[i].ghfy00 + "</span><br>"
                                + "<span >" + "<br>就诊日期:<br>" + Data.retbody[i].yyrq00 + " 上午" + "</span><br>"
                                + "<span style='color:#FF0000'>" + "<br>剩余号源:<br>" + Data.retbody[i].syghs0 + "</span><br>"
                                + "</div>"
                            );
                            $.session.set("yyrq00", Data.retbody[i].yyrq00);
                        } else if (Data.retbody[i].yywbmc == "p") {
                            //预约时间为下午
                            $("#riqi").append(
                                "<div style=\"width:180px;height:155px;float:left;margin-bottom:30px;margin-right:10px;border:1px solid #000;background-color:#B4EEB4;text-align:center;font-size:15px;font-weight: 900;display:inline-block\" value=\"" + Data.retbody[i].pbid00 +"&"+ Data.retbody[i].yywbmc + "\" onclick=\"yyriqi(this)\">"
                                + "<span>" + "<br>诊查费用:<br>" + Data.retbody[i].ghfy00 + "</span><br>"
                                + "<span>" + "<br>就诊日期:<br>" + Data.retbody[i].yyrq00 + " 下午" + "</span><br>"
                                + "<span style='color:#FF0000'>" + "<br>剩余号源:<br>" + Data.retbody[i].syghs0 + "</span><br>"
                                + "</div>"
                            );
                            $.session.set("yyrq00", Data.retbody[i].yyrq00);
                        }
                    }
                    $("#riqi").show();

                } else if (Data.retcode == "-1") {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                } else {
                    $("#tip_div").show();
                    $("#error").text(Data.retmsg);
                }
            },
            error: function () {
                $("#jz").hide();
                $("#tip_div").show();
                $("#error").text("系统异常,请稍后再试!");
            }
        });
    }

    //进入日期选择页面
    function yyriqi(obj) {
    	var formatWithHMS1 = formatWithHMS(new Date());
        var hours = formatWithHMS1.split(":")[0];//小时
        var minuise = formatWithHMS1.split(":")[1];//分钟
        yydate = $(obj).text().split(":")[2];
        var pbid = $(obj).attr("value").split("&")[0];
        var yywbmc = $(obj).attr("value").split("&")[1];
        var daten = new Date();
		var dayn = daten.getDay();//周日值为 0
		var b=true;
		if((yywbmc=="a" && hours>12) || (yywbmc=="a" && (hours==11 &&minuise>30))){
			b=false;
			$("#tip_div").show();
            $("#error").text("上午11:30后不可继续挂上午号！");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
            });
		}
		if(yywbmc=="p" && hours>17){
			b=false;
			$("#tip_div").show();
			$("#error").text("下午5:00后不可继续挂下午号！");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
            });
		}
		//if(dayn=="0" || (dayn=="6" && yywbmc=="p")){
		if(dayn=="6" && yywbmc=="p"){
			b=false;
			$("#tip_div").show();
            $("#error").text("周六下午或者周日请到窗口挂号！");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
            });
		}
		if(b){
			$.session.set('pbid00T', pbid);
	        $.session.set('riqi', yydate);
	        window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yytime.jsp";
		}
		
		
		
		
		
        /* if((yywbmc=="a" && hours<11) || (yywbmc=="a" && (hours==11 &&minuise<30))){
        	if(dayn=="7"){
        		$("#tip_div").show();
                $("#error").text("周六下午或者周日请到窗口挂号！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                });
        	}else{
        		$.session.set('pbid00T', pbid);
                $.session.set('riqi', yydate);
                window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yytime.jsp";
        	}
        }else{
        	$("#tip_div").show();
            $("#error").text("上午11:30后不可继续挂上午号！");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
            });
        }
        
        if(yywbmc=="p" && hours<17){
        	if(dayn=="7" || dayn=="6" ){
        		$("#tip_div").show();
                $("#error").text("周六下午或者周日请到窗口挂号！");
                $("#tip_s").on("click", function () {
                    $("#tip_div").hide();
                });
        	}else{
                $.session.set('pbid00T', pbid);
                $.session.set('riqi', yydate);
                window.location.href = "${pageContext.request.contextPath}/jsp/mzyy/yytime.jsp";
        	}
        }else{
        	$("#tip_div").show();
            $("#error").text("下午5:00后不可继续挂下午号！");
            $("#tip_s").on("click", function () {
                $("#tip_div").hide();
            });
        } */

        
    }

    stepshow();
</script>
</html>
