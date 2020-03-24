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
	<style>
		.defenclass{
			line-height: 30px;
			font-weight: bold;
			margin-right: 5px;
		}
		.daanclass{
			line-height: 30px;
			margin-right: 5px;
			color: red;
			font-weight: bold;
		}
		.defenclassone{
			line-height: 30px;
			color: #666;
			font-weight: bold;
		}
		.daanclassone{
			line-height: 30px;
			font-size: 12px;
			color: red;
		}
	</style>
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
		<p style="margin-top: 30px;">考生: ${sessionScope.user.nickname}</p>
         <p>考试编号: EXAM-${ViewInfo.paperInfo.paper.par_id}</p>
		<p>试卷总分: <span id="allSocre"></span></p>
		<p>你的分数: ${ViewInfo.examRecord.sum_score}</p>
	</div>
	<div>
		<% int count = 1;%>
		<script>
			var all_score = 0;
			var usermap = {};
			var userScoremap = {};
			<c:forEach items="${ViewInfo.userAnswerList}" var="userAnswer" >
				var qid = "${userAnswer.que_id}";
				var ans = "${userAnswer.ask}";
				var score = "${userAnswer.score}";
				usermap[qid] = ans;
				userScoremap[qid] = score;
			</c:forEach>

			var analysismap ={}
			<c:forEach items="${ViewInfo.queWithOptionList}" var="analyList" >
				var qid = "${analyList.que.que_id}";
				var analysis = "${analyList.que.analysis}";
				analysismap[qid] = analysis;
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
						<%--<div style="margin-top: 15px;margin-left: 15px;"><span>得分:</span><span id="score${qList.que.que_id}"></span><br/>--%>
						<div style="margin-top: 15px;margin-left: 15px;">
							<span class="defenclass">得分:&nbsp;</span><span class="defenclassone" id="score${qList.que.que_id}"></span><br/>
							<span class="daanclass">答案:&nbsp;</span><span class="daanclassone" id="rightAsk${qList.que.que_id}"></span><br>
							<textarea id="analy${qList.que.que_id}" name="${qList.que.que_id}" style="border: solid 1px #cccccc; border-radius: 5px;" rows="7" cols="90"></textarea>
							<script>
								var qid = "${qList.que.que_id}";
								<%--var analysis = "答案:${qList.que.right_ask}\n"--%>
								 analysis = analysismap[qid];
								$("#analy${qList.que.que_id}").text(analysis);
								var rightAsk = "${qList.que.right_ask}";
								$("#rightAsk${qList.que.que_id}").text(rightAsk);

								var score = userScoremap[qid];
								$("#score${qList.que.que_id}").text(score);
							</script>
						</div>
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
	<%--<div class="remain_time" id="remain_time">--%>
		<%--剩余时间：0:0--%>
	<%--</div>--%>
	<div class="back_top">
		<a href="#top" style="color: white;font-size: 12px;">回到顶部</a>
	</div>
	<div class="back_top">
		<a href="#btm22" style="color: white;font-size: 12px;">回到底部</a>
	</div>
	<div class="sub">
		<a class="tijiao" href="${pageContext.request.contextPath}/html/kaoshi3.jsp">返回</a>
	</div>
</div>

</form>
<script>
	layui.use('layer', function(){
		var layer = layui.layer;

	});
</script>
<iframe src="${pageContext.request.contextPath}/html/footer.html" frameborder="0" width="100%" height="59px" scrolling="no"></iframe>
</body>

</html>
