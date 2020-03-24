<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
  
  <head>
      <meta charset="UTF-8">
      <title>欢迎页面-X-admin2.0</title>
      <meta name="renderer" content="webkit">
      <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
      <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"
              charset="utf-8"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
      <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
      <!--[if lt IE 9]>
      <![endif]-->
  </head>
  
  <body class="layui-anim layui-anim-up">

  <xblock>
      <div class="layui-inline">
          <form class="demoTable">
              请输入模块名称关键字：
              <div class="layui-inline" >
                  <input class="layui-input" name="post_title" id="demoReload" autocomplete="off">
              </div>
              <button class="layui-btn" lay-submit=""  lay-filter="fromreload">搜索</button>
          </form>
      </div>
  </xblock>
    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
        <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
        <button class="layui-btn" data-type="isAll">验证是否全选</button>
        <button class="layui-btn" data-type="delChecked">删除所选</button>
    </div>
    <table class="layui-table" lay-data="{limit: 5,limits: [5, 15, 25], url:'${pageContext.request.contextPath}/management/Posts/getAllPosts', page:true, id:'idTest'}" lay-filter="demo">
        <thead>
        <tr>
            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
            <th lay-data="{field:'post_id', width:100, sort: true, fixed: true}">帖子ID</th>
            <th lay-data="{field:'posting_time', width:200}">发帖时间</th>
            <th lay-data="{field:'post_title', width:100}">帖子标题</th>
            <th lay-data="{field:'user_id',sort: true, width:100}">发帖人ID</th>
            <th lay-data="{field:'user_name', width:100}">发帖人姓名</th>
            <th lay-data="{field:'post_numbers',sort: true, width:100}">阅历数</th>
            <th lay-data="{field:'post_status',templet: '#switchTpl', width:100}">帖子状态</th>
            <th lay-data="{field:'post_essence',templet: '#switchTp2', width:120}">是否为精华帖</th>
            <th lay-data="{field:'post_roof_placement',templet: '#switchTp3', width:120}">是否为置顶帖</th>
            <th lay-data="{field:'post_image', height:250,templet:'#gudingimg' }">帖子的图片</th>
            <th lay-data="{fixed: 'right', width:200, align:'center', toolbar: '#barDemo'}">操作</th>
        </tr>
        </thead>
    </table>
    <script type="text/html" id="barDemo">
        <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑帖子</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <script type="text/html" id="switchTpl">
        <input type="checkbox" name="post_status" value="{{d.post_id}}"
               lay-skin="switch" lay-text="启用|禁用" lay-filter="statusDemo" {{ d.post_status == 1 ? 'checked' : '
        ' }} >
    </script>
    <script type="text/html" id="switchTp2">
        <input type="checkbox" name="post_essence" value="{{d.post_id}}"
               lay-skin="switch" lay-text="精华帖|普通帖" lay-filter="essenceDemo" {{ d.post_essence == 1 ? 'checked' : '
        ' }} >
    </script>
    <script type="text/html" id="switchTp3">
        <input type="checkbox" name="post_roof_placement" value="{{d.post_id}}"
               lay-skin="switch" lay-text="置顶|不置顶" lay-filter="roof_placementDemo" {{ d.post_roof_placement == 1 ? 'checked' : '
        ' }} >
    </script>
      <script type="text/html" id="gudingimg">
          <div><img height="32px" src="{{d.post_image}}" ></div>
      </script>
    <script>
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            form.on('submit(fromreload)',function () {
                var demoReload = $('#demoReload').val();
                //执行重载
                // alert(demoReload)
                var url='${pageContext.request.contextPath}/management/Posts/findPostByTitle';
                table.reload('idTest', {
                    url:url
                    ,where: {
                        'likename':demoReload
                    }
                });
                return false;
            })
            form.on('switch(statusDemo)', function (obj) {
                // layer.tips(this.value + ' ' + this.name + '：' + obj.elem.checked, obj.othis);
                var tid="id="+this.value;
                // alert(this.value)
                $.post("${pageContext.request.contextPath}/management/Posts/changeStatus",tid,function (result) {
                    layer.alert(result.msg, {icon: 6, time: 1000}, function () {
                        // location.reload();
                    });
                })
            });
            form.on('switch(essenceDemo)', function (obj) {
                // layer.tips(this.value + ' ' + this.name + '：' + obj.elem.checked, obj.othis);
                var tid="id="+this.value;
                // alert(this.value)
                $.post("${pageContext.request.contextPath}/management/Posts/changeEssence",tid,function (result) {
                    layer.alert(result.msg, {icon: 6, time: 1000}, function () {
                        // location.reload();
                    });
                })
            });
            form.on('switch(roof_placementDemo)', function (obj) {
                // layer.tips(this.value + ' ' + this.name + '：' + obj.elem.checked, obj.othis);
                var tid="id="+this.value;
                // alert(this.value)
                $.post("${pageContext.request.contextPath}/management/Posts/changePost_roof_placement",tid,function (result) {
                    layer.alert(result.msg, {icon: 6, time: 1000}, function () {
                        // location.reload();
                    });
                })
            });
        });
    </script>
    <script>
        layui.use('table', function(){
            var table = layui.table;
            //监听表格复选框选择
            table.on('checkbox(demo)', function(obj){
                //alert(obj);
            });
            //监听工具条
            table.on('tool(demo)', function(obj){
                var data = obj.data;
                if(obj.event === 'detail'){
                    layer.msg('用户ID：'+ data.post_id + ' 的查看操作');
                } else if(obj.event === 'del'){
                    layer.confirm('真的删除本帖么', function(index){
                        //删除
                        // alert(data.post_id);
                        var  data1 ="id="+data.post_id ;
                        $.post("${pageContext.request.contextPath}/management/Posts/delPosts",data1,function (result) {
                            layer.alert(result.msg, {icon: 6, time: 1000}, function () {
                                // // 获得frame索引
                                // var index = parent.layer.getFrameIndex(window.name);
                                // //关闭当前frame
                                // parent.layer.close(index);
                            });
                            obj.del();
                            layer.close(index);
                            location.reload();
                        });
                    });
                } else if(obj.event == 'edit'){
                    // $.post("Plate/findPlate",'id='+data.plate_id,function () {
                    //   alert(111);
                    // })
                    //找到一个模块
                    change_Posts("编辑帖子", "${pageContext.request.contextPath}/management/Posts/findPostsdemo?id="+data.post_id,600,500);
                    // layer.alert('编辑行：<br>'+ JSON.stringify(data))
                }
            });
            var $ = layui.$, active = {
                getCheckData: function(){ //获取选中数据
                    var checkStatus = table.checkStatus('idTest')
                        ,data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                },
                delChecked: function(){ //获取选中数据
                    if(window.confirm("确认删除吗")){
                        var checkStatus = table.checkStatus('idTest')
                            ,data = checkStatus.data;
                        //data是json数组
                        var params="";
                        for (var i =0; i < data.length; i++){
                            params += "ids=" + data[i].post_id + "&";
                        }
                        alert(params)
                        $.post("${pageContext.request.contextPath}/management/Posts/delListPost", params, function (result) {
                            location.reload();
                        })
                    }
                    // layer.alert(JSON.stringify(data));
                }
                ,getCheckLength: function(){ //获取选中数目
                    var checkStatus = table.checkStatus('idTest')
                        ,data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                }
                ,isAll: function(){ //验证是否全选
                    var checkStatus = table.checkStatus('idTest');
                    layer.msg(checkStatus.isAll ? '全选': '未全选')
                }
            };

            $('.demoTable .layui-btn').on('click', function(){
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        });
    </script>
    <script>
        function change_Posts(title, url, w, h) {
            if (title == null || title == '') {
                title = false;
            }
            ;
            alert(url);
            if (w == null || w == '') {
                w = ($(window).width() * 0.9);
            }
            ;
            if (h == null || h == '') {
                h = ($(window).height() - 50);
            }
            ;
            layer.open({
                type: 2,
                area: [w + 'px', h + 'px'],
                fix: false, //不固定
                maxmin: true,
                shadeClose: true,
                shade: 0.4,
                title: title,
                content: url
                , btn: '修改完成'
                , btnAlign: 'c' //按钮居中
                , shade: 0 //不显示遮罩
                , yes: function () {
                    parent.layer.closeAll();
                    // $.post('AddChange');
                    location.reload();
                }
            });
        }
    </script>
  </body>

</html>