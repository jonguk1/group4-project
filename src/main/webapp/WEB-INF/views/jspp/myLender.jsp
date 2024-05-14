<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
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
                    <div class="input-group mt-3"> <!-- 여기에 mt-3 클래스 추가 -->
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
           				<c:out value="${userId}"/>님의 빌려준 목록
           			</h3>
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
    		    <c:when test="${lenders eq null or empty lenders}">
    		        <div class="col-md-8">
    		            빌려준 물품 목록이 없습니다
    		        </div>
    		    </c:when>
    		    <c:otherwise>
    		        <div class="col-md-8">
                        <div class="row">
                            <c:forEach var="lenders" items="${lenders}" varStatus="status" begin="0" end="${page.oneRecordPage-4}">
                                <div class="col-md-4">
                                    <div class="card">
                                        <h5 class="card-header">
                                            <c:out value="${lenders.title}"/>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <img src="/images/${lenders.itemImage1}" alt="대체_텍스트" style="width: 100%; height: 200px;">
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${lenders.isAuction eq 0}">
                                                    <p><span class="badge bg-danger">경매전</span>
                                                </c:when>
                                                <c:when test="${lenders.isAuction eq 1}">
                                                    <p><span class="badge bg-danger">경매중</span>
                                                </c:when>
                                                <c:when test="${lenders.isAuction eq 2}">
                                                    <p><span class="badge bg-danger">경매후</span>
                                                </c:when>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${lenders.isLend eq 0}">
                                                    <span class="badge bg-success">대여전</span>
                                                </c:when>
                                                <c:when test="${lenders.isLend eq 1}">
                                                    <span class="badge bg-success">대여중</span>
                                                </c:when>
                                                <c:when test="${lenders.isLend eq 2}">
                                                    <span class="badge bg-success">대여후</span>
                                                </c:when>
                                            </c:choose>
                                            <p>
                                                <c:out value="${lenders.itemName}"/>
                                                <fmt:formatNumber value="${lenders.price}" pattern="#,###"/>원
                                            </p>
                                            <span>관심 <c:out value="${lenders.interestCnt}"/></span>
                                            <span>조회 <c:out value="${lenders.hits}"/></span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

    		<div class="col-md-2">
    		</div>
    	</div>

        <br>

    	<div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <div class="row">
                    <c:forEach var="lenders" items="${lenders}" varStatus="status" begin="${page.oneRecordPage-3}" end="${page.oneRecordPage}">
                        <div class="col-md-4">
                            <div class="card">
                                <h5 class="card-header">
                                    <c:out value="${lenders.title}"/>
                                </h5>
                                <div class="card-body">
                                    <p class="card-text">
                                        <img src="/images/${lenders.itemImage1}" alt="대체_텍스트" style="width: 100%; height: 200px;">
                                    </p>
                                </div>
                                <div class="card-footer">
                                    <c:choose>
                                        <c:when test="${lenders.isAuction eq 0}">
                                            <p><span class="badge bg-danger">경매전</span>
                                        </c:when>
                                        <c:when test="${lenders.isAuction eq 1}">
                                            <p><span class="badge bg-danger">경매중</span>
                                        </c:when>
                                        <c:when test="${lenders.isAuction eq 2}">
                                            <p><span class="badge bg-danger">경매후</span>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${lenders.isLend eq 0}">
                                            <span class="badge bg-success">대여전</span>
                                        </c:when>
                                        <c:when test="${lenders.isLend eq 1}">
                                            <span class="badge bg-success">대여중</span>
                                        </c:when>
                                        <c:when test="${lenders.isLend eq 2}">
                                            <span class="badge bg-success">대여후</span>
                                        </c:when>
                                    </c:choose>
                                    <p>
                                        <c:out value="${lenders.itemName}"/>
                                        <fmt:formatNumber value="${lenders.price}" pattern="#,###"/>원
                                    </p>
                                    <span>관심 <c:out value="${lenders.interestCnt}"/></span>
                                    <span>조회 <c:out value="${lenders.hits}"/></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
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
            </c:otherwise>
        </c:choose>
    </div>
</body>

