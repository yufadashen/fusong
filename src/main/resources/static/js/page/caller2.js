$(function () {
	
	initH();
	initDatagridTable();
	calcLayout();
})

 // 框架尺寸计算
function calcLayout() {

    //调整表格尺寸
    $("#datagridTable").datagrid("resize");

    var sumH = 0;
    $.each($(".calcForTable"), function (i, ele) {
        sumH += $(ele).outerHeight();
    })
    sumH = cPage.winSize.y - sumH;
    $("#datagridTable").datagrid("resize",{
        height: sumH
    });

    if ($("#rightAreaSearch form").outerHeight() < 76) {
        $("#arrowTop").hide();
    }else{
        $("#arrowTop").show();
    }

}



function initH(){
	var hh=$(window).height()-$("#queryForm").outerHeight()-100;	
	$("#datagridTable").height((hh)+"px");
}

//表格初始化
function initDatagridTable(){
    $("#datagridTable").datagrid({
//        url: cPageConfig.dataTableUrl,
    	url: "getPatientList.json?sectionsId=1",
        method: "GET",
        fitColumns: true,
        pagination: true,
        rownumbers: true,
        nowrap: false,
        striped: true,
        collapsible: true,
        singleSelect: false,//是否单选
        checkOnSelect: true,
        remoteSort: false,
        // scrollbarSize: 0,
        autoRowHeight: false,
        columns: [[
            { field: 'id', title: 'ID',hidden:true },
            { field: 'patienId', title: '病人id',hidden:true },
            { field: 'requisitionId', title: '检查号',align:"center", width: 25 },
            { field: 'name', title: '姓名', width: 10,align:"center", width: 20},
            { field: 'sex', title: '性别', align: "center", width: 10 },
            { field: 'emergency', title: '是否急诊', align: "center", width: 15 },
            { field: 'reqDepartment', title: '检查科室', width: 10, align: "center", width: 30 }
//            {
//                field: 'zt', title: '状态', width: 10, align: 'center',
//                formatter: function (value, row, index) {
//                    if (value === "0") {
//                        return '<span style="display:inline-block;width:20px;height:20px;background-color:#18C71B;border-radius:50%;"></span>'
//                    } else if (value === "1") {
//                        return '<span style="display:inline-block;width:20px;height:20px;background-color:#FFDF25;border-radius:50%;"></span>'
//                    } else if (value === "2") {
//                        return '<span style="display:inline-block;width:20px;height:20px;background-color:red;border-radius:50%;"></span>'
//                    }
//                }
//            }
        ]]
    })
    var p = $('#datagridTable').datagrid('getPager');
    // $(p).pagination({
    //     showRefresh: false,
    //     pageSize: 20,
    //     afterPageText: '页,共 {pages} 页,每页',
    //     displayMsg: ',记录总数 {total} 条',
    //     onSelectPage: function (pageNumber, pageSize) {
    //         $('#page').val(pageNumber);
    //         $('#pageSize').val(pageSize);
    //         $(this).pagination('loading');
    //         $('#queryForm').submit();
    //         $(this).pagination('loaded');
    //     }
    // });
    
    $(p).pagination({
        layout:["sep","first","prev","sep","manual","list","条","sep","next","last","sep","refresh","info"],
        beforePageText: '第',
        afterPageText: '页,共 {pages} 页,每页',
        // displayMsg: '显示 {from} 至 {to} 条，共 {total} 条记录',
        onSelectPage: function (pageNumber, pageSize) {
            $('#page').val(pageNumber);
            $('#pageSize').val(pageSize);
            $(this).pagination('loading');
            $('#queryForm').submit();
            $(this).pagination('loaded');
        }
    });
}