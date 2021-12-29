

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                <c:if test="${sessionScope.LOGIN_INFO.status == 'New'}">
                    <c:url var="activeAccount" value="getCodeActive">
                        <c:param name="btnAction" value="GetCode"></c:param>
                    </c:url>
                    <a href="${activeAccount}">Active Account</a>
                </c:if>
                <a href="writeArticle.jsp">Write Article</a>
            </c:if> 
            <a href="${logout}">Logout</a>

        </c:if>
        ${requestScope.MESSAGE}
        <form action="search">
            ${requestScope.SEARCH_ERROR}<br/>
            Search: <input type="text" name="txtSearch" value="${param.txtSearch}" />
            <input type="submit" value="Search" name="btnAction"/>
        </form>
        <c:if test="${not empty requestScope.ARTICLE_LIST}">
            <table border="1">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Author</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="artDTO" items="${requestScope.ARTICLE_LIST}">
                        <tr>
                            <td>
                                <c:if test="${empty param.txtSearch}">
                                    <a href="loadComment?txtID=${artDTO.articleID}">${artDTO.articleTitle}</a>
                                </c:if>
                                <c:if test="${not empty param.txtSearch}">
                                    <a href="loadComment?txtID=${artDTO.articleID}&txtSearch=${param.txtSearch}">${artDTO.articleTitle}</a>
                                </c:if>
                            </td>
                            <td>
                                ${artDTO.articleShortDesc}
                            </td>
                            <td>
                                ${artDTO.articleAuthor}
                            </td>
                            <td>
                                ${artDTO.postingDate}
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty param.txtSearch}">
                <c:if test="${requestScope.CURREN_PAGE != 1}">
                <td><a href="Load?PAGE=${requestScope.CURREN_PAGE - 1}">Previous</a></td>
            </c:if>

            <table border="1">
                <c:forEach begin="1" end="${requestScope.NUM_OF_PAGE}" var="i">
                    <c:choose>
                        <c:when test="${requestScope.CURREN_PAGE eq i}">
                            <td>${i}</td>
                        </c:when>
                        <c:otherwise>
                            <td><a href="Load?PAGE=${i}">${i}</a></td>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
            </table>

            <c:if test="${requestScope.CURREN_PAGE lt requestScope.NUM_OF_PAGE}">
                <td><a href="Load?PAGE=${requestScope.CURREN_PAGE + 1}">Next</a></td>
            </c:if>
        </c:if>

        <c:if test="${not empty param.txtSearch}">
            <c:if test="${requestScope.CURREN_PAGE != 1}">
                <td><a href="Search?PAGE=${requestScope.CURREN_PAGE - 1}&txtSearch=${param.txtSearch}">Previous</a></td>
            </c:if>

            <table border="1">
                <c:forEach begin="1" end="${requestScope.NUM_OF_PAGE}" var="i">
                    <c:choose>
                        <c:when test="${requestScope.CURREN_PAGE eq i}">
                            <td>${i}</td>
                        </c:when>
                        <c:otherwise>
                            <td><a href="Search?PAGE=${i}&txtSearch=${param.txtSearch}">${i}</a></td>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
            </table>

            <c:if test="${requestScope.CURREN_PAGE lt requestScope.NUM_OF_PAGE}">
                <td><a href="Search?PAGE=${requestScope.CURREN_PAGE + 1}&txtSearch=${param.txtSearch}">Next</a></td>
            </c:if>
        </c:if>
    </c:if>

    <c:if test="${empty requestScope.ARTICLE_LIST}">
        No record
    </c:if>
</body>
</html>
