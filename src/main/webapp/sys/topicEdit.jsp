<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="../management/lib/layui/css/layui.css">
<script src="../management/js/jquery3.3.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../management/lib/layui/layui.js"></script>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>帖子编辑</title>
    <script>
        var layer;
        layui.use(['form', 'upload'], function () {
            var form = layui.form
                , layer = layui.layer
                , upload = layui.upload;

            <c:if test="${code == 2}">
            layer.msg("操作成功", {icon: 6});
            <c:remove var="code" scope="session"></c:remove>
            // 得到user界面
            var user = $("iframe[data-frameid=33]",top.document)[0].contentWindow;
            user.table.reload('pageTable');
            </c:if>

            form.on('switch(switchTest)', function (data) {
            });
            form.on('submit(tj)', function (data) {
                return true;
            });
            form.val('myform', {
                "editor": "${reqTopic.editor}"
                ,"tTitle":"${reqTopic.tTitle}"
                , "isTop": ${reqTopic.isTop == 1 ? true : false}
                , "isCream":${reqTopic.isCream == 1 ? true : false}
                , "state": ${reqTopic.state == 1 ? true : false}
            });
        });
    </script>
</head>
<body>

<form lay-filter="myform" class="layui-form layui-form-pane" method="post" action="${ctx}/topic.do">
    <input type="hidden" name="method" value="update">
    <input type="hidden" name="tId" value="${reqTopic.tId}">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">发帖人</label>
            <div class="layui-input-block">
                <input type="text" readonly name="editor" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">帖子标题</label>
            <div class="layui-input-block">
                <input type="text" readonly name="tTitle" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">是否置顶</label>
        <div class="layui-input-block">
            <input value="1" lay-text="ON|OFF" type="checkbox" name="isTop" lay-skin="switch" lay-filter="switchTest">
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">是否加精</label>
        <div class="layui-input-block">
            <input value="1" lay-text="ON|OFF" type="checkbox" name="isCream" lay-skin="switch" lay-filter="switchTest">
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">是否过审</label>
        <div class="layui-input-block">
            <input value="1" lay-text="ON|OFF" type="checkbox" name="state" lay-skin="switch" lay-filter="switchTest">
        </div>
    </div>
    <div class="layui-form-item">
        <button class="layui-btn" lay-submit="" lay-filter="tj">提交</button>
    </div>
</form>
</body>
</html>
