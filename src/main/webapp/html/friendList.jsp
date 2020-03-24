<%--
  Created by IntelliJ IDEA.
  User: yeegum
  Date: 2019/8/19
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的好友</title>
    <link href="${pageContext.request.contextPath}/html/friend/css/makefriends.css" rel="stylesheet" />
    <link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<body>
<table class="layui-hide" id="test" lay-filter="demo"  width="1000px">
</table>
<script type="text/html" id="barDemo">
    <a href="email.jsp"  class="layui-btn layui-btn-xs layui-btn-primary">发邮件</a>
    <a class="layui-btn layui-btn-xs" lay-event="delete">解除好友</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="addBlackList">屏蔽拉黑</a>
</script>
<script type="text/javascript">
        layui.use('table',function () {
            var $=layui.jquery;
            var table=layui.table;
            table.render({
                elem:'#test',
                url:'/management/friends',
                cols:[[/*{type:'checkbox', fixed: 'left'},*/
                    {field:'userid', width:80, title: '好友ID', sort: true}
                    ,{field:'nickname', width:220,  title: '昵称', sort: true}
                    ,{field:'sex', width:80,  title: '性别', templet:function (f) {
                            if (f.sex==0) { return'男'}
                            else if (f.sex==1){return'女'}
                        }
                    }
                    ,{field:'email', width:280,  title: '邮箱地址', sort: true}
                    ,{fixed: 'right', width:280,  align:'center', title:'操作', toolbar: '#barDemo'}
                ]],
                text:{
                 none:"您还没有好友呢，赶快去添加吧😊"
                }
                ,page:true,
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
                if(obj.event === 'sendEmail'){

                }else if (obj.event === 'delete'){
                    $.post("/management/delFriends?userid="+userid,function (delete_result) {
                        layer.alert("已经删除了，再加上得看天意了🙃", {
                            time:3000,
                            end:function () {
                                location.reload();
                            }},function () {
                            // 获得frame索引
                            parent.location.reload();
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    })
                } else if(obj.event === 'addBlackList'){
                    $.post("/management/addBlackList?userid="+userid,function (addBlackList_result) {
                        layer.alert("拉黑成功，只能去黑名单里看见他😭", {
                            time:3000,
                            end:function () {
                                location.reload();
                            }},function () {
                            // 获得frame索引
                            parent.location.reload();
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    })
                }
            });
        });

</script>
</body>
</html>
