var cPageT = {

    //初始化uni表单
    initTable: function () {
        $.each($(".uni-table"), function (i, _table) {

            var cloneHtml = $(_table).children("tbody").children("tr").last().get(0).outerHTML;

            $(_table).attr("rowObj",cloneHtml);

        })
    },

    //uni表单增删行
    tableRowOper: function () {
        $.each($(".uni-table"),function (i,_table) {

            //add
            $(_table).on("click",".addRowBtn",function () {
                var cloneObj = $($(_table).attr('rowObj')).clone(false, true);
                $(_table).append(cloneObj);
                cPageT.rowNumCalc(_table);
            })

            //delete
            $(_table).on("click",".delRowBtn",function () {
                if ($(_table).find("tbody tr").length > 1){
                    $(this).parents('tr:first').remove();
                    cPageT.rowNumCalc(_table);
                }
                
            })
        })
    },

    //表单序号计算
    rowNumCalc: function (_table) {
        $(_table).find(".uni-row-index").each(function (i, ele) {
            $(ele).html(i + 1);
        });
    }

}

$(function () {
    cPageT.initTable();
    cPageT.tableRowOper();
})