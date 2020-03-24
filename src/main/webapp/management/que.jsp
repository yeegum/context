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
    </style>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>

<%
    /*GameUser gameUser=new GameUser();
    gameUser.setId(6);
    session.setAttribute("user",gameUser);*/
%>
<%--<c:forEach items="${types}" var="temp">
    <c:choose>
        <c:when test="${temp.id==que.id}">
            <option selected value="${temp.id}">${temp.type}</option>
        </c:when>
        <c:otherwise>
            <option value="${temp.id}">${temp.type}</option>
        </c:otherwise>
    </c:choose>

</c:forEach>--%>
<div id="box_add" class="x-body layui-anim layui-anim-up" style="display: none">
    <form id="form1" style="margin-left: 50px;" method="post" class="layui-form">
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="x-red">*</span>科目
            </label>
            <div class="layui-input-inline">
                <select id="L_repass" name="subid" lay-verify="required">
                    <option value="">请选择科目</option>
                    <c:forEach items="${subs}" var="temp">
                        <option value="${temp.sub_id}">${temp.sub_name}</option><%------${temp.tname}--%>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">
                <span class="x-red">*</span>题型
            </label>
            <div class="layui-input-inline">
                <select lay-filter="type" id="ty" name="typeid" lay-verify="required">
                    <option value="">请选择题型</option>
                    <c:forEach items="${types}" var="temp">
                        <option value="${temp.que_type_id}">${temp.type_name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="L_username" class="layui-form-label">
                <span class="x-red">*</span>题目内容
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_username" name="content" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div id="a" class="layui-form-item">

        </div>
        <div id="a1" style="display: none" class="layui-form-item">

        </div>
        <div id="a2" style="display: none" class="layui-form-item">


        </div>
        <br/>
        <br/>
        <br/>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button type="submit" class="layui-btn" lay-filter="add" lay-submit="">
                增加
            </button>
        </div>
    </form>
</div>

<div class="layui-btn-group demoTable layui-inline">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
    <button class="layui-btn" data-type="delChecked">删除所选</button>
    <button class="layui-btn" onclick="member_add('添加题目','box_add')">增加数据</button>
</div>
<br/>
<br/>
<form class="layui-form  ">
    <div class="layui-form-item">

       <%-- <div class="layui-input-inline">
            <input type="text" class="layui-input" id="id" placeholder="题目ID">
        </div>--%>

        <div class="layui-input-inline">
            <select id="sub">
                <option value=1>javaSE</option>
                <option value=2>JavaOracle</option>
                <option value=3>javaEE</option>
            </select>
        </div>

        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="ask" placeholder="关键字">
        </div>
       <%-- <div class="layui-input-inline">
            <select id="status">
                <option value="0">未审批</option>
                <option value="1">已审批</option>
            </select>
            <input type="text" class="layui-input" id="endscore">
        </div>--%>
        <button class="layui-btn" lay-submit=""  lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
           <button class="layui-btn"   onclick="location.reload(location.href)">刷新</button>
    </div>
</form>

<table  class="layui-table"
       align="center" style="width:800px;height:600px;margin: auto;margin-top: 100px;text-align:center;" lay-filter="demo">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'que_id', width:80, sort: true, fixed: true}">问题编号</th>
        <th lay-data="{field:'sub_id', width:80}">科目编号</th>
        <th lay-data="{field:'que_type_id', width:80}">题型编号</th>
        <th lay-data="{field:'ask', width:250}">问题内容</th>
        <th lay-data="{field:'right_ask', width:250}">参考答案</th>
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


    /*增加问题*/
    function member_add(title, id) {
        layer.open({
            type: 1,
            area: [500 + 'px', 400 + 'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: $("#" + id)//$("#box_add")
        });
    }

    layui.use(['layer', 'jquery','table', 'form'], function () {
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
        //form 搜索
        form.on('submit(search)',function () {
           /* alert("..");*/
            // var demoReload = $('#demoReload').val();
            //执行重载
           /* var id = $("#id").val();*/
            // alert(startScore);
            var sub= $("#sub").val();
            // alert(endScore);
            var ask = $("#ask").val();
            // alert(status);
         /*   var par_id = getQueryVariable("par_id");*/
            // alert(par_id);
            var url = "${pageContext.request.contextPath}/test/queSearch";
        /*    alert(url);*/
          /*  table.render({
                id: 'table1',
                url:url

            });*/
            table.reload('table1', {
                url:url
                ,where: {
                    /*'id':id,*/
                    'sub':sub,
                    'ask':ask
                }
            });
            return false;
        });
        form.on('submit(add)', function (data) {
            var url = "/test/queAdd";
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
                    alert("提交失败");
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
      /*  lay-data="{limit: 5,limits: [3, 5, 10] , url:'/test/page', page:true, id:'table1'}";*/
        var url = "${pageContext.request.contextPath}/test/page";
        // alert(url);
        table.init('demo',{
            id:'table1'
            ,limit:3
            ,limits:[3,5,10]
            ,url:url
            ,page:true
        });
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
                    params += "ids=" + data.que_id;

                    $.post("/test/Del", params, function (result) {
                        /*location.reload();*/
                    });
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                layer.open({
                    type: 2,
                    area: [600 + 'px', 500 + 'px'],
                    fix: false, //不固定
                    maxmin: true,
                    shadeClose: true,
                    shade: 0.4,
                    title: '问题修改',
                    content: '${pageContext.request.contextPath}/test/getQueById?id=' + data.que_id
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
            /*reload: function(){
                var demoReload = $('#demoReload');
                    alert(demoReload.val());
                //执行重载
                table.reload('table1', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        key: {
                            que_id: demoReload.val()
                        }
                    }
                }, 'data');
            },*/
            getCheckData: function () { //获取选中数据
                var checkStatus = table.checkStatus('table1')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            , getCheckLength: function () { //获取选中数目
                var checkStatus = table.checkStatus('table1')
                    , data = checkStatus.data;
                layer.msg('选中了：' + data.length + ' 个');
            }

            , delChecked: function () { //删除选中数据
                if (window.confirm("确认删除吗")) {
                    var checkStatus = table.checkStatus('table1')
                        , data = checkStatus.data;
                    //data是json数组
                    var params = "";
                    // alert(data.length);
                    for (var i = 0; i < data.length; i++) {
                        params += "ids=" + data[i].que_id + "&";
                    }
                    // alert(params);

                    $.post("/test/Del", params, function (result) {
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