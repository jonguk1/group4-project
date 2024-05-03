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
