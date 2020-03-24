<%--
  Created by IntelliJ IDEA.
  User: yeegum
  Date: 2019/8/19
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发邮件</title>
    <link href="${pageContext.request.contextPath}/html/friend/css/makefriends.css" rel="stylesheet" />
    <link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<body>
<div style="width: 650px; position: relative; left:25%; margin-top: 50px">
    <form class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label layui-bg-blue">收件人ID</label>
            <div class="layui-input-block ">
                <input type="text" name="recv_userid" required  lay-verify="required" placeholder="请输入您可爱好友的昵称哦！" autocomplete="off" class="layui-input">
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-bg-blue">邮件标题</label>
            <div class="layui-input-block">
                <input type="text" name="topic" required  lay-verify="required" placeholder="邮件标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label layui-bg-blue">邮件内容</label>
            <div class="layui-input-block">
                <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>

    <script>
        //Demo
        layui.use('form', function(){
            $ = layui.jquery;
            var form = layui.form
                ,layer = layui.layer;

            //监听提交
            form.on('submit(formDemo)', function(data){
                /*layer.msg(JSON.stringify(data.field));*/
                $.ajax({
                    url:"/management/sendEmail",
                    async:false,
                    type:"POST",
                    dataType:"text",
                    data:data.field,
                    success:function (data) {
                            layer.alert("发送成功😀", {
                                time:3000,
                                end:function () {
                                    location.reload();
                                }},function () {
                                // 获得frame索引
                                location.reload();
                                var index = parent.layer.getFrameIndex(window.name);
                                //关闭当前frame
                                parent.layer.close(index);
                            });
                    }
                });
                return false;
            });
        });
    </script>
</div>
</body>
</html>
