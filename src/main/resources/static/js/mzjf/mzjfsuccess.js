	//初始化倒计时时间：120秒
	var time = 120;
	//用户点击或按键等操作时，倒计时重新计时
	function timeAgin() {
		time = 120;
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
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="/main/main.html";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href="/main/main.html";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#confirmApp").on("click", function(){
			$.session.clear();
			window.location.href="/main/main.html";
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		$("#waiting").hide();
		alert("打印凭条");
		//print();
	}
	//打印挂号小票
	function print(){
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hours=date.getHours();
        var minutes=date.getMinutes();
        var seconds=date.getSeconds();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
        if(hours<10){
        	hours="0"+hours;
        }
        if(minutes<10){
        	minutes="0"+minutes;
        }
        if(seconds<10){
        	seconds="0"+seconds;
        }
        var currDate = year+"-"+month+"-"+day;
        var currTime = hours+":"+minutes+":"+seconds;
		var printer=window.parent.KPrinter;
		printer.SetFontModeAndTypeX(0x00,0x00);	//设置字体
		printer.SetTextModeX(1);				//设置中文模式
		printer.WriteTextLineX("      抚松县人民医院自助缴费凭条");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      —————————————————————");
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      姓名："+window.parent.Name+"  性别: "+window.parent.Sex);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      缴费日期：" + currDate);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      缴费时间：" + currTime);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      缴费金额:" + $.session.get('TotalFee'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      —————————————————————");
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      打印时间："+currDate+" "+currTime);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      注意事项：");
		printer.WriteTextLineX("      (1)本凭证只作核对作用，不做报销凭证。");
		printer.WriteTextLineX("      (2)退款凭本收据或本人身份证。");
		printer.LFX(2);
		printer.CeTCutX(); 						//切纸
	}
	
	init();