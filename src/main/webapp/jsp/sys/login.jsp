<!DOCTYPE html>
<html lang="en">
<head>
    <title>自助机管理员登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
    <!--
        EasyUI使用:
            1 将EasyUI提供的js文件和主题（themes）样式存放到项目的指定位置
            2 在Html文档中引入EasyUI的插件
            3在HTML文档标签上遵循EasyUI的文档规则使用EasyUI完成页面的开发

        面板使用(panel)：
            创建面板：
                在创建一个div标签，并class属性值为："easyui-panel"
            面板属性:
                title:添加面板标题
                data-options：给面板添加常用的操作。具体参照API
                添加按钮
            信息提示
        注意：
            EasyUI的使用
                通过标签的class属性添加基本EasyUI功能，包括样式和jQuery操作
                data-options属性对标签的基本功能进行修改操作
    -->
    <!--引入主题样式-->
    <link rel="stylesheet" type="text/css" href="/themes/default/easyui.css"/>
    <!--引入图标样式-->
    <link rel="stylesheet" type="text/css" href="/themes/icon.css"/>
    <!--引入jQuery文件-->
    <script src="/js/jquery1.7.js" type="text/javascript" charset="utf-8"></script>
    <!--引入EasyUi的js文件-->
    <script src="/lib/jquery-easyui-1.3.2/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
    <!--声明css代码域-->
    <style type="text/css">
        table {
            margin: auto;
            margin-top: 20px;
        }

        tr {
            height: 40px;
            text-align: center;
        }
    </style>
    <!--声明js代码域-->
    <script type="text/javascript">
        /*校验登录信息*/
        $(function () {

            changeImg();

            //重置
            $("#btnCan").click(function () {
                $("form").get(0).reset();
            })
        })
        //登录校验
        function checklogin () {
            //校验用户信息
            if ($("#username").val() == "") {
                //使用EasyUI的信息框进行提示
                $.messager.alert('登录提示', "用户名不能为空！", "warning");
                return false;
            } else if ($("#password").val() == "") {
                //使用EasyUI的信息框进行提示
                $.messager.alert('登录提示', "密码不能为空！", "warning");
                return false;
            } else if ($("#captcha").val() == "") {
                $.messager.alert('登录提示', "验证码不能为空！", "warning");
                return false;
            }
        }
        function login() {
            checklogin();
            username =  $("#username").val();
            password = $("#password").val();
            captcha = $("#captcha").val();
            $.post(
                "login",
                {"username":username,"password":password,"captcha":captcha},
                function (data) {
                    if (data*1==1){
                        alert("账号不存在");
                        jfslk;
                    }else if (data*1==2){
                        alert("密码错误");
                        jfslk;
                    }else if (data*1==3){
                        alert("验证码错误");
                        jfslk;
                    }else if(data*1==0){
                        debugger
                        window.location.href="jsp/sys/main.jsp";
                    }
                }
            )
        }
        // 回车键登陆
        function keyLogin(){
            if (event.keyCode==13){
                login();
            }
        }
    </script>
</head>

<body background="images/15.jpg"  onkeydown="keyLogin();">
<div id="easyui-window" style="margin: auto;width: 500px;margin-top: 100px;">
    <!--创建登录面板-->
    <div id="login" class="easyui-window" title="登录" data-options="iconCls:'icon-mlogin',minimizable:true,maximizable:true
                ,collapsible:true,closable:true" style="width: 400px;height: 250px;">
        <form id="loginform" action="" method="post">
            <table>
                <tr>
                    <td>用户名:</td>
                    <td>
                        <input class="easyui-textbox" id="username" name="username"
                               prompt="usercode" iconWidth="28"
                               data-options="label:'用户名:',required:true"
                               style="width: 300px; height: 34px; padding: 10px;"/>
                    </td>
                </tr>
                <tr>
                    <td>密&nbsp;&nbsp;&nbsp;码:</td>
                    <td>
                        <input class="easyui-passwordbox" id="password" name="password"
                               prompt="password" iconWidth="28"
                               data-options="label:'密码:',required:true"
                               style="width: 300px; height: 34px; padding: 10px"/>
                    </td>
                </tr>
                <tr>
                    <td>验证码:</td>
                    <td>
                        <input class="easyui-textbox" id="captcha" name="captcha"
                               prompt="验证码" iconWidth="28"
                               data-options="label:'验证码:',required:true,missingMessage:''"
                               style="width: 177px; height: 34px;vertical-align:middle;"/>
                            <img  width="120" id="verify_code_img" alt="点击刷新" height="32" src="/getImg" onclick="changeImg()" style="vertical-align:middle;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a id="btnCon" href="javascript:login()" class="easyui-linkbutton" style="width: 50px;">登录</a>
                        &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                        <a id="btnCan" href="javascript:void(0)" class="easyui-linkbutton" style="width: 50px;">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
<script>
    function changeImg(){
        var img = document.getElementById("verify_code_img");
        img.src = "/getImg?date=" + new Date();
    }
</script>

</html>