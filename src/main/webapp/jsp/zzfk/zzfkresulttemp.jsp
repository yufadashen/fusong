<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>办理就诊卡结果处理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.2.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/jqsession.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/control.css" media="all">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<!--以IE8模式渲染-->
<meta http-equiv="X-UA-Compatible" content="IE=7">
<!--以IE7模式渲染-->
<style type="text/css">
body {
	width: 1024px;
	height: 768px;
	overflow: hidden;
	background: url(${pageContext.request.contextPath}/images/bj.jpg) no-repeat;
}
div{
	position:absolute;
}
</style>
</head>
<body scroll="no" onselectstart="return false;">
	<div id="waiting" style="margin:199px 0px 0px 212px;z-index:100;width:576px;height:321px;background-image:url('../../images/waiting.gif');position:absolute;"></div>
	<div id="tip_div"
		style="z-index:1000;display:none;width:659px;height:243px;background-image:url('${pageContext.request.contextPath}/images/dck2.png');position:absolute;left:290px;top:440px;">
		<div id="tip_divInfo"
			style="text-align:center;position:relative;top:82px">
			<span id="error" style="font-size:30px;color:#EE7700;"><strong></strong></span>
		</div>
		<img id="tip_s"
			src="${pageContext.request.contextPath}/images/qdmix.png" width="90"
			height="43" style="position:relative;top:160px;left:300px" />
	</div>
</body>
<script type="text/javascript">
	function initialize	(){
		var status = $.session.get("zzfkstatus");
		if(status == "1"){//支付成功
			signSure();//确认建档
		}else{
			//cancelzzbk();//取消建档 流程撤销
			window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
		}
	}
	//发卡确认建档：M07.02.02.04 如果jdzt00=9,则his建档成功，允许充值
	function signSure(){
		var cgjysj = $.session.get("cgjysj");
		var jyrq00 = cgjysj.slice(0,8);
		var jysj00 = cgjysj.slice(9);
		var datas = {
		 	"funcid": "M07.02.02.04",
            "jdlsh0": $.session.get("jdlsh0"),//建档流水号
            "jylsh0": $.session.get("jylsh0"),//交易流水号
            "czlb00": "1",//操作类别   0：社保卡建档  1：自助发卡
            "cxdm00": window.parent.cardNo,//卡号
            "fzxbh0": "", //患者身份编号    空--自费 ，0--职工医保 ，1—城乡居民医保
            "fzxmc0":"", //患者身份名称 
            "id0000":"",//社会保障号  前端读医保卡返回
            "sfzhao": window.parent.sfzhao,//身份证号   
            "xming0": window.parent.xming0,//姓名 
            "xbie00": window.parent.xbie00=="男"?"1":"2",//  性别 
            "brnl00": getAge(window.parent.csrq00),//病人年龄
            "rylb00": "",//人员类别(工作状态)    前端读医保卡返回
            "csrq00":window.parent.csrq00,//出生日期   
            "gzdwmc":"",//工作单位名称 前端读医保卡返回
            "grzhye":"",//医保个人账户余额
            "bqbm00":"",//病情编码  
            "lxdh00":window.parent.lxdh00,//联系电话
            "ptqqls":$.session.get("ptqqls"),//平台请求流水
            "ptddls":$.session.get("ptddls"),//平台订单流水
            "jylb00":"ONE_QR",//交易类别
            "jyje00":"5",//交易金额
            "jyrq00":jyrq00,//交易日期
            "jysj00":jysj00//交易时间
		}
        $.ajax({
            async: true,
            type: "post",
            data: datas,
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: window.parent.serverUrl + "?method=ApplyAction",
            success: function (json) {
            	var Data = eval(json);
				if (Data.retcode == "0") {
					window.parent.brid00 = Data.retbody[0].brid00;//病人id
					//window.parent.brid00 = "00080397500";//病人id
					var pjh000 = Data.retbody[0].brid00;
					var cgjysj1 = Data.retbody[0].cgjysj;
					if(window.parent.brid00){
						fkandprint(cgjysj1);
					}else{
						printfail(cgjysj1);
						window.parent.cardPrinter.MoveCard(2);//建档失败，将卡移动到回收箱
						message("发卡建档失败！");//TODO 
					}
				} else {
					printfail();
					window.parent.cardPrinter.MoveCard(2);//建档失败，将卡移动到回收箱
					message("发卡建档失败2！");//TODO 
				}
            },
            error: function () {
            	printfail();
                message("系统异常，请稍后再试！");
            }
        });	
	}
	//获取年龄
	function getAge(birthday) {
	    //出生时间 毫秒
	    var birthDayTime = new Date(birthday.substr(0, 4),birthday.substr(4, 2),birthday.substr(6, 2)).getTime(); 
	    //当前时间 毫秒
	    var nowTime = new Date().getTime(); 
	    //一年毫秒数(365 * 86400000 = 31536000000)
	    return Math.floor((nowTime-birthDayTime)/31536000000);
	}

	//发卡和打印小票
	function fkandprint(cgjysj1){
		var cardPrinter = window.parent.cardPrinter;
		var ret = cardPrinter.MoveCard(3);
		if(ret == "0"){
			//log.WriteLog("出卡成功！"+window.parent.cardNo);
			print(cgjysj1);
			message("请取走你的卡片！");
			
		}else{
			//log.WriteLog("出卡失败！"+window.parent.cardNo);
			printfail(cgjysj1);
			message("出卡失败！请联系工作人员！");
		}
	}
	//打印
	function print(cgjysj1) {
		var bksj;
		if(cgjysj1){
			bksj = cgjysj1.replace(/T/," ");
		}
		var printer = window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x08, 0x01); //设置字体
	    printer.SetTextModeX(1); //设置中文模式
		printer.WriteTextLineX("河北北方学院附属第一医院");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("自助办卡成功！");
		printer.WriteTextLineX("");
		printer.LFX(2); //多行送纸
		printer.SetTextModeX(0); //设置中文模式
		printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
		printer.WriteTextLineX("  姓    名："+window.parent.xming0);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  就诊卡号："+window.parent.cardNo);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  平台请求流水："+$.session.get("ptqqls"));//平台请求流水
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  病人id："+window.parent.brid00);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  办卡时间："+bksj);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  办卡金额：5元");
		printer.LFX(2); //多行送纸
		printer.SetTextModeX(1); //设置中文模式
		printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  退款凭本收据或本人身份证。");
		printer.LFX(3); //多行送纸
		printer.CeTCutX(); //切纸
	}
	// 扣费失败 打印
	function printfail(cgjysj1) {
		var bksj = "建档失败！";
		if(cgjysj1){
			bksj = cgjysj1.replace(/T/," ");
		}
		var printer = window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x08, 0x01); //设置字体
	    printer.SetTextModeX(1); //设置中文模式
		printer.WriteTextLineX("河北北方学院附属第一医院");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("自助办卡失败！");
		printer.WriteTextLineX("");
		printer.LFX(2); //多行送纸
		printer.SetTextModeX(0); //设置中文模式
		printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
		printer.WriteTextLineX("  姓    名："+window.parent.xming0);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  就诊卡号："+window.parent.cardNo);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  平台请求流水："+$.session.get("ptqqls"));//平台请求流水
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  办卡时间："+bksj);
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  办卡金额：5元");
		printer.LFX(2); //多行送纸
		printer.SetTextModeX(1); //设置中文模式
		printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("");
		printer.WriteTextLineX("  退款凭本收据或本人身份证。");
		printer.LFX(3); //多行送纸
		printer.CeTCutX(); //切纸
	}
	//提示信息
	function message(msg){
		 $("#waiting").hide();
		 $("#tip_div").show();
         $("#error").text(msg);
	}
	var init = function(){
		initialize();
		$("#tip_s").on("click", function () {
            $("#tip_div").hide();
            $.session.clear();
            window.location.href = "${pageContext.request.contextPath}/jsp/main/main.jsp";
        });
	}
	init();
</script>
</html>