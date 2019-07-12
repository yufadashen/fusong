
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
	var sumJFJE=0;
	var RecipeNos = new Array();
	var Data;
	//获取缴费明细
	function getAppInfo() {
		var datas = {
			"OutpatientIds":window.parent.OutpatientId,
			"PaymentStatus":"0"//支付状态    0: "未支付"; 1: "已支付";2: "已退费"; 3: "部分退费"; 4: "金额错误";5: ”已取消” null 查询全部
		};
		$.ajax({
			async : true,
			type : "post",
			data : datas,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			url:window.parent.serverUrl+"GetOutpatientIdFeeList",
			success : function(json) {
				var Data = JSON.parse(json);
				if (Data.Code == "0") {
					var temp = Data.Departments;
					if(!$.isEmptyObject(temp)){
						var j = 0;
						for(var key in temp){
							j++;
							var temp1 = temp[key];
							var opDate = temp1[0].OperDate.slice(0,4)+"年" +temp1[0].OperDate.slice(4,6)+"月"+temp1[0].OperDate.slice(6,8)+"日 "
											+temp1[0].OperDate.slice(8,10)+":"+temp1[0].OperDate.slice(10,12)+":"+temp1[0].OperDate.slice(12,14);
							$("#info_s").append(
									"<tr class=\"tb_tr\">"
									+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(j)+"</div></td>"
									+ "<td>"+key+"</td>"
									+ "<td>"+opDate+"</td>"
									+ "<td onclick='jfchoose(this)' style=''><div style='width:60px;height:30px;background-color:#3f7dac;border-radius: 7px;line-height: 30px;'>缴费</div></td>"
								+ "</tr>"
							);
						}
					}else{
						$("#waiting").hide();
						$("#tip_div").show();
						$("#error").text("没有查询到收费项目！");	
					}
					
				} else {
					goError(data.retmsg);
				}
				$("#waiting").hide();
			},
			error : function() {
				goError("系统异常,请稍后再试!");
			}
		}); 
	}	
	
	function showOp(regNo){
		if(Data && Data.Departments){
			Data = Data.Departments[regNo];
			var length = Data.length;
			$("#chooseRegNo").hide();
			for (var i = 0; i < length; i++) {
				$("#info_t").append(
					"<tr class=\"tb_tr\">"
						+ "<td class=\"tb_td\" style=\"width:50px;\"><div style=\"margin-left: 10px;border-radius:3px;width:30px;background-color:#3f7dac;behavior:url(../../js/PIE.htc);\">"+parseInt(i+1)+"</div></td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemName+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemNum+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemPrice+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].ItemSpec+"</td>"
						+ "<td class=\"tb_td\">"+Data[i].TotalCost+"</td>"
					+ "</tr>")
				sumJFJE += parseFloat(Data[i].TotalCost);
				RecipeNos.push(Data[i].RecipeNo);//取所有收费项目编号放入数组查询订单需要传输的参数
			}
			sumJFJE = Math.floor(sumJFJE * 100) / 100;//总金额取小数点后两位
			$("#zfy").text(sumJFJE);//表头显示总价
			
			page = new Page(8, "keshi_t", "info_t");
			$("#confirmBtn").text((page.pageIndex+1)+"/"+page.pageCount);
		}
	}
	function jfchoose(obj){
		var regNo = obj.parentNode.childNodes[1].innerHTML;
		showOp(regNo);
	}
	//去重数组
	Array.prototype.unique = function(){
		 var res = [];
		 var json = {};
		 for(var i = 0; i < this.length; i++){
		  	if(!json[this[i]]){
			   	res.push(this[i]);
			   	json[this[i]] = 1;
		  	}
		 }
		 return res;
	}
	//缴费操作
	function jfOperation(){
		if(sumJFJE>0){
			RecipeNos = RecipeNos.unique();
			$.session.set("RecipeNos", RecipeNos);
			$.session.set("TotalFee",sumJFJE);
			window.location.href="/pay/lypayway.html";
		}
	}
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="/main/error.html";
	}
	/**
	*初始化操作
	**/
	var init = function(){
		$("#waiting").show();
		$("#cusName").text(window.parent.Name);
		$("#cusBalance").text(window.parent.OutpatientId);
		$("#btnMain").bind("click dbclick", function() {//返回主页
			$.session.clear();
			window.location.href="/main/main.html";
		});
		$("#btnReturn").bind("click dbclick", function() {//返回上一级
			window.location.href = "/main/main.html";
			$("#waiting").show();
		});
		$("#tip_s").on("click", function() {
			$("#tip_div").hide();
			window.location.href="/main/main.html";
		});
		returnTime();//倒计时
		document.onkeydown = timeAgin;
		document.onclick = timeAgin;
		
		setTimeout("getAppInfo();",500);//获取预约信息
		$("#btnJF").bind("click dbclick", function() {//点击缴费
			jfOperation()
		});
	}
	init();