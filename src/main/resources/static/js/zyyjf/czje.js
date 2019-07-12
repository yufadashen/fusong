var log = window.parent.Logger;
var sfkcz = 0;//TODO
function goNext(){
    $("#tip_div").show();
    $("#tip_c").show();
    $("#error").html("姓名:"+window.parent.Name+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;住院号:"+$.session.get("srzyh")+"<br/> 充值金额:"+$("#czje").val()+"元");
    //message("姓名:"+window.parent.Name+"     住院号:"+$.session.get("srzyh")+"      充值金额:"+$("#czje").val()+"元");
    $("#tip_c").off().on("click", function() {
        window.location.href="/main/main.html";
    });
    $("#tip_s").off().on("click", function() {
        $.session.set("TotalFee",$("#czje").val());
        window.location.href = "/pay/lypayway.html";
    });
}

function initialize	(){
    $("#name").text(window.parent.Name);//姓名
    $("#ynye").text($.session.get("zyyeb"));//余额
    $("#openkb").bind("click dbclick", function() {//打开 关闭键盘
        var a = $("#money")[0].style.display;
        if(a == "none"){
            $("#money").css("display","block");
        }else{
            $("#money").css("display","none");
        }
    });
    $("#qrcz").bind("click dbclick", function() {//确认充值
        if($("#czje").val()){
            if(parseInt($("#czje").val())%100==0){
                goNext();
            }else{
                //message("充值金额为100或100的倍数！");
                message("请输入‘整百’的充值金额！");
            }
        }else{
            message("请输入充值金额！");
        }
    });
    $("#wsy").bind("click dbclick", function() {//100元点击事件
        $("#czje").val("100");
        goNext();
    });
    $("#yby").bind("click dbclick", function() {//200
        $("#czje").val("200");
        goNext();
    });
    $("#eby").bind("click dbclick", function() {//300
        $("#czje").val("300");
        goNext();
    });
    $("#sby").bind("click dbclick", function() {//500
        $("#czje").val("500");
        goNext();
    });
    $("#wby").bind("click dbclick", function() {//1000
        $("#czje").val("1000");
        goNext();
    });
    $("#yqy").bind("click dbclick", function() {//2000
        $("#czje").val("2000");
        goNext();
    });

    $("#mainPage").bind("click dbclick", function() {//返回主页
        window.location.href="/main/main.html";
    });
    $("#backPage").bind("click dbclick", function() {//返回上一级
        window.location.href = "/cxym/cxzyInfo_b.html";
    });
}

//初始化倒计时时间：120秒
var time = 120;
//用户点击或按键等操作时，倒计时重新计时
function timeAgin() {
    time = 120;
}
//自动倒计时，计时时间为0时，
function returnTime(){
    myVar=setInterval(
        function(){
            time--;
            $("#time").text(time);
            if(time==0){
                $.session.clear();
                //跳转页面
                window.location.href="/main/main.html";
            }
        },1000);
}

function message(message) { //提示信息
    if($("#waiting")){
        $("#waiting").hide();
    }
    $("#tip_div").show();
    $("#error").text(message);
    $("#tip_s").off().on("click", function() {
        $("#tip_div").hide();
    });
    return;
}
/**
 *初始化操作
 **/
var init = function(){
    initialize();
    returnTime();//倒计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;
}
/***
 ***  键盘事件
 ***/
$('img[name="numKey"]').on("click", function() {
    var valStr = $("#czje").val();
    if (valStr == "" || valStr == 0) {
        $("#czje").val($(this).attr("value"));
    } else {
        $("#czje").val(valStr + $(this).attr("value"));
        if (valStr.length > 4) {
            $("#czje").val(valStr);
        }
        if(parseInt($("#czje").val())>20000){
            $("#czje").val(20000);
        }
    }
});
//删除
$("#modify").on("click", function() {
    var num = $("#czje").val();
    var newstr = num.substring(0, num.length - 1);
    $("#czje").val(newstr);
});
//重填
$("#reinput").on("click", function() {
    $("#czje").val("");
});
//关闭
$("#close").bind("click dbclick", function() {
    var a = $("#money")[0].style.display;
    if(a == "none"){
        $("#money").css("display","block");
    }else{
        $("#money").css("display","none");
    }
});
//确认
$("#sure").bind("click dbclick", function() {
    if($("#czje").val()){
        if(parseInt($("#czje").val())%100==0){
            goNext();
        }else{
            //message("充值金额为100或100的倍数！");
            message("请输入‘整百’的充值金额！");
        }
    }else{
        message("请输入充值金额！");
    }
});
init();