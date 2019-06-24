/************************************************************************/
/* 								应天海乐自助驱动脚本
									author:zhuoqiang 2011-02-12														*/
/************************************************************************/
/************************************************************************/
/*
 通用返回说明 ：RetVal:0为成功. 非0为错误，可取ErrorInfo取到相对应该错误信息
 /************************************************************************/
/*
111000	正常空闲
111001	正常，读取二代身份证信息成功
411001	设备故障
411002	端口不存在（端口指串口或并口）
411003	端口打开失败
411004	无响应（设备未连接，通讯超时，设备故障）
411005	数据接收异常
																		*/
/************************************************************************/



/************************************************************************/

function UserIDCard(plugin, deviceName){
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


    /************************************************************************/
    /* 读卡信息 返回 111001 表示读卡成功*/
    /************************************************************************/
    this.ReadCard = function(){
        var paraminfo=[

            {name:'ErrorInfo', type:'char*', size:200}
        ]
        return this.Call('ReadCard', paraminfo);
    }

    /************************************************************************/
    /*返回中
    value
    值依次为姓名、性别、民族、出生、住址、身份号码、
    签发机关、开始有效期限、结束有效期限、保留、照片文件名；
    除此之外，增加一个索引，index=11时，value值为照片文件内容。                                                                */
    /************************************************************************/

    this.GetCardInfo = function(index){
        var paraminfo=[
            {name:'index', type:'int',value:index},
            {name:'Value', type:'char*', size:200},
            {name:'ErrorInfo', type:'char*', size:200}
        ]
        return this.Call('GetCardInfo', paraminfo);
    }

    this.LoadDevice();
}
