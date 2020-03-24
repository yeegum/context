<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
		margin: auto;
	}
	.left{
		width: 190px;
		height: 500px;
	}
	.a1{
		width: 190px;
		height: 210px;
		float: left;
		border: solid 1px #C3BEBE;
		border-radius: 5px;
	}
	.a2{
		clear: both;
		float: left;
		margin-top: 10px;
		width: 190px;
		height: 50px;
		border: solid 1px #C3BEBE;
		border-radius: 5px;
	}
	.b1{
		margin-top: 10px;
		margin-left: 30px;
		line-height: 30px;
		width: 110px;
		height: 30px;
	}
	a{
		font-size: 15px;
		font-weight: bold;
		color: #46586A;
		text-decoration: none;
		line-height: 30px;
	}
	.a3{
		clear: both;
		float: left;
		margin-top: 17px;
		width: 190px;
		height: 50px;
		border: solid 1px #C3BEBE;
		border-radius: 5px;
	}
	.a4{
		clear: both;
		float: left;
		margin-top: 10px;
		width: 190px;
		height: 147px;
		border: solid 1px #C3BEBE;
		border-radius: 5px;
		line-height: 49px;
	}
	.b2{
		float: left;
		width: 80px;
		height: 49px;
		background: url(../../images/fanke/z18.png)no-repeat;
		background-size: 80px,49px;
	}
	.b3{
		float: left;
		width: 80px;
		height: 49px;
		background: url(../../images/fanke/z17.png)no-repeat;
		background-size: 80px,49px;
	}
	.b4{
		float: left;
		width: 80px;
		height: 49px;
		background: url(../../images/fanke/z19.png)no-repeat;
		background-size: 80px,49px;
	}
	.a4 li{
		width: 190px;
		height: 49px;
		float: left;
		outline: solid 1px #C3BEBE;
		list-style: none;
	}
	.a2:hover{
		outline: solid 1px red;
	}
	.a3:hover{
		outline: solid 1px red;
	}
	a:hover{
		color: #D05054;
	}
	/*.a2 .a3 a:hover{
		border: solid 1px #D05054;
	}*/
	</style>
</head>

<body>
<div class="left">
	<div class="a1">
		<iframe src="ZC.jsp" height="210px" width="190px" frameborder="0" scrolling="no"></iframe>
	</div>
	
	
	<div class="a2">
	<a target="_parent" href="/html/kaoshi2.jsp"><div class="b1"><div style="float: left;"><img src="../../images/fanke/z15.png" style="width: 30px;height: 30px;"></div>&nbsp;&nbsp;&nbsp;在线考试</div></a>
	</div>
	<div class="a3">
		<a target="_parent" href="/html/kaoshi3.jsp"><div class="b1"><div style="float: left;"><img src="../../images/fanke/z16.png" style="width: 30px;height: 30px;"></div>&nbsp;&nbsp;&nbsp;成绩查询</div></a>
	</div>
	<div class="a4">
		<ul>
			<li><div class="b2"></div> &nbsp;&nbsp;<a target="_top" href="/management/Plate/getAllNoPagePlate">思诚论坛</a></li>
			<li><div class="b3"></div> &nbsp;&nbsp;<a target="_parent" href="/management/Note/doShow?url=xuexi">学习资源</a></li>
			<li><div class="b4"></div> &nbsp;&nbsp;<a target="_parent" href="/html/makefriends.jsp">交友邮箱</a></li>
		</ul>
	</div>
</div>
</body>
</html>
