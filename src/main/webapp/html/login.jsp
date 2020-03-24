<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>考试系统登录6.0</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/js/jquery3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script>
        function reImg()
        {
            document.getElementById("img").src="number.jsp?code=" + Math.random();
        }
    </script>


</head>
<body class="login-bg">
    <div class="login layui-anim layui-anim-up">
        <div class="message">考试系统登录</div>
        <div id="darkbannerwrap"></div>
        
        <form id="form1" method="post" class="layui-form" >
            <input name="account" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <input style="width: 200px" name="code" placeholder="请填写验证码"  type="text" lay-verify="required" class="layui-input" >
                </div>
                <div class="layui-inline">
                    <img src="number.jsp" id="img" onclick="reImg()" height="30" style="cursor: pointer" title="点击刷新验证码"/>
                </div>

            </div>
            <input value="登录" lay-submit lay-filter="log" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
        <a href="register.jsp" style="float: right; color: blue;font-size: 15px;font-family: 宋体 ">用户注册</a>
    </div>

    <script type="text/javascript">
        $(function  () {
            layui.use('form', function () {
                var form = layui.form;
                form.on('submit(log)', function () {
                    $.post("${pageContext.request.contextPath}/login", $("#form1").serialize(), function (data) {
                        layer.msg(data.msg,{time:2000},function () {
                            if(data.code==111){
                                reImg();
                            }else if(data.code==100){
                                window.location.href="${pageContext.request.contextPath}/html/all.jsp";//跳转链接
                            }else if(data.code==200){
                                window.location.href="${pageContext.request.contextPath}/admin.jsp";//跳转链接
                            }
                        });

                    });
                    return false;
                });
            })
        })
    </script>
</body>
</html>