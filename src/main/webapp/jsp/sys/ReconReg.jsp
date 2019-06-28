<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/jsp/sys/file/common.jspf" %>

<html>
<head>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>
    <title>挂号支付对账</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/json2.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/ReceiptPrinter.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/DriverJS/PinPad.js"></script>
    <script src="${pageContext.request.contextPath}/js/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/UserIDCard.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/layui.css" media="all">
    <meta http-equiv="X-UA-Compatible" content="IE=8">
    <!--以IE8模式渲染-->
    <meta http-equiv="X-UA-Compatible" content="IE=7">
</head>
<body>
<div class="print_databox">
    <div class="data_tablebox">
        <div class="print_info_btns text_r">
            <!-- <a class="prints_btn_com" id="exportList" >导出EXCEL</a> -->
            <span>&nbsp;&nbsp;</span>
            <a class="prints_btn_com" onclick="javascript:window.print()" >打印</a>
        </div>
        <div style="font-size:20px; font-weight:bold; line-height:30px; text-align:center;">
            <span style="text-decoration: underline;">自助机挂号支付对账</span>
            <h2 style="font-size: 20px; letter-spacing:10px; text-align:center">挂号支付记录表</h2>
            <p>
                <span>时间：</span>

             <%--   <span>年龄：${patientInHospital.patientNumber.age }岁</span>
                <span>床号：<b>${patientInHospital.bednumber }</b></span>
                <span>住院号：<b>${patientInHospital.inhosnumber }</b></span>
                 <span>手机号：13311111114</b></span> --%>
            </p>
            <p>
                <%--<span>住院时间：<b><s:date name="#patientInHospital.inhostime" format="yyyy-MM-dd"></s:date></b></span>
                <span>出院时间：<b><s:date name="#patientInHospital.outhostime" format="yyyy-MM-dd"></s:date></b></span>
                <span>监测次数：${totalCount }</span>--%>
            </p>
        </div>
        <table id="keshi_t"  width="100%" border="1" cellspacing="0" cellpadding="0" class="comtbl">
            <thead>
            <tr>
                <th align="center">挂号流水号</th>
                <th align="center">患者id</th>
                <th align="center">商户订单号 </th>
                <th align="center">支付金额</th>
                <th align="center">支付方式</th>
                <th align="center">第三方支付时间</th>
                <th align="center">第三方支付流水号</th>
                <th align="center">支付状态</th>
            </tr>
            </thead>
            <tbody id="info_t" >
            </tbody>

        </table>
        <%-- <div class="fenye">
            <div class="page_f">
                            </div>
        </div> --%>
    </div>
</div>
<div id="popResetPsw">
    <form method="post" action="#">
        <div class="blank20"></div>
        <div class="comrow_div" style="text-align:center;">
            <input class="pop_com_btn" name="" type="button" value="导出当前页" id="nowpage"  />
            <input class="pop_com_btn" name="" type="button" value="导出全部" id="allpage"  />
            <input class="pop_com_btn" name="" type="reset" value="取消" id="docNot" />
        </div>
        <div class="blank20"></div>
    </form>
</div>
</body>
<script type="text/javascript">
    var datas ={
        "startTime":"20190624000000",
        "endTime":"20190627000000"
    };
    $.ajax({
        type: 'post',
        url: 'http://localhost:8888/ReconciliationGH',
        // contentType: "application/json",
        dataType: 'json',
        data : { "startTime":"20190624000000",
            "endTime":"20190627000000"},
        success: function (data) {
            var Data = JSON.parse(data);

            ;


            // var data = eval(json);
            var tbody = document.getElementsByTagName("tbody")[1];
            var table = document.getElementById("keshi_t");
            // table.removeChild(tbody);
            var nbody = document.createElement("tbody");
            nbody.id="info_t";
            table.appendChild(nbody);
            // if (data.retcode == "0") {
                var length = Data.list.length;
                for (var i = 0; i < length; i++) {
                    var  pay = Data.list[i].paymentWay=="12"?"微信":"支付宝";
                    $("#info_t").append(
                        "<tr class=\"tb_tr\">"
                        + "<td>"+Data.list[i].regNo+"</td>"
                        + "<td>"+Data.list[i].outpatientId+"</td>"
                        + "<td>"+Data.list[i].outTradeNo+"</td>"
                        + "<td>"+ parseFloat(Data.list[i].totalFee)/100 +"</td>"
                        + "<td>"+pay+"</td>"
                        + "<td>"+Data.list[i].settleDate+"</td>"
                        + "<td>"+Data.list[i].tradeSerialNumber+"</td>"
                        + "<td>"+Data.list[i].ifFee+"</td>"
                        + "</tr>")
                }
                page = new Page(8, "keshi_t", "info_t");
                $("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);

            // } else {
            //     goError(Data.retmsg);
            // }
            $("#waiting").hide();

            console.log(Data);
        }
    });
    // as();
    // function as(){
        <%--var datas ={--%>
            <%--"startTime":"20190624000000",--%>
            <%--"endTime":"20190627000000"--%>
        <%--};--%>
        <%--$.ajax({--%>
            <%--async : true,--%>
            <%--type : "post",--%>
            <%--data : datas,--%>
            <%--dataType : "json",--%>
            <%--contentType : "application/x-www-form-urlencoded; charset=utf-8",--%>
            <%--url : "http://localhost:8888/ReconciliationGH",--%>
            <%--&lt;%&ndash;//url:"${pageContext.request.contextPath}/Test/test.do",&ndash;%&gt;--%>
            <%--success : function(json) {--%>
                <%--//alert(1);--%>
                <%--//1、解析json--%>
                <%--var data = eval(json);--%>
                <%--alert(data);--%>
                <%--//2、判断出参--%>
                <%--if(data.retcode=="0"){--%>
                    <%--//显示终端编号--%>
                    <%--var number =  data.retbody[0].zdbh00;--%>
                    <%--//alert(number);--%>
                    <%--$("#termialNum").text(number);--%>
                <%--}--%>
            <%--},--%>
            <%--error : function() {--%>
                <%--//alert(2);--%>
            <%--},--%>
        <%--});--%>
    // }

</script>
</html>
