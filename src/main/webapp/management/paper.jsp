<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/lib/layui/css/layui.css"/>
    <style type="text/css">
        .x-red {
            color: #E70012;
        }
        .layui-table-page{text-align: center;}

    </style>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>

<%
    /*GameUser gameUser=new GameUser();
    gameUser.setId(6);
    session.setAttribute("user",gameUser);*/
%>
<div id="box_edit" class="x-body layui-anim layui-anim-up" style="display: none">
    <form id="form1" style="margin-left: 50px;" method="post" class="layui-form">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>试卷编号
            </label>
            <div class="layui-input-inline">
                <input type="text"   id="pid" name="pid"
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>试卷名称
            </label>
            <div class="layui-input-inline">
                <input type="text"   id="pna" name="pna" lay-verify="required"
                       autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">开始时间：</label>
            <div class="layui-input-inline">
                <input type="text"  name="startime" class="layui-input" id="startime" placeholder="yyyy-MM-dd HH:mm:ss">
            </div>
        </div>
        <br/>
        <br/>
        <div class="layui-inline">
            <label class="layui-form-label">结束时间：</label>
            <div class="layui-input-inline">
                <input type="text"  name="endtime" class="layui-input" id="endtime" placeholder="yyyy-MM-dd HH:mm:ss">
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>考试时长
            </label>
            <div class="layui-input-inline">
                <input type="text"   id="leng" name="leng" lay-verify="required"
                       autocomplete="off" class="layui-input" >
            </div>
        </div>
        <br/>
        <br/>
        <br/>
        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button type="submit" class="layui-btn" lay-filter="alt" lay-submit="">
                修改
            </button>
        </div>
    </form>
</div>

<div class="layui-btn-group demoTable" align="center">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
    <button class="layui-btn" data-type="delChecked">删除所选</button>
    <button class="layui-btn" onclick="add('添加试卷','./test.html',600,400)">增加试卷</button>
</div>
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="sex" value="{{d.status}}" lay-skin="switch" lay-text="已发布|未发布" lay-filter="sexDemo"
           {{ 1==d.status?'checked':''}} >
</script>
<table id="table1" class="layui-table"
       lay-data="{limit: 5,limits: [3, 5, 10], url:'/test/paper', page:true, id:'idTest'}"
        style="width:800px;height:600px;margin: auto;margin-top: 100px;text-align:center;" lay-filter="demo">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left',align:'center'}"></th>
        <th lay-data="{field:'par_id', width:80, sort: true, fixed: true,align:'center'}">试卷编号</th>
        <th lay-data= "{field:'status', width:120, templet: '#switchTpl', unresize: true,align:'center'}">发布状态</th>
        <th lay-data="{field:'rel_name', width:150,align:'center'}">模块名称</th>
        <th lay-data="{field:'sub_name', width:80,align:'center'}">科目名称</th>
        <th lay-data="{field:'par_name', width:150,align:'center'}">试卷名称</th>
        <th lay-data="{field:'test_start_time', width:180,align:'center'}">开始时间</th>
        <th lay-data="{field:'test_end_time', width:180,align:'center'}">结束时间</th>
        <th lay-data="{field:'test_length_time', width:80,align:'center'}">考试时长</th>
        <th lay-data="{fixed: 'right', width:178, align:'center', toolbar: '#barDemo'}"></th>

    </tr>
    </thead>
</table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;


        //日期时间选择器
        laydate.render({
            elem: '#startime'
            ,type: 'datetime'
            ,theme: '#E70012'
        });
        laydate.render({
            elem: '#endtime'
            ,type: 'datetime'
            ,theme: '#E70012'
        });
    });
    function add(title,url,w,h){

        layer.open({
            type: 2,
            area: [w+'px', h +'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade:0.4,
            title: title,
            content: url
        });
    }


    layui.use(['layer', 'jquery', 'form','table'], function () {
        var layer = layui.layer,
            $ = layui.jquery,
            form = layui.form,
            table=layui.table;

        form.on('select(type)', function (data) {
            if (data.value == 3) {
                // $("#a1").attr("display","block");
                $("#a").empty();
                var a1 = ' <label for="answer" class="layui-form-label">\n' +
                    '                <span class="x-red">*</span>参考答案\n' +
                    '            </label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <textarea name="key" id="answer" placeholder="请输入内容" lay-verify="required" class="layui-textarea"></textarea>\n' +
                    '            </div>';
                /*     alert(a1);*/
                $("#a").append(a1);
                form.render('select')
            } else {
                $("#a").empty();
                var a2 = '<div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span>A</span>\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="a" lay-verify=""\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '\n' +
                    '            <div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span>B</span>\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="b" lay-verify=""\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '\n' +
                    '            <div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span>C</span>\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="c" lay-verify=""\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '\n' +
                    '            <div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span>D</span>\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="d" lay-verify=""\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '\n' +
                    '            <div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span>E</span>\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="e" lay-verify=""\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span class="x-red">*</span>参考答案：\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="key" lay-verify="required"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>';
                /*  alert(a2);*/
                $("#a").append(a2);
                form.render('select');//select是固定写法 不是选择器
            }
    });
        //渲染表格

        //监听性别操作
        form.on('switch(sexDemo)', function(obj){
/*
            layer.tips(obj.value + ' ' + obj.name + '：'+ obj.elem.checked,obj.othis);*/
           /* alert($(obj.elem).parent().parent().prev().text());*/

            //alert($(obj.othis).parent().html());
          /*  table.render({
                id: 'table1'
                //...剩余省略
            });

            table.reload('table1', {   //方法渲染表格里的属性 ID
                where: { //设定异步数据接口的额外参数，任意设
                    aaaaaa: 'xxx'
                    ,bbb: 'yyy'
                },
                page: {
                    curr: $(".layui-laypage-em").next().html()  //主要代码行
                }
            });*/
            var id=$(obj.elem).parent().parent().prev().text();
                var url='${pageContext.request.contextPath}/test/issue';
                $.ajax({
                    type: "POST",
                    url: url,
                    data:{id:id, s:obj.value},
                    success: function (data) {
                       /* if (data.code == 200) {
                            layer.msg(data.msg);
                            setTimeout("window.location.reload()", 3500);
                        } else {
                            layer.msg(data.msg, {time: 3000});
                            setTimeout("window.location.reload()", 3500);
                        }*/
                       table.reload('table1');
                    }

                });

        });
        form.on('submit(alt)', function (data) {
            var url = "/test/paperAlt";
            /*$.post(url,$("#form1").serialize(),function (data) {
                alert(data.msg);
                /!*if(data.code=="201"){
                    layer.msg(data.msg,function(){
                        location.href='test.html'
                    });
                }else{
                    layer.msg(data.msg);
                }*!/
            });*/
            $.ajax({
                type: "POST",
                url: url,
                data: $("#form1").serialize(),
                dataType: "json",//预期后端的返回数据格式

                success: function (data) {
                    if (data.code == 200) {
                        layer.msg(data.msg);
                        setTimeout("window.location.reload()", 3500);
                    } else {
                        layer.msg(data.msg, {time: 3000});
                        setTimeout("window.location.reload()", 3500);
                    }
                },
                error: function () {
                    alert("修改失败");
                    /*window.location.refresh() ;*/
                    window.location.reload();
                }
            });
            return false;
        });
    });
    layui.use('table', function () {
        var table = layui.table;
        //监听表格复选框选择
        /* table.on('checkbox(demo)', function(obj){
             alert(obj);
         });*/


        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.alert('JSON信息行：<br>' + JSON.stringify(data))
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    /* var checkStatus = table.checkStatus('idTest')
                         ,data = checkStatus.data;
                     //data是json数组*/
                    var params = "";
                    params += "ids=" + data.par_id;

                    $.post("/test/delPaper", params, function (result) {
                        /*location.reload();*/
                    });
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {

                $("#pid").val(data.par_id);
                $("#pna").val(data.par_name);
                $("#startime").val(data.test_start_time);
                $("#endtime").val(data.test_end_time);
                $("#leng").val(data.test_length_time);
                layer.open({
                    type: 1,
                    area: [600 + 'px', 500 + 'px'],
                    fix: false, //不固定
                    maxmin: true,
                    shadeClose: true,
                    shade: 0.4,
                    title: '问题修改',
                    content: $("#box_edit")
                   /* btn: '修改完成',
                   btnAlign: 'c', //按钮居中
                    shade: 0, //不显示遮罩
                    yes: function () {
                        layer.closeAll();
                        location.href = "ques?page=1";//刷新
                    }
                        */
                });

            }
        });
        var $ = layui.$, active = {
            getCheckData: function () { //获取选中数据
                var checkStatus = table.checkStatus('idTest')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            , getCheckLength: function () { //获取选中数目
                var checkStatus = table.checkStatus('idTest')
                    , data = checkStatus.data;
                layer.msg('选中了：' + data.length + ' 个');
            }

            , delChecked: function () { //删除选中数据
                if (window.confirm("确认删除吗")) {
                    var checkStatus = table.checkStatus('idTest')
                        , data = checkStatus.data;
                    //data是json数组
                    var params = "";
                    for (var i = 0; i < data.length; i++) {
                        params += "ids=" + data[i].par_id + "&";
                    }

                    $.post("/test/delPaper", params, function (result) {
                        location.reload();
                    })
                }

                // layer.alert(JSON.stringify(data));
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
</body>
</html>