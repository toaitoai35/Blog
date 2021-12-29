
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.CREATE_USER}">
            ${requestScope.CREATE_USER}
            <a href="login.jsp">Login</a>
        </c:if>
        <c:if test="${empty requestScope.CREATE_USER}">
            <form action="createNewAccount" method="POST">
                Email: <input type="text" name="txtEmail" value="" /></br>
                ${requestScope.CREATE_ERROR.emailError}<br/>
                Password <input type="password" name="txtPassword" value="" /></br>
                ${requestScope.CREATE_ERROR.password}<br/>
                RePassword <input type="password" name="txtRePassword" value="" /></br>
                ${requestScope.CREATE_ERROR.rePassword}<br/>
                Name: <input type="text" name="txtUsername" value="" /></br>
                ${requestScope.CREATE_ERROR.username}<br/>
                <input type="submit" value="Create" name="btnAction" />
                <input type="reset" value="Reset" />
            </form>
        </c:if>
    </body>
</html>
