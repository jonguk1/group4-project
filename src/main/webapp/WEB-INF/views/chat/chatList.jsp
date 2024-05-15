<!DOCTYPE html>
<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Navigation Bar</title>
    <!-- 부트 스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.0.0/dist/minty/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            /* 링크에 밑줄 없애기 */
            .list-group-item a {
                text-decoration: none;
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
                                                    <a class="nav-link" href="#">
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
    				<div class="col-md-4">
    					<h2>
    						상세
    					</h2>
    					<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
                        <img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
                        <img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
                        <br>
                        <br>
    					<button type="button" class="btn btn-md btn-success">닉네임</button>
    					<button type="button" class="btn btn-success">채팅</button>
    					<button type="button" class="btn btn-success">가격</button>
                        <br>
                        <br>
                        <h3>자전거 빌려 드립니다.</h3>
                        <p>상세 내용 ㅇㅁㄹㅇㅁㄴㄻㅇㄴㄹㅇㅁㄴㄻㅇㄴㄻㅇㄴㄻㄴㅇㄹㅇㄴㅁㄹ
                            ㅇㄻㅇㄴㄻㄴㅇㄻㄴㅇㄹㅇㄴㅇㅁㄻㅇㄴㄻㄴㅇㄹ
                            ㅇㄹㅇㅁㄴㄻㅇㄴㄻㄴㅇㄹㅇㅁㄴㄹㅇㅁㄴ리망너리;ㅏ멍ㄴ;리ㅓㅁㅇ;니ㅏ러;ㅣㅏㅇㅁ너리;ㅏ멍ㄴ리;ㅏ
                        </p>
    				</div>
    				<div class="col-md-4">
    					<h3>
    						채팅
    					</h3>

                        <ul class="list-group">
                            <li class="list-group-item list-group-item-primary d-flex justify-content-between align-items-center">
                                user 이름1
                                <span class="badge bg-primary rounded-pill">2024.04.26</span>
                            </li>

                            <a href="#"><li class="list-group-item list-group-item-light d-flex justify-content-between align-items-center">
                                ㅈㅅ
                                <span class="badge bg-primary rounded-pill"></span>
                              </li></a>


                            <li class="list-group-item list-group-item-primary d-flex justify-content-between align-items-center">
                                user 이름2

                                <span class="badge bg-primary rounded-pill">2024.04.26</span>
                            </li>
                            <a href="#"><li class="list-group-item list-group-item-light d-flex justify-content-between align-items-center">
                                네고되냐고 네고되냐고 네고되냐고 네고되냐고 네고되냐고 네고되냐고
                                <span class="badge bg-primary rounded-pill">8</span>
                              </li></a>


                            <li class="list-group-item list-group-item-primary d-flex justify-content-between align-items-center">
                                user 이름3
                                <span class="badge bg-primary rounded-pill">2024.04.26</span>
                            </li>

                            <a href="#"><li class="list-group-item list-group-item-light d-flex justify-content-between align-items-center">
                                자니...?
                                <span class="badge bg-primary rounded-pill">1</span>
                              </li></a>


                            <li class="list-group-item list-group-item-primary d-flex justify-content-between align-items-center">
                                user 이름4
                                <span class="badge bg-primary rounded-pill">2024.04.26</span>
                            </li>

                            <a href="a"><li class="list-group-item list-group-item-light d-flex justify-content-between align-items-center">
                                하이용
                                <span class="badge bg-primary rounded-pill">1</span>
                            </li></a>

                            <li class="list-group-item list-group-item-light d-flex justify-content-between align-items-center">
                                썸띵랜드 채팅입니당~
                            </li>
                        </ul>
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


