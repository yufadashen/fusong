	var RegNo;//号点
	var time = 120;//初始化倒计时时间：120秒
	//自动倒计时，计时时间为0时，
	function returnTime() {
		myVar = setInterval(
			function() {
				time--;
				$("#time").text(time);
				if (time == 0) {
					//跳转页面
					$.session.clear();
					window.location.href="/main/main.html";
				}
			}, 1000);
	}
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin() {
		time = 120;
	}
	returnTime();
	
	function getDate(){
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
        	minutes="0"+day;
        }
        if(seconds<10){
        	seconds="0"+seconds;
        }
		return year+""+month+""+day;
	}
	
	function confirmOp (msg){
		$("#waiting").hide();
		$("#tip_div").show();
		$("#tip_div").show();
		$("#error").text(msg);
	}
	
	
	function clickDoctor(obj) {
		var sysl = $.trim(obj.children[3].innerText);
		if(sysl == "已满"){
			message("当前预约已满，请重新选择。");
			return;
		}else{
			
			var ysxm00 = obj.children[0].innerText;
			$("#chooseDoc").val(ysxm00);
			
			var ScheduleId = obj.children[5].innerText;//号点id
			var RegLevelId = obj.children[6].innerText;//挂号级别id
			var TotalFee = obj.children[7].innerText;//挂号级别id
			var ghDate = obj.children[8].innerText;//挂号日期
			$.session.set("TotalFee", TotalFee);
			var OutpatientId = window.parent.OutpatientId;//病人id
			var DeptId = $.session.get("kbid00");
			//根据患者确认信息，然后进行占号操作
			var datas = {
				"ScheduleId" : ScheduleId,
				"RegLevelId" : RegLevelId,
				"OutpatientId" :OutpatientId,
				"DeptId" : DeptId,
				"ScheduleTime" : ghDate
			};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"OccupyRegPoint",
				success : function(json) {
					$("#waiting").hide();
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						RegNo = Data.Departments[0].RegNo;
						$.session.set("RegNo",RegNo);
						var TotalFee = Data.Departments[0].TotalFee;
						var DiagnoseFee = Data.Departments[0].DiagnoseFee;
						var RegFee = Data.Departments[0].RegFee;
						var InspectFee = Data.Departments[0].InspectFee;
						var SpclFee = Data.Departments[0].SpclFee;
						var CouponInfo = Data.Departments[0].CouponInfo;
						var RmngNum = Data.Departments[0].RmngNum;
						if(RegNo){
							window.location.href = "../pay/lypayway.html";
						}else{
							message("号点为空！");
						}
					}else{
						message("占号点时出错！");
					}	
				},
				error : function() {
					goError("系统异常,请稍后再试!");		
				}
			}); 
		}
	}
	//释放占号
	function sfzhOp(){
		var datas = {
			"RegNo" : $.session.get("RegNo")
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"ReleaseRegPoint",
			success : function(json) {
				var Data = JSON.parse(json)
				if (Data.Code == "0") {
					//log("释放成功！号点："+RegNo);
				}	
			},
			error : function() {
				goError("释放号点时系统异常,请稍后再试!");		
			}
		}); 
	}
	//提示信息
	function message(msg){
		$("#waiting").hide();
		$("#tip_div").show();
		$("#error").text(msg);
	}
	//记录日志
	function log(info){
		log.writeLog(info);
	}
	//获取医生信息
	function getDoctors() {
		var date = new Date();
		var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        if(month<10){
        	month="0"+month;
        }      
        if(day<10){
        	day="0"+day;
        }
		var datas = {
				"DeptId" : $.session.get("kbid00"),
				"OperatorType" : "1",
				"day" : 1
			};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"GetSchedules",
				success : function(json) {
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						var length = Data.Departments.length;
						for (var i = 0; i < length; i = i + 3) {
							if (i + 2 < length) {
								var ss = Data.Departments[i].RmngNum=="0"?"已满":"剩余"+Data.Departments[i].RmngNum+"号";
								var ss1 = Data.Departments[i+1].RmngNum=="0"?"已满":"剩余"+Data.Departments[i+1].RmngNum+"号";
								var ss2 = Data.Departments[i+2].RmngNum=="0"?"已满":"剩余"+Data.Departments[i+2].RmngNum+"号";
								
								var dd = Data.Departments[i].EndTime.slice(0, 4)+"年"+Data.Departments[i].EndTime.slice(4, 6)+"月"+Data.Departments[i].EndTime.slice(6, 8)+"日";
								var dd1 = Data.Departments[i+1].EndTime.slice(0, 4)+"年"+Data.Departments[i+1].EndTime.slice(4, 6)+"月"+Data.Departments[i+1].EndTime.slice(6, 8)+"日";
								var dd2 = Data.Departments[i+2].EndTime.slice(0, 4)+"年"+Data.Departments[i+2].EndTime.slice(4, 6)+"月"+Data.Departments[i+2].EndTime.slice(6, 8)+"日";
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\">"
										+"<div class=\"DrName\">" + Data.Departments[i].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + dd +"</div>"
										+"<div class=\"syghs0\">"+ ss + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i].TotalFee + "元</div>" 
										+"<span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										
										+"<td><div class=\"models\"  >"
										+"<div class=\"DrName\">" + Data.Departments[i+1].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i+1].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + dd2 +"</div>"
										+"<div class=\"syghs0\">"+ ss1 + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i+1].TotalFee + "元</div>" 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i+1].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i+1].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										
										+"<td><div class=\"models\"  >"
										+"<div class=\"DrName\">" + Data.Departments[i+2].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i+2].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + dd2 +"</div>"
										+"<div class=\"syghs0\">"+ ss2 + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i+2].TotalFee + "元</div>" 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i+2].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+2].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+2].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i+2].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										+"</tr>");
							} else if (i + 1 < length) {
								var sss = Data.Departments[i].RmngNum=="0"?"已满":"剩余"+Data.Departments[i].RmngNum+"号";
								var sss1 = Data.Departments[i+1].RmngNum=="0"?"已满":"剩余"+Data.Departments[i+1].RmngNum+"号";
								
								var ddd = Data.Departments[i].EndTime.slice(0, 4)+"年"+Data.Departments[i].EndTime.slice(4, 6)+"月"+Data.Departments[i].EndTime.slice(6, 8)+"日";
								var ddd1 = Data.Departments[i+1].EndTime.slice(0, 4)+"年"+Data.Departments[i+1].EndTime.slice(4, 6)+"月"+Data.Departments[i+1].EndTime.slice(6, 8)+"日";
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\">"
										+"<div class=\"DrName\">" + Data.Departments[i].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + ddd +"</div>"
										+"<div class=\"syghs0\">"+ sss + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i].TotalFee + "元</div>" 
										+"<span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										
										
										
										+"<td><div class=\"models\"  >"
										+"<div class=\"DrName\">" + Data.Departments[i+1].DrName + "</div>" 
										+"<div class=\"RegLevelName\">" + Data.Departments[i+1].RegLevelName + "</div>" 
										+"<div class=\"noon\">" + ddd1 +"</div>"
										+"<div class=\"syghs0\">"+ sss1 + "</div>" 
										+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i+1].TotalFee + "元</div>" 
										+"</span><span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i+1].ScheduleId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].RegLevelId+"</span>"
										+"<span style=\"display:none;\">"+Data.Departments[i+1].TotalFee+"</span>"
										+"<span style=\"display:none;\">" + Data.Departments[i+1].EndTime.slice(0, 8) +"</span>"
										+"</div></td>"
										+"</tr>");
							} else if (i < length) {
								var ssss = Data.Departments[i].RmngNum=="0"?"已满":"剩余"+Data.Departments[i].RmngNum+"号";
								
								var dddd = Data.Departments[i].EndTime.slice(0, 4)+"年"+Data.Departments[i].EndTime.slice(4, 6)+"月"+Data.Departments[i].EndTime.slice(6, 8)+"日";
								$("#info_t").append(
										"<tr>"
											+"<td><div class=\"models\">"
											+"<div class=\"DrName\">" + Data.Departments[i].DrName + "</div>" 
											+"<div class=\"RegLevelName\">" + Data.Departments[i].RegLevelName + "</div>" 
											+"<div class=\"noon\">" + dddd +"</div>"
											+"<div class=\"syghs0\">"+ ssss + "</div>" 
											+"<div class=\"TotalFee\">挂号费：" +Data.Departments[i].TotalFee + "元</div>" 
											+"<span class=\"pbid00\" style=\"display:none;\">"+Data.Departments[i].ScheduleId+"</span>"
											+"<span style=\"display:none;\">"+Data.Departments[i].RegLevelId+"</span>"
											+"<span style=\"display:none;\">"+Data.Departments[i].TotalFee+"</span>"
											+"<span style=\"display:none;\">" + Data.Departments[i].EndTime.slice(0, 8) +"</span>"
											+"</div></td>"
										+"</tr>");
							}
						}
						page = new Page(2, "keshi_t", "info_t");
						$('#confirmBtn').text((page.pageIndex+1)+"/"+page.pageCount);
						
						$(".models").bind("click", function(){
							clickDoctor(this);
						});
						
				} else {
					$("#tip_div").show();
					$("#error").text(Data.Message);			
				}
				$("#waiting").hide();
			//});
			},
			error : function() {
				goError("系统异常,请稍后再试!");		
			}
		}); 
	}	
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="/main/error.html";
	}
	//根据input框内容是否存在值，确认是否进行过该页面的操作，如果有操作，可以进行修改，如果没有，置灰 不可修改
	function initStyle(){
		var inputs = $(".chooseContent");
		$.each(inputs,function(index,temp){
			if(temp.value){
				$(this).parent().css("border","1px #599CE0 solid");
				$(this).parent().prev().removeClass();
				$(this).parent().prev().addClass("chooseType1");//蓝色可点击  
				$(this).next().removeClass();
				$(this).next().addClass("modifys");
				$(this).next().click(goModify);
			}else{
				$(this).parent().css("border","1px grey solid");
				$(this).parent().prev().removeClass();
				$(this).parent().prev().addClass("chooseType");
				$(this).next().removeClass();
				$(this).next().addClass("modifys1");//置灰不可点击
				$(this).next().unbind();//不可点击
			}
		});
	}
	function goModify(){
		var pageName = $(this).attr("id");
		window.location.href = "/mzgh/"+pageName+".html";
		$("#waiting").show();
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		getDoctors();
		$("#chooseKb").val($.session.get('kebie'));
		$("#chooseKs").val($.session.get('keshi'));
		$("#chooseNoon").val($.session.get('noon'));
		
		
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="/main/main.html";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "/mzgh/ghkebie.html";
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		
		$("#cusName").text(window.parent.Name);
		$("#cusBalance").text(window.parent.OutpatientId);
		initStyle();
	}
	init();