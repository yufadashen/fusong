var Card = new CardPayment(plugin, "读卡器");
var Pad = new PinPad(plugin, "密码键盘");
/*var CashBV = new CashPayment(plugin, "识币器");*/
/*var Printer = new ReceiptPrinter(plugin, "清单打印机");*/
function homePage()
{
	loadPage('home.html',-1);
}

function retValues()
{
	entity = "";
	transMoney = "";
	transNo = "";
	curOper = "";
	punishNo = "";
	punishMoney = "";
	cardNo = "";
	track2 = "";
	track3 = "";
	ICData = "";
	pinData = "";
	nxCard=false;
}

function openDevices()
{
	//CashBV.OpenDevice(5);
	//Card.OpenDevice(3);
	Pad.OpenDevice(6);
	/*Printer.OpenDevice(1);*/
}
function openPadDevices()
{
	Pad.OpenDevice(6);
	/*Printer.OpenDevice(1);*/
}
function closePadDevices()
{
	Pad.CloseDevice();
	/*Printer.OpenDevice(1);*/
}
//下载工作密钥 主密钥位置MainKeyIndex PIN工作密钥/MAC工作密钥位置WorkKeyIndex PIN工作密钥/MAC工作密钥值WorkKey
function SetWorkKey(MainKeyIndex,WorkKeyIndex,WorkKey)
{
	return Pad.UpdateWorkKey(MainKeyIndex,WorkKeyIndex,WorkKey);
}

//激活工作密钥  主密钥位置MainKeyIndex PIN工作密钥/MAC工作密钥位置WorkKeyIndex
function ActiveKey(MainKeyIndex,WorkKeyIndex)
{
	return Pad.ActiveWorkKey(MainKeyIndex,WorkKeyIndex);
}

//设置加密参数  若有要求卡号参与加密，设置卡号，方法自动截取12位进行加密，若不要求卡号参与加密，设置为12个0
function SetPan(Pan)
{
	Pad.SetEncryptParameters(Pan);
}

function MAC(InData)
{
	var OutData;
	var aRet = ActiveKey(0,1);
	if(aRet.RetVal==0){
		var eRet = Pad.SetEncryptType(0x20,0x20,0x04); 
		if(eRet.RetVal==0)
		{
			var Ret = Pad.GetDataMAC(InData);
		    if(Ret.RetVal==0)
		    {
		    	OutData = Ret.MAC;
		    }
		}
	}
    return OutData;
}