<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
	<%--<link rel="stylesheet" href="../css/xadmin.css">--%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery3.3.1.min.js"></script>
	<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
		margin: auto;
	}
	.top{
		width: 780px;
		height: 283px;
		margin: auto;
	}
	.a1{
		width: 510px;
		height: 270px;
		float: left;
		border: solid 1px #C3BEBE;
		border-radius: 10px;
	}
	.a2{
		width: 260px;
		height: 270px;
		float: right;
		border: solid 1px  #C3BEBE;
		font-size: 14px;
		border-radius: 10px;
	}
	.a2_1{
	    background: #46586A;
		font-size: 15px;
		color: white;
		font-weight: bold;
		text-align: center;
	}
	li{
		width: 260px;
		height: 40px;
		outline: solid 1px  #C3BEBE;
		list-style: none;
		line-height: 40px;
	}
	a{
		text-decoration: none;
		font-weight: bold;
		color: black;
	}
	a:hover{
		color: gold;
	}
	a:hover li{
		width: 260px;
		height: 40px;
		background-color:#DD5054;
	}
	</style>
</head>

<body onload="myfunction()">
<div class="top">
	<div class="a1">
		<div class="layui-carousel" id="test1">
			<div carousel-item>
				<div><img src="../images/download.jpg" style="max-width:100%;height:220px"></div>
				<div><img src="../images/download1.jpg" style="max-width:100%;height:220px"></div>
				<div><img src="../images/huangchunwei.png" style="max-width:100%;max-height: 100%"></div>
			</div>
		</div>
	</div>
	<div class="a2">
		<ul>
			<li class="a2_1">学分排行榜</li>
			<%--<a href="$"><li>&nbsp;<img src="">&nbsp;&nbsp;胡 cs1072 总分0分</li></a>
			<a href="$"><li>&nbsp;<img src="">&nbsp;&nbsp;胡 cs1072 总分0分</li></a>--%>
           <%-- <table class="layui-hide" id="demo" lay-filter="test"></table>--%>
			<div>
				<table id="score">
					<tr>
                        <td> <font size="4" >头像</font></td>
                        <td ><font size="4" >用户名</font></td>
                        <td><font size="4" >积分</font></td>
					</tr>
				</table>
			</div>
		</ul>
	</div>
</div>
<script>
	layui.use('carousel', function(){
		var carousel = layui.carousel;
		//建造实例
		carousel.render({
			elem: '#test1'
			,width: '100%' //设置容器宽度
			//,arrow: 'always' //始终显示箭头
			//,anim: 'updown' //切换动画方式
		});
	});

</script>

<script>

  function myfun() {

	  var url="${pageContext.request.contextPath}/page";
	  $.post(url,function (data) {
	  	// for(var i=0;i<5;i++){
		// 	$(#).append(data.data[i].account);
		// }
		  for(var i=0;i<data.data.length;i++){
		  	var str = "<tr style=\"height: 39px;\">\n" +
					" <td width='40px'><img width='32px' src='"+data.data[i].faceimg+"'/></td>\n" +
					" <td width='150px'>"+data.data[i].account+"</td>\n" +
					" <td width='75px'>"+data.data[i].integral+"分</td>\n" +
					" </tr>"
		  	// var str = "<img src='data.data[i].faceimg'/>"+data.data[i].account +"&nbsp;&nbsp;"+ data.data[i].integral+"分<br>";
		  	// alert(str);
		  	$("#score").append(str);
		  }



	  })


  }
  window.onload = myfun;//不要括号
	  <%--
      layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function() {
          var laydate = layui.laydate //日期
              , laypage = layui.laypage //分页
              , layer = layui.layer //弹层
              , table = layui.table //表格
              , carousel = layui.carousel //轮播
              , upload = layui.upload //上传
              , element = layui.element //元素操作
              , slider = layui.slider //滑块

          //执行一个 table 实例
       table.render({
              elem: '#demo'
              ,height: 420
              ,url: '${pageContext.request.contextPath}/page' //数据接口
              ,title: '积分排名'
              ,page: true //开启分页
             // ,totalRow: true //开启合计行
              ,cols: [[
                  {field: 'faceimg', width: 50, templet:"#imgtmp"}
                  ,{field: 'nickname', width:80}
                  ,{field: 'integral', width: 90, sort: true, totalRow: true}

              ]]
              ,initSort:{field:'integral'
              ,type:'desc'}

              ,limits:[5,5]
              ,limit:5
              ,skin: 'row'
              ,done: function (res, curr, count) {
                  $('.layui-table .layui-table-cell > span').css({'font-weight': 'bold'});//表头字体样式
                  /*$('th').css({'background-color': '#5792c6', 'color': '#fff','font-weight':'bold'}) 表头的样式 */
                  $('th').hide();//表头隐藏的样式
                  $('.layui-table-page').css('margin-top','40px');//页码部分的高度调整
              },
              id: 'messageReload',
              page: true
          });
      })
  }
          window.onload = myfun;//不要括号
</script>
<script type="text/html" id="imgtmp">
<img src="{{d.imgUrl}}">--%>
</script>
</body>
</html>
