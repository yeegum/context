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
            <c:if test="${vo == 400}">
            /*9.11*/
            layer.msg("成功", {icon: 6});
            // 得到user界面
            var user = $("iframe[data-frameid=2]",top.document)[0].contentWindow;
            user.table.reload('pageTable');
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
                /*layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })*/
                var userId = $(":hidden[name=userid]").val();
                if(!userId) {
                    $(":hidden[name=method]").val("save");
                }
                //  提交
                return true;
            });

            //表单初始赋值
            form.val('myform', {
                "account": "${requser.account}" // "name": "value"
               , "nickname": "${requser.nickname}"
                , "phone": "${requser.phone}"
                /*,"interest": 1 下拉框用的value*/
                /*  ,"like[write]": true //复选框选中状态*/
                , "status": ${requser.status == 1 ? true : false} //开关状态
                , "sex": "${requser.sex}"
            })

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


        });

        $(function () {
            $('#account').blur(function () {
                var account=$('#account').val();
                $.ajax({
                    url: "/user/ajaxaccount",
                    type: "post",
                    data: {"account":account},
                    success: function (data) {
                        //请求服务器成功了，执行的回调函数
                        if (data == 0) {
                            layer.msg("用户名已经存在请重新输入", {icon: 6});
                        } else {
                            layer.msg("用户名合法", {icon: 6});
                        }
                    }
                })

            })

        });
    </script>
</head>
<body>

<form lay-filter="myform" class="layui-form layui-form-pane" method="post" action="/user/update" id="myform">
    <input type="hidden" name="method" value="update">
    <input type="hidden" name="userid" value="${requser.userid}">
    <%--<input type="hidden" name="face" value="${requser.face}">--%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-block">
                <input type="text" readonly name="account" value="${requestScope.requser.account}" autocomplete="off" aria-readonly="true" class="layui-input" id="account">
                <script>
                    if("${requser.userid}" == "") {
                        $(":text[name=account]").removeAttr("readonly");
                    }
                </script>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-inline">
                <input  type="text" name="nickname" value="${requestScope.requser.nickname}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-inline">
                <input  type="text" name="phone" value="${requestScope.requser.phone}" lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item" pane="">
        <label class="layui-form-label">是否有效</label>
        <div class="layui-input-block">
            <input value="1" lay-text="ON|OFF" ${requestScope.requser.status == 1 ? true : false} type="checkbox" name="status"  lay-skin="switch" lay-filter="switchTest">
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">单选框</label>
        <div class="layui-input-block" >
            <input type="radio" name="sex"  value="0"
            <c:if test="${requestScope.requser.sex==0}">checked</c:if>
                   title="男">
            <input type="radio" name="sex" value="1"
                   <c:if test="${requestScope.requser.sex==1}">checked</c:if>
                   title="女">
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">角色</label>
        <div class="layui-input-block">
            <c:forEach var="role" items="${requestScope.reqrole}" varStatus="i">
                <input type="checkbox" name="roleIds" title="${role.rolename}" value="${role.roleid}">
            </c:forEach>
            <script>
                <c:forEach var="myrole" items="${requestScope.requser.roles}">
                $(":checkbox[value=${myrole.roleid}]").prop("checked", true);
                </c:forEach>
            </script>
        </div>
    </div>


    <%--<div class="layui-form-item layui-form-text">--%>
        <%--<label class="layui-form-label">头像</label>--%>
        <%--<div class="layui-input-block">--%>
            <%--<div class="layui-inline">--%>
                <%--<button type="button" class="layui-btn" id="uploadBtn">上传图片</button>--%>
            <%--</div>--%>
            <%--<div class="layui-inline">--%>
                <%--<img style="border-radius:50%; width:100px;height:100px;" onerror="this.src='${ctx}/images/default.jpg'" src="${ctx}/user.do?method=initFace&face=${requser.face}" class="layui-upload-img" id="faceImg">--%>
            <%--</div>--%>

        <%--</div>--%>
    <%--</div>--%>

    <div class="layui-form-item">
        <button class="layui-btn" lay-submit="" lay-filter="tj">提交</button>
    </div>
</form>

</body>
</html>
