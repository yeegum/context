<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<style>
	*{
		margin: 0;
		padding: 0;
	}
	a{
		text-decoration:none;
		color:white;
		font-size: 16px;
	}
	.top{
		width:972px;
		height:75px;
/*		outline: solid 1px black;*/
		margin: auto;
	}
	li{
		float: left;
		height: 40px;
		width: 109px;
		list-style: none;
/*		outline: solid 1px red;*/
		color: white;
		font-weight: bold;
		border-radius: 4px;
	}
	.lix:hover {
		background:#BD3538;
	}
	.top_left{
		float: left;
		width: 273px;
		height: 70px;
/*		border: solid 1px red;*/
		margin-top: 6px;
		
	}
	.top_right{
		float: right;
		width: 672px;
		height: 42px;
/*		outline: solid 1px red;*/
		margin-top: 19px;
		text-align: center;
		line-height: 42px;
		background: #CF5053;
		border-radius: 4px;
	
	}
	.xian{
/*		margin-left: 112px;*/
/*		margin-right: 0px;*/
		color: white;
		width: 3px;
		height: 20px;
/*		font-size: 1px;*/
		font-weight: 100;
		
	}
	</style>
</head>
<body>
	<div class="top">
		<div class="top_left">
			<img src="../images/logoBG.png" width="275px" height="70px">
		</div>
		<div class="top_right">
			<ul>
				<li class="lix" onClick="javascript:window.parent.location.href='all.jsp'">首页</li>
				<li class="xian">|</li>
				<li class="lix" onClick="javascript:window.parent.location.href='/management/Note/doShow?url=xuexi'">学习 </li>
				<li class="xian">|</li>	
				<li class="lix" onClick="javascript:window.parent.location.href='${pageContext.request.contextPath}/management/Plate/getAllNoPagePlate'">论坛 </li>
				<li class="xian">|</li>
				<li class="lix"  onClick="javascript:window.parent.location.href='${pageContext.request.contextPath}/html/kaoshi3.jsp'">考试</li>
				<li class="xian">|</li>
				<li class="lix"  onClick="javascript:window.parent.location.href='${pageContext.request.contextPath}/html/makefriends.jsp'">交友</li>
				<li class="xian">|</li>
				<li class="lix" onClick="javascript:window.parent.location.href='${pageContext.request.contextPath}/show'">我的信息</li>
			</ul>
			
		</div>
	</div>
</body>
</html>
