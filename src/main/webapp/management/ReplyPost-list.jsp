<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <![endif]-->
</head>
<body class="layui-anim layui-anim-up">
<div class="x-body">
    <%--<div class="layui-row">--%>
        <%--<form class="layui-form layui-col-md12 x-so">--%>
            <%--<input type="text" name="likename" placeholder="请输入模块名称关键字" autocomplete="off" class="layui-input">--%>
            <%--<button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>--%>
        <%--</form>--%>
    <%--</div>--%>
    <xblock>
        <div class="layui-inline">
        <form class="demoTable">
            请输入回复者的关键字：
            <div class="layui-inline" >
                <input class="layui-input" name="plate_type" id="demoReload" autocomplete="off">
            </div>
            <button class="layui-btn" lay-submit=""  lay-filter="fromreload">搜索</button>
        </form>
        </div>
    </xblock>
    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
        <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
        <button class="layui-btn" data-type="isAll">验证是否全选</button>
        <button class="layui-btn" data-type="delChecked">删除所选</button>
    </div>

    <table class="layui-table"
           lay-data="{limit: 5,limits: [5, 15, 25],
            url:'${pageContext.request.contextPath}/management/Posts/getAllReplyPost',page:true, id:'idTest'}"
           lay-filter="demo">
        <thead>
        <tr>
            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
            <th lay-data="{field:'reply_id', width:150, sort: true, fixed: true}">评论ID</th>
            <th lay-data="{field:'user_id', width:150}">回复者的ID</th>
            <th lay-data="{field:'user_name', width:150}">回复者的账号名</th>
            <th lay-data="{field:'responded_id', width:100}">被回复的id</th>
            <th lay-data="{field:'post_id',width:100}">回复帖子的id</th>
            <th lay-data="{field:'apply_time', width:200}">评论时间</th>
            <th lay-data="{field:'apply_content', width:250}">回复的内容</th>
            <%--<th class="td-status">--%>
            <th lay-data="{field:'apply_status',templet: '#switchTpl', width:250}">回复的状态</th>
            <%--<span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span></th>--%>
            <th lay-data="{fixed: 'right', width:178, align:'center', toolbar: '#barDemo'}">操作</th>
        </tr>
        </thead>
    </table>
</div>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
        <script type="text/html" id="switchTpl">
            <input type="checkbox" name="apply_status" value="{{d.reply_id}}"
                   lay-skin="switch" lay-text="启用|禁用" lay-filter="statusDemo" {{ d.apply_status == 1 ? 'checked' : '
            ' }} >
        </script>
    <script>
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            form.on('switch(statusDemo)', function (obj) {
                var tid="id="+this.value;
                $.post("${pageContext.request.contextPath}/management/Posts/changeReplyStatus",tid,function (result) {
                    layer.alert(result.msg, {icon: 6, time: 1000}, function () {
                    });
                })
            });
        });
    </script>

<script>
   layui.use(['layer', 'form'], function () {
        $ = layui.jquery;
        layer = layui.layer,
            form = layui.form;
        //监听提交
    })
</script>
<script>
    layui.use('table', function () {
        var table = layui.table;
        //监听表格复选框选择
        form.on('submit(fromreload)',function () {
            var demoReload = $('#demoReload').val();
            //执行重载
            // alert(demoReload)
            var url='${pageContext.request.contextPath}/management/Posts/likeNameReply';
            table.reload('idTest', {
                url:url
                ,where: {
                    'likename':demoReload
                }
            });
            return false;
        })


        table.on('checkbox(demo)', function (obj) {
            //alert(obj);
        });
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.msg('用户ID：' + data.reply_id + ' 的查看操作');
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    //删除
                    var data1 = "id=" + data.reply_id;
                    $.post("${pageContext.request.contextPath}/management/Posts/delSingerReplyPost", data1, function (result) {
                        layer.alert(result.msg, {icon: 6, time: 1000}, function () {
                            // // 获得frame索引
                            // var index = parent.layer.getFrameIndex(window.name);
                            // //关闭当前frame
                            // parent.layer.close(index);
                        });
                        obj.del();
                        layer.close(index);
                        location.reload();
                    });
                });
            }
        });

        var $ = layui.$, active = {
            getCheckData: function () { //获取选中数据
                var checkStatus = table.checkStatus('idTest')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            },
            delChecked: function () { //删除选中数据
                if (window.confirm("确认删除吗")) {
                    var checkStatus = table.checkStatus('idTest')
                        , data = checkStatus.data;
                    //data是json数组
                    var params = "";
                    for (var i = 0; i < data.length; i++) {
                        params += "ids=" + data[i].reply_id + "&";
                    }

                    $.post("${pageContext.request.contextPath}/management/Posts/delListReply", params, function (result) {
                        location.reload();
                    })
                }

                // layer.alert(JSON.stringify(data));
            }
            , getCheckLength: function () { //获取选中数目
                var checkStatus = table.checkStatus('idTest')
                    , data = checkStatus.data;
                layer.msg('选中了：' + data.length + ' 个');
            }
            , isAll: function () { //验证是否全选
                var checkStatus = table.checkStatus('idTest');
                layer.msg(checkStatus.isAll ? '全选' : '未全选')
            }
        };

        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
<script type="text/javascript">
    function reads(fil) {
        var reader = new FileReader();
        reader.readAsDataURL(fil);
        reader.onload = function () {
            // document.getElementById("dd").innerHTML += "<img src='"+reader.result+"'>";
            $("#logo").attr("src", reader.result)
        }
    }
</script>
</body>
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

    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {

            if ($(obj).attr('title') == '启用') {
                //发异步把用户状态进行更改
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {icon: 5, time: 1000});

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {icon: 5, time: 1000});
            }

        });
    }

    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function (index) {
            //捉到所有被选中的，发异步进行删除
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
</html>