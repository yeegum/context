<%--
  Created by IntelliJ IDEA.
  User: wuhecheng
  Date: 2019/8/17
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <%--<link  type="text/css" href="../css/forum_demo.css" rel="stylesheet" />--%>
    <!--引用外部js文件forum_inside.js-->
    <%--<script type="text/javascript" src="../js/forum_inside.js"></script>--%>
    <link type="text/css" href="${pageContext.request.contextPath}/css/forum_inside.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
    <link type="text/css" href="${pageContext.request.contextPath}/css/htmlposts.css" rel="stylesheet"/>
</head>
<script>
    $(function () {
        layui.use(['layer', 'form'], function () {
            $ = layui.jquery;
            layer = layui.layer,
                form = layui.form;
            //监听提交
            form.on('submit(add)', function (data) {
                //发异步，把数据提交给后台
                $.post("${pageContext.request.contextPath}/management/Posts/addReplyPost", $("#forum").serialize(), function (data) {
                    layer.alert(data.msg, {icon: 6}, function () {
                        parent.location.reload();
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                })

                return false;
            });
        })
    })
    $(function () {
        layui.use(['layer', 'form'], function () {
            $ = layui.jquery;
            layer = layui.layer,
                form = layui.form;
            //监听提交
            form.on('submit(addse)', function (data) {
                console.log(data);
                //发异步，把数据提交给后台
                $.post("${pageContext.request.contextPath}/management/Posts/addReplyPost",data.field, function (data) {
                    layer.alert(data.msg, {icon: 6}, function () {
                        parent.location.reload();
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                })

                return false;
            });
        })
    })
    function add_reply(title, w, h, id) {
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
</script>
</head>
<body>
<div style="width:972px; height:75px; margin: auto;">
    <iframe src="${pageContext.request.contextPath}/html/top.jsp" frameborder="0" width="972" height="80"></iframe>
</div>
<div class="x_body" >
    <div class="user_msg">
        <%--<div class="user_img"><img src="${postUser.faceimg}" alt="" style="width: 100px;height: 100px"></div>--%>
        <span class="user_name">${postUser.account}</span>
    </div>
    <div class="bodyleft">
        <div  id="toppost">
            <div id="post-title">
                <div id="post-title-name"> ${posts.post_title} </div>
                    <div id="post-title-author">作者:${posts.user_name}<span id="post-title-times">阅读数:${posts.post_numbers}</span></div>
                <div id="post-title-dottom"></div>
            </div>
            <div class="post-content-img">
                <div id="post-content">
                    <p>${posts.post_content}</p>
                </div>
                <div id="post-img">
                    <img src="${posts.post_image}" alt="" style="height: 200px;">
                </div>
            </div>

        </div>
        <div id="repltpost">
            <ul>
                <c:forEach items="${replyPosts}" var="replyPost">
                    <c:if test="${replyPost.responded_id eq 0}">
                        <li style="border-top: 1px dotted #01AAED">
                            <br/>
                            <div style="text-align: left;color:#444">
                                    <span style="color:#01AAED">${replyPost.user_name}</span>
                                <c:if test="${replyPost.user_id  eq   sessionScope.user.userid}">
                                   <div class="deleteReply" >
                                       <a onclick="delReply(${replyPost.reply_id})" >☒</a>
                                   </div>
                                </c:if>
                                <div ><div>${replyPost.apply_content}</div>
                                    <span style="float: right;width: 300px">
                                    <span style="margin-left: 60px">发表于:${replyPost.apply_time}</span>
                                    <button type="button" class="layui-btn layui-btn-xs layui-btn-normal"
                                            onclick="add_reply('回复',450,300,'reply${replyPost.reply_id}');">
                                        回复
                                    </button>
                                    </span>
                                </div>
                            </div>
                            <div>
                                <div class="comment-paren" style="text-align:left;margin-top:7px;color:#444;">
                                    <!-- 回复表单默认隐藏 start-->
                                    <div class="replycontainer" id="reply${replyPost.reply_id}"
                                         style="display: none">
                                        <form  method="post" class="layui-form"   id="reply${replyPost.reply_id}">
                                            <input type="hidden" name="post_id" value=${posts.post_id}>
                                            <input type="hidden" name="user_id" value=${posts.user_id}>
                                            <input type="hidden" name="responded_id" value=${replyPost.reply_id}>
                                            <div class="layui-form-item">
                                                <textarea name="apply_content" lay-verify="replyContent"
                                                          placeholder="请输入回复内容"
                                                          class="layui-textarea" style="min-height:150px;"></textarea>
                                            </div>
                                            <div class="layui-form-item">

                                                        <input type="submit" class="layui-btn" lay-filter="addse" lay-submit="" value="评论"/>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- 以下是回复信息 -->
                            <c:forEach items="${sreplyPosts}" var="sreplyPost">
                                <!-- 每次遍历出来的留言下存在回复信息才展示（本条回复信息是本条留言下的就显示在当前留言下） -->
                                <c:if test="${ sreplyPost.responded_id eq replyPost.reply_id}">
                                    <div style="text-align: left;margin-left:61px;color: #444">
                                        <div>
                                            <span style="color:#5FB878">${sreplyPost.user_name}&nbsp;&nbsp;回复${replyPost.user_name}</span>
                                            <c:if test="${sreplyPost.user_id  eq sessionScope.user.userid}">
                                                <div class="deleteReply" >
                                                    <a onclick="delReply(${sreplyPost.reply_id})">☒</a>
                                                </div>
                                            </c:if>

                                        </div>
                                        <div >${sreplyPost.apply_content} <span style="float: right">发表于:${sreplyPost.apply_time}</span></div>
                                    </div>
                                    <div>
                                        <div class="comment-paren"
                                             style="text-align:left;margin-top:7px;margin-left:61px;color:#444">
                                            <hr style="margin-top: 7px;"/>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <div class="page">
            <a href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?page=1&post_id=${posts.post_id}" >首页</a>
            <a href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?page=${pageInfo.getPrePage()}&post_id=${posts.post_id}">上一页</a>
            <a href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?page=${pageInfo.getNextPage()}&post_id=${posts.post_id}">下一页</a>
            <a href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?page=${pageInfo.getLastPage()}&post_id=${posts.post_id}">末页</a>
        </div>
        <div style="height: 160px">

        </div>
        <div id="chat">
            <form class="layui-form" method="post" id="forum">
                <div class="layui-inline">
                    <div id="chattext"  class="layui-form-item layui-form-text">
                        <div id="" class="layui-input-block">
                            <%--<textarea type="text" placeholder="请输入内容" class="layui-textarea" name="apply_content"--%>
                            <textarea name="apply_content" lay-verify="replyContent"
                                      placeholder="请输入回复内容"
                                      class="layui-textarea" style="min-height:100px;"></textarea>
                        </div>
                    </div>
                </div>
                <div class="layui-inline">
            <span class="layui-form-item">
                <input type="hidden" name="post_id" value=${posts.post_id}>
                <input type="hidden" name="user_id" value=${sessionScope.user.userid}>
                <input type="hidden" name="responded_id" value=0>
                <input type="submit" class="layui-btn" lay-filter="add" lay-submit="" value="评论"/>
            </span>
                </div>
            </form>
        </div>
    </div>

    <div class="bodyright">
    <%--${postUser.account}的最近发帖--%>
        <div id="hotpostdiv">
            <ul id="hotpost">
                <li id="hotpostLi1">&nbsp;&nbsp;热门推荐  <div style="float: right;width: 30px;"></div></li>
            <c:forEach items="${hotPosts}" var="posts">
                <a   href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id=${posts.post_id}">
                    <li class="hotpostLi">${posts.post_title}</li></a>
            </c:forEach>
            </ul>
        </div>
    </div>
</div>
    <script>
    function delReply(id) {
        layer.confirm('真的删除这条评论么', function(index){
        // layer.alert(data.msg, {icon: 6, time: 1000}, function () {
        var url="${pageContext.request.contextPath}/management/Posts/delReplyPost";
        var id1="id="+id;
        $.post(url,id1,function (data) {
            layer.alert(data.msg, {icon: 6, time: 1000}, function () {
                // parent.location.reload();
                // var index = parent.layer.getFrameIndex(window.name);//关闭当前frame
                // parent.layer.close(index);
            });
            layer.close(index);
            location.reload();
        });
        })
        // })
    }
</script>
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
</script>
</body>
</html>
