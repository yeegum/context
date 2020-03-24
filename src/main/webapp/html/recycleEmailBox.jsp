<%--
  Created by IntelliJ IDEA.
  User: yeegum
  Date: 2019/8/19
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>回收站</title>
    <link href="${pageContext.request.contextPath}/html/friend/css/makefriends.css" rel="stylesheet" />
    <link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<body>
<table class="layui-hide" id="test6" lay-filter="demo"  width="1000px">
</table>
<script type="text/html" id="barDemo6">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="remove">移回</a>
</script>
<script type="text/javascript">
        layui.use('table',function () {
            var $=layui.jquery;
            var table=layui.table;
            table.render({
                elem:'#test6',
                url:'/management/recycleEmailBox',
                cols:[[/*{type:'checkbox', fixed: 'left'},*/
                    {field:'status', width:100, title: '状态',templet:function (f) {
                            if (f.status==3) { return'发送的邮件'}
                            else if (f.status==2){return'收到的邮件'}
                        }}
                    ,{field:'topic', width:220,  title: '发件标题', sort: true}
                    ,{field:'datetime', width:280,  title: '发件时间', sort: true}
                    ,{fixed: 'right', width:280,  align:'center', title:'操作', toolbar: '#barDemo6'}
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
                if(obj.event === 'remove'){
                    // alert(data.send_id)
                    $.ajax({
                        url: "/management/recovery",
                        data: {id:data.id},
                        datatype: "text",
                        success: function (data) {
                            layer.alert("移回了哦☺", {
                                time: 3000,
                                end: function () {
                                    location.reload();
                                }
                            }, function (addRecycleEmail_result) {
                                // 获得frame索引
                                location.reload();
                                /*var index = parent.layer.getFrameIndex(window.name);
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
