<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="../management/lib/layui/css/layui.css">
<script src="../management/js/jquery3.3.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../management/lib/layui/layui.js"></script>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>用户编辑</title>
    <script>
        var layer;
        layui.use(['form', 'upload'], function () {
            var form = layui.form
                , layer = layui.layer
                , upload = layui.upload;

            <c:if test="${code == 600}">
            layer.msg("操作成功", {icon: 6});
            // 得到user界面
            var menu = $("iframe[data-frameid=4]",top.document)[0].contentWindow;
            menu.table.reload('pageTable');
            </c:if>
            //监听指定开关
            form.on('switch(switchTest)', function (data) {
//                 layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
//                     offset: '6px'
//                 })
//                layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
//
//                alert(JSON.stringify(data));
            });

            //监听提交
            form.on('submit(tj)', function (data) {
                layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })
                var mid = $(":hidden[name=mid]").val();
               if(!mid) {
                   $(":hidden[name=method]").val("save");
               }
                //  提交
                return true;
            });
            <%--//表单初始赋值--%>
            <%--form.val('myform', {--%>
                <%--"mname": "${reqmenu.mname}" // "name": "value"--%>
                <%--, "murl": "${reqmenu.murl}"--%>
                <%--, "mid" :"${reqmenu.mid}"--%>
                <%--/*,"interest": 1 下拉框用的value*/--%>
                <%--/*  ,"like[write]": true //复选框选中状态*/--%>
                <%--&lt;%&ndash;, "valid": ${reqUser.valid == 1 ? true : false} //开关状态&ndash;%&gt;--%>
                <%--&lt;%&ndash;, "gender": "${reqUser.gender}"&ndash;%&gt;--%>
            <%--})--%>

            var uploadInst = upload.render({
                elem: '#uploadBtn'
                ,accept: 'images'
                ,auto: false
                ,size: 1024 * 1024 * 2
                ,choose: function(obj){
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result){
                        $('#faceImg').attr('src', result); //图片链接（base64）
                        $(":hidden[name=face]").val(result);
                    });
                }
            });
            $.get("/m/flist", function (r) {
                $(r).each(function () {
                    $("select[name=fid]").append(new Option(this.mname, this.mid));
                });
                form.render("select","role_filter");
            }, "json");

//            $.get("/user.do", {"method": "allRoles"}, function (r) {
//                $(r).each(function () {
//                    $("select[name=roleId]").append(new Option(this.roleName, this.roleId));
//                });
//                form.render("select","role_filter");
//            }, "json");
        });
    </script>
</head>
<body>

<form lay-filter="myform" class="layui-form layui-form-pane" method="post" action="/m/add">
    <input type="hidden" name="method" value="update">
    <input type="hidden" name="mid" value="${reqmenu.mid}">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">模块名</label>
            <div class="layui-input-block">
                <input type="text"  name="mname" autocomplete="off" class="layui-input" value="${reqmenu.mname}">
                <script>
                    if("${reqmenu.mid}" == "") {
                        $(":text[name=mname]").removeAttr("readonly");
                    }



                    <%--if("${reqmenu.fid}")--%>
                </script>
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">模块url</label>
        <div class="layui-input-inline">
            <input lay-verify="required" type="text" name="url" autocomplete="off" class="layui-input" value="${reqmenu.url}">
        </div>
    </div>


    <div class="layui-form layui-inline" lay-filter="role_filter">
    <select name="fid" lay-search>
    <option value="0">--选择父模块--</option>
    <option value="0">--无父模块--</option>
    </select>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">角色</label>
        <div class="layui-input-block">
            <c:forEach var="role" items="${role}" varStatus="i">
                <input readonly type="checkbox" name="mroleids" title="${role.rolename}" value="${role.roleid}">
            </c:forEach>
            <script>
                <c:forEach var="myrole" items="${reqmenu.mroles}">
                $(":checkbox[value=${myrole.roleid}]").prop("checked", true);
                </c:forEach>
            </script>
        </div>
    </div>

    <div class="layui-form-item">
        <button class="layui-btn" lay-submit="" lay-filter="tj">提交</button>
    </div>
</form>

</body>
</html>
