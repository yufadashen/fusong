/************************************************************************/
/* 								应天海乐自助驱动脚本																	
									author:zhuoqiang 2011-02-12														*/
/************************************************************************/
/************************************************************************/
/* 
 通用返回说明 ：RetVal:0为成功. 非0为错误，可取ErrorInfo取到相对应该错误信息
 读卡器 状态码
109000	正常，机内无卡
109001	正常，卡在门口
109002	正常，机内有卡
109003	正常，读卡失败
109004	正常，插卡失败
109005	正常，上电失败
309001	警告，卡接触不良
309002	卡空白
409001	设备故障
409002	端口不存在（端口指串口或并口）
409003	端口打开失败
409004	无响应（设备未连接，通讯超时，设备故障）
409005	数据接收异常                                                    */
/************************************************************************/

function CardPayment(plugin, deviceName)
{
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
/* 读卡                                                                 */
/************************************************************************/

   this.ReadTracks = function(TraceNo,UserNo){
        var paraminfo=[
        			{name:'Trackid', type:'int',value:7},
        			{name:'TraceNo', type:'char*',value:TraceNo},
       			  {name:'UserNo', type:'char*',value:UserNo},			
        			{name:'Track', type:'char**',arraylen:3,size:255},
              {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('ReadTracks', paraminfo);
    }  
/************************************************************************/
/* 取当前卡位置                                                                     */
/************************************************************************/
    this.GetCardPosition = function(){
        var paraminfo=[	
               {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('GetCardPosition', paraminfo);
    }  
    
/************************************************************************/
/* 充许进卡                                                                     */
/************************************************************************/
   this.CallEntry = function(){
        var paraminfo=[
               {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('CallEntry', paraminfo);
    }  
    
/************************************************************************/
/* 禁止进卡                                                             */
/************************************************************************/
   this.DisEntry = function(){
        var paraminfo=[
                 {name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('DisEntry', paraminfo);
    } 
     
/************************************************************************/
/* 退卡                                                                 */
/************************************************************************/

   this.Eject = function(){
        var paraminfo=[          
            	{name:'ErrorInfo', type:'char*', size:200}
              ]
        return this.Call('Eject', paraminfo);
    }  
/************************************************************************/
/* 设置交易金额 2015.1.19                                               */
/************************************************************************/

   this.SetTransAmount = function(iMoney){
      var paraminfo=[
        				 {name:'Amount', type:'int',value:iMoney},                
                 {name:'ErrorInfo', type:'char*', size:200}  
                 ];
        return this.Call('SetTransAmount', paraminfo);
    }  

/************************************************************************/
/* 取银联组包需要的IC卡数据 2015.1.19                                                                 */
/************************************************************************/

   this.Get_IC_Trans_Begin = function(){
      var paraminfo=[
        				 {name:'TransInfo', type:'char*', size:256},           
                 {name:'ErrorInfo', type:'char*', size:200}  
                 ];
        return this.Call('Get_IC_Trans_Begin', paraminfo);
    }  
  
 /************************************************************************/
/* 消费完成后返回IC数据信息 2015.1.19
	输入(InfoIn)格式//ARPC响应授权码|发卡行脚本1|发卡行脚本2   按55域返回数据         
	输出格式同 Get_IC_Trans_Begin
	*/
/************************************************************************/
   
   this.Get_IC_Trans_End = function(InfoIn){
      var paraminfo=[
        				 {name:'InfoIn', type:'char*',value:InfoIn},         
         				 {name:'TransInfo', type:'char*', size:256},           
                 {name:'ErrorInfo', type:'char*', size:200}  
                 ];
        return this.Call('Get_IC_Trans_End', paraminfo);
    }     
    this.LoadDevice();
}
