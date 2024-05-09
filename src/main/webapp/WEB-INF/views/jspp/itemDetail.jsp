        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


        <!DOCTYPE html>
        <html lang="en">
        <head>

            <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>


            <link rel="stylesheet" href="/css/bootstrap.min.css">

            <meta charset="UTF-8">
            <title>Title</title>


        </head>

        <body>
            <div class="container bg-green text-center">
                <div class="row">
                    <div class="col" >
                        <nav class="navbar navbar-expand-lg bg-green" data-bs-theme="light">
                            <a href="/">
                            <img src="/images/logo.png" style="height: 55px; width: 55px; margin-right: 8px;">
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
                            <div class="dropdown-menu" id="lendServe">

                            </div>
                        </li>

                        <li class="nav-item dropdown text-center">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려드려요</a>
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


            <br>
            <div class="container-fluid">

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6 text-center">
                        <span class="badge bg-danger">
                            ${postById.isAuction}
                        </span>
                        <span class="badge bg-success">
                            ${postById.isLend}
                        </span>
                        <span>
                            <h2>
                            ${postById.title}
                            </h2>
                        </span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>
                <br>

                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 " >
                        <div id="myCarousel" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                <li data-target="#myCarousel" data-slide-to="1"></li>
                                <li data-target="#myCarousel" data-slide-to="2"></li>
                            </ol>

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner ">
                                  <c:if test="${not empty postById.itemImage[0]}">
                                    <div class="carousel-item active">
                                        <img src="${postById.itemImage[0]}" alt="Image 1" style="width: 100%; height: 500px;">

                                    </div>
                                  </c:if>

                                <c:if test="${not empty postById.itemImage[1]}">
                                    <div class="carousel-item">
                                        <img src="${postById.itemImage[1]}" alt="Image 1" style="width: 100%; height: 500px;">

                                    </div>
                                </c:if>

                                <c:if test="${not empty postById.itemImage[2]}">
                                    <div class="carousel-item">
                                        <img src="${postById.itemImage[2]}" alt="Image 1" style="width: 100%; height: 500px;">

                                    </div>
                                </c:if>
                            </div>

                            <!-- Left and right controls -->
                            <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">이전 사진</span>
                            </a>
                            <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">다음 사진</span>
                            </a>
                        </div>

                    </div>
                    <div class="col-md-3"></div>
                </div>

                <br>
                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">

                            <span>
                                 <img src="/images/people.png" alt="대체_텍스트" style="width: 50px;">
                            </span>

                                <span>${postById.writer}</span>

                            <span>
                                <button type="button" class="btn btn-primary" id="chat">채팅</button>
                            </span>

                            <span>
                                <button type="button" class="btn btn-primary">경매</button>
                            </span>

                            <span>
                                <button type="button" class="btn btn-primary">관심</button>
                            </span>

                            <span>
                                <img src="/images/ban.png" alt="대체" style="width: 50px; height:20px;">
                            </span>

                            <span>
                                <img src="/images/singo.png" alt="대체" style="width: 50px; height:20px;">
                            </span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span>${postById.regDate}</span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span id="address">서울특별시 종로구 혜화</span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <hr>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <p> ${postById.content}</p>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span>관심 ${postById.interestCnt}</span>
                        <span>채팅 12</span>
                        <span>조회 ${postById.hits}</span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                    <hr>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-4">
                                <span class="text-primary-emphasis">같은 물건 다른 글</span>
                            </div>
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-4 text-end">
                                <a class="nav-link"  href="/board?boardCategoryId=${postById.boardCategoryId}&itemCategoryId=${postById.itemCategoryId}"><span>전체글 보기</span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <br>
                <c:if test="${not empty postsBySearchTerm[0]}">
                <div class="row">
                        <div class="col-md-3">
                        </div>
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                        <h5 class="card-header">
                                            <span>${postsBySearchTerm[0].title}</span>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <img src="${postsBySearchTerm[0].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <p>${postsBySearchTerm[0].price}원</p>
                                            <p>${postsBySearchTerm[0].address}</p>
                                            <span>관심 ${postsBySearchTerm[0].interestCnt}</span>
                                            <span>채팅 41</span>
                                            <span>조회 ${postsBySearchTerm[0].hits}</span>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty postsBySearchTerm[1]}">
                                <div class="col-md-4">
                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                        <h5 class="card-header">
                                            <span>${postsBySearchTerm[1].title}</span>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <img src="${postsBySearchTerm[1].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <p>${postsBySearchTerm[1].price}원</p>
                                            <p>${postsBySearchTerm[1].address}</p>
                                            <span>관심 ${postsBySearchTerm[1].interestCnt}</span>
                                            <span>채팅 41</span>
                                            <span>조회 ${postsBySearchTerm[1].hits}</span>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                                <c:if test="${not empty postsBySearchTerm[2]}">
                                <div class="col-md-4">
                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                        <h5 class="card-header">
                                            <span>${postsBySearchTerm[2].title}</span>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <img src="${postsBySearchTerm[2].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <p>${postsBySearchTerm[2].price}원</p>
                                            <p>${postsBySearchTerm[2].address}</p>
                                            <span>관심 ${postsBySearchTerm[2].interestCnt}</span>
                                            <span>채팅 41</span>
                                            <span>조회 ${postsBySearchTerm[2].hits}</span>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-3">
                        </div>
                    </div>
                </c:if>
                <br>
                 <c:if test="${not empty postsBySearchTerm[3]}">
                <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="card border-light mb-3" style="max-width: 20rem;">
                                                <h5 class="card-header">
                                                    <span>${postsBySearchTerm[3].title}</span>
                                                </h5>
                                                <div class="card-body">
                                                    <p class="card-text">
                                                        <img src="${postsBySearchTerm[3].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                    </p>
                                                </div>
                                                <div class="card-footer">
                                                    <p>${postsBySearchTerm[3].price}원</p>
                                                    <p>${postsBySearchTerm[3].address}</p>
                                                    <span>관심 ${postsBySearchTerm[3].interestCnt}</span>
                                                    <span>채팅 41</span>
                                                    <span>조회 ${postsBySearchTerm[3].hits}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${not empty postsBySearchTerm[4]}">
                                        <div class="col-md-4">

                                            <div class="card border-light mb-3" style="max-width: 20rem;">
                                                <h5 class="card-header">
                                                    <span>${postsBySearchTerm[4].title}</span>
                                                </h5>
                                                <div class="card-body">
                                                    <p class="card-text">
                                                        <img src="${postsBySearchTerm[4].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                    </p>
                                                </div>
                                                <div class="card-footer">
                                                    <p>${postsBySearchTerm[4].price}원</p>
                                                    <p>${postsBySearchTerm[4].address}</p>
                                                    <span>관심 ${postsBySearchTerm[4].interestCnt}</span>
                                                    <span>채팅 41</span>
                                                    <span>조회 ${postsBySearchTerm[4].hits}</span>
                                                </div>
                                            </div>
                                            </c:if>
                                        </div>

                                        <c:if test="${not empty postsBySearchTerm[5]}">
                                        <div class="col-md-4">
                                            <div class="card border-light mb-3" style="max-width: 20rem;">
                                                <h5 class="card-header">
                                                    <span>${postsBySearchTerm[5].title}</span>
                                                </h5>
                                                <div class="card-body">
                                                    <p class="card-text">
                                                        <img src="${postsBySearchTerm[5].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                    </p>
                                                </div>
                                                <div class="card-footer">
                                                    <p>${postsBySearchTerm[5].price}원</p>
                                                    <p>${postsBySearchTerm[5].address}</p>
                                                    <span>관심 ${postsBySearchTerm[5].interestCnt}</span>
                                                    <span>채팅 41</span>
                                                    <span>조회 ${postsBySearchTerm[5].hits}</span>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                </div>
                            </div>

                </c:if>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <hr>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-4">
                                <span class="text-primary-emphasis">인기글</span>
                            </div>
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-4 text-end">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>
                <br>


                <br>
                <c:if test="${not empty hitPosts[0]}">
                <div class="row">
                                        <div class="col-md-3">
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                                        <h5 class="card-header">
                                                            <span>${hitPosts[0].title}</span>
                                                        </h5>
                                                        <div class="card-body">
                                                            <p class="card-text">
                                                                <img src="${hitPosts[0].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                            </p>
                                                        </div>
                                                        <div class="card-footer">
                                                            <p>${hitPosts[0].price}원</p>
                                                            <p>${hitPosts[0].address}</p>
                                                            <span>관심 ${hitPosts[0].interestCnt}</span>
                                                            <span>채팅 41</span>
                                                            <span>조회 ${hitPosts[0].hits}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${not empty hitPosts[1]}">
                                                <div class="col-md-4">
                                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                                        <h5 class="card-header">
                                                            <span>${hitPosts[1].title}</span>
                                                        </h5>
                                                        <div class="card-body">
                                                            <p class="card-text">
                                                                <img src="${hitPosts[1].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                            </p>
                                                        </div>
                                                        <div class="card-footer">
                                                            <p>${hitPosts[1].price}원</p>
                                                            <p>${hitPosts[1].address}</p>
                                                            <span>관심 ${hitPosts[1].interestCnt}</span>
                                                            <span>채팅 41</span>
                                                            <span>조회 ${hitPosts[1].hits}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                </c:if>
                                                <c:if test="${not empty hitPosts[2]}">
                                                <div class="col-md-4">
                                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                                        <h5 class="card-header">
                                                            <span>${hitPosts[2].title}</span>
                                                        </h5>
                                                        <div class="card-body">
                                                            <p class="card-text">
                                                                <img src="${hitPosts[2].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                            </p>
                                                        </div>
                                                        <div class="card-footer">
                                                            <p>${hitPosts[2].price}원</p>
                                                            <p>${hitPosts[2].address}</p>
                                                            <span>관심 ${hitPosts[2].interestCnt}</span>
                                                            <span>채팅 41</span>
                                                            <span>조회 ${hitPosts[2].hits}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                        </div>
                                    </div>

                                    </c:if>
                                    <br>
                                    <c:if test="${not empty hitPosts[3]}">
                                    <div class="row">
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <div class="card border-light mb-3" style="max-width: 20rem;">
                                                                            <h5 class="card-header">
                                                                                <span>${hitPosts[3].title}</span>
                                                                            </h5>
                                                                            <div class="card-body">
                                                                                <p class="card-text">
                                                                                    <img src="${hitPosts[3].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                                                </p>
                                                                            </div>
                                                                            <div class="card-footer">
                                                                                <p>${hitPosts[3].price}원</p>
                                                                                <p>${hitPosts[3].address}</p>
                                                                                <span>관심 ${hitPosts[3].interestCnt}</span>
                                                                                <span>채팅 41</span>
                                                                                <span>조회 ${hitPosts[3].hits}</span>
                                                                            </div>
                                                                        </div>
                                                                    <c:if test="${not empty hitPosts[4]}">
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="card border-light mb-3" style="max-width: 20rem;">
                                                                            <h5 class="card-header">
                                                                                <span>${hitPosts[4].title}</span>
                                                                            </h5>
                                                                            <div class="card-body">
                                                                                <p class="card-text">
                                                                                    <img src="${hitPosts[4].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                                                </p>
                                                                            </div>
                                                                            <div class="card-footer">
                                                                                 <p>${hitPosts[4].price}원</p>
                                                                                 <p>${hitPosts[4].address}</p>
                                                                                 <span>관심 ${hitPosts[4].interestCnt}</span>
                                                                                 <span>채팅 41</span>
                                                                                 <span>조회 ${hitPosts[4].hits}</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty hitPosts[5]}">
                                                                    <div class="col-md-4">
                                                                        <div class="card border-light mb-3" style="max-width: 20rem;">
                                                                            <h5 class="card-header">
                                                                                <span>${hitPosts[5].title}</span>
                                                                            </h5>
                                                                            <div class="card-body">
                                                                                <p class="card-text">
                                                                                    <img src="${hitPosts[5].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                                                                </p>
                                                                            </div>
                                                                            <div class="card-footer">
                                                                                 <p>${hitPosts[5].price}원</p>
                                                                                 <p>${hitPosts[5].address}</p>
                                                                                 <span>관심 ${hitPosts[5].interestCnt}</span>
                                                                                 <span>채팅 41</span>
                                                                                 <span>조회 ${hitPosts[5].hits}</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>
                                                        </div>
                                            </c:if>
                        <br><br>
                        <input type="hidden" name="latitude" id="latitude" value="${postById.latitude}">
                        <input type="hidden" name="longitude" id="longitude" value="${postById.longitude}">
            </div>
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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
                                $("#itemCategoryId").append("<option value='" + value.itemCategoryId + "'>" + value.itemCategoryName + "</option>")
                            });
                        }
                    });

                    var latitude = document.getElementById("latitude").value;
                    var longitude = document.getElementById("longitude").value;



                    $.ajax({
                        url: "/address?latitude=" + latitude + "&longitude=" + longitude,
                        type: "GET",

                        dataType: "json",
                        success: function(response) {
                            console.log(response);
                            $("#address").html(response.address.replace(/^"(.*)"$/, '$1'));
                        },
                        error: function(xhr, status, error) {
                            console.error(xhr.responseText);
                        }
                    });

                    $('#carousel-340598').carousel({
                        interval: 2000
                    });

                });

                $(document).on("click","#chat",function(){
                    //alert("글 상세번호 : " + "${postById.boardId}");
                    let boardId2 = ${postById.boardId};
                    //alert(boardId2);
                    $.ajax({
                      url: "../chat/chat2",
                      method: "GET",
                      data : boardId2,
                      success:function(data){
                        alert("이게뭐지: "+data);
                      }
                    })
                })

            </script>

        </body>