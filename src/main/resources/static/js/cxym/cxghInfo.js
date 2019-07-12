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
//获取预约信息
function getAppInfo() {
    var datas = {
        "funcid" : "M07.02.04.08",
        "cxdm00" : window.parent.cardNo//患者卡号
    };
    $.ajax({
        async : true,
        type : "post",
        data : datas,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url:window.parent.serverUrl+"GetRegInfos",
        success : function(json) {
            var data = eval(json);
            var tbody = document.getElementsByTagName("tbody")[1];
            var table = document.getElementById("keshi_t");
            table.removeChild(tbody);
            var nbody = document.createElement("tbody");
            nbody.id="info_t";
            table.appendChild(nbody);
            if (data.retcode == "0") {
                var length = data.retbody.length;

                for (var i = 0; i < length; i++) {
                    $("#info_t").append(
                        "<tr class=\"tb_tr\">"
                        + "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(/js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
                        + "<td class=\"tb_td\">"+data.retbody[i].yyrq00+"</td>"
                        + "<td class=\"tb_td\">"+data.retbody[i].mzksmc+"</td>"
                        /* + "<td class=\"tb_td\"><input type=\"text\" style=\"background:none;border:0px;\" value=\""+data.retbody[i].mzksmc+"\"></td>" */
                        + "<td class=\"tb_td\">"+data.retbody[i].mzysxm+"</td>"
                        + "<td class=\"tb_td\">"+data.retbody[i].yysj00+"</td>"//预约时间

                        + "<td style=\"display:none;\">"+data.retbody[i].yylsh0+"</td>"//预约号码
                        + "<td style=\"display:none;\">"+data.retbody[i].ksbh00+"</td>"//his科室编号
                        + "<td style=\"display:none;\">"+data.retbody[i].ysbh00+"</td>"//his医生编号
                        + "<td style=\"display:none;\">"+data.retbody[i].yysj00+"</td>"//

                        + "<td>"
                        + "<img src=\"/images/yue/yyqx.jpg\" onclick='qxOperation(this)'></img>"
                        + "</td>"
                        + "</tr>")
                }
                page = new Page(8, "keshi_t", "info_t");
                $("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);

            } else {
                goError(data.retmsg);
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
/**
 *初始化操作
 **/
var init = function(){
    $("#btnMain").bind("click dbclick", function() {//返回主页
        window.location.href="/main/main.html";
    });
    $("#btnReturn").bind("click dbclick", function() {//返回上一级
        window.location.href="/main/main.html";
    });
    $("#tip_s").on("click", function() {
        $("#tip_div").hide();
        window.location.href="/main/main.html";
    });
    returnTime();//倒计时
    document.onkeydown = timeAgin;
    document.onclick = timeAgin;
}
init();