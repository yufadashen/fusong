 /*var serverUrl = "http://192.9.10.212:8888/";*/
 var serverUrl = "http://boyi.natapp1.cc/";
 var reTime = 120;//倒计时时间
 var OutpatientId;//病人id
 var Name;
 var Sex;
 var idCardNo;
 var brith;
 var PapersNo;
 var ttype;//操作类型
 var ipAddress = "0.0.0.0";//本机ip
 
 var CardNo;//卡号
 var CardType;//医院定义的卡类型
 var CardNo;//卡号
 var Balance;//卡内余额
 var Limit;// 日限额
 var CreateTime;//创建时间
 var CardName;// 卡名称
 var Enable;// 数据状态

 
 
 //硬件状态开始*************************
 var Reader = document.getElementById("AVFOCX");
 var KPrinter = document.getElementById("AVFOCX2"); 
 var Logger = document.getElementById("AVFOCX3");
 var shutdown=document.getElementById("AVFOCX4");
 var idCarder = document.getElementById("IDCARD");
 var IPHlpOcx = document.getElementById("IPHlpOcx");//获取本地IP

 function openDevices(){

	 var bb = KPrinter.OpenAndSetCOMX("COM1",19200);
	 var cc = idCarder.OpenDeviceAndReadCard(4,10);
	 var aa = Reader.OpenCardReader(2,4);
  
 } 
 //硬件状态结束*-***********************

 //openDevices();