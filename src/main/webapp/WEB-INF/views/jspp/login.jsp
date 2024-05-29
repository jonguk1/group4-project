<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>

<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="css/bootstrap.min.css">
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
                                            <c:if test="${not loggedIn}">
                                                <a class="nav-link" href="/login" style="color: black;">로그인</a>
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


                    </ul>
                </nav>
            </div>

   <br><br><br>


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
           </div>
           <div class="col-md-2">
           </div>
           <div class="col-md-4">
               <div class="board">
                   <form id="loginForm" onsubmit="return false;" method="post">
                       <div class="form-group">
                           <label for="userId">아이디</label>
                           <input type="text" name="userId" id="userId" class="form-control" />
                       </div>
                       <br>
                       <div class="form-group">
                           <label for="exampleInputPassword1">비밀번호</label>
                           <input type="password" name="pw" id="exampleInputPassword1" class="form-control" />
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
                                   <button type="button" id="loginBtn" class="btn btn-primary btn-block" style="width: 100%;">login</button>
                               </div>
                           </div>
                       </div>
                       <br>
                       <div class="row">
                           <div class="col-md text-center">
                               <div class="form-group">
                                   <button type="button" onclick="location.href='user/signup'" class="btn btn-info" style="width: 100%;">회원가입</button>
                               </div>
                           </div>
                       </div>
                   </form>
               </div>
           </div>
           <div class="col-md-2">
           </div>
           <div class="col-md-2">
           </div>
       </div>
   </div>


<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
window.onload = () => {
    document.querySelectorAll('#userId, #pw').forEach(element => {
        element.addEventListener('keyup', (e) => {
            if (e.keyCode === 13) {
                login();
            }
        })
    })


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
}

        document.addEventListener("DOMContentLoaded", function() {
            var userIdInput = document.getElementById("userId");
            var rememberCheck = document.getElementById("remember-check");
            var loginBtn = document.getElementById("loginBtn");

            // 세션저장소에 있으면 유저아이디 돌려줌
            if (sessionStorage.getItem("savedUserId")) {
                userIdInput.value = sessionStorage.getItem("savedUserId");
                rememberCheck.checked = true;
            }

            //로그인 기능
			function login() {
                        const form = document.getElementById('loginForm');

                        if (!form.userId.value || !form.pw.value) {
                            alert('아이디와 비밀번호를 모두 입력해 주세요.');
                            form.userId.focus();
                            return false;
                        }

                        $.ajax({
                            url: '/login',
                            type: 'POST',
                            dataType: 'json',
                            data: {
                                userId: form.userId.value,
                                pw: form.pw.value
                            },
                            async: false,
                            success: function(response) {
                                // If the remember checkbox is checked, save userId to session storage
                                if (rememberCheck.checked) {
                                    sessionStorage.setItem("savedUserId", form.userId.value);
                                } else {
                                    sessionStorage.removeItem("savedUserId");
                                }

                                location.href = '/board?boardCategoryId=1&itemCategoryId=1';
                            },
                            error: function(request, status, error) {
                                alert('아이디와 비밀번호를 확인해 주세요.');
                            }
                        });
                    }

                    loginBtn.addEventListener("click", login);
                });
            </script>
</body>
