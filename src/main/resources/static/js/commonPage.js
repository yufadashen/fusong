/**
 * 通用页面js
 * @usage: 使用一个对象命名空间，管理所有全局变量，所有配置均在该对象中配置
 */

//  配置
var cPageConfig = {
    hasZTree: false, // 是否显示左侧树
    hasTab: true, // 是否显示tab
    zTreeUrl: "", // 左侧树url
    dataTableUrl: "getPatientList.json" // 表格的url
}
var cPage = {
    winSize: {
        x: document.documentElement.clientWidth,
        y: document.documentElement.clientHeight,
        update: function () {
            this.x = document.documentElement.clientWidth;
            this.y = document.documentElement.clientHeight;
        }
    },
    initLayout: function () {
        if(!cPageConfig.hasZTree){
            $("#leftArea").hide();
            $("#rightAreaComm").css("marginLeft",0)
        }
        if(!cPageConfig.hasTab){
            $("#rightAreaTab").hide();
            $("#tablePrev").css("marginTop",0)
        }
        if ($("#rightAreaSearch form").outerHeight() < 76) {
            $("#arrowTop").hide();
        }
    },
    // 获取页面部分元素的尺寸
    getEleSize: {
        name: "getEleSize",
        // 计算左侧树的高度
        calcForLeftTree: function () {
            var sumH = 0;
            $.each($(".calcForLeftTree"),function (i,ele) {
                sumH += $(ele).outerHeight();
            })
            sumH = cPage.winSize.y - sumH;
            return sumH;
        }
    },
    
    // 框架尺寸计算
    calcLayout: function () {

        // 计算左侧树容器的高度
        $(".leftTree").height(cPage.getEleSize.calcForLeftTree());

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

    },

    // 目录树配置
    ztreeObj: {
        settings: {
            view: {
                showLine: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {//表示tree的一些事件处理函数
                onClick: function (event, treeId, treeNode) {
                    cPage.nodeClick(event, treeId, treeNode)
                }
            }
        },
        zNodes: [
            { id: 1, pId: 0, name: "服务目录", open: true },
            { id: 11, pId: 1, name: "服务目录", open: true },
            { id: 111, pId: 11, name: "服务目录" },
            { id: 112, pId: 11, name: "服务目录" },
            { id: 113, pId: 11, name: "服务目录" },
            { id: 114, pId: 11, name: "服务目录" },
            { id: 12, pId: 1, name: "服务目录", open: false },
            { id: 121, pId: 12, name: "公告" },
            { id: 122, pId: 12, name: "通知" },
            { id: 123, pId: 12, name: "决定" },
            { id: 124, pId: 12, name: "纪要" },
            { id: 13, pId: 1, name: "2015年", open: false },
            { id: 131, pId: 13, name: "公告" },
            { id: 132, pId: 13, name: "通知" },
            { id: 133, pId: 13, name: "决定" },
            { id: 134, pId: 13, name: "纪要" }
        ],
        url: cPageConfig.zTreeUrl
    },
    nodeClick: function (event, treeId, treeNode) {
        // console.log(treeNode)
        $("#datagridTable").datagrid('load', {
            //your code
        })
    },
    // 搜索项折叠
    searchAreaToggle: function () {
        $("#arrowTop").click(function () {
            var $_this = $(this);
            if (!$_this.hasClass("closed")){
                $("#rightSearchCon").animate({
                    height: "38px"
                }, 300, function () {
                    $_this.addClass("closed");
                    cPage.calcLayout();
                })
            }else{
                if ($("#rightAreaSearch form").outerHeight() >= 76){
                    $("#rightSearchCon").animate({
                        height: $("#rightAreaSearch form").outerHeight()
                    }, 300, function () {
                        $_this.removeClass("closed");
                        cPage.calcLayout();
                    })
                }
            }
        })
    },

    // 表格初始化
    initDatagridTable: function(){
        $("#datagridTable").datagrid({
            url: cPageConfig.dataTableUrl,
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
                { field: 'ck', checkbox: true },
                // { field: 'flh', title: '分录号', width: 5 },
                { field: 'lcb', title: '里程碑', width: 10 },
                { field: 'dcbz', title: '达成标志', width: 15 },
                { field: 'zrr', title: '责任人', width: 10 },
                { field: 'jhks', title: '计划开始', width: 10,align:"right", sortable:true },
                { field: 'jzdcrq', title: '基准达成日期', align: "right", width: 10 },
                { field: 'yjdcrq', title: '预计达成日期', align: "right", width: 10 },
                { field: 'jd', title: '进度', width: 10, align: "right" },
                {
                    field: 'zt', title: '状态', width: 10, align: 'center',
                    formatter: function (value, row, index) {
                        if (value === "0") {
                            return '<span style="display:inline-block;width:20px;height:20px;background-color:#18C71B;border-radius:50%;"></span>'
                        } else if (value === "1") {
                            return '<span style="display:inline-block;width:20px;height:20px;background-color:#FFDF25;border-radius:50%;"></span>'
                        } else if (value === "2") {
                            return '<span style="display:inline-block;width:20px;height:20px;background-color:red;border-radius:50%;"></span>'
                        }
                    }
                }
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
    },

    // 切换tab
    changeTab: function () {
        $("#tabUl > li").click(function () {
            $(this).addClass("tab-active").siblings().removeClass("tab-active");
            $("#datagridTable").datagrid('load',{
                //your code
            })
        })
    },

    //查询提交
    searchAction: function () {
        $('#searchForm').form({
            url: cPageConfig.dataTableUrl,
            onSubmit: function () {
                // do some check
                // return false to prevent submit;
            },
            success: function (data) {
                console.log(data)
            }
        });
        // submit the form
        $('#searchForm').submit();
    },

    //新增
    addMethod: function () {
        layer.open({
            title: "新增",
            type: 2,
            content: "./commonPageAdd.html",
            area: ["800px","600px"]
        });
    },

    //编辑
    editMethod: function () {
        layer.open({
            title: "编辑",
            type: 2,
            content: "./commonPageEdit.html",
            area: ["800px", "600px"]
        });
    },
}

$(function () {
    
    // 初始化布局
    cPage.initLayout();

    // 初始化左侧树
    if (cPageConfig.hasZTree) {
        $.fn.zTree.init($("#ztree"), cPage.ztreeObj.settings, cPage.ztreeObj.zNodes);
    }

    // 搜索项折叠
    cPage.searchAreaToggle();

    // 初始化数据表格
    cPage.initDatagridTable();

    //计算布局
    cPage.calcLayout();

    // 切换tab
    cPage.changeTab();

    // 窗口缩放
    $(window).resize(function () {

        cPage.winSize.update();

        cPage.calcLayout();

        if (!$("#arrowTop").hasClass("closed")){
            $("#rightSearchCon").height($("#rightSearchCon").children("form").outerHeight());
        }

        
    })

})