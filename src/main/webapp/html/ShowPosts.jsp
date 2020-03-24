<%--
  Created by IntelliJ IDEA.
  User: wuhecheng
  Date: 2019/8/17
  Time: 13:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <link  type="text/css" href="${pageContext.request.contextPath}/css/forum_inside.css" rel="stylesheet" />
    <%--<link  type="text/css" href="../css/forum_demo.css" rel="stylesheet" />--%>
    <!--引用外部js文件forum_inside.js-->
    <%--<script type="text/javascript" src="../js/forum_inside.js"></script>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
    <link  type="text/css" href="${pageContext.request.contextPath}/css/postPage.css" rel="stylesheet" />
</head>
<body>
<div style="width:972px; height:100px; margin: auto;">
    <iframe src="${pageContext.request.contextPath}/html/top.jsp" frameborder="0" width="972" height="80"></iframe>
</div>
<div style="width:1000px; margin: auto;">
    <%--内容的开始--%>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="${pageContext.request.contextPath}/management/Posts/findPostByTitleAndName">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <input type="text" name="user_name" placeholder="作者" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-inline">
                    <input type="text" name="post_title" placeholder="帖子标题" class="layui-input">
                </div>
                <div class="layui-inline">
                    <button class="layui-btn" type="submit"><i class="layui-icon">&#xe615;</i>
                    </button>
                    <%--<input type="submit" class="layui-btn">--%>
                </div>
                <div class="layui-inline">
                    <select name="plate_typeid">
                        <c:forEach items="${Platelist}" var="temp">
                            <option value="${temp.plate_id}">${temp.plate_type}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="layui-inline" style="float: right;width: 100px;">
                    <button type="button" class="layui-btn layui-btn-normal"  placeholder="" onclick="Posts_add('发帖','addPlate',600,400)">
                        发帖    </button>
                </div>
            </div>
        </form>
    </div>
</div>
<div id="container">
    <%--内容的开始--%>
    <div id="Posts">
<ul>
    <c:forEach items="${list}" var="temp">
        <%--<li>--%>
        <div class="btnPosts">
            <div class="btnPostsImg"><img height="100px" width="100px" src="${temp.post_image}">
            </div>
            <div class="btnPostsContent">
                <a target="_blank" href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id=${temp.post_id}">
                    <div class="btnPostsTitle">${temp.post_title}
                        <c:if test="${temp.user_id  eq   user.userid}">
                            <div class="deleteReply" >
                                <a onclick="delPost(${temp.post_id})" >☒</a>
                            </div>
                        </c:if>
                    </div>
                    <div>
                        <span>作者:${temp.user_name}</span>
                        <span style=" width: 180px;font-size: 12px;margin-left: 60px;">　发布于: ${temp.posting_time}</span>
                        <span style="float: right; width: 92px">浏览次数:${temp.post_numbers}</span><br/>
                    </div>
                    <div style="margin-top: 14px; font-size: 12px;text-indent: 20px;">${temp.post_content}</div><br/>
                </a>
            </div>
        </div>
    </c:forEach>
</ul>
    </div>
</div>
    </tbody>
</table>
<div class="bodyright">
    <%--${postUser.account}的最近发帖--%>
    <div id="hotpostdiv">
        <ul id="hotpost">
            <li id="hotpostLi1">&nbsp;&nbsp;热门推荐  <div style="float: right;width: 30px;"></div></li>
            <c:forEach items="${hotPosts}" var="posts">
                <a   target="_blank" href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id=${posts.post_id}">
                    <li class="hotpostLi">${posts.post_title}</li></a>
            </c:forEach>
        </ul>
    </div>
</div>
<div style="width:980px; height:59px;margin: auto;">
    <iframe src="${pageContext.request.contextPath}/html/footer.html" frameborder="0" width="972" height="200" scrolling="no"></iframe>
</div>
<script>
    /*
    title是弹窗的标题，id是弹出层里面的内容
    这个函数的作用是把指定id里面的内容弹出来,并且以title作为弹窗的标题
     */
    function Posts_add(title, id, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        ;
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        ;
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        ;
        layer.open({
            type: 1,
            area: [w + 'px', h + 'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: $('#' + id)
        });
    }
    alert(${user})
</script>

<div id="addPlate" class="x-body layui-anim layui-anim-up" style="display: none">
    <form method="post" action="${pageContext.request.contextPath}/management/Posts/addPosts" class="layui-form"
          enctype="multipart/form-data">
        <input name="post_title" placeholder="帖子的标题" type="text" lay-verify="required" class="layui-input">
        <hr class="hr15">
        <%--所属板块--%>
        <select name="plate_typeid">
            <c:forEach items="${Platelist}" var="temp">
                <option value="${temp.plate_id}">${temp.plate_type}</option>
            </c:forEach>
        </select>
        <hr class="hr15">
        <textarea name="post_content" class="layui-textarea" placeholder="内容"></textarea>
        <hr class="hr15">
        图片内容:<input type="file" name="img" id="cphoto"/><br/>
        <!--<button  class="layui-btn" lay-filter="add" lay-submit="">-->
        <!--增加-->
        <!--增加-->
        <!--</button>-->
        <input type="submit" value="提交" class="layui-btn"/>
    </form>
    <script>
        function delPost(id) {
            layer.confirm('真的删除本帖么', function(index){
            var url="${pageContext.request.contextPath}/management/Posts/delPosts";
            var id1="id="+id;
            $.post(url,id1,function (data) {
                layer.alert(data.msg, {icon: 6, time: 1000}, function () {
                    parent.location.reload();
                    var index = parent.layer.getFrameIndex(window.name);//关闭当前frame
                    parent.layer.close(index);
                });
            })
                // layer.close(index);
                // location.reload();
            });
        }
    </script>
</div>
</body>
</html>
