<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>学习管理</title>
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

<body class="layui-anim layui-anim-up">
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">学习管理</a>
        <a>
          <cite>笔记管理</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            笔记名称:<input type="text" id="title" placeholder="请输入笔记名称" autocomplete="off" class="layui-input">
            <button class="layui-btn" onclick="doSearch()" type="button" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="location='/management/Note/doShow?page=1&status=0&url=management/admin-waitpass-note-list'">待审核笔记</button>
        <button class="layui-btn" onclick="location='/management/Note/doShow?page=1&status=2&url=management/admin-nopass-note-list'">未过审核笔记</button>
        <span class="x-right" style="line-height:40px">&nbsp;&nbsp;共${pageInfo.pages} 页</span>
        <span class="x-right" style="line-height:40px">共有数据：${pageInfo.total} 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i
                        class="layui-icon">&#xe605;</i></div>
            </th>
            <th>笔记ID</th>
            <th>笔记标题</th>
            <th>笔记作者</th>
            <th>笔记类别</th>
            <th>文件名</th>
            <th>上传时间</th>
            <th>下载次数</th>
            <th>笔记状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="i">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='${i.nid}'><i
                            class="layui-icon">&#xe605;</i>
                    </div>
                </td>
                <td>${i.nid}</td>
                <td>${i.title}</td>
                <td>${i.nickname}</td>
                <td>${i.tname}</td>
                <td>${i.path}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${i.subtime}" type="both"/></td>
                <td>${i.times}</td>
                <td>${i.sname}</td>
                <td class="td-manage">
                    <a title="编辑" onclick="x_change('修改信息','/management/Note/doForChange?nid=${i.nid}',400,400)" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="member_del(${i.nid})" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="page">
        <div>
            <a class="num" href="/management/Note/doShow?page=${pageInfo.firstPage}&url=management/admin-pass-note-list " onmousemove="window.status=''">首页</a>
            <a class="prev" href="/management/Note/doShow?page=${pageInfo.prePage}&url=management/admin-pass-note-list" onmousemove="window.status=''">&lt;&lt;</a>
            第${pageInfo.pageNum}页
            <a class="next" href="/management/Note/doShow?page=${pageInfo.nextPage}&url=management/admin-pass-note-list" onmousemove="window.status=''">&gt;&gt;</a>
            <a class="num" href="/management/Note/doShow?page=${pageInfo.lastPage}&url=management/admin-pass-note-list" onmousemove="window.status=''">尾页</a>
        </div>
    </div>

</div>
<script>
    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    function doSearch() {
        var title = document.getElementById("title").value;
        $.post('/management/Note/doSearch', {title: title}, function (data) {
            location.reload();
        })
    }


    function member_del(nid) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            var params = "nid="+nid;
            $.post("/management/Note/dodel",params, function (data) {
                if (parseInt(data.code) != 0) {
                    layer.msg(data.msg,{icon: 1}, {time: 1500});
                } else {
                    layer.msg(data.msg,{icon: 2},{time:1500})
                }
                setTimeout(function(){location=""},1000);
            })
        });
    }

    function x_change(title,url,w,h){
        if (w == null || w == '') {
            w=($(window).width()*0.9);
        };
        if (h == null || h == '') {
            h=($(window).height() - 50);
        };
        layer.open({
            type: 2,
            area: [w+'px', h +'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade:0.4,
            title: title,
            content: url,
            shade: 0 //不显示遮罩
        });
    }




    function delAll(argument) {
        var data = tableCheck.getData();
        if(data==""){
            layer.msg('请先进行选取'+data,{icon:7},{time:1000})
        }else {
            var params="";
            for (var i =0; i < data.length; i++){
                params += "ids=" + data[i] + "&";
            }
            layer.confirm('确认要删除吗？',{icon:3}, function (index) {
                //捉到所有被选中的，发异步进行删除
                $.post("/management/Note/delAll", params, function (data) {
                    if (parseInt(data.code) != 0) {
                        layer.msg(data.msg,{icon: 1}, {time: 1500});
                    } else {
                        layer.msg(data.msg,{icon: 2},{time:1500})
                    }
                    setTimeout(function(){location=""},1000);
                })
            });
        }
    }
</script>
</body>

</html>