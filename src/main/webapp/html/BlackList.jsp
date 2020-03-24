<%--
  Created by IntelliJ IDEA.
  User: yeegum
  Date: 2019/8/19
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>黑名单</title>
    <link href="${pageContext.request.contextPath}/html/friend/css/makefriends.css" rel="stylesheet" />
    <link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<body>
<table class="layui-hide" id="test2" lay-filter="demo"  width="1000px">
</table>
<script type="text/html" id="barDemo2">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="refriend">变回好友</a>
</script>
<script type="text/javascript">
        layui.use('table',function () {
            var $=layui.jquery;
            var table=layui.table;
            table.render({
                elem:'#test2',
                url:'/management/blackList',
                cols:[[/*{type:'checkbox', fixed: 'left'},*/
                    {field:'userid', width:80, title: '好友ID', sort: true}
                    ,{field:'nickname', width:220,  title: '昵称', sort: true}
                    ,{field:'sex', width:80,  title: '性别', sort: true}
                    ,{field:'email', width:280,  title: '邮箱地址', sort: true}
                    ,{fixed: 'right', width:280,  align:'center', title:'操作', toolbar: '#barDemo2'}
                ]],
                page:true,
                limit:5,
                limits:[5,10,15,20]
            });
//监听表格复选框选择
            table.on('checkbox(demo)', function(obj){
                console.log(obj)
            });
//监听工具条(操作栏)
            table.on('tool(demo)', function(obj){
                var data = obj.data;
                var userid=data.userid;
                if(obj.event === 'refriend'){
                    $.ajax({
                        url: "/management/refriend",
                        data: {userid:data.userid},
                        datatype: "text",
                        success: function (data) {
                            layer.alert("变回好友了哦☺", {
                                time: 3000,
                                end: function () {
                                    location.reload();
                                }
                            }, function (addRecycleEmail_result) {
                                // 获得frame索引
                                location.reload();
                                /*    var index = parent.layer.getFrameIndex(window.name);
                                    //关闭当前frame
                                    parent.layer.close(index);*/
                            });
                        }
                    })

                }
            });
        });
</script>
</body>
</html>
