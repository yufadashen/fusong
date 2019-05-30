(function ($) {
    var defaults = {
        theme: 'light',
        showYear: true,
        sort: 'desc',
        data: null,
        url: '',
        type: 'GET',
    };
    var methods = {
        init: function (options) {
            
            var settings = $.extend({}, defaults, options);
            return this.each(function () {
                $this = $(this);
                var conHtml = '<div class="tml-container"><div class="tml-lists-year"></div></div>';
                $this.append(conHtml);

                if (!settings.url){
                    console.error("Error: jQuery.timeliner url of params is undefined!");
                    return;
                }
                function asc(a,b) {
                    return Date.parse(a.date.replace(/\./g, '/')) - Date.parse(b.date.replace(/\./g, '/'))
                }
                function desc(a,b) {
                    return Date.parse(b.date.replace(/\./g, '/')) - Date.parse(a.date.replace(/\./g, '/'))
                }
                $.ajax({
                    data: settings.data,
                    url: settings.url,
                    type: settings.type
                }).done(function (result) {
                    var oldYear = '';
                    var oldDate = '';
                    
                    if(settings.sort == 'asc'){
                        result.sort(asc);
                        
                    } else if(settings.sort == 'desc'){
                        result.sort(desc);
                    }
                    
                    $.each(result, function (index, obj) {
                        var date = new Date(obj.date.replace(/\./g, '/'));
                        var year = date.getFullYear();

                        var yearHtml = '<div class="tml-title">' + year + '年</div>';

                        var dateConhtml = '<div class="tml-lists-date"></div>';

                        var dateHtml = '<div class="tml-list-date">' + obj.date + '</div><div class="tml-lists-items"></div>';

                        var msgHtml = '<div class="tml-lists-items-con"><div class="tml-item-symb"><span class="tml-symb-cir"></span>' +
                            '</div><div class="tml-item-con"><p class="tml-item-text">' + obj.title + '</p></div></div>';
                        
                        if (year != oldYear) {//新年份

                            $(".tml-lists-year").last().append(yearHtml);//插入年份

                            $(".tml-lists-year").last().append(dateConhtml);//插入日期容器

                            $(".tml-lists-date").last().append(dateHtml);//插入日期

                            $(".tml-lists-items").last().append(msgHtml);//插入内容
                        } else {
                            if (obj.date != oldDate) {//新日期

                                $(".tml-lists-year").last().append(dateConhtml);

                                $(".tml-lists-date").last().append(dateHtml);

                                $(".tml-lists-items").last().append(msgHtml);

                            } else {

                            }
                        }
                        oldYear = year;
                    })
                    
                    //默认显示年份
                    if(!settings.showYear){
                        $this.find(".tml-title").hide();
                    }

                    //执行onLoadSucces函数
                    if (settings.onLoadSuccess) {
                        settings.onLoadSuccess.call($this);
                    }
                })
            })
        },
        hideyears: function () {
            $(".tml-title").hide();
        }
    };

    $.fn.timeliner = function (method) {
        // 方法调用
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method:' + method + ' does not exist in jQuery.timeliner');
        }
    }
})(jQuery)