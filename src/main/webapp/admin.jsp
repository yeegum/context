<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%@ page errorPage="/error.jsp" %> --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="management/lib/layui/css/layui.css">
<script src="management/js/jquery3.3.1.min.js"></script>
<script src="js/jquery.serializejson.min.js"></script>
<script src="management/lib/layui/layui.js"></script>

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
<%@ include file="core.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>....管理系统</title>
    <script>
        var layer;
        function openLay(title, url, width, height){
            layer.open({
                type: 2 //此处以iframe举例
                ,title: title
                ,area: [width, height]
                ,shade: 0.3
                ,maxmin: true
                ,offset: [ //为了演示，随机坐标
                    "auto"
                ]
                ,content: url
                ,btn: ['关闭'] //只是为了演示
                ,yes: function(){
                    layer.closeAll();
                },zIndex: layer.zIndex
                ,success: function(layero){
                    layer.setTop(layero); //置顶当前窗口，该参数为当前窗口的dom对象
                }
            });
        }
        //JavaScript代码区域

        layui.use(["element", "layer"], function () {
            var $ = layui.jquery, element = layui.element;
            layer = layui.layer;
            $('.menu-tab').on('click', function () {
                var dataid = $(this);
                //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
                if ($(".layui-tab-title li[lay-id]").length <= 0) {
                    //如果比零小，则直接打开新的tab项
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                } else {
                    //否则判断该tab项是否以及存在

                    var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                    $.each($(".layui-tab-title li[lay-id]"), function () {
                        //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                        if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                            isData = true;
                        }
                    })
                    if (isData == false) {
                        //标志为false 新增一个tab项
                        active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                    }
                }
                //最后不管是否新增tab，最后都转到要打开的选项页面上
                active.tabChange(dataid.attr("data-id"));
            });
            //触发事件
            var active = {
                tabAdd: function (url, id, name) {
                    //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                    //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                    element.tabAdd('pageTab', {
                        title: name,
                        /*                        content: '<iframe scrolling="no" style="overflow: hidden" width="100%" height="100%" name="ifr" data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '?id='+id+'"></iframe>',*/
                        id: id ,//规定好的id
                        content: '<iframe width="100%" height="100%" name="ifr" data-frameid="'+id+'"  frameborder="0" src="'+url+'?id='+id+'"></iframe>',
                    })
                },
                tabChange: function (id) {
                    //切换到指定Tab项
                    element.tabChange('pageTab', id); //根据传入的id传入到指定的tab项
                },
            };
        });
    </script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">exam后台管理系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/exam/studentTest.jsp"target="_blank" >学生考试</a></li>
            <li class="layui-nav-item"><a target="_blank" href="learn.do?note=login&userId=${sessionScope.user.userid}">${sessionScope.user.userid}用户</a></li>
            <li class="layui-nav-item"target="_blank" >
                <a href="/html/all.jsp" target="_blank">前台系统</a>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <%--<a href="javascript:;">--%>
                    <%--<!-- 头像 -->--%>
                    <%--<img onerror="this.src='${ctx}/images/default.gif'"--%>
                         <%--src="${ctx}/user.do?method=initFace&face=${user.face}" class="layui-nav-img">--%>
                    <%--${sessionScope.user.username}--%>
                <%--</a>--%>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/logout">注销</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <c:forEach var="menu" items="${sessionScope.user.modulars}">
                    <li class="layui-nav-item layui-nav-itemed">
                        <c:if test="${menu.fid == 0}">
                            <a href="javascript:;">${menu.mname}</a>
                            <dl class="layui-nav-child">
                                <c:forEach var="childMenu" items="${sessionScope.user.modulars}">
                                    <c:if test="${childMenu.fid == menu.mid}">
                                        <dd>
                                                <%--<a data-type="tabAdd"
                                                   style="text-indent:20px;"
                                                   href="${ctx}${childMenu.murl}"
                                                   target="ifr" >${childMenu.mname}</a>--%>
                                            <a style="text-indent:20px;"
                                               data-url="${ctx}${childMenu.url}"
                                               data-title="${childMenu.mname}"
                                               data-id="${childMenu.mid}"
                                               class="menu-tab"
                                               href="javascript:;">${childMenu.mname}</a>
                                        </dd>
                                    </c:if>
                                </c:forEach>
                            </dl>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <%--<iframe frameborder="0" name="ifr" src="" height="100%" width="100%"></iframe>--%>
        <div class="layui-tab layui-tab-brief" lay-filter="pageTab" lay-allowclose="true">
            <ul class="layui-tab-title">
            </ul>
            <div class="layui-tab-content">
            </div>
        </div>
    </div>

    <div class="layui-footer">
        江西思诚科技有限公司 赣ICP备17006097号 CopyRight©2014 - 2018
    </div>
</div>
</body>
</html>
