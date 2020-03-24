<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%@ page errorPage="/error.jsp" %> --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="management/lib/layui/css/layui.css">
<script src="management/js/jquery3.3.1.min.js"></script>
<script src="js/jquery.serializejson.min.js"></script>
<script src="management/lib/layui/layui.js"></script>

<style>
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
        top: 50%;
        transform: translateY(-50%);
        }
</style>
<script>
    function autoFrame(id){
        //找到当年ifr
        $("iframe[name=ifr][data-frameid="+id+"]",parent.document).css("height",$(document).height());

    }
</script>