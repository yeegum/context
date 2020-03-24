<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/lib/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"></script>

    <title>userPage</title>
</head>
<body>
<form id="form1"  style="width:80%;height:80%;margin:auto;margin-top: 2%;" class="layui-form" method="post">


    <div class="layui-form-item">
        <label for="LN_ID" class="layui-form-label">
            <span class="x-red">*</span>模板名
        </label>
        <div class="layui-input-inline">
            <input name="rel_name" type="text" id="LN_ID"  lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-mid layui-word-aux">
            <span class="x-red">模板的名称</span>
        </div>
    </div>
    <div class="layui-form-item">
        <label for="LN_ID" class="layui-form-label">
            <span class="x-red">*</span>科目类型
        </label>
        <div class="layui-input-inline">
            <select name="sub">
                <c:forEach items="${subList}" var="temp">
                    <option value="${temp.sub_id}">${temp.sub_name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="layui-form-mid layui-word-aux">
            <span class="x-red">科目</span>
        </div>
    </div>


    <br>
    <div class="layui-form-item">
        <label class="layui-form-label">题目类型</label>
        <div class="layui-input-block">
            <input lay-filter="type" type="checkbox" id="r" title="单选题" checked>
            <input lay-filter="type" type="checkbox" id="c" title="多选题" >
            <input lay-filter="type" type="checkbox" id="z" title="主观题">
        </div>
    </div>
    <div id="radeoT">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red"></span>题目数量
            </label>
            <div class="layui-input-inline">
                <input name="radioT" type="text"  required=""
                       autocomplete="off" class="layui-input"  value="3">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">单选题</span>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red"></span>题目分数
            </label>
            <div class="layui-input-inline">
                <input name="radioT" type="text"    required=""
                       autocomplete="off" class="layui-input"  value="5">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">单选题</span>
            </div>
        </div>
    </div>
    <br>
    <div id="checkboxT" style="display: none">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red"></span>题目数量
            </label>
            <div class="layui-input-inline">
                <input name="checkboxT" type="text"   required=""
                       autocomplete="off" class="layui-input"  value="0">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">多选题</span>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red"></span>题目分数
            </label>
            <div class="layui-input-inline">
                <input name="checkboxT" type="text"    required=""
                       autocomplete="off" class="layui-input"  value="0">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">多选题</span>
            </div>
        </div>
    </div>
    <br>
    <div id="writeT" style="display: none">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red"></span>题目数量
            </label>
            <div class="layui-input-inline">
                <input name="writeT" type="text"   required=""
                       autocomplete="off" class="layui-input"  value="0">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">主观题</span>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red"></span>题目分数
            </label>
            <div class="layui-input-inline">
                <input name="writeT" type="text"   required=""
                       autocomplete="off" class="layui-input"  value="0">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">主观题</span>
            </div>
        </div>
    </div>




    <div class="layui-form-item">
        <button  class="layui-btn" lay-submit="" lay-filter="alt">
            添加模板
        </button>
    </div>
</form>
<script>
    $(function () {
        $("#r").click(function () {
            alert("sdfsd");
        })
    })


</script>
<script>
    $(function () {//页面加载函数（jquery）
        // 任何需要执行的js特效，$("table tr:nth-child(even)").addClass("even");
        var val=$("#ty  option:selected").val();


    });
    layui.use('form', function () {
        var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加(),只有执行了这一步，部分表单元素才会自动修饰成功
        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
        form.render();
        //监听 选择
        form.on('checkbox(type)', function (data) {
            if($( data.elem).attr("id")=='r'){
                if($( data.elem).is(':checked')){
                    $("#radeoT").show();
                    $("#radeoT input").val(2);
                }else {
                    $("#radeoT").hide();
                    $("#radeoT input").val(0);
                }

            }else if($( data.elem).attr("id")=="c"){
                if($( data.elem).is(':checked')){
                    $("#checkboxT").show();
                    $("#checkboxT input").val(2);
                }else {
                    $("#checkboxT").hide();
                    $("#checkboxT input").val(0);
                }

            }else if($( data.elem).attr("id")=="z"){
                if($( data.elem).is(':checked')){
                    $("#writeT").show();
                    $("#writeT input").val(2);
                }else {
                    $("#writeT").hide();
                    $("#writeT input").val(0);
                }

            }


        });
        //监听提交
        form.on('submit(alt)', function (data) {
            var url = "${pageContext.request.contextPath}/exam/insertRel";
            // alert(url);
            $.ajax({
                type: "POST",
                url: url,
                data: $("#form1").serialize(),
                success: function (data) {
                    /* layer.msg(data.msg, {time: 3000});
                      setTimeout("location.href='{pageContext.request.contextPath}'+'/login.html'",3500);*/
                    layer.alert(data.msg, function () {

                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        parent.location.reload();
                    });

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
            len: function (value) {
                if (value.length < 3) {
                    return '至少得3个字符啊';
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
