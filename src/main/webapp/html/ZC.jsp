<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
	<script src="${pageContext.request.contextPath}/js/jquery3.3.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquerysession.js"></script>



    <style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
		margin: auto;
	}
	.a0{
		width: 180px;
		height: 220px;
		border: solid 1px #C3BEBE;
		border-radius: 5px;
	}
	.a1{

		width: 180px;
		height: 190px;
		margin-top: 10px;
		margin-left: 10px;
	}
	.b1{float:left;
		 width: 180px;
		 height: 30px;
	 }
	.c1{float:left;
		width: 180px;
		height: 30px;
	}
	li{
		width: 180px;
		height: 30px;
		line-height: 30px;
		list-style: none;
	}
	.b2{
		width: 150px;
		height: 100px;
	    float: left;
	}
	.b4{
		float: left;
		width: 35px;
		height: 100px;
	}
	.b5{
		float: left;
		width: 110px;
		height: 90px;
		/*background: url("../images/touxiang.jpg") no-repeat;*/
		background-size: 130px 90px;
	}
	.b3{

		width: 150px;
		height: 30px;
		float: left;
	}
	.b6{
        margin-left: 10px;
        float: left;
		width: 50px;
		height: 30px;

		margin-top: 6px;
		background-color: #46586A;
        text-align: center;
		line-height: 30px;
		border-radius: 5px;;
	}
    .b7{
        float: right;
        width: 50px;
        height: 30px;
        margin-top: 6px;
        background-color: #46586A;
        text-align: center;
        line-height: 30px;
        border-radius: 5px;
    }
	a{
		text-decoration: none;
		font-size: 15px;
		font-weight: bold;
		color: white;
	}
	a:hover{
		color: #D05054;
	}

	#nickname{
		float:left;
		width:80px;
	}
		#aa{
		float: left;
		width:60px;
	}
	#age{
		float:left;

		width:50px;
	}
	#c2{
		float: left;
		width:50px;

	}
	</style>
</head>
<body onload="myfunction()" >
	 <div class="a0">
	 	<div class="a1">
	 		<div class="b1">
				<ul>
					<li id="aa">用户名 :</li><li id="nickname" ></li>
	 			</ul>
	 		</div>
			<div class="c1">
				<ul>
					<li id="c2">年龄 :</li><li id="age" ></li>
				</ul>
			</div>
	 		<div class="b2">
	 			<div class="b4">头像</div>
                <div class="b5"> <a href=""><img src=""  id="aaaa" style="max-width:100%;max-height: 100%"> </a></div>
	 		</div>
	 		<div class="b3">
	 			<div class="b6"><a  href="/logout" target="_top">注销</a></div>
               <div class="b7"><a id="sign_btn" type="button">签到</a></div>
	 		</div>
	 	</div>
	 </div>
<script>
	function myfun() {
		var url="${pageContext.request.contextPath}/shows";
		// alert("l");
		$.post(url,function (data) {
			$("#nickname").append(data.data.account);
			$("#age").append(data.data.age);
			$("#aaaa").attr("src",data.data.faceimg);
		})
	}
	window.onload = myfun;//不要括号
</script>
     <script type="text/javascript">
         layui.use('layer',function () {
             var layer=layui.layer;
             $(document).on('click','#sign_btn',function () {
                 //layer.msg('hello',{time:1000})
                 var url="${pageContext.request.contextPath}/sign";
                 $.post(url,function(data){
                     layer.msg(data,{time:2000});
                 })
             });

         })
         <%--function zx() {--%>
             <%--$.session.clear();--%>
             <%--parent.parent.location.href="${pageContext.request.contextPath}/html/login.jsp"--%>
         <%--}--%>
     </script>
</body>
</html>
