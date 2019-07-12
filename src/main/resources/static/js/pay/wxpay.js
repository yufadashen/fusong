var  log = window.parent.Logger;
function log(Info){
    log.WriteLog(Info);
}


var init = function() {
    $("#xming0").text(window.parent.Name);
    $("#zfye").text($.session.get("TotalFee")+" 元");
    returnTimeStart(); //倒计时
    wxorder();//下单
}
var time = 120;
function returnTimeStart() {
    time = 120;
    function returnTime() {
        myVar=setInterval(
            function(){
                time--;
                $("#time").text(time);
                if(time==0){
                    cancleOrder();
                    //跳转页面
                    window.location.href="/main/main.html";
                }
            },1000);
    }
    //用户点击或按键等操作时，倒计时重新计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;
    function timeAgin() {
        time = 120;
    }
    returnTime();
}
function message(msg){
    $("#tip_div").show();
    $("#error").text(msg);
    $("#tip_s").off().on("click", function() {
        $("#tip_div").hide();
        window.location.href="/main/main.html";
    });
}
//微信充值下单
var aa;
var bb;
var cc;
var outTradeNo;//微信订单流水
function wxorder() {
    var datas = {
        "RegNo" : $.session.get("RegNo"),
        "ipAddress":window.parent.ipAddress,
        "Fee" : $.session.get("TotalFee")
    };
    //log("微信充值下单：  挂号流水号=="+$.session.get("RegNo") +"    金额:"+$.session.get("TotalFee"));
    $.ajax({
        async : true,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"WxPayGH",
        success : function(json) {
            var Data = JSON.parse(json)
            if (Data.Code == "0") {
                var qrcode = Data.retBody.url; //二维码串
                outTradeNo = Data.retBody.outTradeNo; //微信订单流水
                //将二维码串转换为图片
                $("#erweima").qrcode({
                    render: "canvas",
                    width : 200,
                    height : 200,
                    text : qrcode
                })
                $("#erweima").show();
                $("#cancel").show();
                $("#zhuyitingxing").show();
                //log("微信下单成功：  挂号流水号=="+$.session.get("RegNo") +"    金额:"+$.session.get("TotalFee"));
                aa = setTimeout("queryOrder()", 2000); //查询订单状态
            } else {
                //log("微信下单失败：  挂号流水号=="+$.session.get("RegNo") +"    金额:"+$.session.get("TotalFee"));
                message("微信下单失败，请重试");
            }
        },
        error : function() {
            //log("微信下单系统异常：  挂号流水号=="+$.session.get("RegNo") +"    金额:"+$.session.get("TotalFee"));
            message("系统异常，请稍后再试！");
        }
    });
}
//微信充值查询订单状态
function queryOrder() {
    if(outTradeNo){
        var datas = {
            "outTradeNo" : outTradeNo,
            "RegNo" : $.session.get("RegNo"),
            "opType" : window.parent.ttype //1挂号，  2缴费   3,住院
        };
        //log("微信充值查询订单状态：  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
        if(window.parent.ttype == 2){//缴费需要增加参数
            datas.RecipeNos = $.session.get("RecipeNos");
        }
        $.ajax({
            async : false,
            type : "post",
            data : datas,
            dataType : "json",
            contentType : "application/x-www-form-urlencoded; charset=utf-8",
            url:window.parent.serverUrl+"WxPayIsFee",
            success : function(json) {
                var Data = JSON.parse(json)
                if (Data.Code == "0") {
                    var czztbz = Data.retBody.trade_state; //充值状态标识
                    if(czztbz == "SUCCESS"){//支付成功
                        //log("微信充值查询订单状态 支付成功：  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
                        if(bb){
                            clearTimeout(bb);
                        }
                        //打印凭条 跳转成功页面 进行打印凭条
                        if(window.parent.ttype==1){//挂号
                            window.location.href = "/mzgh/ghsuccess.html";
                        }else if(window.parent.ttype==2){//门诊缴费
                            window.location.href = "/mzjf/mzjfsuccess.html";
                        }else if(window.parent.ttype == 3){ //住院缴费
                            // TODO  需要获取充值之后的余额
                            window.location.href = "/zyyjf/zyPaySuccess.html";
                        }
                    }else if(czztbz == "NOTPAY"){//未支付
                        bb = setTimeout("queryOrder()", 800);
                    }else if(czztbz == "HISFAIL"){//充值成功，his失败
                        //log("微信充值查询订单状态 充值成功his失败：  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
                        //处理退费打印凭条，还是打印凭条，窗口退费
                        $("#erweima").hide();
                        $("#cancel").hide();
                        if($.session.get("RegNo") && window.parent.ttype == 1){
                            sfzhOp();///撤销订单 如果是挂号，同时进行释放占号操作
                        }
                        refund();//退费
                        message("由于his系统挂号失败，您的费用将原途径退费，如果退费失败，请凭借退费失败凭条到窗口进行咨询人工退费，谢谢您的配合！");
                    }
                } else {
                    message("查询订单信息失败！");
                }
            },
            error : function() {
                message("系统异常，请稍后再试！");
            }
        });
    }else{
        message("微信订单流水获取失败！"+outTradeNo);
    }
}

//微信充值撤销订单
function cancleOrder() {
    if($.session.get("RegNo") && window.parent.ttype == 1){///撤销订单 如果是挂号缴费，同时进行释放号点操作
        sfzhOp();
    }
    var datas = {
        "outTradeNo":outTradeNo
    };
    $.ajax({
        async : false,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"WxCloseorder",
        success : function(json) {
            //log("微信充值撤销订单：交易流水号="+outTradeNo);
            var Data = JSON.parse(json)
            if (Data.Code == "0") {
                //log("微信充值撤销订单     成功：交易流水号="+outTradeNo);
                message("取消订单成功");
            } else {
                //log("微信充值撤销订单    失败："+Data.retmsg+"   交易流水号="+outTradeNo);
                message(Data.retmsg);
            }
        },
        error : function() {
            //log("微信充值撤销订单     系统异常：交易流水号="+outTradeNo);
            message("系统异常，请稍后再试！");
        }
    });
}

$("#cancel").bind("click dbclick", function() {
    $("#erweima").hide();
    $("#cancel").hide();
    clearTimeout(aa);
    clearTimeout(bb);
    cancleOrder();
    $.session.clear();
});

$("#main").bind("click dbclick", function() {
    if ($("#erweima")[0].style.display == "none") {
        window.location.href="/main/main.html";
    } else {
        $("#erweima").hide();
        $("#cancel").hide();
        clearTimeout(aa);
        clearTimeout(bb);
        cancleOrder();
        $.session.clear();
    }
});

$("#pre").bind("click dbclick", function() {
    if ($("#erweima")[0].style.display == "none") {
        window.location.href = "/pay/lypayway.html";
    } else {
        $("#erweima").hide();
        $("#cancel").hide();
        clearTimeout(aa);
        clearTimeout(bb);
        cancleOrder();
        $.session.clear();
    }
});
//释放占号
function sfzhOp(){
    var datas = {
        "RegNo" : $.session.get("RegNo")
    };
    $.ajax({
        async : false,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"ReleaseRegPoint",
        success : function(json) {
            var Data = JSON.parse(json)
            if (Data.Code == "0") {
                //log("释放成功！号点："+$.session.get("RegNo"));
            }else{
                //log("释放失败！号点："+$.session.get("RegNo"));
            }
        },
        error : function() {
            //log("释放号点时系统异常！"+$.session.get("RegNo"));
            message("释放号点时系统异常,请稍后再试!");
        }
    });
}
//微信退费
function refund(){
    var datas = {
        "outTradeNo" : outTradeNo,
        "Fee" : $.session.get("TotalFee")
    };
    //log("微信退费：  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
    $.ajax({
        async : false,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"WxRefund",
        success : function(json) {
            var Data = JSON.parse(json)
            if (Data.Code == "0") {
                var msg = Data.retBody.msg;
                if(msg == "Success"){
                    //log("微信退费成功："+msg+"  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
                    printTF();
                }else{
                    //log("微信退费失败："+msg+"  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
                    printTFFail();
                }
            }else{
                //log("微信退费失败："+Data.Code+"  挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
                printTFFail();
            }
        },
        error : function() {
            //log("微信退费系统异常： 挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：window.parent.ttype=="+window.parent.ttype+"  (1挂号，  2缴费 , 3住院)");
            printTFFail();
            message("系统异常，退费失败!");
        }
    });
}

function printTF() {
    var type = window.parent.ttype;//1挂号，  2缴费 , 3住院
    //log("打印退费成功凭条： 挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：type=="+type+"  (1挂号，  2缴费 , 3住院)");
    var title = "";
    if(type == 1){
        title = "微信挂号退费成功!";
    }else if(type == 2){
        title = "微信门诊缴费退费成功!";
    }else if(type == 3){
        title = "微信住院充值退费成功!";
    }
    var Printer = window.parent.KPrinter;
    Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
    Printer.SetTextModeX(1);//设置中文模式
    Printer.WriteTextLineX("	河北北方学院附属第一医院");
    Printer.WriteTextLineX("	"+title);
    Printer.LFX(2); //多行送纸
    Printer.PrintBarCodeX(73,100,4,window.parent.OutpatientId);
    Printer.WriteTextLineX("");
    Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
    Printer.WriteTextLineX("  患者姓名：" + window.parent.Name);
    Printer.WriteTextLineX("  ID  号：" + window.parent.OutpatientId);
    Printer.WriteTextLineX("  退费金额：" + $.session.get("TotalFee") + "元");
    Printer.WriteTextLineX("  终端编号：" + window.parent.ipAddress);//终端编号
    Printer.WriteTextLineX("  交易流水：" + outTradeNo);
    Printer.SetFontModeAndTypeX(0x08, 0x00);
    Printer.SetTextModeX(1); //设置中文模式
    Printer.LFX(2); //多行送纸
    Printer.SetTextModeX(1); //设置中文模式
    Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
    Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
    Printer.LFX(3); //多行送纸
    Printer.CeTCutX(); //切纸
}
function printTFFail() {//
    var type = window.parent.ttype;//1挂号，  2缴费 , 3住院
    //log("打印退费失败凭条： 挂号流水号=="+$.session.get("RegNo") +"    交易流水号:"+outTradeNo + "   操作类型：type=="+type+"  (1挂号，  2缴费 , 3住院)");
    var title = "";
    if(type == 1){
        title = "微信挂号退费失败!";
    }else if(type == 2){
        title = "微信门诊缴费退费失败!";
    }else if(type == 3){
        title = "微信住院充值退费失败!";
    }
    var Printer = window.parent.KPrinter;
    Printer.SetFontModeAndTypeX(0x08, 0x01);//设置字体
    Printer.SetTextModeX(1);//设置中文模式
    Printer.WriteTextLineX("	河北北方学院附属第一医院");
    Printer.WriteTextLineX("");
    Printer.WriteTextLineX("	"+title);
    Printer.LFX(2); //多行送纸
    Printer.PrintBarCodeX(73,100,4,window.parent.OutpatientId);
    Printer.WriteTextLineX("");
    Printer.SetFontModeAndTypeX(0x08, 0x00); //设置字体
    Printer.WriteTextLineX("  患者姓名：" + window.parent.Name);
    Printer.WriteTextLineX("  ID  号：" + window.parent.OutpatientId);
    Printer.WriteTextLineX("  退费金额：" + $.session.get("TotalFee") + "元");
    Printer.WriteTextLineX("  终端编号：" + window.parent.ipAddress);//终端编号
    Printer.WriteTextLineX("  交易流水：" + outTradeNo);
    Printer.SetFontModeAndTypeX(0x08, 0x00);
    Printer.SetTextModeX(1); //设置中文模式
    Printer.LFX(2); //多行送纸
    Printer.SetTextModeX(1); //设置中文模式
    Printer.WriteTextLineX("  注  意：本凭证只作核对作用，不做报销凭证。");
    Printer.WriteTextLineX("  请妥善保管此凭证，遗失不补.");
    Printer.LFX(3); //多行送纸
    Printer.CeTCutX(); //切纸
}
init();