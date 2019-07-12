var init = function(){
    returnTimeStart(); //倒计时方法
    jump();//跳转页面方法
}
function returnTimeStart(){
    //初始化倒计时时间：60秒
    var time = 120;
    //自动倒计时，计时时间为0时，
    function returnTime(){
        myVar=setInterval(
            function(){
                time--;
                $("#time").text(time);
                if(time==0){
                    //跳转页面
                    window.location.href="/main/main.html";
                }
            },1000);
    }

    //用户点击或按键等操作时，倒计时重新计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;
    function timeAgin(){
        //time = window.parent.reTime;
        time = 120;
    }
    returnTime();
}
function jump() {
    $("#zfbpay").bind("click dbclick", function() {
        window.location.href="/pay/alipay.html";
    });
    $("#wxpay").bind("click dbclick", function() {
        window.location.href="/pay/wxpay.html";
    });
    $("#main").bind("click dbclick", function() {
        if($.session.get("RegNo") && window.parent.ttype == 1){
            sfzhOp();
        }
        window.location.href="/main/main.html";
    });
    $("#pre").bind("click dbclick", function() {
        if($.session.get("RegNo") && window.parent.ttype == 1){
            sfzhOp();
        }
        window.location.href="/main/main.html";
    });
}
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
                //log("释放成功！号点："+RegNo);
            }
        },
        error : function() {
            message("释放号点时系统异常,请稍后再试!");
        }
    });
}
init();