<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>学习界面</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <style>
        * {
            padding: 0;
            margin: 0;
        }

        li {
            font-size: 12px;
            list-style: none;
            float: left;
        }

        a {
            text-decoration: none;
            color: black;
        }

        .place ul {
            margin-left: 65px;
            margin-top: -28px;
        }

        .tp {
            margin: auto;
            width: 972px;
        }

        .place {
            width: 1000px;
            height: 40px;
            margin: auto;
            background: #ECF5F9;
        }

        .place a:hover {
            color: #00A3AB;
        }

        .mid {
            width: 1000px;
            height: 326px;
            margin: auto;

        }

        .mid_left {
            float: left;
            width: 170px;
            height: 427px;
            background: #F2F9FE;
            outline: solid 1px #BDD7F0;
            border-radius: 5px;
        }

        .mid_left a {
            font-size: 12px;
            font-weight: normal;
            color: blue;
            margin-left: 70px;
        }

        .mid_left a:hover {
            text-decoration: underline;
            color: red;
        }

        .mid_center {
            float: left;
            width: 580px;
            height: 432px;
            outline: solid 1px #C0DBF0;
        }

        .mid_center > div {
            float: left;
        }

        .mid_center ul li {
            width: 61px;
            height: 27px;
            background: #4097C9;
            margin-left: 7px;
            text-align: center;
            line-height: 27px;
            border-radius: 4px;
            color: white;

        }

        .mid_center ul li:hover {
            background: #096DAE;
        }

        .input {
            width: 360px;
            height: 35px;
            margin-left: 18px;
            margin-top: 12px;
        }

        .input2 {
            width: 136px;
            height: 35px;
            outline: solid 2px #CACACA;
            margin-top: 12px;
            margin-left: 20px;
            text-align: center;
            line-height: 35px;
        }

        .mid_right {
            float: right;
            width: 240px;
            height: 434px;
            background: #F2F9FE;
            text-align: center;
            line-height: 108px;
        }

        .tiaozhaun {
            width: 185px;
            margin-left: 350px;
            /*		outline: solid 1px red;*/
        }

        .footer {
            width: 980px;
            height: 59px;
            /*margin-left: 275px;*/
            /*margin-bottom: 100px;*/
            border-radius: 5px;
        }

        #btn {
            width: 70px;
            height: 30px;
            background: #4097C8;
        }

        table {
            text-align: center;
        }

        tr:hover {
            background: #E4EAED;
        }
    </style>
</head>

<body>

<div id="box" style="width: 980px;margin: 0 auto; position: relative">
    <div class="tp">
        <iframe src="${pageContext.request.contextPath}/html/top.jsp" width="972px" height="75px" scrolling="no"
                frameborder="0"></iframe>
    </div>

    <div class="place">
	<span style="font-weight:bold; margin-left:15px;line-height:40px;">
		位置:
	</span>
        <ul>
            <li><a href="">首页</a> &nbsp;>&nbsp;&nbsp;</li>
            <li><a href="">学习</a> &nbsp;>&nbsp;&nbsp;</li>
            <li><a href="">表单</a> &nbsp;</li>
        </ul>
    </div>

    <div class="mid">

        <div class="mid_left" style="font-size:14px;color:blue;font-weight: bold;padding-top: 5px;padding-left: 10px;">
            <div style="margin-top: 20px;margin-left: 12px">
                <select name="type" id="type" onchange="typeChange()" style="height: 30px;width: 114px">
                    <c:forEach items="${types}" var="temp">
                        <c:choose>
                            <c:when test="${temp.tid==tid}">
                                <option value="${temp.tid}" selected>${temp.tname}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${temp.tid}">${temp.tname}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
            <a href="/management/Note/doShow?url=xuexi">
                <div style="margin-top: 20px;margin-left: 20px">
                    <button class="layui-btn layui-btn-normal" onclick="">返回主页</button>
                </div>
            </a>
        </div>

        <div class="mid_center">

            <div class="input">
                <input type="text" name="title" id="title" placeholder="请输入笔记名"
                       style="width:360px;height:35px;outline: solid 2px #CACACA;border:0px;text-indent: 10px;">
            </div>
            <div class="input2">
                <a onclick="doSearch()" href="javascript:;">搜索文档</a>
            </div>

            <div style="width:300px;height: 30px;margin-left: 13px;margin-top:10px;">
                <ul style="float: left">
                    <a href="/management/Note/doShow?page=${pageInfo.firstPage}&uid=${user.userid}&url=mynote"
                       onmousemove="window.status=''">
                        <li>首页</li>
                    </a>
                    <a href="/management/Note/doShow?page=${pageInfo.prePage}&uid=${user.userid}&url=mynote"
                       onmousemove="window.status=''">
                        <li>上一页</li>
                    </a>
                    <a href="/management/Note/doShow?page=${pageInfo.nextPage}&uid=${user.userid}&url=mynote"
                       onmousemove="window.status=''">
                        <li>下一页</li>
                    </a>
                    <a href="/management/Note/doShow?page=${pageInfo.lastPage}&uid=${user.userid}&url=mynote"
                       onmousemove="window.status=''">
                        <li>尾页</li>
                    </a>
                </ul>
            </div>

            <div style="width:200px;height: 30px;margin-top:10px;font-size: 13px; line-height: 30px;">
                <p>总记录条数${pageInfo.total}条 共${pageInfo.pages}页 当前第${pageInfo.pageNum}页</p>
            </div>

            <div class="tiaozhaun">
                <form action="/management/Note/doShow" id="form2" method="post">
                    跳转至&nbsp;&nbsp;<input type="text" name="page" value="${pageInfo.pageNum}"
                                          style="width:32px;border-radius:4px;text-indent: 10px;"/>&nbsp;&nbsp;页
                    <input type="submit" id="btn" value="GO"
                           style="border:0px;outline: 0px; color:white;border-radius:4px;">
                    <input type="hidden" name="url" value="mynote"/>
                    <input type="hidden" name="uid" value="${user.userid}"/>
                </form>
            </div>
            <table>
                <tr height="35px">
                    <td width="171px">笔记标题</td>
                    <td width="100px">笔记状态</td>
                    <td width="265px">上传时间</td>
                    <td width="80px">下载次数</td>
                    <td width="200px">操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="i">
                    <tr height="35px">
                        <td>${i.title}</td>
                        <td>${i.sname}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${i.subtime}" type="both"/></td>
                        <td>${i.times}</td>
                        <td>
                            <a href="/management/Note/download?nid=${i.nid}">
                                <c:if test="${i.sid==3}">
                                    <button id="dowload" class="layui-btn layui-btn-sm layui-btn-disabled" onclick="">
                                        下载
                                    </button>
                                </c:if>
                                <c:if test="${i.sid!=3}">
                                    <button id="dowload" class="layui-btn layui-btn-sm layui-btn-normal" onclick="">
                                        下载
                                    </button>
                                </c:if>
                            </a>
                            <button id="delete" class="layui-btn layui-btn-sm layui-btn-danger"
                                    onclick="member_del(${i.nid})">
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="mid_right">
            <button class="layui-btn layui-btn-normal" onclick="x_show('上传笔记','box_upload',400,460)">上传文件</button>
        </div>
    </div>

    <div class="footer" style="position:  absolute;top:560px">
        <iframe src="${pageContext.request.contextPath}/html/footer.html" width="980px" height="59px" frameborder="0"></iframe>
    </div>

</div>


<div id="box_upload" class="x-body layui-anim layui-anim-up" style="display: none">
    <form class="layui-form" id="form1">
        <div class="layui-form-item">
            <label for="L_passs" class="layui-form-label">
                <span class="x-red">*</span>笔记标题
            </label>
            <div class="layui-input-inline">
                <input type="text" value="" id="L_passs" name="title" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">
                <span class="x-red">*</span>笔记类别
            </label>
            <div class="layui-input-inline">
                <select name="type" lay-verify="required">
                    <option value=""></option>
                    <c:forEach items="${types}" var="temp">
                        <c:choose>
                            <c:when test="${temp.tid!=0}">
                                <option value="${temp.tid}">${temp.tname}</option>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_passs" class="layui-form-label">
                <span class="x-red">*</span>选择文件:
            </label>
            <div class="layui-input-inline">
                <input type="file" value="" id="L_pass" name="note" required="" lay-verify=""
                       autocomplete="off" class="layui-input" style="border: 0px;margin-top: 8px">
            </div>
        </div>
        <div class="layui-form-item" style="margin-left: 138px;margin-top: 150px">
            <button class="layui-btn" type="button" onclick="upload()">
                确认上传
            </button>
        </div>
    </form>
</div>
<script>

    function typeChange() {
        var type = document.getElementById("type").value;
        $.post('/management/Note/ShowByType', {tid: type}, function (data) {
            location.reload();
        });
    }


    function doSearch() {
        var title = document.getElementById("title").value;
        $.post('/management/Note/doSearch', {title: title}, function (data) {
            location.reload();
        })
    }




    function member_del(nid) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            var params = "nid=" + nid;
            $.post("/management/Note/dodel", params, function (data) {
                if (parseInt(data.code) != 0) {
                    layer.msg(data.msg, {icon: 1}, {time: 1500});
                } else {
                    layer.msg(data.msg, {icon: 2}, {time: 1500})
                }
                setTimeout(function () {
                    location = ""
                }, 1000);
            })
        });
    }


    function fh() {
        setTimeout(function () {
            location = "";
        })
            , 10000
    }

    function x_show(title, boxid, w, h) {
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
            content: $("#" + boxid)
        });
    }


    function upload() {
        var formData = new FormData($("#form1")[0]);
        $.ajax({
            url: '/management/Note/upload',
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.code != 0) {
                    layer.msg(data.msg, {icon: 1}, {time: 1500});
                } else {
                    layer.msg(data.msg, {icon: 2}, {time: 1500});
                }
                setTimeout(function () {
                    location = "";
                }, 1200)
            },
            error: function (data) {
                layer.alert(data);
            }
        });
    }

</script>
</body>
</html>
