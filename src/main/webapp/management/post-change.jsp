<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <![endif]-->
</head>

<body>
<div  id="Plate/changePlate"  class="x-body layui-anim layui-anim-up" >
    <form method="post"  action="${pageContext.request.contextPath}/management/Posts/changePost"  class="layui-form"  enctype="multipart/form-data">
        帖子标题<input name="post_title"    type="text" lay-verify="required" class="layui-input" value="${posts.post_title}">
        <hr class="hr15">
        帖子内容<input name="post_content" lay-verify="replyContent"
                 value="${posts.post_content}"
                  class="layui-textarea" style="min-height:100px;"></input>
        <hr class="hr15">
        <img src="${posts.post_image}">原始图片
        <hr class="hr15">
        帖子图片:<input type="file" name="img" id="cphoto"/><br/>
        <hr class="hr15">
        状态： <c:choose >
        <c:when test="${posts.post_status  eq   1 }">
            <input type="radio" name="post_status" value="1" title="启用" checked>
            <input type="radio" name="post_status" value="0" title="禁用"></c:when>
        <c:otherwise>
            <input type="radio" name="post_status" value="1" title="启用" >
            <input type="radio" name="post_status" value="0" title="禁用" checked>
        </c:otherwise>
    </c:choose>
        <br/>
        是否为精华帖： <c:choose >
        <c:when test="${posts.post_essence  eq   1 }">
            <input type="radio" name="post_essence" value="1" title="精华帖" checked>
            <input type="radio" name="post_essence" value="0" title="普通帖"></c:when>
        <c:otherwise>
            <input type="radio" name="post_essence" value="1" title="精华帖" >
            <input type="radio" name="post_essence" value="0" title="普通帖" checked>
        </c:otherwise>
    </c:choose>
        <br/>
        是否置顶： <c:choose >
        <c:when test="${posts.post_roof_placement  eq   1 }">
            <input type="radio" name="post_roof_placement" value="1" title="精华帖" checked>
            <input type="radio" name="post_roof_placement" value="0" title="普通帖"></c:when>
        <c:otherwise>
            <input type="radio" name="post_roof_placement" value="1" title="精华帖" >
            <input type="radio" name="post_roof_placement" value="0" title="普通帖" checked>
        </c:otherwise>
    </c:choose>
        <br/>
            <input type="hidden" name="post_id" value="${posts.post_id}">
                <input type="submit" value="提交" class="layui-btn" />
            </form>
        </div>
    </form>
</div>
</body>
<%--<script>--%>
    <%--$ = layui.jquery;--%>
    <%--var form = layui.form--%>
        <%--, layer = layui.layer;--%>

    <%--form.on('submit(add)', function (data) {--%>
        <%--console.log(data);--%>
<%--//发异步，把数据提交给php--%>
        <%--var url = "${pageContext.request.contextPath}/AddChange";--%>
        <%--$.post(url, $("#changequestion").serialize(), function (data) {--%>
            <%--if (parseInt(data) == 0) {--%>
                <%--layer.alert("修改成功", {icon: 6, time: 2000}, function () {--%>
                    <%--parent.parent.layer.closeAll();--%>
                    <%--parent.location.reload();--%>
                <%--});--%>
            <%--} else {--%>
                <%--layer.alert("增加失败", {icon: 6, time: 1000}, function () {--%>
                    <%--layer.close();--%>
                <%--});--%>
            <%--}--%>
        <%--})--%>
        <%--return false;--%>
    <%--});--%>
<%--</script>--%>
</html>
