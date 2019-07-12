//初始化倒计时时间：15秒
var time = 15;
//自动倒计时，计时时间为0时，
function returnTime(){
    var myVar=setInterval(
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

//用户点击或按键等操作时，倒计时重新计时
document.onkeydown = timeAgin;
document.onclick = timeAgin;
function timeAgin(){
    time = 15;
}


//var regtest = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
function initialize	(){
    $("#name").text(window.parent.Name);//姓名
    $("#czje").text($.session.get("TotalFee"));//充值金额
    $("#czqye").text($.session.get("zyyeb"));//充值前金额
    $("#czhye").text($.session.get("ayjjye0"));//充值后金额   TODO
    $("#qrfh").bind("click dbclick", function() {//确认返回
        $.session.clear();
        window.location.href="/main/main.html";
    });

    $("#tip_s").on("click", function() {
        $("#tip_div").hide();
    });
    $("#mainPage").bind("click dbclick", function() {//返回主页
        $.session.clear();
        window.location.href="/main/main.html";
    });
    $("#backPage").bind("click dbclick", function() {//返回上一级
        $.session.clear();
        window.location.href = "/main/main.html";
    });
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
init();