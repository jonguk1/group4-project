<!DOCTYPE html>
<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Navigation Bar</title>
    <!-- 부트 스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.0.0/dist/minty/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            #detailImg{
                width:100px;
                height:100px;
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
                                            <li class="nav-item">
                                                <c:if test="${loggedIn}">
                                                    <a class="nav-link" href="#">
                                                        <img src="/images/icon/notificationIcon.png" style="width:30px; height:30px;">
                                                    </a>
                                                </c:if>
                                            </li>

                                            <li class="nav-item">
                                                <c:if test="${loggedIn}">
                                                    <a class="nav-link" href="/chat/chatList/${userId}">
                                                        <img src="/images/icon/chatIcon.png" style="width:37px; height:37px;">
                                                    </a>
                                                </c:if>
                                            </li>
                                            <li class="nav-item">
                                                <c:if test="${loggedIn}">
                                                    <a class="nav-link" href="/user" style="color: black;">내정보</a>
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



    <div class="container-fluid">
    	<div class="row">
    		<div class="col-md-12">
    			<div class="row">
    				<div class="col-md-2">
    				</div>
    				<div class="col-md-8">
    					<h3>
    						${userId}님의 채팅
    					</h3>
                         <div id="chatList">
                             <ul class="list-group">
                                 <c:forEach var="chat" items="${chatList}">
                                    <a href="/chat/${chat.chatId}" style="text-decoration-line: none;">
                                        <input type="hidden" name="boardId" id="boardId" value="${chat.boardId}">

                                        <li class="list-group-item list-group-item-primary d-flex justify-content-between align-items-center">
                                              <c:choose>
                                                <c:when test="${chat.from eq userId}">
                                                    <c:out value="${chat.to}"/>님과의 채팅
                                                </c:when>
                                                <c:when test="${chat.to eq userId}">
                                                    <c:out value="${chat.from}"/>님과의 채팅
                                                </c:when>
                                              </c:choose>
                                             <span class="badge bg-primary rounded-pill"><fmt:formatDate pattern="yy-MM-dd HH:mm:ss" value="${chat.sendTime}"/></span>
                                        </li>
                                        <li class="list-group-item list-group-item-secondary d-flex justify-content-between align-items-center">
                                            <c:out value="${chat.chatItemDTO.title}"/>
                                            <img alt="이미지 없음" src="${chat.chatItemDTO.images}" id="detailImg" />
                                         </li>
                                        <li class="list-group-item list-group-item-light d-flex justify-content-between align-items-center">
                                             <c:out value="${chat.content}"/>
                                             <span class="badge bg-primary rounded-pill">2</span>
                                        </li>
                                    </a>
                                </c:forEach>
                             </ul>
                         </div>
                    </div>
    				<div class="col-md-2">
    				</div>
    			</div>
    		</div>
    	</div>
    </div>


    </body>


    </html>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $.ajax({
               url: "/board/board-category",
               type: "GET",
               dataType: "json",
               success: function(response) {
                   console.log(response);

                   $.each(response, function(index, value) {
                       $("#lendServe").append("<a class='dropdown-item' href='/board?boardCategoryId=1&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                       $("#lendServed").append("<a class='dropdown-item' href='/board?boardCategoryId=2&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                       $("#itemCategoryId").append("<option value='" + value.itemCategoryId + "'>" + value.itemCategoryName + "</option>");
                   });


               },
               error: function(xhr, status, error) {
                   console.error("요청 실패:", status, error);
               }
            });

        });

    </script>


