	//初始化倒计时时间：60秒
	var time = 30;
	//自动倒计时，计时时间为0时，
	function returnTime(){
		myVar=setInterval(
			function(){
				time--;
				$("#time").text(time);
				if(time==0){
					//跳转页面
					window.location.href = "/html/main/main.html";
				}
			},1000);
	}
	//用户点击或按键等操作时，倒计时重新计时
	document.onkeydown = timeAgin;
	document.onclick = timeAgin;
	function timeAgin(){
		time = window.parent.reTime;
	}
	returnTime();

	//读取身份证信息
	//var idCarder = window.parent.idCarder;
  	function readCard(){
  		window.parent.Name = "岳帅锋";
  		window.parent.idCardNo = "410327199011276410";
  		window.parent.Sex = "1";
  		window.parent.brith = "19901127";
  		getBridInfo();
  		
  		/* 
		var status=idCarder.OpenDeviceAndReadCard(1001,200);//usb串口
		//log.WriteLog("打开身份证读卡："+status);
		if(status=="0"){
			window.parent.Name = idCarder.GetCardInfo(0);
			window.parent.Sex = idCarder.GetCardInfo(1);
			window.parent.idCardNo = idCarder.GetCardInfo(5);
			window.parent.brith = idCarder.GetCardInfo(3);
			//log.WriteLog("读取身份证信息："+window.parent.xming0+window.parent.sfzhao);
			if(window.parent.xming0 && window.parent.sfzhao){
				getBridInfo();
			}else{
				message("身份证读取失败！请联系工作人员！");
			}
		}else{
			setTimeout("readCard();", 800);
		}
		 */
  	}
  	//根据身份证查询基本信息
  	function getBridInfo(){
		 var datas = {"Name":window.parent.Name,//姓名
					  "PapersNo":window.parent.idCardNo,//证件号
					  "PapersType":"1",//证件类型
				      "PhoneNo":"",//电话号
				      "Gender":window.parent.Sex,//性别 1男2女
				      "BirthDate":window.parent.brith//出生日期格式yyyyMMdd
				      };
		 // debugger
			$.ajax({
				async:true,
				type:"post",
				data:datas,
				dataType:"json",
				contentType: "application/x-www-form-urlencoded;charset=utf-8", 
				url:window.parent.serverUrl+"FindPatient",
				success:function(json){
					var Data = JSON.parse(json);
					if(Data.Code == "0"){
						window.parent.OutpatientId=Data.Departments[0].OutpatientId;
						window.parent.CardType=Data.Departments[0].CardType;
						window.parent.CardNo=Data.Departments[0].CardNo;
						window.parent.Balance=Data.Departments[0].Balance;
						window.parent.Limit=Data.Departments[0].Limit;
						window.parent.CreateTime=Data.Departments[0].CreateTime;
						window.parent.CardName=Data.Departments[0].CardName;
						window.parent.Enable=Data.Departments[0].Enable;
						var type=window.parent.ttype;
						if(type==1){
							window.location.href="/mzgh/ghkebie.html";//门诊挂号
							//window.location.href="/html/mzgh/ghkebie.html";
						}else if(type==2){//门诊缴费
							window.location.href="../mzjf/mzjf2.html";//门诊挂号
						}if(type==30){//查询挂号信息
							window.location.href="../cxym/cxghInfo.html";//查询挂号信息
						}
					}else{
						message("失败！");
					}
											
				},
				error:function(){
					goError("系统异常，请稍后再试！");
				}
			});
  	}
	function message(message) { //提示信息
		if($("#waiting")){
			$("#waiting").hide();
		}
		$("#tip_div").show();
		$("#error").text(message);
		$("#tip_s").off().on("click", function() {
			$("#tip_div").hide();
			window.location.href = "/main/main.html";
		});
		return;
	}
	//跳转提示页面
	function goError(msg){
		$.session.set("errormsg",msg);
		window.location.href="/main/error.html";
	}
  	$("#main").bind("click dbclick", function() {
		window.location.href="/main/main.html";
	});
  	$("#next").bind("click dbclick", function() {
		window.location.href="/main/readCardType.html";
	});
  	$("#fanhui").bind("click dbclick", function() {
		window.location.href="/main/main.html";
	});
  	function init(){
	  	readCard();
  	}
  	init();