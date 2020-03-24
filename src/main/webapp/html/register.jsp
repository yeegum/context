<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>考试系统注册</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script src="../js/jquery3.3.1.min.js"></script>
    <script src="../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>


</head>
<body class="login-bg">
    
    <div class="login layui-anim layui-anim-up">
        <div class="message">考试系统注册</div>
        <div id="darkbannerwrap"></div>
        
        <form id="form1"   method="post" class="layui-form" >

            <input name="account" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input id="phonenumber" name="phone" placeholder="电话号码"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <input style="width: 180px" name="code" placeholder="请填写验证码"  type="text" lay-verify="required" class="layui-input" >
                </div>
                <div class="layui-inline">
                    <button type="button" class="layui-btn layui-btn-lg" onclick="getcode()">获取验证码</button>
                </div>
            </div>
            <input value="注册" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
    </div>

    <script type="text/javascript">
        function getcode() {
            var url = "${pageContext.request.contextPath}/sms";
            // alert("df");
            $.post(url,$("#phonenumber").serialize(), function (data) {//data是请求返回的数据
                layer.msg(data,{time:2000});
            })
        }

      $(function  () {
          layui.use('form', function () {
              var form = layui.form;
              form.on('submit(login)', function () {
                  $.post("${pageContext.request.contextPath}/regUser", $("#form1").serialize(), function (data) {
                      layer.msg(data,{time:2000});
                     if(data=="注册成功"){
                         window.location.href="/html/login.jsp";//跳转链接
                     }
                  });
                  return false;
              });
          })
      })
    </script>
</body>
</html>