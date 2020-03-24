<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>考试</title>
	<link href="${pageContext.request.contextPath}/css/test_in.css" rel="stylesheet"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
	<script src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
</head>

<body>
<iframe width="100%" height="75px" src="${pageContext.request.contextPath}/html/top.jsp" frameborder="0" scrolling="no">
	
</iframe>
<form id="form1" name="form1" action="#" method="post">
<div class="main">
    <a name="top"></a>
	<div class="main_title">
		<a href="#">${ViewInfo.paperInfo.paper.par_name}</a>
	</div>
	<div class="main_message">
		<p style="margin-top: 30px;">考生:${sessionScope.user.nickname}</p>
         <p>考试编号: EXAM-${ViewInfo.paperInfo.paper.par_id}</p>
		<p>试卷总分: <span id="allSocre"></span></p>
	</div>
	<div>
		<% int count = 1;%>
		<script>
			var all_score = 0;
			var usermap = {};
			<c:forEach items="${ViewInfo.userAnswerList}" var="userAnswer" >
				var qid = "${userAnswer.que_id}";
				var ans = "${userAnswer.ask}";
				usermap[qid] = ans;

			</c:forEach>
		</script>
		<c:forEach items="${ViewInfo.paperInfo.relList}" var="temp">
			<div class="main_radio_title">
				<span>${temp.typeName} (总共${temp.relInfo.que_count}题，每题${temp.relInfo.que_score}分)</span>
			</div>
			<c:forEach items="${ViewInfo.queWithOptionList}" var="qList">
				<c:choose>
					<c:when test="${qList.que.que_type_id==temp.relInfo.que_type_id}">
						<c:choose>
							<c:when test="${temp.typeName=='单选题'}">
								<div class="main_radio_question">
									<div class="choose" style="margin-top: 20px; padding-left: 25px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/></div>
									<c:forEach items="${qList.optionList}" var="opt">
										<div class="choose"><input type="radio" id="${opt.que_id}${opt.que_op}" name="${opt.que_id}" value="${opt.que_op}"/>${opt.que_op}.<span>${opt.statement} </span></div>
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											// alert(useropt);
											var opt = "${opt.que_op}";
											if( useropt.indexOf(opt) != -1){
												$("#${opt.que_id}${opt.que_op}").prop("checked",true);
											}
										</script>
									</c:forEach>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='多选题'}">
								<div class="main_radio_question">
									<div class="choose" style="margin-top: 20px; padding-left: 25px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/></div>
									<c:forEach items="${qList.optionList}" var="opt">
										<div class="choose" style="padding-left: 15px;"><input type="checkbox" id="${opt.que_id}${opt.que_op}" name="${opt.que_id}" value="${opt.que_op}"/><span>${opt.que_op}.${opt.statement}</span></div>
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											var opt = "${opt.que_op}";
											if( useropt.indexOf(opt) != -1){
												$("#${opt.que_id}${opt.que_op}").prop("checked",true);
											}
										</script>
									</c:forEach>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='主观题'}">
								<div class="main_radio_question">
									<div style="margin-top: 15px;margin-left: 15px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/>
										<textarea id="${qList.que.que_id}" name="${qList.que.que_id}" style="border: solid 1px #cccccc; border-radius: 5px;" rows="7" cols="90"></textarea>
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											$("#${qList.que.que_id}").text(useropt);
										</script>
									</div>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='填空题'}">
								<div class="main_fill_black">
									<div style="margin-top: 15px;margin-left: 15px;">
										<span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/>
										<input name="${qList.que.que_id}" type="text" style="width: 670px;height: 32px;border: solid 1px #cccccc; border-radius: 5px;margin-top: 20px;" />
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											$("#${opt.que_id}${opt.que_op}").val(useropt);
										</script>
									</div>
								</div>
							</c:when>
						</c:choose>

					</c:when>
				</c:choose>
			</c:forEach>


			<script>
				all_score+=${temp.relInfo.que_count}*${temp.relInfo.que_score};
			</script>
		</c:forEach>
		<script>
			$("#allSocre").text(all_score);
		</script>
	</div>
<br/>
<br/>
<br/>
    <input type="hidden" name="par_id" value="${ViewInfo.paperInfo.paper.par_id}">
</div>
<a name="btm22"></a>
<div class="operation">

	<br>
	<div class="remain_time" id="remain_time">
		剩余时间：0:0
	</div>
	<div class="back_top">
		<a href="#top" style="color: white;font-size: 12px;">回到顶部</a>
	</div>
	<div class="back_top">
		<a href="#btm22" style="color: white;font-size: 12px;">回到底部</a>
	</div>
	<div class="sub" onclick="handpaper()">
		<a class="tijiao">交卷</a>
	</div>

	<script>
		function autoSend(){
			var url = "/exam/autohand";
			$.ajax({
				type: "POST",
				url: url,
				data:$("#form1").serialize(),
				success: function(){
				}
			});
		}
		var auto = setInterval("autoSend()",5000);
		function handpaper() {
			clearInterval(auto);
			var url = "/exam/handpaper";

			$.ajax({
				type: "POST",
				url: url,
				data:$("#form1").serialize(),
				success: function(res){
					//var parse = JSON.parse(data);
					// 询问框
					layer.confirm(res.msg, {
						btn: ['查看详情','返回首页'] //按钮
					}, function(){
						location.href="${pageContext.request.contextPath}/exam/record?par_id=${ViewInfo.paperInfo.paper.par_id}";
					}, function(){
						location.href="${pageContext.request.contextPath}/html/all.jsp";
					});
					// layer.alert(res.msg, function(index){
					// 	//do something
					// 	// location.href="";
					// 	layer.close(index);
					// });
					//
					// alert( "Data Saved: " + JSON.stringify(data) );
				}
			});
		}
	</script>
</div>

</form>

<script type="text/javascript">
    var nowTime = Date.parse(new Date());/*获取当前时间*/
	var startTime = new Date("${ViewInfo.examRecord.exam_time}").getTime();/*获取开始考试时间 和现在的差值*/
    var t = nowTime-startTime;
    var limitTime = ${ViewInfo.paperInfo.paper.test_length_time};
    var lastTime = limitTime - parseInt(t/60000);
    if(lastTime<0) lastTime=0;
    // alert(lastTime)

    var a;
    var min=lastTime-1;
    var sc=59;
    function remain_time(){
		nowTime = Date.parse(new Date());/*获取当前时间*/
        var txt=document.getElementById("remain_time");
        sc--;
        if(sc<0){
            sc=59;
            min--;
        }
        if(min<=0){
            clearInterval(a);
            sc=0;
        }
        if(sc==0&&min==0){
            // document.getElementByName("form1").submit();
			handpaper();//自动交卷
        }
        txt.innerHTML="剩余时间："+" "+min+":"+sc;
    }
    a=setInterval("remain_time()",1000);

 </script>

<script>
	layui.use('layer', function(){
		var layer = layui.layer;

	});
</script>
<iframe src="${pageContext.request.contextPath}/html/footer.html" frameborder="0" width="100%" height="59px" scrolling="no"></iframe>
</body>

</html>
