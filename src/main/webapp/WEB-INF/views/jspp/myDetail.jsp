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
    <style>
        .form-group label {
            margin-bottom: 3px; /* 아래 여백 조정 */
        }
        .form-group p,
        .form-group span {
            font-size: 1.1em; /* 글꼴 크기 조정 */
        }
    </style>
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
       				<h3>
       				    <c:out value="${userId}"/>님의 정보
       				</h3>
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
           <div class="col-md-2">
           </div>
           <div class="col-md-4">
                   <div class="form-group">
                       <label for="inputDefault">아이디</label>
                       <p>&nbsp;<c:out value="${details.userId}"/></p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">이름</label>
                       <p>&nbsp;<c:out value="${details.name}"/></p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">전화번호</label>
                       <p>&nbsp;<c:out value="${details.phoneNumber}"/></p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">가입일</label>
                       <p>
                        &nbsp;<fmt:formatDate value="${details.regDate}" pattern="yyyy"/>년
                        <fmt:formatDate value="${details.regDate}" pattern="MM"/>월
                        <fmt:formatDate value="${details.regDate}" pattern="dd"/>일
                       </p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">포인트</label>
                       <p>&nbsp;<fmt:formatNumber value="${details.point}" pattern="#,###"/> 포인트</p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">충전한 돈</label>
                       <div>
                           <span>&nbsp;<fmt:formatNumber value="${details.money}" pattern="#,###"/> 원</span>
                           <button type="submit" class="btn btn-primary">
                               충전
                           </button>
                       <div>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault" style="margin-top:10px">
                           내 동네
                       </label>
                       <div class="row">
                          <div class="col-md-8 text-start">
                              <div class="form-group">
                                  <input type="input" class="form-control" id="myAroundHome" value="${details.address}" placeholder="내 동네를 설정해주세요"/>
                              </div>
                          </div>
                          <div class="col-md-4 text-start">
                              <div class="form-group">
                                  <button type="submit" class="btn btn-primary">
                                      위치검색
                                  </button>
                              </div>
                          </div>
                      </div>
                   </div>
               <br>
               <div class="row">
                   <div class="col-md-6 text-start">
                       <form class="d-flex" method="get" action="/user/${userId}/edit">
                           <div class="form-group">
                               <button type="submit" class="btn btn-primary">
                                   회원수정
                               </button>
                           </div>
                       </form>
                   </div>
                   <div class="col-md-6 text-end">
                       <div class="form-group">
                           <button type="submit" class="btn btn-primary">
                               회원탈퇴
                           </button>
                       </div>
                   </div>
               </div>
           </div>
           <div class="col-md-2">
           </div>
           <div class="col-md-2">
           </div>
       </div>
   </div>


</body>
