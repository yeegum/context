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
<script>
    function autoFrame(id){
        //找到当年ifr
        $("iframe[name=ifr][data-frameid="+id+"]",parent.document).css("height",$(document).height());

    }
</script>
<html>
<head>
    <title>角色管理</title>
    <script>
        var table;
        layui.use(["form", "table", "layer", "laydate"], function () {
            table = layui.table;
            var laydate = layui.laydate;
            var form = layui.form;
//            laydate.render({
//                elem: '#startTimeStr'
//                ,type: 'datetime'
//            });
//            laydate.render({
//                elem: '#endTimeStr'
//                ,type: 'datetime'
//            });
            table.on('tool(tableBind)', function (obj) {
                var data = obj.data;
                if (obj.event == 'detail') {
                    layer.msg("点击了查看");
                } else if (obj.event === 'del') {
                    layer.confirm('真的删除么?', function (index) {
                        deletee({"roleid":data.roleid});
                        table.reload('pageTable');
                    });
                } else if (obj.event === 'edit') {
                    top.openLay("修改角色","/role/updateinit?roleid="+data.roleid,"900px", "860px");
                    table.reload('pageTable');
                }
            });
            function deletee(param) {
                $.post("/role/delete",param,function(r){
                    if(r > 0) {
                        layer.msg("删除成功",{icon:1,anim:6})
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
                        alert(1);
                        top.openLay("添加角色","${ctx}/user.do?method=roleinit","500px", "550px");
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选' : '未全选');
                        break;
                }
                ;
            });

            $.get("/m/list",  function (r) {
                $(r).each(function () {
                    $("select[name=midOne]").append(new Option(this.mname, this.mid));
                });
                form.render("select","role_filter");
            }, "json");

            $("#search").click(function(){
                var where = $("#fm").serializeJSON();
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
    角色管理界面...
    <form id="fm" class="layui-form">
        <div class="layui-inline">
            <label class="layui-form-label">角色名:</label>
        </div>
        <div class="layui-inline">
            <input name="rolename" placeholder="请输入名称" autocomplete="off" class="layui-input">
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">角色权限:</label>
        </div>

        <div class="layui-form layui-inline" lay-filter="role_filter">
            <select name="midOne" lay-search>
                <option value="">--输入或选择权限--</option>
            </select>
        </div>

        <input type="button" id="search" value="查询" class="layui-btn layui-btn-sm">
    </form>
    <table class="layui-table" lay-data="{url:'/role/page', page:true, id:'pageTable',toolbar: '#myBar', done: function(){autoFrame(${param.id})}}" lay-filter="tableBind">
        <thead>
        <tr>
            <th lay-data="{type:'numbers'}">序号</th>
            <th lay-data="{field:'rolename', width:180}">角色名</th>
            <th lay-data="{field:'roleMname', width: 700}">角色权限</th>
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
        top.openLay("添加角色","/role/addinit","500px", "550px");
    }
</script>
</body>
</html>
