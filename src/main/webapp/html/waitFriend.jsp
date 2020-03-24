<%--
  Created by IntelliJ IDEA.
  User: yeegum
  Date: 2019/8/19
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>好友申请</title>
    <link href="${pageContext.request.contextPath}/html/friend/css/makefriends.css" rel="stylesheet" />
    <link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<body>
<table class="layui-hide" id="test3" lay-filter="demo"  width="1000px">
</table>
<script type="text/html" id="barDemo3">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="agree">同意</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="reject">拒绝</a>
</script>
<script type="text/javascript">
        layui.use('table',function () {
            var $=layui.jquery;
            var table=layui.table;
            table.render({
                elem:'#test3',
                url:'/management/waitFriendList?userid=1',
                cols:[[/*{type:'checkbox', fixed: 'left'},*/
                    {field:'apply_userid', width:200,  title: '申请者ID', sort: true}
                    // ,{field:'sex', width:280,  title: '性别', sort: true}
                    ,{field:'apply_datetime', width:280,  title: '申请时间', sort: true}
                    ,{fixed: 'right', width:280,  align:'center', title:'操作', toolbar: '#barDemo3'}
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
                var apply_userid=data.apply_userid;
                var applied_userid=data.applied_userid;
                if(obj.event === 'agree'){
                    $.post("/management/addFriends?userid1="+apply_userid+"&userid2="+applied_userid
                        ,function (agree_result) {
                            obj.del();
                        })
                } else if(obj.event === 'reject'){
                    $.post("/management/rejectFriends?userid1="+apply_userid+"&userid2="+applied_userid
                        ,function (reject_result) {
                            obj.del();
                        })
                }
            });
        });

</script>
</body>
</html>
