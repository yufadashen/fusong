var log = window.parent.Logger;
var zylsh;//住院流水号
var zyFlag = false;//在院信息
function goNext(){
    getZyPatientInfo();//获取住院流水号及基本信息
    if(zyFlag){
        $.session.set("srzyh",$("#czje").val());
        if(window.parent.ttype == 3){//住院充值
            window.location.href = "/zyyjf/czje.html";
        }else if(window.parent.ttype == 4){//查询住院费用信息
            window.location.href = "/cxym/cxzyInfo.html";
        }
    }else{
        message("未查到住院信息，请确认住院号！");
    }
}
//获取住院病人住院流水号
function getZyPatientInfo(){
    var datas = {
        "InpatientNo":	$("#czje").val()
    };
    $.ajax({
        async : false,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"GetInPatientSeriNos",
        success : function(json) {
            var data = JSON.parse(json);
            if (data.Code == "0") {
                var length = data.Departments.length;
                if(length > 0){
                    $.each(data.Departments,function(index,temp){
                        if(temp.InpatientStatus == "0"){//0未出院   1已出院
                            window.parent.Name = temp.Name;
                            $.session.set("zyyeb",temp.Balance);//充值前住院余额
                            $.session.set("zylsh",temp.InpatientSeriNo);//住院流水号
                            zyFlag = true;
                        }
                    });
                }else{
                    message("查询住院流水号为空！请确认住院号！");
                }
            } else {
                message("未找到住院信息!");
            }
            $("#waiting").hide();
        },
        error : function() {
            goError("系统异常,请稍后再试!");
        }
    });
}
//跳转提示页面
function goError(msg){
    $.session.set("errormsg",msg);
    window.location.href="/main/error.html";
}
function initialize	(){
    $("#qrcz").bind("click dbclick", function() {//确认充值
        if($("#czje").val()){
            goNext();
        }else{
            message("请输入住院号！");
        }
    });
    $("#mainPage").bind("click dbclick", function() {//返回主页
        window.location.href="/main/main.html";
    });
    $("#backPage").bind("click dbclick", function() {//返回上一级
        if(window.parent.ttype == 3){
            window.location.href="/main/main.html";
        }else{
            window.location.href="/cxym/cxmenu.html";
        }
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
    return;
}
$("#tip_s").off().on("click", function() {
    $("#tip_div").hide();
});
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
        if (valStr.length > 9) {
            $("#czje").val(valStr);
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
    /*  var a = $("#money")[0].style.display;
     if(a == "none"){
         $("#money").css("display","block");
     }else{
         $("#money").css("display","none");
     } */
});
//确认
$("#sure").bind("click dbclick", function() {
    if($("#czje").val()){
        goNext();
    }else{
        $("#tip_div").show();
        $("#error").text("请输入住院号！");
        $("#tip_s").off().on("click", function() {
            $("#tip_div").hide();
        });
    }
});
init();