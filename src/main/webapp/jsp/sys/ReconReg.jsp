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
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/DriverJS/UserIDCard.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqsession.js"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/layui.css" media="all">
    <meta http-equiv="X-UA-Compatible" content="IE=8">
    <!--以IE8模式渲染-->
    <meta http-equiv="X-UA-Compatible" content="IE=7">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/FileSaver.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/tableExport.js"></script>
        <script type="text/javaScript">
            function doExport() {
                $('#excelstyles').tableExport({
                        type:'excel',
                        mso: {
                            styles: ['background-color',
                                'color',
                                'font-family',
                                'font-size',
                                'font-weight',
                                'text-align']
                        }
                    }
                );
            }



            $(document).ready(function(){
            var date = new Date();
                date.setTime(date.getTime()-24*60*60*1000);
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }


            // var currentdate1 = day1.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate();
            var currentdate1 = date.getFullYear() + month  + strDate+"000000";
            var currentdate2 = date.getFullYear() + month  + strDate+"235959";
                $("#sj1").val(currentdate1);
                $("#sj2").val(currentdate2);
            alert(currentdate);
            })
        </script>

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
        </div>
        <div >请输查询时间：</div>
        <div>
            <span>开始时间：</span>
            <input  id="sj1" value="">

            <span> &nbsp;&nbsp; 结束时间：</span>


            <input  id="sj2" value="">

        <span id="sjcx">&nbsp;&nbsp; <button id="sjcx01" onclick="goCX()">查询</button></span>
        </div>
        <table id="excelstyles" align="center" valign="center"  width="90%" border="1" cellspacing="0" cellpadding="0" class="comtbl">
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
                <th align="center">终端ip</th>
            </tr>
            </thead>
            <tbody id="info_t"  >
            </tbody>
        </table>
    </div>
</div>
<div id="popResetPsw" style="text-align:right;">
    <a href="#" onclick="doExport()">导出Excel表格</a>
</div>
</body>
<script type="text/javascript">


    var date = new Date();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate1 = date.getFullYear() + month  + strDate+"000000";
    var currentdate2 = date.getFullYear() + month  + strDate+"235959";
    $("#sj1").val(currentdate1);
    $("#sj2").val(currentdate2);
    goNext();
function goCX(){


    $("#sjcx").click("click dbclick", function() {
        if($("#sj1").val()||$("#sj2").val()){
            goNext();
        }else{
            message("时间");
            alert("请输入时间");
        }
    });
}
function goNext() {
    

    var datas ={
        "startTime":$("#sj1").val(),
        "endTime":$("#sj2").val()
    };
    $.ajax({
        type: 'post',
        url: '/ReconciliationGH',
        dataType: 'json',
        data : datas,
        success: function (data) {
            var Data = JSON.parse(data);
            var table = document.getElementById("excelstyles");
            var nbody = document.createElement("tbody");
            $("#info_t").empty();
            nbody.id="info_t";
            table.appendChild(nbody);
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
                        + "<td>'"+Data.list[i].settleDate+"</td>"
                        + "<td>'"+Data.list[i].tradeSerialNumber+"</td>"
                        + "<td>"+Data.list[i].ifFee+"</td>"
                        + "<td>"+Data.list[i].addr+"</td>"
                        + "</tr>")
                }
                // page = new Page(8, "excelstyles", "info_t");
                // $("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
            $("#waiting").hide();
            console.log(Data);
        }
    });
}



</script>
</html>
