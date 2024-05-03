<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="css/bootstrap.min.css">
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

       		<span>
       				<h3>로그인</h3>
       		</span>
       		</div>
       		<div class="col-md-2">
       		</div>
       	</div>

       	<br><br>

   <div class="container-fluid">
       	<div class="row">
       		<div class="col-md-2">
       		    <div class="accordion" id="accordionExample">
                     <div class="accordion-item">
                       <h2 class="accordion-header" id="headingOne">
                         <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                           여기 뭐 넣지?
                         </button>
                       </h2>
                       <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
                         <div class="accordion-body">
                            <div class="list-group">
                              <a href="#" class="list-group-item list-group-item-action">내 정보</a>
                              <a href="#" class="list-group-item list-group-item-action">관심 목록</a>
                              <a href="#" class="list-group-item list-group-item-action">빌려준 목록</a>
                              <a href="#" class="list-group-item list-group-item-action">빌린 목록</a>
                              <a href="#" class="list-group-item list-group-item-action">채팅 목록</a>
                              <a href="#" class="list-group-item list-group-item-action">내 경매 목록</a>
                            </div>
                         </div>
                       </div>
                     </div>
       		    </div>
       		</div>
       		<div class="col-md-2">
       		</div>
       		<div class="col-md-4">
       		    <div class="form-group">

                					<label for="exampleInputEmail1">
                						아이디
                					</label>
                					<input type="text" class="form-control" id="userid1" />
                				</div>
                                <br>
                				<div class="form-group">

                					<label for="exampleInputPassword1">
                						비밀번호
                					</label>
                					<input type="password" class="form-control" id="exampleInputPassword1" />
                				</div>
<br>
<label for="remember-check">
                <input type="checkbox" id="remember-check">아이디 저장하기
            </label>

                                <br>
                                <br>

                               <div class="row">

    <div class="col text-center">
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block" style="width: 100%;"> <!-- width: 100%;로 버튼을 가로로 확장 -->
                login
            </button>
        </div>
    </div>
</div>
                                     <br>

                                     <div class="row">
                                    <div class="col-md text-center">
                                        <div class="form-group">

                                            <button type="submit" onclick="location.href='signup'"  class="btn btn-info" style="width: 100%;">


                                            회원가입
                                            </button>
                                        </div>
                                    </div>
</div>


                			</form>

       		</div>
       		<div class="col-md-2">
                   		</div>
       		<div class="col-md-2">
       		</div>
       	</div>


</body>