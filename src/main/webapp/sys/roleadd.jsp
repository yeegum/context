<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="../management/lib/layui/css/layui.css">
<script src="../management/js/jquery3.3.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../management/lib/layui/layui.js"></script>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<head>
    <title>Title</title>
    <script>
        layui.use(["layer","form"],function () {
            var layer=layui.layer;
            var form=layui.form;
        <c:if test="${code == 600}">
        layer.msg("操作成功", {icon: 6});
        // 得到user界面
            var role = $("iframe[data-frameid=3]",top.document)[0].contentWindow;
            role.table.reload('pageTable');
        </c:if>
            form.on('submit(tj)', function (data) {
                layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })
                var roleId = $(":hidden[name=roleid]").val();
                if(!roleId) {
                    $(":hidden[name=method]").val("roleadd");
                }
                //  提交
                return true;
            });
        form.val('myform', {
            "rolename": "${requestScope.reqrole.rolename}" // "name": "value"
            , "roleid":"${requestScope.reqrole.roleid}"
        })
        })
    </script>
</head>


<form  lay-filter="myform" class="layui-form layui-form-pane" method="get" action="/role/add" >
    <input type="hidden" name="method" value="update">
    <input type="hidden" name="roleid"  value="${requestScope.reqrole.roleid}">
    <div class="layui-inline">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" readonly name="rolename" autocomplete="off" class="layui-input" value="${requestScope.reqrole.rolename}">

            <script>
                if("${reqrole.roleid}" == "") {
                    $(":text[name=rolename]").removeAttr("readonly");
                }
            </script>
        </div>


        <div class="layui-form-item" pane="">
            <label class="layui-form-label">角色</label>
            <div class="layui-input-block">
                <c:forEach var="menu" items="${requestScope.ms}" varStatus="i">
                    <input type="checkbox" name="mids" title="${menu.mname}" value="${menu.mid}">
                </c:forEach>
                <script>
                <c:forEach var="myrole" items="${reqrole.modularList}">
                $(":checkbox[value=${myrole.mid}]").prop("checked", true);
                </c:forEach>
                </script>
            </div>
        </div>

        <div class="layui-form-item">
            <button class="layui-btn" lay-submit="" lay-filter="tj">提交</button>
        </div>
    </div>
</form>

</body>
</html>
