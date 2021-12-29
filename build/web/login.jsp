<%-- 
    Document   : login
    Created on : Oct 18, 2021, 10:10:16 AM
    Author     : TungLoc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        ${requestScope.LOGIN_ERROR}
        <form action="login" method="POST">
            Email: <input placeholder="Username" type="text" name="txtEmail" value=""/> <br/>
            Password: <input placeholder="Password" type="password" name="txtPassword" value=""/> <br/>
            <input type="submit" value="Login" name="btnAction"/>
        </form>
        <a href="createNewAccount.jsp">Create new account</a>
    </body>
</html>
