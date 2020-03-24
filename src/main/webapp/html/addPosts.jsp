<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>无标题文档</title>

    <!--引用外部css文件forum_inside.css-->
    <link  type="text/css" href="${pageContext.request.contextPath}/css/forum_inside.css" rel="stylesheet" />
    <%--<link  type="text/css" href="../css/forum_demo.css" rel="stylesheet" />--%>
    <!--引用外部js文件forum_inside.js-->
    <%--<script type="text/javascript" src="../js/forum_inside.js"></script>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>

<body>
<div  id="addPlate"  class="x-body layui-anim layui-anim-up"   style="display: none">
    <form method="post" action="${pageContext.request.contextPath}/management/Posts/addPosts"  class="layui-form"  enctype="multipart/form-data">
        <input name="post_title"  placeholder="帖子的标题"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <%--所属板块--%>
        <select name="plate_typeid" >
            <c:forEach items="${Platelist}" var="temp">
                <option value="${temp.plate_id}">${temp.plate_type}</option>
            </c:forEach>
        </select>
        <hr class="hr15">
        <textarea name="post_content" class="layui-textarea" placeholder="内容"></textarea>
        <hr class="hr15">
        <input type="hidden" value="${sessionScope.user.userid}">
        图片内容:<input type="file" name="img" id="cphoto"/><br/>
        <!--<button  class="layui-btn" lay-filter="add" lay-submit="">-->
        <!--增加-->
        <!--增加-->
        <!--</button>-->
        <input type="submit" value="提交" class="layui-btn" />
    </form>
</div>
</body>
</html>
