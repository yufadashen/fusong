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

laydate.render({
    elem : '#qsrq00', //指定元素
    format : 'yyyy-MM-dd', //可任意组合
    value : new Date(new Date().getTime() - 2592000000),
    maxDate : new Date(),
    isInitValue : false //是否允许填充初始值，默认为 true,isInitValue: false //是否允许填充初始值，默认为 true
});
laydate.render({
    elem : '#jzrq00', //指定元素
    format : 'yyyy-MM-dd', //可任意组合
    value : new Date(),
    maxDate : new Date(),
    isInitValue : false //是否允许填充初始值，默认为 true
});

//获取日期
function GetDateStr(days) {
    var dd = new Date();
    dd.setDate(dd.getDate()+days);//获取days天后的日期
    var y = dd.getFullYear();
    var m = (dd.getMonth()+1)<10?"0"+(dd.getMonth()+1):(dd.getMonth()+1);//获取当前月份的日期，不足10补0
    var d = dd.getDate()<10?"0"+dd.getDate():dd.getDate();//获取当前几号，不足10补0
    return y+""+m+""+d;
}
//查询住院信息
var sumJFJE=0;
function getAppInfo() {
    $("#waiting").show();
    var reg = new RegExp( '-' , "g" )
    var startTime = $("#qsrq00").val().replace(reg, "");
    var endTime  = $("#jzrq00").val().replace(reg, "");
    var datas = {
        "InpatientSeriNo" : $.session.get("zylsh"),//住院号
        "UpdateDateStart" : startTime,//时间段开始
        "UpdateDateEnd" : endTime//时间段结束
        //"UpdateDateStart" : "20130727",//时间段开始
        //"UpdateDateEnd" : "20130816"//时间段结束
    };
    $.ajax({
        async : true,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"GetInpatientFeeList",
        success : function(json) {
            sumJFJE=0;
            var data = JSON.parse(json);
            if (data.Code == "0") {
                var length = data.Departments.length;
                if(length>0){
                    $("#info_t").empty();
                    for (var i = 0; i < length; i++) {
                        $("#info_t").append(
                            "<tr class=\"tb_tr\">"
                            + "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 8px;border-radius:3px;width:40px;background-color:#3f7dac;behavior:url(/js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
                            + "<td class=\"tb_td\">"+data.Departments[i].ItemName+"</td>"
                            + "<td class=\"tb_td\">"+data.Departments[i].ItemNum+"</td>"
                            + "<td class=\"tb_td\">"+data.Departments[i].ItemPrice+"</td>"
                            + "<td class=\"tb_td\">"+data.Departments[i].ItemSpec+"</td>"//预约时间
                            + "<td class=\"tb_td\">"+data.Departments[i].TotalCost+"</td>"//预约时间
                            + "</tr>")
                        sumJFJE += parseFloat(data.Departments[i].TotalCost);
                    }
                    sumJFJE = Math.floor(sumJFJE * 100) / 100;//总金额取小数点后两位
                    $("#zyfy").text(sumJFJE);//表头显示总价

                    page = new Page(8, "keshi_t", "info_t");
                    $("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
                }else{
                    $("#info_t").empty();
                    message("未查询到7天内的信息！");
                }

            } else {
                $.session.set("errormsg",data.retmsg);
                window.location.href="/main/error.html";
            }
            $("#waiting").hide();
        },
        error : function() {
            goError("系统异常,请稍后再试!");
        }
    });
}
function message(msg){
    $("#waiting").hide();
    $("#tip_div").show();
    $("#error").text(msg);
}
//跳转提示页面
function goError(msg){
    $.session.set("errormsg",msg);
    window.location.href="/main/error.html";
}
/**
 *初始化操作
 **/
var init = function(){
    $("#zyNum").text($.session.get("zylsh"));
    $("#btnMain").bind("click dbclick", function() {//返回主页
        $.session.clear();
        window.location.href="/main/main.html";
    });
    $("#btnReturn").bind("click dbclick", function() {//返回上一级
        window.location.href = "/cxym/cxzyInfo_b.html";
        $("#waiting").show();
    });
    $("#tip_s").on("click", function() {
        $("#tip_div").hide();
    });
    returnTime();//倒计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;
    setTimeout("getAppInfo()", 200);
}
init();