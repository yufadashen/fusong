/**
 * COMMON JS
 * @description 通用方法集合
 */

//通用方法
var uniMethods = {

    //自执行函数 定义
    exec: {

    },
    //文档加载后执行函数 定义
    load: {

        //easyui combobox 宽度自适应
        easyuiComboboxWidthAuto: function () {
            $.each($("select.easyui-combobox:not('.uni-select-full')"), function (i, ele) {
                $(ele).combobox({
                    width: function () {
                        return $(ele).outerWidth() + 36;
                    }()
                })
            })
            $.each($("select.easyui-combobox.uni-select-full"), function (i, ele) {
                $(ele).combobox({
                    width: function () {
                        return $(ele).parent().outerWidth();
                    }()
                })
            })
        }
    }
    
}

//自执行函数 执行
!function () {
    
}()

//文档加载后执行函数 执行
$(function(){
    
    uniMethods.load.easyuiComboboxWidthAuto();
    
})

// 窗口缩放执函数 执行
$(window).resize(function () {

    uniMethods.load.easyuiComboboxWidthAuto();
})

