<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<head>
    <meta charset="utf-8">
    <title>无标题文档</title>
    <!--引用外部css文件forum_inside.css-->
    <link type="text/css" href="${pageContext.request.contextPath}/css/forum_inside.css" rel="stylesheet"/>
    <%--<link  type="text/css" href="../css/forum_demo.css" rel="stylesheet" />--%>
    <!--引用外部js文件forum_inside.js-->
    <%--<script type="text/javascript" src="../js/forum_inside.js"></script>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
    <style>
        .container1{
            width: 780px;
            /*background-color: #fdfdfd;*/
            /*overflow: hidden;*/
           margin-left: 450px;
        }
        .container1 > h2{
            /*border: 1px solid #eeeeee;*/
            height: 32px;
            line-height: 32px;
        }
        .container1 .boxo{
            width: 784px;
            padding: 10px;
            border: 1px solid #eeeeee;
            overflow: hidden;
        }
        .container1 .boxo .box1{
            width: 350px;
            /*height: ;*/
            float: left;
            margin-right: 40px;
            margin-top: 20px;
            margin-bottom: 20px;
            border: 1px solid #eeeeee;
            border-radius: 10px;
        }
        .container1 .boxo .box1 .boxhead{
            /*background-color: #ddd;*/
            margin-bottom: 5px;
        }
        .container1 .boxo .box1 .boxhead h3{
            display: inline-block;
            height: 32px;
            padding-left:  5px;
            width: 130px;
            line-height: 32px;
        }
        .container1 .boxo .box1 .boxcon .img{
            width: 125px;
            height: 100px;
            border: 1px solid #eeeeee;
            border-radius: 5px;
            float: left;
        }
        .container1 .boxo .box1 .boxcon .posts{
            margin-left: 15px;
            float: left;
            /*font-size: 14px;*/
            /*color:red;*/
            border-left: 1px dotted #666666;
            padding-left: 15px;
        }
        .container1 .boxo .box1 .boxcon .posts li a{
            /*float: left;*/

            display: inline-block;
            height: 20px;
            line-height: 20px;
            font-size: 14px;
            color: #999999;
        }
    </style>
</head>

<script type="text/javascript">

</script>

<div>
    <!--   头部-->

    <div style="width:972px; height:75px; margin: auto;">
        <iframe src="${pageContext.request.contextPath}/html/top.jsp" frameborder="0" width="972" height="80"></iframe>
    </div>
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
                          <%--<a href="${pageContext.request.contextPath}/management/Posts/getPostsByPlate?id=${temp.plate_id}">--%>
                              <option value="${temp.plate_id}">${temp.plate_type}</option></a>
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

    <!--给内容套上一个div，防止分辨率改变，内容位置发生变化,forum_inside_container开始-->
    <%--<div class="forum_inside_container">--%>
    <%--<!--forum_inside的头部开始-->--%>
    <%--<div class="forum_inside_top">--%>
    <%--</div>--%>
    <!-- forum_inside_top结束-->
<div class="container1">
    <h2>频道导航</h2>
    <div class="boxo">
        <c:forEach items="${Platelist}"  var="temp">
            <div class="box1">
                <div class="boxhead">
                    <h3><a href="${pageContext.request.contextPath}/management/Posts/getPostsByPlate?id=${temp.plate_id}">${temp.plate_type}</a></h3>
                    <%--帖子总数: <span style="color: red">177</span>--%>
                </div>
                <div class="boxcon">
                    <div class="img" >
                        <a href="${pageContext.request.contextPath}/management/Posts/getPostsByPlate?id=${temp.plate_id}"><img class="pdimg" src="${temp.plate_plateimg}" style="width: 125px;height: 100px;"/></a>
                    </div>
                    <ul class="posts">
                        <c:forEach items="${temp.posts}" var="post">
                            <li class="post-li"><a  href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id=${post.post_id}">
                                    ${post.post_title}</a> </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
    <!-- forum_inside_search开始-->
    <!--forum_inside_search结束-->
    <!-- forum_inside_main开始-->
    <div class="forum_inside_main">
        <table width="980" border="1" cellspacing="0" class="forum_inside_main_table" id="forum_inside_main_table">
            <tbody class="forum_inside_main_table_tobdy" id="forum_inside_main_table_tobdy">
            </tbody>
        </table>
    </div>
<div class="bodyright">
    <%--${postUser.account}的最近发帖--%>
    <div id="hotpostdiv">
        <ul id="hotpost">
            <li id="hotpostLi1">&nbsp;&nbsp;热门推荐  <div style="float: right;width: 30px;"></div></li>
            <c:forEach items="${hotPosts}" var="posts">
                <a  href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id=${post.post_id}">
                    <li class="hotpostLi">${posts.post_title}</li></a>
            </c:forEach>
        </ul>
    </div>
</div>
<div style="width:980px; height:59px;margin: auto;">
    <iframe src="${pageContext.request.contextPath}/html/footer.html" frameborder="0" width="972" height="200"
            scrolling="no"></iframe>
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
</div>
</body>
</html>