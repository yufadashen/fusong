<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/jsp/sys/file/common.jspf" %>

<html>
<head>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>
    <title>对账统计</title>

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




        </script>

</head>
<body>
<div class="print_databox">
    <div class="data_tablebox">
        <div class="print_info_btns text_r">
            <!-- <a class="prints_btn_com" id="exportList" >导出EXCEL</a> -->
            <span>&nbsp;&nbsp;</span>
            <button class="prints_btn_com" onclick="javascript:window.print()" >打印</button>
        </div>
        <div style="font-size:20px; font-weight:bold; line-height:30px; text-align:center;">
            <span style="text-decoration: underline;">对账统计</span>
            <h2 style="font-size: 20px; letter-spacing:10px; text-align:center">对账统计表</h2>
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
                <th align="center">部门\类别</th>
                <th align="center">缴费次数</th>
                <th align="center">总金额 </th>
            </tr>
            </thead>
            <tbody id="info_t"  >

            </tbody>
        </table>

    </div>
    <div id="popResetPsw" style="text-align:right;">
        <a href="#" onclick="doExport()">导出Excel表格</a>
    </div>
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
        "startTime":$("#sj1").val()==""?currentdate1:$("#sj1").val(),
        "endTime":$("#sj2").val()==""?currentdate2:$("#sj2").val()
    };
    $.ajax({
        type: 'post',
        url: '/ReconciliationTJ',
        dataType: 'json',
        data : datas,
        success: function (data) {
            var Data = JSON.parse(data);
            var table = document.getElementById("excelstyles");
            var nbody = document.createElement("tbody");
            $("#info_t").empty();

            nbody.id="info_t";
            table.appendChild(nbody);

                    $("#info_t").append(
                        "<tr>" +
                        "                <th align=\"center\">挂号缴费</th>" +
                        "                <td align=\"center\" id=\"gh1\">"+Data.info.gh1.ghCount+"</td>" +
                        "                <td align=\"center\" id=\"gh2\">"+parseFloat(Data.info.gh1.ghSum)/100 +"</td>" +
                        "            </tr>" +
                        "            <tr>" +
                        "                <th align=\"center\">门诊缴费</th>" +
                        "                <td align=\"center\" id=\"mz1\">"+Data.info.mz2.mzCount+"</td>" +
                        "                <td align=\"center\" id=\"mz2\">"+parseFloat(Data.info.mz2.mzSum)/100+"</td>" +
                        "            </tr>" +
                        "            <tr>" +
                        "                <th align=\"center\">住院预交金</th>" +
                        "                <td align=\"center\" id=\"zy1\">"+Data.info.zy3.zyCount+"</td>" +
                        "                <td align=\"center\" id=\"zy2\">"+parseFloat(Data.info.zy3.zySum)/100+"</td>" +
                        "            </tr>" +
                        "            <tr>" +
                        "                <th align=\"center\">合计</th>" +
                        "                <td align=\"center\" id=\"hj1\">"+Data.info.hj.count+"</td>" +
                        "                <td align=\"center\" id=\"hj2\">"+parseFloat(Data.info.hj.sum)/100+"</td>" +
                        "            </tr>");

            $("#waiting").hide();
            console.log(Data);
        }
    });
}
goNext();


</script>
</html>
