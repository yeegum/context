<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="../management/lib/layui/css/layui.css">
<script src="../management/js/jquery3.3.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../management/lib/layui/layui.js"></script>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%@ page errorPage="/error.jsp" %> --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
    .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
        top: 50%;
        transform: translateY(-50%);
    }
</style>
<html>
<head>
    <title>模块管理</title>
    <script>
        var table;
        layui.use(["form", "table", "layer", "laydate"], function () {
            table = layui.table;
            var laydate = layui.laydate;
            var form = layui.form;
            laydate.render({
                elem: '#startTimeStr'
                ,type: 'datetime'
            });
            laydate.render({
                elem: '#endTimeStr'
                ,type: 'datetime'
            });
            table.on('tool(tableBind)', function (obj) {
                var data = obj.data;
                if (obj.event == 'detail') {
                    layer.msg("点击了查看");
                } else if (obj.event === 'del') {
                    layer.confirm('真的删除么?', function (index) {
                        deletee({"mid":data.mid});
                        table.reload('pageTable');
d

                    });
                } else if (obj.event === 'edit') {
                    top.openLay("修改模块","/m/updateinit?mid="+data.mid,"900px", "560px");
                    table.reload('pageTable');
                }
            });
            function deletee(param) {
                $.post("/m/deleteone",param,function(r){
                    if(r > 0) {
                        layer.msg("删除成功",{icon:1,anim:6})
                        reloadTable.reload();
                        table.reload('pageTable');
                    } else {
                        layer.msg("删除失败",{icon:2,anim:6})
                    }
                })
            }
            table.on('toolbar(tableBind)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);
                var data = checkStatus.data;
                switch (obj.event) {
                    case 'deleteCheck':
                        if (checkStatus.data.length == 0) {
                            layer.msg("请先选中要删除的行!", {icon: 2, anim: 6})
                        } else {
                            layer.confirm('真的删除么?', function (index) {
                                layer.msg(JSON.stringify(data));
                            });
                        }
                        break;
                    case 'getCheckLength':
                        var data = checkStatus.data;
                        layer.msg('选中了：' + data.length + ' 个');
                        break;
                    case 'add':
                        top.openLay("添加模块","${ctx}/user.do?method=addinit","700px", "700px");
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选' : '未全选');
                        break;
                }
                ;
            });

            $.get("/m/flist", function (r) {
                $(r).each(function () {
                    $("select[name=fid]").append(new Option(this.mname, this.mid));
                });
                form.render("select","role_filter");
            }, "json");

            $("#search").click(function(){
                var where = $("#fm").serializeJSON();
                layer.msg(where.toString())
                table.reload('pageTable', {
                    where: where
                    , page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            });

        });

        function fmtData(eee) {
            return {'code': 0, 'msg': '', 'count': eee.counts, 'data': eee.beans,};
        }


    </script>
</head>
<body>
模块管理界面...
<form id="fm" class="layui-form">
    <div class="layui-inline">
        <label class="layui-form-label">模块名:</label>
    </div>
    <div class="layui-inline">
        <input name="mname" placeholder="请输入名称" autocomplete="off" class="layui-input">
    </div>

    <div class="layui-inline">
        <label class="layui-form-label">父模块:</label>
    </div>

    <div class="layui-form layui-inline" lay-filter="role_filter">
        <select name="fid" lay-search>
            <option value="">--请选择--</option>
        </select>
    </div>

    <input type="button" id="search" value="查询" class="layui-btn layui-btn-sm">
</form>
<table class="layui-table" lay-data="{url:'/m/page', page:true, id:'pageTable',toolbar: '#myBar',parseData:fmtData, done: function(){autoFrame(${param.id})}}" lay-filter="tableBind">
    <thead>
    <tr>
        <th lay-data="{type:'numbers'}">序号</th>
        <th lay-data="{field:'mname', width:180}">模块名</th>
        <th lay-data="{field:'modularrole', width: 200}">角色权限</th>
        <th lay-data="{field:'fid', width: 100}">父模块ID</th>
        <th lay-data="{field:'url', width: 250}">模块地址</th>
        <th lay-data="{toolbar: '#btns', width: 170, fixed: 'right'}">操作</th>

    </tr>
    </thead>
</table>
<script type="text/html" id="btns">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="myBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add" onclick="add()">添加</button>
    </div>
</script>
<script type="text/javascript">
    function add() {
        top.openLay("添加模块","/m/addinit","900px", "560px");
    }
</script>
</body>
</html>
