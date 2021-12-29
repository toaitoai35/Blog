

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <a href="${logout}">Logout</a>
            </c:if> 

            <c:if test="${sessionScope.LOGIN_INFO.role == 'Admin'}">
                <h1>Welcome, ${sessionScope.LOGIN_INFO.userName}</h1>
                <c:url var="logout" value="logout">
                    <c:param name="btnAction" value="Logout"></c:param>
                </c:url>
                <a href="${logout}">Logout</a>
            </c:if> 
        </c:if>
        <c:if test="${sessionScope.LOGIN_INFO.role == 'Admin'}">
            <c:if test="${param.txtSearch != null}">
                <c:url var="back" value="search">
                    <c:param name="txtSearch" value="${param.txtSearch}"></c:param>
                    <c:param name="cbxStatus" value="${param.cbxStatus}"></c:param>
                    <c:param name="btnAction" value="Search"></c:param>
                </c:url>
            </c:if>
            <c:if test="${param.txtSearch == null}">
                <c:url var="back" value="load">
                    <c:param name="btnAction" value="Search"></c:param>
                </c:url>
            </c:if>
        </c:if>
        <c:if test="${sessionScope.LOGIN_INFO.role != 'Admin'}">
            <c:if test="${param.txtSearch != null}">
                <c:url var="back" value="search">
                    <c:param name="txtSearch" value="${param.txtSearch}"></c:param>
                    <c:param name="btnAction" value="Search"></c:param>
                </c:url>
            </c:if>
            <c:if test="${param.txtSearch == null}">
                <c:url var="back" value="load">
                    <c:param name="btnAction" value="Search"></c:param>
                </c:url>
            </c:if>
        </c:if>
        <a href="${back}">Back</a>   

        <c:set var="dto" value="${requestScope.DETAIL}"/>
        <h1>${dto.articleTitle}</h1>
        <span>Date: ${dto.postingDate}</span><br/>
        <span>Author: ${dto.articleAuthor}</span>
        <div>
            ${dto.articleContent}
        </div>
        <hr>
        <c:forEach var="commentDTO" items="${requestScope.COMMENT_LIST}">
            <span>${commentDTO.commentEmail}</span><br/>
            <span>${commentDTO.commentDate}</span><br/>
            <span>${commentDTO.commentContent}</span><br/><br/>
        </c:forEach>
        <c:if test="${sessionScope.LOGIN_INFO != null}">
            <c:if test="${sessionScope.LOGIN_INFO.role == 'Member'}">
                <hr>
                <c:if test="${param.txtSearch != null}">
                    <form action="postComment">
                        <textarea name="txtComment" rows="4" cols="50" maxlength="250"></textarea><br/>
                        <input type="hidden" name="txtID" value="${param.txtID}"/>
                        <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                        <input type="submit" name="btnAction" value="Post Comment"/>
                    </form>
                </c:if>
                <c:if test="${param.txtSearch == null}">
                    <form action="postComment">
                        <textarea name="txtComment" rows="4" cols="50" maxlength="250"></textarea><br/>
                        <input type="hidden" name="txtID" value="${param.txtID}"/>
                        <input type="submit" name="btnAction" value="Post Comment"/>
                    </form>
                </c:if>
            </c:if>
            <c:if test="${sessionScope.LOGIN_INFO.role == 'Admin'}">
                <c:if test="${requestScope.DETAIL.articleStatus != 'Delete'}">
                    <form action="deleteArticle" method="POST">
                        <input type="hidden" name="txtID" value="${requestScope.DETAIL.articleID}"/>
                        <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                        <input type="hidden" name="cbxStatus" value="${param.cbxStatus}"/>
                        <input value="Delete" type="submit" name="btnAction"/>
                    </form>
                </c:if>
                <c:if test="${requestScope.DETAIL.articleStatus == 'Delete'}">
                    <input value="Delete" type="submit" name="btnAction" disabled/>
                </c:if>
                <c:if test="${requestScope.DETAIL.articleStatus != 'Active'}">
                    <form action="activeArticle" method="POST">
                        <input type="hidden" name="txtID" value="${requestScope.DETAIL.articleID}"/>
                        <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                        <input type="hidden" name="cbxStatus" value="${param.cbxStatus}"/>
                        <input value="Active" type="submit" name="btnAction"/>
                    </form>
                </c:if>
                <c:if test="${requestScope.DETAIL.articleStatus == 'Active'}">
                    <input value="Active" type="submit" name="btnAction" disabled/>
                </c:if>
            </c:if>
        </c:if>
    </body>
</html>
