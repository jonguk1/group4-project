<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>

     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<body>

<div class="container bg-green text-center">
    <div class="row">
            <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
                <nav class="navbar navbar-expand-lg bg-green" data-bs-theme="light">
                    <a class="navbar-brand" href="#" style="color: black;">썸띵랜드</a>
                </nav>
            </div>
            <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
                <form class="d-flex">
                    <div class="input-group mt-3">
                        <input class="form-control me-2" type="search" placeholder="빌리고 싶은 물건을 입력하세요">
                        <button class="btn btn-secondary" type="submit">Search</button>
                    </div>
                </form>
            </div>
            <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
                <nav class="navbar navbar-expand-lg bg-green">
                    <div class="container-fluid">
                        <div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">알림</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">로그아웃</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">채팅</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">메시지</a>
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
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려주세요</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Separated link</a>
                    </div>
                </li>

                <li class="nav-item dropdown text-center">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려드려요</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">도서</a>
                        <a class="dropdown-item" href="#">생활용품</a>
                        <a class="dropdown-item" href="#">의류</a>

                    </div>
                </li>

                <li class="nav-item dropdown text-center">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">경매</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Separated link</a>
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
           	<h3>
           	    <c:out value="${userId}"/>님이 받은 리뷰목록
           	</h3>
        </div>
        <div class="col-md-2">
        </div>
    </div>

    <br><br>

     <div class="container-fluid" style="margin-left:80px;height:300px">
    	<div class="row">
    		<div class="col-md-2" style="margin-right:30px">
    		    <div class="accordion" id="accordionExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                마이페이지
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
                            <div class="accordion-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action">내 정보</a>
                                    <a href="#" class="list-group-item list-group-item-action">관심 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">빌려준 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">빌린 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">차단 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">보낸 리뷰 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">받은 리뷰 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">내 경매 목록</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
    		</div>
    		<c:choose>
    		    <c:when test="${receiveds eq null or empty receiveds}">
                    <div class="col-md-8">
                        <h2>관심 등록한 내역이 없습니다<h2>
                    </div>
    		    </c:when>
    		    <c:otherwise>
                    <div class="col-md-4">
                        <c:forEach var="received" items="${receiveds}" varStatus="status">
                            <c:if test="${status.index==0||status.index==2}">
                                <div class="card bg-light mb-3" style="max-width: 30rem;">
                                  <div class="card-header">아이디:&nbsp&nbsp<c:out value="${received.reviewee}"/>님</div>
                                  <div class="card-body">
                                    <h4 class="card-title"><c:out value="${received.content}"/></h4>
                                    <p class="card-text">
                                        <c:forEach var="k" begin="0" end="${received.star-1}">
                                            <i class="bi bi-star-fill" style="font-size:24px;"></i>
                                        </c:forEach>
                                        <c:forEach var="k" begin="${received.star}" end="4">
                                            <i class="bi bi-star" style="font-size:24px;"></i>
                                        </c:forEach>
                                    </p>
                                  </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="col-md-4">
                        <c:forEach var="received" items="${receiveds}" varStatus="status">
                            <c:if test="${status.index==1||status.index==3}">
                                <div class="card bg-light mb-3" style="max-width: 30rem;">
                                  <div class="card-header">아이디:&nbsp&nbsp<c:out value="${received.reviewee}"/>님</div>
                                  <div class="card-body">
                                    <h4 class="card-title"><c:out value="${received.content}"/></h4>
                                    <p class="card-text">
                                        <c:forEach var="k" begin="0" end="${received.star-1}">
                                            <i class="bi bi-star-fill" style="font-size:24px;"></i>
                                        </c:forEach>
                                        <c:forEach var="k" begin="${received.star}" end="4">
                                            <i class="bi bi-star" style="font-size:24px;"></i>
                                        </c:forEach>
                                    </p>
                                  </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                <div class="col-md-2">
                </div>
                </c:otherwise>
            </c:choose>
    	</div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4">
        </div>
        <br>
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-4">
                    <nav>
                        <ul class="pagination pagination-lg" style="margin-left:-50px;">
                            <c:if test="${prevBlock>0}">
                                <li class="page-item">
                                    <a class="page-link" href="/review/${userId}/received?pageNum=${prevBlock}">Previous</a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${prevBlock+1}" end="${nextBlock-1}">
                                    <c:if test="${i<=pageCount}">
                                        <c:choose>
                                            <c:when test="${param.pageNum eq i}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/review/${userId}/received?pageNum=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/review/${userId}/received?pageNum=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                            </c:forEach>
                            <c:if test="${nextBlock<=pageCount}">
                                <li class="page-item">
                                    <a class="page-link" href="/review/${userId}/received?pageNum=${nextBlock}">Next</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
    </div>
</body>
