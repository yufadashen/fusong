$(function(){
	$('a.inactive').on("click",function(){
		if($(this).next('ul').css('display')=='none'){//关变开
			//自己开
			$(this).addClass("inactives");
			$(this).next("ul").slideDown(100);
			//其他关
			$(this).parent('li').siblings('li').find("a").removeClass('inactives');
			$(this).parent('li').siblings('li').find("ul").slideUp(100);
		}else{
			//开变关
 			$(this).removeClass('inactives');
			$(this).siblings('ul').slideUp(100);
			$(this).parent('li').siblings('li').find("a").removeClass('inactives');
			$(this).parent('li').siblings('li').find("ul").slideUp(100);
		}//else
	});
	
	
	var canClick=$(".canClick");
	canClick.on("click",function(){
		canClick.removeClass("cur");
		$(this).addClass("cur");
	});
	
});
