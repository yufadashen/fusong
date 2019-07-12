	var kebie; //科室
	var kbid00;//科室代码
	var cardNo = window.parent.cardNo;
	var xming0 = window.parent.xming0;//患者名称
	var xbie00 = window.parent.xbie00;//患者性别
	var brnl00 = window.parent.brnl00;//病人年龄
	var fssj00;//发送时间
	var	ksczrq;//开始日期时间
	var	jsczrq;//结束日期时间
	var sjdms01;//时间点编号
	//初始化倒计时时间：120秒
	var time = 120;
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
	/**
	* //TODO
	* 点击当前科别信息的时候，截取需要的文本内容
	* 赋值给变量，并存入session中，在页面之间进行
	* 切换的时候的初始化该值
	**/
	function clickKebie(obj) {//点击的时候 把改方框内的文本取出，按照内容复制给需要的变量
		kebie = obj.children[0].innerText;//名称
		kbid00 = obj.children[1].innerText;//id
		var kbLocation = obj.children[2].innerText;//就诊位置
		$.session.set('kebie', kebie);
		$.session.set('kbid00', kbid00);
		window.location.href = "/mzgh/ghdoctor2.html";
		$("#waiting").show();
	}
	
	//获取科别信息
	function getKebie() {
			var datas = {};
			$.ajax({
				async : true,
				type : "post",
				data : datas,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				url:window.parent.serverUrl+"GetDepts",
				success : function(json) {
					$("#waiting").hide();
					var Data = JSON.parse(json)
					if (Data.Code == "0") {
						//log.WriteLog("卡号:"+carNo+"获取科室列表成功");
						var length = Data.Departments.length;
						for (var i = 0; i < length; i = i + 3) {
							if (i + 2 < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\" style=\"color:white;\">" + Data.Departments[i].DeptName + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;\">" + Data.Departments[i].DeptId + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;display:none;\">" + Data.Departments[i].Location + "</span></div>"
										+"</td>"
										
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\" style=\"color:white;\">" + Data.Departments[i+1].DeptName + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;\">" + Data.Departments[i+1].DeptId + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;display:none;\">" + Data.Departments[i+1].Location + "</span></div>"
										+"</td>"
										
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\" style=\"color:white;\">" + Data.Departments[i+2].DeptName + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;\">" + Data.Departments[i+2].DeptId + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;display:none;\">" + Data.Departments[i+2].Location + "</span></div>"
										+"</td>"
										
										+"</tr>");
							} else if (i + 1 < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\" style=\"color:white;\">" + Data.Departments[i].DeptName + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;\">" + Data.Departments[i].DeptId + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;display:none;\">" + Data.Departments[i].Location + "</span></div>"
										+"</td>"
										
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\" style=\"color:white;\">" + Data.Departments[i+1].DeptName + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;\">" + Data.Departments[i+1].DeptId + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;display:none;\">" + Data.Departments[i+1].Location + "</span></div>"
										+"</td>"
										
										+"</tr>");
							} else if (i < length) {
								$("#info_t").append(
										"<tr>"
										+"<td><div class=\"models\" onclick=\"clickKebie(this)\"><span class=\"remind\" style=\"color:white;\">" + Data.Departments[i].DeptName + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;\">" + Data.Departments[i].DeptId + "</span>"
										+"<span class=\"kbbh\" style=\"color:white;display:none;\">" + Data.Departments[i].Location + "</span></div>"
										+"</td>"
										
										+"</tr>");
							}
						}
						page = new Page(3, "keshi_t", "info_t");
						$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
						/*
						$(".models").bind("click", function(){
							clickKebie(this);
						});
						*/
				} else {
					//log.WriteLog("卡号为:"+cardNo+"获取科室列表失败");
					$("#tip_div").show();
					$("#error").text(Data.retmsg);			
				}
				$("#waiting").hide();
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
		getKebie();
		
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="/main/main.html";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			$.session.clear();
			window.location.href="/main/main.html";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
		});
		
		$("#cusName").text(window.parent.Name);
		$("#cusBalance").text(window.parent.OutpatientId);
		returnTime();
		initStyle();
	}
	init();