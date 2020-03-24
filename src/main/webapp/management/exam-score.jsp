<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/management/lib/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"></script>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/management/js/echarts.common.min.js"></script>--%>

    <title>userPage</title>
</head>
<body>



<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
    <button class="layui-btn" data-type="del">删除所选</button>
</div>

<a class="layui-btn layui-btn-danger" href="exam-paper.jsp">返回上一级</a>
<br>
<br>
<form class="layui-form ">
    <div class="layui-form-item">

        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="startScore" placeholder="分数上限">
        </div>

        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="endScore" placeholder="分数上限">
        </div>

        <div class="layui-input-inline">
            <select id="status">
                <option value="-1">审批状态</option>
                <option value="0">未审批</option>
                <option value="1">已审批</option>
            </select>
            <%--<input type="text" class="layui-input" id="endscore">--%>
        </div>
        <button class="layui-btn" lay-submit=""  lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
    </div>
</form>





<table class="layui-table" lay-filter="demoss">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'par_id', width:80, sort: true, fixed: true}">ID</th>
        <th lay-data="{field:'par_name', width:80, sort: true }">试卷名</th>
        <th lay-data="{field:'userid', width:80 ,hide: true}"><a href="http://www.baidu.com">userid</a></th>
        <th lay-data="{field:'account', width:160, edit: 'text'}" >用户账号</th>
        <th lay-data="{field:'sum_score', width:120, sort: true,
                templet :function (row){
                return row.sum_score+'分';
                }}">分数</th>
        <th lay-data="{field:'exam_time', width:160, sort: true }">开考时间</th>
        <th lay-data="{field:'usetime', width:120, sort: true,
                templet :function (row){
                return row.usetime+'分';
                }}">考试时长</th>
        <th lay-data="{field:'status', width:120, sort: true,templet: '#buttonTpl'
                }">审批状态</th>
        <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>

<script type="text/html" id="barDemo">
    <div class="layui-btn-group">
        <button type="button" class="layui-btn layui-btn-sm layui-btn-danger " lay-event="detail">
            审批试卷
        </button>
        <!--<input type="checkbox" name="zzz" lay-skin="switch" lay-text="开启|关闭">-->
    </div>
</script>
<script type="text/html" id="buttonTpl">
    {{#  if(d.status == 0){ }}
    <input disabled type="checkbox" name="zzz" lay-skin="switch" lay-text="是|否">
    {{#  } else { }}
    <input disabled type="checkbox" name="zzz" checked lay-skin="switch" lay-text="是|否">
    {{#  } }}
</script>


<script>
    layui.use(['table','form'], function(){
        var table = layui.table,form = layui.form;
        //初始化数据表格
        var url = "${pageContext.request.contextPath}/admin/UserPaperScore?par_id="+getQueryVariable("par_id");
        // alert(url);
        table.init('demoss',{
            id:'idTest'
            ,limit:3
            ,limits:[3,5,10]
            ,url:url
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
            var url = "ajax/question-change";
            var map = {};
            map['quesid'] = data.question_id;
            map[field] = value;
            $.post(url,map,function (data) {
                if(parseInt(data)==0){
                    layer.msg('[ID: '+ data.question_id +'] ' + field + ' 字段更改为：'+ value.toString());
                }else{
                    layer.msg("修改失败");
                }
            })
        });

        //form 搜索
        form.on('submit(search)',function () {
            alert("..")
            // var demoReload = $('#demoReload').val();
            //执行重载
            var startScore = $("#startScore").val();
            // alert(startScore);
            var endScore = $("#endScore").val();
            // alert(endScore);
            var status = $("#status").val();
            // alert(status);
            var par_id = getQueryVariable("par_id");
            // alert(par_id);
            var url = "${pageContext.request.contextPath}/admin/UserPaperScoreByOther";
            table.reload('idTest', {
                url:url
                ,where: {
                    'par_id':par_id,
                    'startScore':startScore,
                    'endScore':endScore,
                    'status':status
                }
            });
            return false;
        });

        //监听工具条
        table.on('tool(demoss)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.open({
                    type: 2
                    ,title:data.account+'的试卷--'+data.par_name
                    ,content: '${pageContext.request.contextPath}/exam/Papercorrection?par_id='+data.par_id+"&userid="+data.userid //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    ,area: ['1200px', '600px']
                });
            } else if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    var ids= "";
                    ids += data.id+",";
                    layer.msg(ids);
                    $.ajax({
                        type:"POST",
                        url: '/delGameUserById',
                        data:{"ids":ids},
                        success:function (data) {
                            layer.closeAll('loading');
                            if(parseInt(data)>=0){
                                parent.layer.msg('删除成功！', {icon: 1,time:3000,shade:0.2});
                            }else{
                                parent.layer.msg('删除失败！', {icon: 2,time:3000,shade:0.2});
                            }
                        }
                    })
                    layer.close(index);
                    // location.reload();
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


    //获取url中的参数 的方法
    function getQueryVariable(variable)
    {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable){return pair[1];}
        }
        return(false);
    }


    //子窗口关闭父窗口 需要调用的方法
    function closeSelf() {
        var i = window.parent.layer.getFrameIndex();
        window.parent.layer.close(i);
    }

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
