<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/lib/layui/css/layui.css"/>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <style type="text/css">
        .x-red {
            color: #E70012;
        }

    <![endif]-->
</head>
<body>
<form id="form1"  style="width:80%;height:80%;margin:auto;margin-top: 10%;" class="layui-form" method="post">
    <div class="layui-form-item">
        <label for="L_ID" class="layui-form-label">
            <span class="x-red">*</span>题目ID
        </label>
        <div class="layui-input-inline">
            <input type="text" id="L_ID" name="queid" required=""
                   autocomplete="off" class="layui-input" readonly value="${que.que_id}">
        </div>
        <div class="layui-form-mid layui-word-aux">
            <span class="x-red">不能修改id</span>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="L_repass" class="layui-form-label">
            <span class="x-red">*</span>科目
        </label>
        <div class="layui-input-inline">
            <select id="L_repass" name="subid" lay-verify="">
                <option value="">请选择科目</option>
                <c:forEach items="${subs}" var="temp">
                    <c:choose>
                        <c:when test="${temp.sub_id==que.sub_id}">
                            <option selected value="${temp.sub_id}">${temp.sub_name}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${temp.sub_id}">${temp.sub_name}</option>
                        </c:otherwise>
                    </c:choose>
                    <%--<option value="${temp.sub_id}">${temp.sub_name}----${temp.sub_teacher}</option>--%>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">
            <span class="x-red">*</span>题型
        </label>
        <div class="layui-input-inline">
            <select lay-filter="type" id="ty" name="typeid" lay-verify="">
                <option value="">请选择题型</option>
                <c:forEach items="${types}" var="temp">
                    <c:choose>
                        <c:when test="${temp.que_type_id==que.que_type_id}">
                            <option selected value="${temp.que_type_id}">${temp.type_name}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${temp.que_type_id}">${temp.type_name}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="L_username" class="layui-form-label">
            <span class="x-red">*</span>题目内容
        </label>
        <div class="layui-input-inline">
            <input type="text" id="L_username" name="content" required=""
                   autocomplete="off" class="layui-input" value="${que.ask}">
        </div>
    </div>
    <%--<div class="layui-form-item">
        <label for="L_email" class="layui-form-label">
            <span class="x-red">*</span>参考答案
        </label>
        <div class="layui-input-inline">
            <input type="text" id="L_email" name="key" required=""
                   autocomplete="off" class="layui-input" value="${que.right_ask}">
        </div>
      <&lt;%&ndash;%--  <div class="layui-form-mid layui-word-aux">
            <span class="x-red">*</span>简要一些
        </div>&ndash;%&gt;&ndash;%&gt;
    </div>--%>
    <%--toLowerCase() ---将字符串中的所有字符都转换成小写；toUpperCase() --- 将字符串中的所有字符都转换成大写；--%>
    <div id="a" class="layui-form-item">
         <c:forEach items="${ops}" var="temp">
             <div class="layui-form-item">
                 <label class="layui-form-label">
                     <span class="x-red">*</span>${temp.que_op}
                 </label>
                 <div class="layui-input-inline">
                     <input type="text" name="${temp.que_op}" required=""
                            autocomplete="off" class="layui-input" value="${temp.statement}">
                 </div>
             </div>
         </c:forEach>
    </div>
    <div class="layui-form-item">
        <button  class="layui-btn" lay-submit="" lay-filter="alt">
            修改
        </button>
    </div>
</form>
<script>
    $(function () {//页面加载函数（jquery）
        // 任何需要执行的js特效，$("table tr:nth-child(even)").addClass("even");
        var val=$("#ty  option:selected").val();

        if (val == 3) {
            $("#a").empty();
            var a1 = ' <label for="answer" class="layui-form-label">\n' +
                '                <span class="x-red">*</span>参考答案\n' +
                '            </label>\n' +
                '            <div class="layui-input-block">\n' +
                '                <textarea name="key" id="answer"  lay-verify="required" class="layui-textarea">${que.right_ask}</textarea>\n' +
                '            </div>';
           /* alert(a1);*/
            $("#a").append(a1);
        }else {
            var a1 = ' <label for="answer" class="layui-form-label">\n' +
                '                <span class="x-red">*</span>参考答案\n' +
                '            </label>\n' +
                '            <div class="layui-input-inline">\n' +
                '                 <input type="text"  name="key" lay-verify="required"\n' +
                '                           autocomplete="off" class="layui-input" value="${que.right_ask}">\n'  +
                '            </div>';
         /*   alert(a1);*/
            $("#a").append(a1);
        }
    });
    layui.use('form', function () {
        var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加(),只有执行了这一步，部分表单元素才会自动修饰成功
        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
        form.render();
        //监听提交
        form.on('select(type)', function (data) {

            if (data.value == 3) {
                // $("#a1").attr("display","block");
                $("#a").empty();
                alert(typeof (data.value));
                var a1 = ' <label for="answer" class="layui-form-label">\n' +
                    '                <span class="x-red">*</span>参考答案\n' +
                    '            </label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <textarea name="key" id="answer"  lay-verify="required" class="layui-textarea"  ></textarea>\n' +
                    '            </div>';
                /*     alert(a1);*/
                $("#a").append(a1);
                alert(a1);
                form.render('select')
            } else {
                $("#a").empty();
                var a2 = '<div class="layui-form-item">\n' +
                    '                <label  class="layui-form-label">\n' +
                    '                    <span>A</span>\n' +
                    '                </label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text"  name="a" lay-verify=""\n' +
                    '                           autocomplete="off" class="layui-input" >\n' +
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
                    '                           autocomplete="off" class="layui-input" >\n' +
                    '                </div>\n' +
                    '            </div>';
                /*  alert(a2);*/
                $("#a").append(a2);
                form.render('select');//select是固定写法 不是选择器
            }
        });
        form.on('submit(alt)', function (data) {
            var url = "/test/queChange";
            // alert(url);
            $.ajax({
                type: "POST",
                url: url,
                data: $("#form1").serialize(),
                success: function (data) {
                    if (data.code == 200) {
                      /* layer.msg(data.msg, {time: 3000});
                        setTimeout("location.href='{pageContext.request.contextPath}'+'/login.html'",3500);*/
                        layer.alert("修改成功", {icon: 6, time:2500},function () {
                            parent.location.reload();
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    } else {
                        layer.msg(data.msg, {time: 3000});
                        window.location.reload();
                    }
                },
                error: function () {
                    layer.alert("修改失败",
                        {icon: 6, time:1500,yes:function(index ,layero){
                                layer.close(index); //关闭弹出框
                            }});
                }
            });
            return false;
        });
    });
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;

        //自定义验证规则
        form.verify({
            nikename: function (value) {
                if (value.length < 5) {
                    return '昵称至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , repass: function (value) {
                if ($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(add)', function (data) {
            console.log(data);
            //发异步，把数据提交给php
            alert(111);
            layer.alert("增加成功", {icon: 6}, function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
            });
            return false;
        });


    });
</script>
<script>var _hmt = _hmt || [];
(function () {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>