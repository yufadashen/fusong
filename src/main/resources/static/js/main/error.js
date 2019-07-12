	var time = 10;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 10;
	}
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					$.session.clear();
					//跳转页面
					window.location.href="/main/main.html";
				}
			},1000);
	}
	function event(){
		$("#mainPage").bind("click dbclick", function() {//返回主页
			window.location.href="/main/main.html";
		});
		$("#backPage").bind("click dbclick", function() {//返回上一级
			window.location.href="/main/main.html";
		});
	}
	function init(){
		$("#msg").text($.session.get("errormsg"));
		event();
		returnTime();
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
	}
	init();