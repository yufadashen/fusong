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
					window.location.href="/html/main/main.html";
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
			window.location.href="/html/main/main.html";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href="/html/main/main.html";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		$("#confirmApp").on("click", function(){
			$.session.clear();
			window.location.href="/html/main/main.html";
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
		printer.WriteTextLineX("      抚松县人民医院自助挂号凭条");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      —————————————————————");
		Printer.PrintBarCodeX(73,100,4,window.parent.OutpatientId);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      姓名："+window.parent.Name+"  性别: "+window.parent.Sex);
		printer.WriteTextLineX("          ");
		Printer.WriteTextLineX("  	  ID号：" + window.parent.OutpatientId);
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);
		printer.WriteTextLineX("      挂号日期：" + currDate);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂号时间：" + currTime);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂号科室:" + $.session.get('keshi'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(1);	
		printer.WriteTextLineX("      挂号医生:"+$.session.get('doctor'));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      就诊位置："+$.session.get('jzwz00'));
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      挂  号  费："+$.session.get("TotalFee"));
		printer.WriteTextLineX("          ");
		printer.SetTextModeX(0);	
		printer.WriteTextLineX("      *请尽快到候诊区候诊，避免过号！*");
		printer.WriteTextLineX("      —————————————————————");
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      打印时间："+currDate+" "+currTime);
		printer.WriteTextLineX("          ");
		printer.WriteTextLineX("      1.请您按照候诊区显示屏上的呼叫信息有序");
		printer.WriteTextLineX("      就诊，具体就诊时间以屏幕实际呼叫为准！");
		printer.WriteTextLineX("      2.预约分诊单当日有效，预约当日该医师有可");
		printer.WriteTextLineX("      能遇急事不能坐诊，请您谅解！");
		printer.WriteTextLineX("      3.此凭条不做报销凭证，就诊完毕后，可到各");
		printer.WriteTextLineX("      楼层收费窗口打印发票");
		printer.LFX(2);
		printer.CeTCutX(); 						//切纸
	}
	
	init();