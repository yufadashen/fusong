/************************************************************************/
/* 								应天海乐自助驱动脚本																	
									author:zhuoqiang 2011-02-12														*/
/************************************************************************/
/************************************************************************/
/* 
 通用返回说明 ：RetVal:0为成功. 非0为错误，可取ErrorInfo取到相对应该错误信息
 清单打印机:状态码
107000	正常有纸
107001	正常打印中（忙）
307001	告警纸将尽
307002	脱机，纸尽（无纸、缺纸）
307003	堵纸（卡纸）
407001	设备故障（通讯失败）
407002	脱机，机械故障
407003	脱机，切刀故障
407004	打印头过温
407005	打印机抬起
407006	端口不存在（端口指串口或并口）
407007	端口打开失败
407008	无响应（设备未连接，通讯超时，设备故障）
407009	数据接收异常

                                                                     		*/
/************************************************************************/

function ReceiptPrinter(plugin, deviceName){
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
           // alert(str);
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
    
    //打开设备
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
    
    this.PrintLine = function(Print_Data,style){
        var paraminfo=[
        			{name:'Print_Data', type:'char*',value:Print_Data},
         			{name:'style', type:'char*',value:style},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('PrintLine', paraminfo);
    }
/************************************************************************/
/*设置行间距 0.1mm为单位 0.125mm为每个单位走的位置量   									a */
/************************************************************************/
   this.SetRowDistance = function(Distance){
        var paraminfo=[
        			{name:'Distance', type:'int',value:Distance},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetRowDistance', paraminfo);
    }  
    
/************************************************************************/
/*设置左边距Distance 0.1mm为单位 0.125mm为每个单位走的位置量						*/
/************************************************************************/
    
    this.SetRow_LeftDistance = function(Distance){
        var paraminfo=[
        			{name:'Distance', type:'int',value:Distance},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetRow_LeftDistance', paraminfo);
    }  
/************************************************************************/
/*走纸																																	*/
/************************************************************************/ 
    
   this.FeedLines = function(Distance){
        var paraminfo=[
        			{name:'Distance', type:'int',value:Distance},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('FeedLines', paraminfo);
    }  
/************************************************************************/
/*切纸																																	*/
/************************************************************************/ 
   this.CutPaper = function(){
        var paraminfo=[
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('CutPaper', paraminfo);
    }  
   this.PrintBitmap = function(bmpPath){
        var paraminfo=[
        			{name:'bmp_file', type:'char*',value:bmpPath},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('PrintBitmap', paraminfo);
    } 
/************************************************************************/
/* 打印内置位图 iType<0为自动读配置 Device.ini [清单打印机] 位图=1      */
/************************************************************************/	
       
   this.PrintBitmapType = function(iType){
        var paraminfo=[
        			{name:'iType', type:'int',value:iType},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('PrintBitmapType', paraminfo);
    }
      
/************************************************************************/
/* 打印不带格式                                                          */
/************************************************************************/
     
    this.Print = function(pData){
        var paraminfo=[
        			{name:'pData', type:'char*',value:pData},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('PrintData', paraminfo);
    }  
        
/************************************************************************/
/* 设置字体大小  0为正常字体    大于0为正常字体的iHeight倍高 iWidth倍宽  */
/************************************************************************/
     this.SetFontSize = function(iHeight,iWidth){
        var paraminfo=[
        			{name:'iHeight', type:'int',value:iHeight},
        			{name:'iWidth', type:'int',value:iWidth},		
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetFontSize', paraminfo);
    } 
/************************************************************************/
/* 设置加粗                                                           */
/************************************************************************/
     
    this.SetFontBold = function(bBold){
        var paraminfo=[
        			{name:'bBold', type:'int',value:bBold},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetFontBold', paraminfo);
    }   
/************************************************************************/
/* 设置对齐模式
0左对齐 1.中间对齐 2右对齐                                              */
/************************************************************************/ 
     this.SetAlignMode = function(iMode){
        var paraminfo=[
        			{name:'iMode', type:'int',value:iMode},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetAlignMode', paraminfo);
    }                
     this.LoadDevice();
}
