var  IPHlpOcx = window.parent.IPHlpOcx;
if(IPHlpOcx.contentDocument){
	window.parent.ipAddress = IPHlpOcx.GetHostIP();//获取本机ip地址
}
	 $.session.clear();
	 var shutdown=window.parent.shutdown;
	 var KPrinter=window.parent.KPrinter;
	 var zdbh00 = window.parent.zdbh00;
	 var logger = window.parent.Logger;//日志OCX对象
	 //初始化倒计时时间：60秒
	 var time = window.parent.reTime;
	 
	 function re(){
		$("#zdbh").text(zdbh00);
		 window.parent.money=0;
		 window.parent.jstype=1;
		 window.parent.cztype=1;
		 window.parent.czsucc=0;
		 returnTime();//长时间无操作关机判断
		 document.onkeydown = timeAgin;
		 document.onclick = timeAgin;
		 
	 }
	 function timeAgin(){
		 time = 60;
	 }
	 //倒计时60S后 无操作自动关机
	 function returnTime(){
			myVar=setInterval(
				function(){
					time--;
					if(time==0){
						//定时关机任务
						shutdownt();
					}
				},1000);
	}
	 
	 //定时关机任务
	 function shutdownt(){
		 var date=new Date();
		 var h=parseInt(date.getHours());
		 var m=parseInt(date.getMinutes());
		 if((h==17 && m > 0) ||h>17 || (h==6 && m<25) || h<6){
			 shutdown.ShutdownFunc();
		 }else{
			 setTimeout(function(){ shutdownt(); }, 1000);
		 }
	 }
	$("#tip_s").on("click", function() {
		$("#tip_div").hide();
	});
	//门诊缴费
 	$("#mzcz").bind("click dbclick", function() {
			window.parent.ttype=2;
			window.location.href="../main/readcard.html";
		/* 	
			var status=KPrinter.GetStatusX();
			//alert(status);
			if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
				window.parent.ttype=2;
				window.location.href="/html/main/readcard.html";
			}else if(status="01000000"){
				$.session.set("errormsg","热敏打印机缺纸，请联系工作人员");
				window.location.href="/html/main/error.html";
			}else if(status="00010000"){
				$.session.set("errormsg","热敏打印机卡纸，请联系工作人员");
				window.location.href="/html/main/error.html";
			}else{
				$.session.set("errormsg","热敏打印机脱机，请联系工作人员");
				window.location.href="/html/main/error.html";
			} */
	});
	
	//门诊挂号
	$("#mzgh").bind("click dbclick", function() {
			window.parent.ttype=1; //1挂号， 2缴费
			window.location.href="../main/readcard.html";
			/* 
			var status = KPrinter.GetStatusX();
			if(status=="00000000" || status=="20000000"|| status=="04000000"|| status=="24000000"){
				window.parent.ttype=1;
				window.location.href="../main/readcard.html";
			}else if(status="01000000"){
				$.session.set("errormsg","热敏打印机缺纸，请联系工作人员");
				window.location.href="/html/main/error.html";
			}else if(status="00010000"){
				$.session.set("errormsg","热敏打印机卡纸，请联系工作人员");
				window.location.href="/html/main/error.html";
			}else{
				$.session.set("errormsg","热敏打印机脱机，请联系工作人员");
				window.location.href="/html/main/error.html";
			} */
	});
	
	//住院充值
	$("#zycz").bind("click dbclick", function() {
		window.parent.ttype=3;
		window.location.href="/cxym/cxzyInfo_b.html";
	});
	
	//查询
	$("#zzcx").bind("click dbclick", function() {
		window.parent.ttype=4;
		window.location.href="/cxym/cxmenu.html";
	});
	
	/**三秒连点五下打开管理界面****/
 	var cNum = 0;
 	setInterval(function() {
 		 cNum = 0;
 	}, 3000);
	$("#manageArea").bind("click", function() {
		cNum++;
		if(cNum == 2){
			cNum = 0;
			window.location.href="../manageop/checkPage.html";
		}
	}); 
	function timer(obj, txt) {
		//console.log(txt);
		obj.text(txt);
		 if(window.parent.zdbh00){
			 $("#zdbh").text(window.parent.zdbh00);
		 }
	}
	
	setInterval(showTime, 1000);
	function showTime() {
		var today = new Date();
		var weekday = new Array(7);
		weekday[0] = "星期日";
		weekday[1] = "星期一";
		weekday[2] = "星期二";
		weekday[3] = "星期三";
		weekday[4] = "星期四";
		weekday[5] = "星期五";
		weekday[6] = "星期六";
		var y = today.getFullYear() + "-";
		var month = (today.getMonth()+1) + "-";
		var td_keleyi_com = today.getDate() + " ";
		var d = weekday[today.getDay()];
		var h;
		if(today.getHours() < 10){
			h = "0" + today.getHours() + ":";
		}else{
			h = today.getHours() + ":";
		}
		var m;
		if(today.getMinutes() < 10){
			m = "0" + today.getMinutes() + ":";
		}else{
			m = today.getMinutes() + ":";
		}
		var s;
		if(today.getSeconds() < 10){
			s = "0" + today.getSeconds();
		}else{
			s = today.getSeconds();
		}
		timer($(".Y"), y+month+td_keleyi_com);
		//timer($(".D"), d);
		timer($(".H"), h+m+s);
	}

 re();