<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="/js/menuControl.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
     <script src="/js/notification.js"></script>
     <link rel="stylesheet" type="text/css" href="/css/notification.css">
    <meta charset="UTF-8">
    <title>Title</title>

    <script>
        function deleteBlockUser(blockedUserId) {
            if (confirm(blockedUserId+'님의 차단을 해제하시겠습니까?')) {
                $.ajax({
                    url: '/block/' + blockedUserId,
                    type: 'DELETE',
                    success: function(result) {
                        if (result === 'ok') {
                            alert('차단을 해제하셧습니다');
                            location.reload();
                        } else {
                            alert('차단해제를 실패하였습니다');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('에러가 발생하였습니다');
                    }
                });
            }
        }
    </script>

</head>

<body>

  <div class="container bg-green text-center">
                  <div class="row">
                      <div class="col" >
                          <nav class="navbar navbar-expand-lg bg-green" data-bs-theme="light">
                              <a href="/">
                              <img src="/images/icon/logo.png" style="height: 50px; width: 50px; margin-right: 8px;">
                              </a>
                              <a class="navbar-brand" href="/" style="color: black; font-size: 25px;">썸띵랜드</a>
                          </nav>
                      </div>
                      <div class="col" >
                          <form class="d-flex" method="get" action="/board/search">
                              <div class="input-group mt-3" >
                                  <input class="form-control me-2" type="search" name="searchTerm" id="searchTerm" placeholder="빌리고 싶은 물건을 입력하세요">
                                  <button class="btn btn-secondary" type="submit">상품명 검색</button>
                              </div>
                          </form>
                      </div>
                      <div class="col" >
                          <nav class="navbar navbar-expand-lg bg-green">
                              <div class="container-fluid">
                                  <div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
                                      <ul class="navbar-nav">

                                        <li>
                                            <div id="messageContainer" style="display: none;">

                                            </div>
                                        </li>
                                        <span id="notificationMessage" class="notification-message" >여기에 알림 메시지를 입력하세요.</span>
                                          <li class="nav-item">
                                              <c:if test="${loggedIn}">
                                                  <a class="nav-link" href="#">
                                                      <img src="/images/icon/notificationIcon.png" id="notificationIcon" style="width:30px; height:30px;">
                                                  </a>
                                              </c:if>
                                          </li>

                                          <li class="nav-item">
                                              <c:if test="${loggedIn}">
                                                  <a class="nav-link" href="#">
                                                      <img src="/images/icon/chatIcon.png" style="width:37px; height:37px;">
                                                  </a>
                                              </c:if>
                                          </li>
                                          <li class="nav-item">
                                              <c:if test="${loggedIn}">
                                                  <a class="nav-link" href="/user/${userId}" style="color: black;">${userId}님</a>
                                              </c:if>
                                          </li>
                                          <li class="nav-item">
                                              <c:if test="${not loggedIn}">
                                                  <a class="nav-link" href="/login" style="color: black;">로그인</a>
                                              </c:if>
                                              <c:if test="${loggedIn}">
                                                  <a class="nav-link" href="/logout" style="color: black;">로그아웃</a>
                                              </c:if>
                                          </li>
                                      </ul>

                                  </div>
                              </div>
                          </nav>
                      </div>
                  </div>
              </div>





              <div class="container d-flex justify-content-center">
                  <nav class="navbar navbar-expand-lg" data-bs-theme="light">
                      <ul class="navbar-nav me-auto">
                          <li class="nav-item dropdown text-center">
                              <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려드려요</a>
                              <div class="dropdown-menu" id="lendServe">

                              </div>
                          </li>

                          <li class="nav-item dropdown text-center">
                              <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려주세요</a>
                              <div class="dropdown-menu" id="lendServed">
                              </div>
                          </li>

                          <li class="nav-item dropdown text-center">
                              <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">경매</a>
                              <div class="dropdown-menu">
                                  <a class="dropdown-item" href="#">경매 현황</a>
                                  <a class="dropdown-item" href="#">마감 임박</a>

                              </div>
                          </li>
                      </ul>
                  </nav>
              </div>
   <br><br>

   <div class="row">
       		<div class="col-md-2">
       		</div>
       		<div class="col-md-8 text-center">

       		<span>
       				<h3><c:out value="${userId}"/>님의 차단 목록</h3>
       		</span>
       		</div>
       		<div class="col-md-2">
       		</div>
       	</div>

       	<br><br>

   <div class="container-fluid">
       	<div class="row">
       		<div class="col-md-2">
       		    <%@ include file="/WEB-INF/views/jspp/include/mypage.jsp"%>
       		</div>
       		<c:choose>
       		    <c:when test="${blocks eq null or empty blocks}">
       		        <div class="col-md-8">
       		            등록된 차단 유저가 없습니다
       		        </div>
       		    </c:when>
       		    <c:otherwise>
                    <div class="col-md-8">
                        <table class="table">
                            <tr>
                              <th scope="col">차단 유저</th>
                              <th scope="col">삭제</th>
                            </tr>
                            <c:forEach var="block" items="${blocks}">
                                <tr style="font-size:1.25rem">
                                    <td>
                                        <c:out value="${block.blockedUserId}"/>
                                    </td>
                                    <td>
                                        <button type="submit" class="btn btn-primary" onclick="deleteBlockUser('${block.blockedUserId}')">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
       		<div class="col-md-2">
       		</div>
       	</div>

       	<br>

        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-4">
                        <nav>
                            <c:out value="${pageNavi}" escapeXml="false"/>
                        </nav>
                    </div>
                    <div class="col-md-4">
                    </div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
        </div>


</body>