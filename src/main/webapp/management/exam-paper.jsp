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
    <button class="layui-btn" data-type="del">删除所选</button>
</div>
<br>
<br>

<form class="layui-form ">
    <div class="layui-form-item">
        <label class="layui-form-label">试卷名搜索</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="par_name">
        </div>
        <button class="layui-btn" lay-submit=""  lay-filter="seabyname"><i class="layui-icon">&#xe615;</i></button>
    </div>
</form>
<table class="layui-table" lay-filter="demoss">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'par_id', width:80, sort: true, fixed: true}">ID</th>
        <th lay-data="{field:'par_name', width:160, edit: 'text'}" >试卷名</th>
        <th lay-data="{field:'test_start_time', width:160}">答卷开始时间</th>
        <th lay-data="{field:'test_end_time', width:160 }">答卷结束时间</th>
        <th lay-data="{field:'test_length_time', width:120, sort: true,
                templet :function (row){
                return row.test_length_time+'分';
                }}">考试时长</th>
        <th lay-data="{field:'relName', width:120, edit: 'text'}" >模板名</th>
        <th lay-data="{field:'examCount', width:80, sort: true,
                templet :function (row){
                return row.examCount+'人';
                }}">考试人数</th>
        <th lay-data="{field:'avgScore', width:80, sort: true,
                templet :function (row){
                return row.avgScore+'分';
                }}">平均分</th>
        <th lay-data="{field:'score', width:80, sort: true,
                templet :function (row){
                return row.score+'分';
                }}">满分</th>
        <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>

<script type="text/html" id="barDemo">
    <div class="layui-btn-group">
        <button type="button" class="layui-btn layui-btn-sm " lay-event="viewpaper">
            查看试卷
        </button>
        <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="detail">
            查看详情
        </button>
        <!--<button type="button" class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit" title="修改">-->
            <!--<i class="layui-icon">&#xe642;</i>-->
        <!--</button>-->
        <!--<button type="button" class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del" title="删除">-->
            <!--<i class="layui-icon">&#xe640;</i>-->
        <!--</button>-->
        <!--<input type="checkbox" name="zzz" lay-skin="switch" lay-text="开启|关闭">-->
    </div>
</script>

<script>
    layui.use(['table','form'], function(){
        var table = layui.table,form = layui.form;
        //初始化数据表格
        table.init('demoss',{
            id:'idTest'
            ,limit:3
            ,limits:[3,5,10]
            ,url:'/admin/PaperList'
            ,page:true
        });
        //监听表格复选框选择
        table.on('checkbox(demoss)', function(obj){
            console.log(obj)

        });
        //form 搜索
        form.on('submit(seabyname)',function () {
            // var demoReload = $('#demoReload').val();
            //执行重载
            var par_name = $("#par_name").val();
            // alert(par_name);
            var url='${pageContext.request.contextPath}/admin/PaperListByName';
            table.reload('idTest', {
                url:url
                ,where: {
                    'par_name':par_name
                }
            });
            return false;
        });
        //监听单元格编辑
        table.on('edit(demoss)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
           /* var url = "ajax/question-change";
            var map = {};
            map['quesid'] = data.question_id;
            map[field] = value;
            $.post(url,map,function (data) {
                if(parseInt(data)==0){
                    layer.msg('[ID: '+ data.question_id +'] ' + field + ' 字段更改为：'+ value.toString());
                }else{
                    layer.msg("修改失败");
                }
            })*/
        });

        //监听工具条
        table.on('tool(demoss)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                location.href="exam-score.jsp?par_id="+data.par_id;
                // layer.msg('ID：'+ data.par_id + ' 的查看操作');
            } else if(obj.event === 'viewpaper'){
                layer.open({
                    type: 2
                    ,title:"试卷信息"
                    ,content: '${pageContext.request.contextPath}/exam/paperview?par_id='+data.par_id //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    ,area: ['1200px', '600px']
                });
            } else if(obj.event === 'edit'){
                layer.alert('编辑行：<br>'+ JSON.stringify(data))

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
            ,del: function () { //删除
                var checkStatus = table.checkStatus('idTest')
                    ,data = checkStatus.data;
                var ids= "";
                for(var i=0;i<data.length;i++){
                    ids += data[i].id+",";
                }
                layer.msg(ids);
                parent.layer.msg('删除中...', {icon: 16,shade: 0.3,time:5000});
                layer.confirm("您确定要删除吗？"+ids,function(){
                    $.ajax({
                        type:"POST",
                        url: '/delGameUserById',
                        data:{"ids":ids},
                        success:function (data) {
                            layer.closeAll('loading');
                            if(parseInt(data)>=0){
                                parent.layer.msg('删除成功！', {icon: 1,time:3000,shade:0.2});
                                location.reload(true);
                            }else{
                                parent.layer.msg('删除失败！', {icon: 2,time:3000,shade:0.2});
                            }
                        }
                    })
                })
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
