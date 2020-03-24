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
    <title>用户管理</title>
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
                    layer.confirm('真的重置么?', function (index) {
                        cz({"userid":data.userid});
                        table.reload('pageTable');
                    });
                } else if (obj.event === 'del') {
                    layer.confirm('真的删除么?', function (index) {
                        deletee({"userid":data.userid});
                      table.reload('pageTable');
                    });
                } else if (obj.event === 'edit') {
//                    top.active.openLay("修改用户","https://www.baidu.com","500px", "400px");
                    top.openLay("修改用户","${ctx}/user/updateinit?userid="+data.userid,"900px", "560px");
                    table.reload('pageTable');
                }
            });
            function cz(param) {
                $.post("/user/cz",param,function(r){
                    if(r=1) {
                        layer.msg("重置成功",{icon:1,anim:6})
//                        reloadTable.reload();
                        table.reload('pageTable');
                    } else {
                        layer.msg("重置失败",{icon:2,anim:6})
                    }
                })
            }
            function deletee(param) {
                $.post("/user/deleteone",param,function(r){
                    if(r=1) {
                        layer.msg("删除成功",{icon:1,anim:6})
//                        reloadTable.reload();
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

                    case 'add':
                        top.openLay("添加用户","/user/addinit","900px", "560px");
                        break;

                }
                ;
            });

            // 查询角色
            $.get("/role/list", function (r) {
                $(r).each(function () {
                    $("select[name=roleId]").append(new Option(this.rolename, this.roleid));
                });
                form.render("select","role_filter");
            }, "json");
            //  点击查询按钮
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

        function fmtData(res) {
            return {'code': 0, 'msg': '', 'count': res.counts, 'data': res.beans};
        }

        function setFace(face) {
            return "<img onerror='this.src=\"../images/default.jpg\"' src='${ctx}/user.do?method=initFace&face="+face+"' class='layui-nav-img'>";
        }
    </script>
</head>
<body>
<form id="fm" class="layui-form">
    <div class="layui-inline">
        <label class="layui-form-label">用户名称:</label>
    </div>
    <div class="layui-inline">
        <input name="account" placeholder="请输入名称" autocomplete="off" class="layui-input">
    </div>

    <div class="layui-inline">
        <label class="layui-form-label">联系方式:</label>
    </div>
    <div class="layui-inline">
        <input name="phone" placeholder="请输入联系方式" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">角色:</label>
    </div>

    <div class="layui-form layui-inline" lay-filter="role_filter">
        <select name="roleId" lay-search>
            <option value="">--输入或选择角色--</option>
        </select>
    </div>
    <br>
    <div class="layui-inline">
        <label class="layui-form-label">开始时间:</label>
    </div>
    <div class="layui-inline">
        <input readonly id="startTimeStr" name="startTimeStr" placeholder="请选择开始时间" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">结束时间:</label>
    </div>
    <div class="layui-inline">
        <input readonly id="endTimeStr" name="endTimeStr" placeholder="请选择结束时间" autocomplete="off" class="layui-input">
    </div>

    <div class="layui-inline">
        <label class="layui-form-label">性别:</label>
    </div>
    <div class="layui-form layui-inline">
        <select name="sex" lay-search>
            <option value="">--输入或选择性别--</option>
            <option value="0">男</option>
            <option value="1">女</option>
        </select>
    </div>
    <input type="button" id="search" value="查询" class="layui-btn layui-btn-sm">
</form>

    <table class="layui-table" lay-data="{url:'/user/list', page:true, id:'pageTable',toolbar: '#myBar',  done: function(){autoFrame(${param.id})}}" lay-filter="tableBind">
    <thead>
    <tr>
        <th lay-data="{type:'numbers'}">序号</th>
        <th lay-data="{field:'account', width:150}">用户名</th>
        <th lay-data="{field:'nickname', width:120}">昵称</th>

        <th lay-data="{field:'sex', width:80, sort: true,templet:function(res){return res.sex == 0 ? '男':'女'}}">
            性别
        </th>
        <th lay-data="{field:'phone',width:150}">联系方式</th>
        <th lay-data="{field:'faceimg',width:70,templet:function(res){return setFace(res.face);}}">头像</th>
        <th lay-data="{field:'rolename', width: 160}">角色</th>
        <th lay-data="{field:'registertime', sort: true, width: 150}">注册时间</th>
        <th lay-data="{field:'status', sort: true, width: 100,templet:function(res){return res.status == 1 ? '<font color=green>有效</font>': '<font color=gray>无效</font>'}}">是否有效</th>
        <th lay-data="{toolbar: '#btns', width: 170, fixed: 'right'}">操作</th>
    </tr>
    </thead>
</table>
<script type="text/html" id="btns">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">重置</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="myBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add" onclick="add()">添加</button>
    </div>
</script>
<script type="text/javascript">
    function add(){
        alert(1)
        top.openLay("添加用户","/user/addinit","900px", "560px");

    }
</script>
</body>
</html>
