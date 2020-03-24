<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
	<title>Title</title>
	<link type="text/css" href="${pageContext.request.contextPath}/css/forum_inside.css" rel="stylesheet"/>
	<%--<link  type="text/css" href="../css/forum_demo.css" rel="stylesheet" />--%>
	<!--引用外部js文件forum_inside.js-->
	<%--<script type="text/javascript" src="../js/forum_inside.js"></script>--%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/management/css/xadmin.css">
	<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js"
			charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadmin.js"></script>
</head>
<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
		margin: auto;
	}
	.botton{ 
	    width: 780px;
		height: 217px;
		margin: auto;
		line-height: 31px;
	}
	.a1{
		float: left;
		width: 260px;
		height: 217px;
	  
	}
	.a1_1{
		float: left;
		width: 250px;
		height: 217px;
		line-height: 31px;
		outline: solid 1px #C3BEBE;
		
	}
	.a2{
		float: left;
		width: 260px;
		height: 217px;
	}
	.a2_1{
		float: left;
		width: 250px;
		height: 217px;
		outline: solid 1px #C3BEBE;
		
	}
	.a3{
		float: left;
		width: 260px;
		height: 217px;
	}
	.a3_1{
		float: right;
		width: 250px;
		height: 217px;
		outline: solid 1px #C3BEBE;
	}
	.b0{
		background-color: #46586A;
		font-size: 15px;
		font-weight: bold;
		line-height: 32px;
		color: white;
	}
	a{
		text-decoration: none;
		color: black;
		font-size: 12px;
		line-height: 31px;
	}
	a:hover{
		color:white;
	}
	 li{
		width: 250px;
		height: 31px;
		outline: solid 1px #C3BEBE;
		list-style: none;
		float: left;
	}
	a:hover li{
		background-color: #D05054;
	}
	</style>

<body>
<div class="botton">
	<div class="a1">
		<div class="a1_1">
		<ul id="ulpost">
			<li class="b0">&nbsp;&nbsp;精华帖子  <div style="float: right;width: 30px;" > ></div></li>
			<%--<c:forEach items="${list}" var="temp">--%>
        <%--<li><a href="${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id=data.data[i].post_id">data.data[i].post_title</a></li>--%>
			<%--</c:forEach>--%>
		</ul>
		</div>
	</div>
	<script>
		$.post('${pageContext.request.contextPath}/management/Posts/getEssencePost',function (data) {
			for (var i=0;i<data.code;i++){
				var contain="<a target=\"_parent\" href=\"${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id="+data.data[i].post_id+"\"><li>"+data.data[i].post_title+"</li></a>";
				$("#ulpost").append(contain)
			}
		});

		$.post('${pageContext.request.contextPath}/management/Posts/getHotPost',function (data) {
			for (var i=0;i<data.code;i++){
				var c="<div style=\"width: 80px; float: right\"";
				c+=">阅览次数:";
				c+=data.data[i].post_numbers;
				c+="</";
				c+="div>";
				var contain="<a  target=\"_parent\" href=\"${pageContext.request.contextPath}/management/Posts/getPostAndReplyPost?post_id="+data.data[i].post_id+"\"><li>"+data.data[i].post_title+c+"</li></a>";
				$("#hotpost").append(contain)
			}
		});
	</script>
	<div class="a2">
		<div class="a2_1">
			<ul id="hotpost">
				<li class="b0">&nbsp;&nbsp;热门帖子  <div style="float: right;width: 30px;"> ></div></li>

			</ul>
		</div>
	</div>

	<script type="text/javascript">
		$.post('${pageContext.request.contextPath}/management/Note/getHotNotes',function (data) {
			for (var i=0;i<data.code;i++){
				var c="<div style=\"width: 80px; float: right\"";
				c+=">下载次数:";
				c+=data.data[i].times;
				c+="</";
				c+="div>";
				var contain="<a href=\"${pageContext.request.contextPath}/management/Note/download?nid="+data.data[i].nid+"\"><li style=\"padding-left: 5px\">"+data.data[i].title+c+"</li></a>";
				$("#hotNotes").append(contain)
			}
		});
	</script>
	<div class="a3">
		<div class="a3_1">
			<ul id="hotNotes">
				<li class="b0" >&nbsp;&nbsp;热门资源  <div style="float: right;width: 30px;"> ></div></li>
			</ul>
		</div>
	</div>
	<%--<div class="a3">--%>
         <%--<div class="a3_1">--%>
	       <%--<ul>--%>
				<%--<li class="b0" >&nbsp;&nbsp;热门资源  <div style="float: right;width: 30px;"> ></div></li>--%>
				<%--<a href="$"><li>jsp</li></a>--%>
				<%--<a href="$"><li>python</li></a>--%>
				<%--<a href="$"><li>参数测试</li></a>--%>
				<%--<a href="$"><li>参数测试</li></a>--%>
				<%--<a href="$"><li>参数测试</li></a>--%>
				<%--<a href="$"><li>java工具包</li></a>--%>
			<%--</ul>--%>
		 <%--</div>--%>
	<%--</div>--%>
</div>
</body>
</html>
