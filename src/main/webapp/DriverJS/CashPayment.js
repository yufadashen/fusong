/************************************************************************/
/* 								应天海乐自助驱动脚本																	
									author:zhuoqiang 2011-02-12														*/
/************************************************************************/
/************************************************************************/
/* 
 通用返回说明 ：RetVal:0为成功. 非0为错误，可取ErrorInfo取到相对应该错误信息
 状态码
110000	正常空闲
110001	正常忙，币在入口
110002	正常忙，币在机内
110003	正常忙，识别成功
110004	正常忙，正在接收
110005	正常忙，正在叠币
110006	正常忙，叠币成功
110007	收钱成功（只做记录日志使用）
110008	开始接收（只做记录日志使用）
110009	停止接收（只做记录日志使用）
110010	禁止投币
110011	识别器已关闭，处于非工作状态
310001	告警、钱箱满
310002	告警，钱箱被取出
410001	进钞口卡币（堵塞）
410002	端口不存在（端口指串口或并口）
410003	端口打开失败
410004	无响应（设备未连接，通讯超时，设备故障）
410005	数据接收异常
                                                                     		*/
/************************************************************************/

function CashPayment(plugin, deviceName){
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
 //显示调试信息
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
/* 开始识币     
 TraceNo 流水号
 用户号，指用户对应手机号码/用户编号                                     */
/************************************************************************/

   this.StartIdentify = function(TraceNo,UserNo){
        var paraminfo=[
        			{name:'TraceNo', type:'char*',value:TraceNo},
       				{name:'UserNo', type:'char*',value:UserNo},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('StartIdentify', paraminfo);
    }  
/************************************************************************/
/* 中止识币                                                       */
/************************************************************************/    
    this.StopIdentify = function(){
        var paraminfo=[	
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('StopIdentify', paraminfo);
    }  
/************************************************************************/
/*取当前一次币的总金额																									*/
/************************************************************************/ 
    
   this.GetBillValue = function(){
        var paraminfo=[
               {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('GetBillValue', paraminfo);
    }  
/************************************************************************/
/* 设置可识别的纸币类型
1:1元  2:2元 4:5元 8:10元 16:20元 32:50元 64:100元                        */
/************************************************************************/
   this.SetDenominations = function(EnabledDenominations){
        var paraminfo=[
          
             {name:'EnabledDenominations', type:'int',value:EnabledDenominations},
             {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('SetDenominations', paraminfo);
    }  
/************************************************************************/
/* 当前是否忙  RetVal:返回0不忙 1识币中                                  */
/************************************************************************/    
   this.IsBusing = function(){
        var paraminfo=[
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('IsBusing', paraminfo);
    }      
    this.LoadDevice();
}
