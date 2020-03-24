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
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">演示</a>
        <a>
          <cite>导航元素</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
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
            请输入模块名称关键字：
            <div class="layui-inline" >
                <input class="layui-input" name="plate_type" id="demoReload" autocomplete="off">
            </div>
            <button class="layui-btn" lay-submit=""  lay-filter="fromreload">搜索</button>
        </form>
        </div>
            <div class="layui-inline">
        <button class="layui-btn" onclick="show_add('添加论坛版块','add',600,400)"><i class="layui-icon"></i>添加</button>
            </div>
    </xblock>
    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
        <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
        <button class="layui-btn" data-type="isAll">验证是否全选</button>
        <button class="layui-btn" data-type="delChecked">删除所选</button>
    </div>

    <table class="layui-table"
           lay-data="{limit: 5,limits: [5, 15, 25],width: 1500, height:800,
            url:'${pageContext.request.contextPath}/management/Plate/getAllPlate',page:true, id:'idTest'}"
           lay-filter="demo">
        <thead>
        <tr>
            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
            <th lay-data="{field:'plate_id', width:150, sort: true, fixed: true}">论坛模块ID</th>
            <%--<th  width="100px" height="100px"--%>
                <%--lay-data="{field:'plate_plateimg',width:250,templet:function (e) { return '<div><img src='+e.plate_plateimg+' ></div>' }}">--%>
                <%--论坛模块图片--%>
            <%--</th>--%>
            <th  width="100px" height="100px"
                 lay-data="{field:'plate_plateimg',width:250,templet :'#gudingimg'}"> 论坛模块图片</th>
            <th lay-data="{field:'plate_type', width:150}">论坛模块</th>
            <th lay-data="{field:'plate_status',templet: '#switchTpl', width:250}">论坛模块状态</th>
            <%--<th class="td-status">--%>
            <%--<span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span></th>--%>
            <th lay-data="{fixed: 'right', width:178, align:'center', toolbar: '#barDemo'}">操作</th>
        </tr>
        </thead>
    </table>
</div>
    <script type="text/html" id="barDemo">
        <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
        <script type="text/html" id="switchTpl">
            <input type="checkbox" name="plate_status" value="{{d.plate_id}}"
                   lay-skin="switch" lay-text="启用|禁用" lay-filter="statusDemo" {{ d.plate_status == 1 ? 'checked' : '
            ' }} >
        </script>

        <script type="text/html" id="gudingimg">
            <div><img height="32px" src="{{d.plate_plateimg}}" ></div>
        </script>
    <script>
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            form.on('switch(statusDemo)', function (obj) {
                // layer.tips(this.value + ' ' + this.name + '：' + obj.elem.checked, obj.othis);
                var tid="id="+this.value;
                $.post("${pageContext.request.contextPath}/management/Plate/changeStatus",tid,function (result) {
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
            var url='${pageContext.request.contextPath}/management/Plate/likeNamePlate';
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
                layer.msg('用户ID：' + data.plate_id + ' 的查看操作');
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    //删除
                    // alert(data.plate_id);
                    var data1 = "id=" + data.plate_id;
                    $.post("${pageContext.request.contextPath}/management/Plate/delPlate", data1, function (result) {
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
            } else if (obj.event == 'edit') {
                // $.post("Plate/findPlate",'id='+data.plate_id,function () {
                //   alert(111);
                // })
                //找到一个模块
                change_Plate("编辑模块", "${pageContext.request.contextPath}/management/Plate/findPlate?id=" + data.plate_id, 600, 500);
                // layer.alert('编辑行：<br>'+ JSON.stringify(data))
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
                        params += "ids=" + data[i].plate_id + "&";
                    }

                    $.post("${pageContext.request.contextPath}/management/Plate/delListPlate", params, function (result) {
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
<script>
    function change_Plate(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        ;
        // alert(url);
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        ;
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        ;
        layer.open({
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: url
            , btn: '修改完成'
            , btnAlign: 'c' //按钮居中
            , shade: 0 //不显示遮罩
            , yes: function () {
                parent.layer.closeAll();
                // $.post('AddChange');
                location.reload();
            }
        });
    }
</script>

<script>
    /*
    title是弹窗的标题，id是弹出层里面的内容
    这个函数的作用是把指定id里面的内容弹出来,并且以title作为弹窗的标题
     */
    function show_add(title, id, w, h) {
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

<div id="add" class="x-body layui-anim layui-anim-up" style="display: none">
    <form method="post" action="${pageContext.request.contextPath}/management/Plate/addPlate" class="layui-form"
          enctype="multipart/form-data">
        <input name="plate_type" id="plate_type" placeholder="论坛种类名称" type="text" lay-verify="required"
               class="layui-input">
        <hr class="hr15">
        <input type="radio" name="plate_status" value="1" title="启用" checked>
        <input type="radio" name="plate_status" value="0" title="禁用">
        <hr class="hr15">
        论坛头像:<input type="file" name="img" id="cphoto"/><br/>
        <!--<button  class="layui-btn" lay-filter="add" lay-submit="">-->
        <!--增加-->
        <!--增加-->
        <!--</button>-->
        <input type="submit" value="提交" class="layui-btn"/>
    </form>
</div>

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