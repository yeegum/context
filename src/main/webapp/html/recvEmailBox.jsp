<%--
  Created by IntelliJ IDEA.
  User: yeegum
  Date: 2019/8/19
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>收件箱</title>
    <link href="${pageContext.request.contextPath}/html/friend/css/makefriends.css" rel="stylesheet" />
    <link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<body>
<table class="layui-hide" id="test4" lay-filter="demo"  width="1000px">
</table>
<script type="text/html" id="barDemo4">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看邮件</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="addRecycleEmail">移至回收站</a>
</script>
<script type="text/javascript">
        layui.use('table',function () {
            var $=layui.jquery;
            var table=layui.table;
            table.render({
                elem:'#test4',
                url:'/management/recvEmailBox',
                cols:[[/*{type:'checkbox', fixed: 'left'},*/
                    {field:'send_userid', width: 120, title: '发送方ID', sort: true}
                    ,{field:'nickname', width:220,  title: '昵称', sort: true}
                    ,{field: 'topic', width: 220, title: '标题', sort: true}
                    ,{field:'datetime', width:280,  title: '发件时间', sort: true}
                    ,{field:'status', width:100, title: '状态',templet:function (f) {
                            if (f.status==0) { return'未读'}
                            else if (f.status==1){return'已读'}
                        }}
                    ,{fixed: 'right', width:280,  align:'center', title:'操作', toolbar: '#barDemo4'}
                ]],
                text:{none:"您还没有来信呢"}
                ,page:true,
                limit:5,
                limits:[5,10,15,20]
            });
        });
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                $.ajax({
                    url: "/management/readRecvEmail",
                    data: {id: data.id},
                    datatype: "text",
                    success: function (result) {
                        show('查看邮件内容❤','add',600,400,data.content);
                    }
                })
            } else if(obj.event === 'addRecycleEmail'){
                $.ajax({
                    url: "/management/addRecycleEmail_recvEmail",
                    data: {id:data.id},
                    datatype: "text",
                    success: function (data) {
                        layer.alert("放到回收站了哦☺", {
                            time: 3000,
                            end: function () {
                                location.reload();
                            }
                        }, function (addRecycleEmail_result) {
                            // 获得frame索引
                            location.reload();
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    }
                })
            }
        });
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
<script type="text/javascript">
    function show(title,id,w,h,data){
        if (title == null || title == '') {
            title=false;
        };
        if (w == null || w == '') {
            w=($(window).width()*0.9);
        };
        if (h == null || h == '') {
            h=($(window).height() - 50);
        };
        layer.open({
            type: 1,
            area: [w+'px', h +'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade:0.4,
            title: title,
            content: data,
            end:function(){
                location.reload();//弹出层结束后，刷新主页面
            }
        });
    }
    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form
            ,layer = layui.layer;
    });
</script>
<style type="text/css">

    .layui-table-cell{

        text-align:center;

        height: auto;

        white-space: normal;

    }

    .layui-table img{

        max-width:30px

    }
</style>
</body>
</html>
