

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--<script src="<c:url value="/ckeditor/ckeditor.js"></c:url>"></script>-->
            <script src="//cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>

        </head>
        <body>
        <c:if test="${sessionScope.LOGIN_INFO == null}">
            <a href="login.jsp">Login</a>
        </c:if>

        <c:if test="${sessionScope.LOGIN_INFO != null}">
            <c:if test="${sessionScope.LOGIN_INFO.role != 'Member'}">
                <c:redirect url="login.jsp"></c:redirect>
            </c:if>
            <c:if test="${sessionScope.LOGIN_INFO.role == 'Member'}">
                <h1>Welcome, ${sessionScope.LOGIN_INFO.userName}</h1>
                <c:url var="logout" value="logout">
                    <c:param name="btnAction" value="Logout"></c:param>
                </c:url>
            </c:if> 
            <a href="${logout}">Logout</a>
        </c:if>

        <form action="postArticle" method="POST">
            Title:<input type="text" name="txtArticleTitle" value="${param.txtArticleTitle}"/><br/>
            Short Description:<input type="text" name="txtShortDescription" value="${param.txtShortDescription}"/><br/>
            Content: <textarea name="txtContent"></textarea><br/>
            <input type="submit" name="btnAction" value="Post"/>
        </form>
        <script>
            CKEDITOR.replace('txtContent');
        </script>
    </body>
</html>
