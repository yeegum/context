<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>修改页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <![endif]-->
</head>

<body>
<div id="box_change" class="x-body layui-anim layui-anim-up" style="align-content: center">
    <form class="layui-form" action="" id="form1">
        <div class="layui-form-item">
            <label for="L_passs" class="layui-form-label">
                <span class="x-red">*</span>笔记标题
            </label>
            <div class="layui-input-inline">
                <input type="text" value="${note.title}" id="L_passs" name="title" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">
                <span class="x-red">*</span>笔记类别
            </label>
            <div class="layui-input-inline">
                <select name="tid" lay-verify="required">
                    <c:forEach items="${types}" var="temp">
                        <c:choose>
                            <c:when test="${temp.tid==note.tid}">
                                <option value="${temp.tid}" selected>${temp.tname}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${temp.tid}">${temp.tname}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-left: 138px;margin-top: 150px">
            <button class="layui-btn" lay-filter="change" lay-submit="">
                确认修改
            </button>
        </div>
        <input type="hidden" value="${note.nid}" name="nid"/>
    </form>
</div>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;

        //监听提交
        form.on('submit(change)', function (data) {
            //发异步，把数据提交给php
            $.post("/management/Note/doChange", $("#form1").serialize(), function (data) {
                if (parseInt(data.code) != 0) {
                    layer.msg(data.msg,{icon: 1}, {time: 1500});
                } else {
                    layer.msg(data.msg,{icon: 2},{time:1500})
                }
                setTimeout(function(){
                    parent.location.reload();
                    var mylay = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(mylay);
                },1000);
            });
            return false;
        });


    });
</script>
</body>

</html>