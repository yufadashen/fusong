/************************************************************************/
/* 								应天海乐自助驱动脚本																	
									author:zhuoqiang 2011-02-12														*/
/************************************************************************/
/************************************************************************/
/* 
 通用返回说明 ：RetVal:0为成功. 非0为错误，可取ErrorInfo取到相对应该错误信息
 密码键盘 状态码
103000	正常、主密钥已安装
303001	设置工作密钥失败
303002	设置工作状态失败
303003	获取密文失败
303004	获取明文失败
403001	主密钥失效或未安装
403002	通讯故障
403003	端口不存在（端口指串口或并口）
403004	端口打开失败
403005	无响应（设备未连接，通讯超时，设备故障）
403006	数据接收异常
                                                                     		*/
/************************************************************************/

function PinPad(plugin, deviceName){
    this.deviceName = deviceName;
    this.deviceID;
    this.msgInfo;
    this.plugin = plugin;
    this.debug = false;
    //加载驱动
    
    this.LoadDevice = function(){
        this.deviceID = this.plugin.NewDevice(this.deviceName);
        if (this.deviceID == -1)
            this.msgInfo = "加载设备文件失败";
        else if (this.deviceID == -2)
            this.msgInfo = "设备文件错误";
        else
            this.msgInfo = "成功";
        
        if (this.deviceID < 0)
            alert("加载"+deviceName+"驱动失败");
    }
    //调用驱动指定的函数funcName
    //paramJson为驱动所要的参数.
    this.Call = function(funcName, paramJson){
        
        
        if (this.debug){
           // alert(JSON.stringify(paramJson));
            this.ShowDebugInfo(funcName,JSON.stringify(paramJson));
            
        }
        str = this.plugin.Call(this.deviceID, funcName, JSON.stringify(paramJson));
        if (this.debug){
        	this.ShowDebugInfo(funcName,str);
            
        }
        return obj = eval('('+str+')');
    }
    //释放设备
    this.Release = function(){
        return this.plugin.DelDevice(this.deviceID);
    }
    //启用调试信息
   this.SetDebug = function(debugDiv){
   	    this.debug=true;
   	    this.debugDiv=debugDiv; 
    }
 
    this.ShowDebugInfo = function(funcName,info)
    {
    	if(this.debugDiv!=null)
    	{ 
    		var Div = document.getElementById(this.debugDiv);
    		if(Div!=null)
    		{
    			Div.innerHTML="<font color=red>["+funcName+"]</font>";
    			Div.innerHTML+="</font>";
    			Div.innerHTML +=info;
    			Div.innerHTML +="<br>";
    		}
    	}
    	
    }
    //打开设备 Port为0时为自动获取配置.
    //RetVal 0:成功, 非0:失败 ErrorInfo:错误信息
    this.OpenDevice = function(Port){
        var paraminfo=[
        				 {name:'Port', type:'int',value:Port},                
                 {name:'ErrorInfo', type:'char*', size:200} //包含size表示数据会返回到变量里通过json返回.
                 ];
                     
        return this.Call('OpenDevice', paraminfo);
    }
    
    //关闭设备
    //RetVal 0:成功, 非0:失败
    this.CloseDevice = function(){
        var paraminfo=[              
                 {name:'ErrorInfo', type:'char*', size:200}];
       
        return this.Call('CloseDevice', paraminfo);
    }
    
    
    
    //取设备状态
    //RetVal 0:成功, 非0:失败
    this.GetDeviceStatus = function(){
        var paraminfo=[
               {name:'ErrorInfo', type:'char*', size:200}
               ]    
        return this.Call('GetDeviceStatus', paraminfo);
    } 

/************************************************************************/
/* 设置工作模式 Work_Mode ：0  明文 1.密文                              */
/************************************************************************/

   this.SetWorkMode = function(Work_Mode){
        var paraminfo=[
        			{name:'Work_Mode', type:'int',value:Work_Mode},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetWorkMode', paraminfo);
    }  
/************************************************************************/
/* 激活工作密钥  Master_Key_No :主密钥号
  Work_Key_No:工作密钥号                                                                  */
/************************************************************************/
    this.ActiveWorkKey = function(Master_Key_No,Work_Key_No){
        var paraminfo=[	
        			{name:'Master_Key_No', type:'int',value:Master_Key_No},
        			{name:'Work_Key_No', type:'int',value:Work_Key_No},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('ActiveWorkKey', paraminfo);
    }  
    
/************************************************************************/
/* 取键值  RetVal: 0 ,表示没收到键值                                     */
/************************************************************************/ 
   this.GetNextKey = function(){
        var paraminfo=[
               {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('GetNextKey', paraminfo);
    }  
/************************************************************************/
/* 取键值  RetVal: 0 ,表示没收到键值                                     */
/************************************************************************/ 
   this.GetPIN = function(){
        var paraminfo=[
        			 {name:'pData', type:'char*',size:200,value:''}, 
        			 {name:'OutLen', type:'int*', value:16}, 
               {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('GetPIN', paraminfo);
    }  
/************************************************************************/
/* 更新工作密钥  Master_Key_No:主密钥号
 Work_Key_No:工作密钥号      
Key_Data :密钥                                                           */
/************************************************************************/

 this.UpdateWorkKey = function( Master_Key_No,  Work_Key_No, Key_Data){
        var paraminfo=[
          
        			{name:'Master_Key_No', type:'int',value:Master_Key_No},
        			{name:'Work_Key_No', type:'int',value:Work_Key_No},
        			{name:'Key_Data', type:'char*',value:Key_Data},       			
            	{name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('UpdateWorkKey', paraminfo);
    }  
/************************************************************************/
/* 设置PIN输入长度                                                       */
/************************************************************************/
   this.SetMaxPIN = function(Max_Size){
        var paraminfo=[
        			{name:'Max_Size', type:'int',value:Max_Size},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetMaxPIN', paraminfo);
    }    
      
/************************************************************************/
/* 设置卡号                                                              */
/************************************************************************/    
    this.SetEncryptParameters = function(Pan){
        var paraminfo=[
        			{name:'Pan', type:'char*',value:Pan},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetEncryptParameters', paraminfo);
    }      
/************************************************************************/
/* 加密数据                                                              */
/************************************************************************/
    
  this.EncryptData = function(pData){
        var paraminfo=[
        			{name:'pData', type:'char*',size:200,value:pData},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('EncryptData', paraminfo);
    }      
/************************************************************************/
/* 解密数据                                                              */
/************************************************************************/    
    this.DecryptData = function(pData){
        var paraminfo=[
        			{name:'pData', type:'char*',size:200,value:pData},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('DecryptData', paraminfo);
    }  
    
 /************************************************************************/
/* 获取MAC                                                             */
/************************************************************************/    
    this.GetDataMAC = function(pData){
        var paraminfo=[
        			{name:'pData', type:'char*',value:pData},
        			{name:'MAC', type:'char*',size:200},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('GetDataMAC', paraminfo);
    } 
    
 /************************************************************************/
/* 
设置加密算法  WorkKeyAlgo/PinAlgo 0x20 DES 0x30 3DES     
MacAlgo 0x01 ANSI9.9 0x02 PSAM  0x03银联                                  */
/************************************************************************/    
    this.SetEncryptType = function(  WorkKeyAlgo, PinAlgo, MacAlgo){
        var paraminfo=[
          
        			{name:'WorkKeyAlgo', type:'int',value:WorkKeyAlgo},
        			{name:'PinAlgo', type:'int',value:PinAlgo},
        			{name:'MacAlgo', type:'int',value:MacAlgo},	
            	{name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetEncryptType', paraminfo);
    }  
    
/************************************************************************/
/*
 更新主密钥  Master_Key_No:主密钥号     
						 Key_Data :密钥                                             */
/************************************************************************/

 this.DownMasterKey = function( Master_Key_No, Key_Data){
        var paraminfo=[
          
        			{name:'Master_Key_No', type:'int',value:Master_Key_No},
        			{name:'Key_Data', type:'char*',value:Key_Data},       			
            	{name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('DownMasterKey', paraminfo);
    }  
     
 /************************************************************************/
/*
 发送psam指令   pos SAM卡座位置
					                                    */
/************************************************************************/

 this.ResetPSAM = function(pos){
        var paraminfo=[
          
        			{name:'Pos', type:'int',value:pos},
             	{name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('ResetPSAM', paraminfo);
    }         
    this.LoadDevice();

 /************************************************************************/
/*
 发送psam指令  
						                                       */
/************************************************************************/
 this.SendPSamCmd = function( Cmd){
        var paraminfo=[
          
        			{name:'Cmd', type:'char*',value:Cmd},
        			{name:'Rep', type:'char*', size:255},
             	{name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SendPSAMCmd', paraminfo);
    }         
    this.LoadDevice();
    
 
}
