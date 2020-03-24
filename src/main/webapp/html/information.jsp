<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>注册页面</title>
    <link rel="stylesheet" href="../lib/layui/css/layui.css">
    <script src="../lib/layui/layui.js"></script>
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script type="text/javascript" src="../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
    <script src="../js/jquery3.3.1.min.js"></script>



    <link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css?t=1565940880988" media="all">

    <style type="text/css">
        #ce {
            margin: 0px 0px 0px 400px;
        }
    </style>

</head>
<body>
<ul class="layui-nav" align="right">
    <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/html/all.jsp">首页
        <!--<span class="layui-badge">9</span>-->
    </a></li>


    <li class="layui-nav-item"><a href=""><img
            src="${user.data.faceimg}" class="layui-nav-img">我</a>
        <%--<dl class="layui-nav-child">
           &lt;%&ndash; <dd>
                <a href="javascript:;">修改信息</a>
            </dd>
            <dd>
                <a href="javascript:;">退了</a>
            </dd>&ndash;%&gt;
        </dl>--%>
    </li>
</ul>
<br>
<br>
<br>
<br>
<div id="ce">
    <form id="form1" class="layui-form" action="../upload" method="post" enctype="multipart/form-data">
        <div class="layui-form-item" >
            <label class="layui-form-label">头像</label>
           <input type="file"  name="img" >
        </div>

        <div class="layui-form-item" style="">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-block" style="width: 120px;">
                <input type="text" name="nickname" value="${user.data.nickname}" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block" style="width: 120px;">
                <input type="text" name="email" value="${user.data.email}" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">生日</label>
            <div class="layui-input-block" style="width: 120px;">
                <input class="layui-input" value="${user.msg}" name="birthday" id="start">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="0" title="男" checked="checked"/>
                <input type="radio" name="sex" value="1" title="女"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">城市</label>
            <div class="layui-input-block" style="width: 120px;">
                <select name="address" lay-filter="aihao" id="statenums" >
                    <option value="北京">北京</option>
                    <option value="上海">上海</option>
                    <option value="深圳">深圳</option>
                    <option value="南昌">南昌</option>
                </select>
            </div>
        </div>
        <br>

        <div class="layui-form-item layui-form-text"
             style="margin: 0px 0px 0px 25px; width: 600px;">
            <label class="layui-form-label">个人介绍</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="introduce">${user.data.introduce} </textarea>
            </div>
        </div>
        <br> <br>

        <div class="layui-form-item" style="margin: 0px 0px 0px 100px;">
            <div class="layui-input-block">
                <input value="立即提交" lay-submit lay-filter="sub" type="submit" class="layui-btn" name="a" >
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

 <script type="text/javascript">
     layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function() {
         var laydate = layui.laydate //日期
             , laypage = layui.laypage //分页
             , layer = layui.layer //弹层
             , table = layui.table //表格
             , carousel = layui.carousel //轮播
             , upload = layui.upload //上传
             , element = layui.element //元素操作
             , slider = layui.slider //滑块
                //生日
                laydate.render({
                    elem: '#start' //指定元素
                });

           /* $(document).on('change','input[name=img]',function () {
                layer.msg("上传成功",{time:1000});
            })*/

          })
     $(function(){
         var s="${user.data.sex}";
         $("input[type='radio'][name='sex'][value='"+s+"']").attr("checked",true);
     })
     $(function(){
         var b="${user.data.address}";
         $("#statenums option[value = '"+b+"']").attr("selected",true)
     })
    </script>
<%--<script>
    layui.use('util', function() {
        var util = layui.util;

        //执行
        util.fixbar({
            bar1 : true,
            bar2 : true,
            click : function(type) {
                console.log(type);
                if (type === 'bar1') {
                    alert('点击了bar1')
                }
            }
        });

    });

</script>--%>

</body>
</body>
</html>
