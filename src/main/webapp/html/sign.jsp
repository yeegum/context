<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../css/font.css">
    <script type="text/javascript" src="../js/jquery3.3.1.min.js"></script>
    <script type="text/javascript" src="../lib/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../lib/layui/css/layui.css"/>
    <script type="text/javascript">
      layui.use('layer',function () {
        var layer=layui.layer;
        $(document).on('click','#sign_btn',function () {
        //layer.msg('hello',{time:1000})
        var url="${pageContext.request.contextPath}/sign";
        $.post(url,function(data){
        layer.msg(data,{time:2000});
        })
        });

        })
        </script>
</head>
<body>
<div style="width:300px;height:100px;margin: auto;margin-top: 300px">
<button id="sign_btn" type="button" class="layui-btn  layui-btn-lg layui-btn-normal">签到</button>
</div>
</body>
</html>
