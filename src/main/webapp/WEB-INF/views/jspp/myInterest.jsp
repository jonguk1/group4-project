<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="/js/menuControl.js"></script>
     <meta charset="UTF-8">
     <title>Title</title>
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
                                                  <a class="nav-link" href="#">
                                                      <img src="/images/icon/chatIcon.png" style="width:37px; height:37px;">
                                                  </a>
                                              </c:if>
                                          </li>
                                          <li class="nav-item">
                                              <c:if test="${loggedIn}">
                                                  <a class="nav-link" href="/user/${userId}" style="color: black;">내정보</a>
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
           			<h3>
           				<c:out value="${userId}"/>님의 관심목록
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
    		    <c:when test="${favorites eq null or empty favorites}">
    		        <div class="col-md-8">
    		            등록한 관심 목록이 없습니다
    		        </div>
    		    </c:when>
    		    <c:otherwise>
    		        <div class="col-md-8">
                        <div class="row">
                            <c:forEach var="favorite" items="${favorites}" varStatus="status" begin="0" end="${page.oneRecordPage-4}">
                                <div class="col-md-4">
                                    <div class="card">
                                        <h5 class="card-header">
                                            <c:out value="${favorite.boards[0].title}"/>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <img src="/images/${favorite.boards[0].itemImage1}" alt="대체_텍스트" style="width: 100%; height: 200px;">
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${favorite.boards[0].isAuction eq 0}">
                                                    <p><span class="badge bg-danger">경매전</span>
                                                </c:when>
                                                <c:when test="${favorite.boards[0].isAuction eq 1}">
                                                    <p><span class="badge bg-danger">경매중</span>
                                                </c:when>
                                                <c:when test="${favorite.boards[0].isAuction eq 2}">
                                                    <p><span class="badge bg-danger">경매후</span>
                                                </c:when>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${favorite.boards[0].isLend eq 0}">
                                                    <span class="badge bg-success">대여전</span>
                                                </c:when>
                                                <c:when test="${favorite.boards[0].isLend eq 1}">
                                                    <span class="badge bg-success">대여중</span>
                                                </c:when>
                                                <c:when test="${favorite.boards[0].isLend eq 2}">
                                                    <span class="badge bg-success">대여후</span>
                                                </c:when>
                                            </c:choose>
                                            <p>
                                                <c:out value="${favorite.boards[0].itemName}"/>
                                                <fmt:formatNumber value="${favorite.boards[0].price}" pattern="#,###"/>원
                                            </p>
                                            <span>관심 <c:out value="${favorite.boards[0].interestCnt}"/></span>
                                            <span>조회 <c:out value="${favorite.boards[0].hits}"/></span>
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
                    <c:forEach var="favorite" items="${favorites}" varStatus="status" begin="${page.oneRecordPage-3}" end="${page.oneRecordPage}">
                        <div class="col-md-4">
                            <div class="card">
                                <h5 class="card-header">
                                    <c:out value="${favorite.boards[0].title}"/>
                                </h5>
                                <div class="card-body">
                                    <p class="card-text">
                                        <img src="/images/${favorite.boards[0].itemImage1}" alt="대체_텍스트" style="width: 100%; height: 200px;">
                                    </p>
                                </div>
                                <div class="card-footer">
                                    <c:choose>
                                        <c:when test="${favorite.boards[0].isAuction eq 0}">
                                            <p><span class="badge bg-danger">경매전</span>
                                        </c:when>
                                        <c:when test="${favorite.boards[0].isAuction eq 1}">
                                            <p><span class="badge bg-danger">경매중</span>
                                        </c:when>
                                        <c:when test="${favorite.boards[0].isAuction eq 2}">
                                            <p><span class="badge bg-danger">경매후</span>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${favorite.boards[0].isLend eq 0}">
                                            <span class="badge bg-success">대여전</span>
                                        </c:when>
                                        <c:when test="${favorite.boards[0].isLend eq 1}">
                                            <span class="badge bg-success">대여중</span>
                                        </c:when>
                                        <c:when test="${favorite.boards[0].isLend eq 2}">
                                            <span class="badge bg-success">대여후</span>
                                        </c:when>
                                    </c:choose>
                                    <p>
                                        <c:out value="${favorite.boards[0].itemName}"/>
                                        <fmt:formatNumber value="${favorite.boards[0].price}" pattern="#,###"/>원
                                    </p>
                                    <span>관심 <c:out value="${favorite.boards[0].interestCnt}"/></span>
                                    <span>조회 <c:out value="${favorite.boards[0].hits}"/></span>
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
