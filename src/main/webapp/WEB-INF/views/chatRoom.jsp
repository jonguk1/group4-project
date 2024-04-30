<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootswatch@5.0.0/dist/minty/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- header -->
<div class="container bg-green text-center">
    <div class="row">
        <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
            <nav class="navbar navbar-expand-lg bg-green" data-bs-theme="light" style="display: block; margin-left: 0;margin-right: auto;">
                <a class="navbar-brand" href="#"><img src="/img/logo.png" width="20%"/></a>
            </nav>
        </div>
        <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
            <form class="d-flex">
                <div class="input-group mt-3"> <!-- 여기에 mt-3 클래스 추가 -->
                    <input class="form-control me-2" type="search" placeholder="빌리고 싶은 물건을 입력하세요">
                    <button class="btn btn-secondary" type="submit">검색</button>
                </div>
            </form>
        </div>
        <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
            <nav class="navbar navbar-expand-lg bg-green">
                <div class="container-fluid">
                    <div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: black;"><img src="/img/noti.gif" width="45px" alt="알림"></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: black;">로그아웃</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: black;"><img src="/img/chat.png" width="45px" alt="채팅"></a>
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
                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">경매해요</a>
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
<!-- header -->

<!-- chat -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<div class="row">
				<div class="col-md-6">
					<h3>
						자전거 팔아요
					</h3><img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
					<h2>
						자전거 팔아요
					</h2>
					<p>
						혈육 군대간 사이에 처분합니다
					</p>
					<p>
						<a class="btn" href="#">View details »</a>
					</p>
				</div>
				<div class="col-md-6">
					<div class="row">
						<div class="col-md-1">
                        	<img src="/img/back.png" width="100%" height="100%" />
                        </div>
                        <div class="col-md-11">
                        	 <div class="breadcrumb" >
                                <h7 style="color:white; text-align: center;">
                                   ㅇㅇㅇ님과의 채팅
                                </h7>
                             </div>
                        </div>
					</div>
					<div class="row">
						<div class="col-md-2">
							<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" width="100%" height="100%" />
						</div>
						<div class="col-md-2">
							<li class="nav-item dropdown" style="list-style: none;">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">대여전</a>
                                <div class="dropdown-menu" style="">
                                  <a class="dropdown-item" href="#">대여중</a>
                                  <a class="dropdown-item" href="#">대여완료</a>
                                </div>
                              </li>
						</div>
						<div class="col-md-6">
						    <h7>상세글 제목 출력하기</h7>
						</div>
						<div class="col-md-1">
							<button type="button" class="btn btn-warning">
								<img src="/img/report.png"/>
							</button>
						</div>
						<div class="col-md-1">
						    <button type="button" class="btn btn-danger">
                            	<img src="/img/block.png"/>
                            </button>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
						    <textarea id="w3review" name="w3review" rows="10" cols="40">채팅창 표현하기</textarea>
						</div>
					</div>
					<div class="row">
						<div class="input-group mb-3">
						    <li class="nav-item dropdown" style="list-style: none;">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                    <img src="/img/plus.png"/>
                                </a>
                                <div class="dropdown-menu" style="">
                                  <a class="dropdown-item" href="#">파일첨부</a>
                                  <a class="dropdown-item" href="#">예약하기</a>
                                  <a class="dropdown-item" href="#">약속장소</a>
                                </div>
                              </li>
                            <input type="text" class="form-control" placeholder="채팅을 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
                            <button class="btn btn-primary" type="submit" id="button-addon2">전 송</button>
                        </div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
</div>