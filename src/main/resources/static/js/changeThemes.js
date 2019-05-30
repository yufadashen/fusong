//定义皮肤路径
var stylePathObj={
	"blue":"themes/blue/",
	"brown":"themes/brown/",
	"green":"themes/green/"
};
//一旦进入页面就加载的皮肤
var nowPath=stylePathObj.blue;
$(function(){
	loadTheme();
});
//通过用户选择，选择皮肤
function getThemePath(color){
	nowPath=stylePathObj[color];
	loadTheme();
}
//加载皮肤
function loadTheme(){
	var styleDoc=$(".styleDoc");
	styleDoc.each(function(index, element) {
        var href=$(this).attr("_href");
		var newHref=nowPath+ href;
		$(this).attr("href",newHref);
    });
}

