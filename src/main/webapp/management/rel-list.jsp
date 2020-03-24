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

<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
    <button class="layui-btn" data-type="addrel">添加模板</button>
</div>


<table class="layui-table" lay-filter="demoss">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'rel_id', width:240, sort: true, fixed: true}">ID</th>
        <th lay-data="{field:'rel_name', width:240, edit: 'text'}" >模板名</th>
        <%--<th lay-data="{field:'examCount', width:80, sort: true,--%>
                <%--templet :function (row){--%>
                <%--return row.examCount+'人';--%>
                <%--}}">考试人数</th>--%>
        <%--<th lay-data="{field:'avgScore', width:80, sort: true,--%>
                <%--templet :function (row){--%>
                <%--return row.avgScore+'分';--%>
                <%--}}">平均分</th>--%>
        <%--<th lay-data="{field:'score', width:80, sort: true,--%>
                <%--templet :function (row){--%>
                <%--return row.score+'分';--%>
                <%--}}">满分</th>--%>
        <th lay-data="{fixed: 'right', width:400, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>

<script type="text/html" id="barDemo">
    <div class="layui-btn-group">
        <%--<button type="button" class="layui-btn layui-btn-xs layui-btn-normal" lay-event="detail">--%>
            <%--查看详情--%>
        <%--</button>--%>
        <button type="button" class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit" title="修改详细信息">
            <i class="layui-icon">&#xe642;</i>
        </button>
        <button type="button" class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del" title="删除">
            <i class="layui-icon">&#xe640;</i>
        </button>
       <%--<input type="checkbox" name="zzz" lay-skin="switch" lay-text="开启|关闭">--%>
    </div>
</script>

<script>
    layui.use('table', function(){
        var table = layui.table;
        //初始化数据表格
        table.init('demoss',{
            id:'idTest'
            ,limit:3
            ,limits:[3,5,10]
            ,url:'${pageContext.request.contextPath}/admin/getRelList'
            ,page:true
        });
        //监听表格复选框选择
        table.on('checkbox(demoss)', function(obj){
            console.log(obj)

        });
        //监听单元格编辑
        table.on('edit(demoss)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段

            // alert(data.rel_id+value);
            var url = "${pageContext.request.contextPath}/exam/changeRelName";
            $.ajax({
                type:"POST",
                url: url,
                data:{
                    rel_id:data.rel_id,
                    rel_name:value
                },
                success:function (data) {
                    layer.msg(data.msg);
                    // if(parseInt(data)>=0){
                    //     parent.layer.msg('删除成功！', {icon: 1,time:3000,shade:0.2});
                    //     location.reload(true);
                    // }else{
                    //     parent.layer.msg('删除失败！', {icon: 2,time:3000,shade:0.2});
                    // }
                }
            })

        });

        //监听工具条
        table.on('tool(demoss)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                location.href="exam-score.jsp?par_id="+data.par_id;
                // layer.msg('ID：'+ data.par_id + ' 的查看操作');
            } else if(obj.event === 'del'){
                // alert(data.rel_id);
                var url = "${pageContext.request.contextPath}/exam/delRel";
                layer.alert("确认删除吗", function () {
                    $.ajax({
                        type:"POST",
                        url: url,
                        data:{
                            rel_id:data.rel_id
                        },
                        success:function (data) {
                            layer.msg(data.msg);
                        }
                    })
                    obj.del();
                });


            } else if(obj.event === 'edit'){

                layer.open({
                    type: 2
                    ,title:"修改模板设置信息"
                    ,content: '${pageContext.request.contextPath}/exam/EditRelInfo?rel_id='+data.rel_id
                    ,area: ['600px', '600px']
                });
            }
        });


        /*
        * */
        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('idTest')
                    ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
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
            ,addrel: function () { //添加
                layer.open({
                    type: 2
                    ,title:"添加模板"
                    ,content: '${pageContext.request.contextPath}/exam/insertEditRel'
                    ,area: ['600px', '700px']
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>







</body>

<script>
    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var h = date.getHours();
        h = h<10?("0"+h):h;
        var M = date.getMinutes();
        M = M<10?("0"+M):M;
        var str = y+"-"+m+"-"+d+" "+h+":"+M;
        return str;
    }
</script>
</html>
