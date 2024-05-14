<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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
                                    <a class="nav-link" href="#" style="color: black;">로그인</a>
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
       				<h3>회원 가입</h3>
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
                    <form name="signup" action="/user/signup" method="post" accept-charset-"utf-8">
                					<input type ="hidden" name="idDupChk" value="f">
                					<label for="exampleInputEmail1">
                						아이디
                					</label>
                            </div>
                                <div class="row">
                                    <div class="col-md-8 text start">
                                      <div class="form-group">

                					<input type="user_id" name="userId" class="form-control" id="user_id1" placeholder="아이디 입력(6~20자)" required/>

                                    </div>
                                    </div>
                                    <div class="col-md-4 text-start">
                                    <div class="form-group">
                                        <input type="button" value="중복체크" onclick="idDupPopup()" class="btn btn-primary">
                                        중복 확인
                                         </button>
                                         </div>
                                         </div>

                				</div>
                                <br>
                				<div class="form-group">
                                    <label for="exampleInputPassword1">비밀번호</label>
                                    <input type="password" name="pw" class="form-control" id="exampleInputPassword1" required />
                                </div>
                                <div id="passwordLengthError" class="text-danger"></div>
                                <br>
                                <div class="form-group">
                                    <label for="exampleInputPassword2">비밀번호 확인</label>
                                    <input type="password" class="form-control" id="exampleInputPassword2" />
                                    <div id="passwordMatchError" class="text-danger"></div>
                                </div>

                                <br>
                                <div class="form-group">

                                <label for="exampleInputName1">
                                    이름
                                </label>
                                <input type="text" name="name"class="form-control" id="exampleInputName1" required/>
                            </div>
                            <br>
                            <div class="form-group">

                                    <label for="exampleInputPhone_number1">
                                        전화번호
                                    </label>
                                    <input type="tel" name="phoneNumber" class="form-control" id="exampleInputPhone_number1" required />
                                </div>
                                <br>

                                <div class="form-group">
                                   <label for="myAroundHome">
                                   내 동네
                                   </label>
                                </div>

                                <div class="row">
                                    <div class="col-md-8 text-start">
                                        <div class="form-group">
                                            <input type="text" name="address" class="form-control" id="myAroundHome" placeholder="주소" required/>
                                        </div>
                                    </div>
                                    <div class="col-md-4 text-start">
                                        <div class="form-group">
                                            <button type="button" onclick="sample5_execDaumPostcode()" value="주소검색" class="btn btn-primary">
                                            위치검색
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <br>
                               <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
                                <br>
                                <div class="row">
                                    <div class="col text-center">
                                        <div class="form-group">
                                            <button type="submit"  value="회원가입" class="btn btn-info btn-block" style="width: 60%;">
                                                가입완료
                                            </button>
                                        </div>
                                    </div>
                                </div>
<div class="form-group">
    <input type="text" name="latitude" class="form-control" id="latitude" placeholder="위도를 입력하세요" style="display:none">
</div>
<div class="form-group">
    <input type="text" name="longitude" class="form-control" id="longitude" placeholder="경도를 입력하세요" style="display:none">

</div>



                			</form>
                			</form>

       		</div>
       		<div class="col-md-2">
                   		</div>
       		<div class="col-md-2">
       		</div>
       	</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1c08b45ccd77d7bdeca02bed5ff2979c&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


   function sample5_execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               var addr = data.address; // 최종 주소 변수

               // 주소 정보를 해당 필드에 넣는다.
               document.getElementById("myAroundHome").value = addr;
               // 주소로 상세 정보를 검색
               geocoder.addressSearch(data.address, function(results, status) {
                   // 정상적으로 검색이 완료됐으면
                   if (status === daum.maps.services.Status.OK) {
                       var result = results[0]; //첫번째 결과의 값을 활용

                       // 해당 주소에 대한 좌표를 받아서
                       var coords = new daum.maps.LatLng(result.y, result.x);

                       // Set latitude and longitude input values
                       document.getElementById("latitude").value = result.y;
                       document.getElementById("longitude").value = result.x;

                       // 지도를 보여준다.
                       mapContainer.style.display = "block";
                       map.relayout();
                       // 지도 중심을 변경한다.
                       map.setCenter(coords);
                       // 마커를 결과값으로 받은 위치로 옮긴다.
                       marker.setPosition(coords);
                   }
               });
           }
       }).open();
   }

</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var passwordInput = document.getElementById("exampleInputPassword1");
        var confirmPasswordInput = document.getElementById("exampleInputPassword2");
        var passwordLengthError = document.getElementById("passwordLengthError");
        var passwordMatchError = document.getElementById("passwordMatchError");

        function validatePassword() {
            if (passwordInput.value.length < 8) {
                passwordLengthError.textContent = "비밀번호는 8자 이상이어야 합니다.";
                return false;
            } else {
                passwordLengthError.textContent = "";
            }

            if (passwordInput.value !== confirmPasswordInput.value) {
                passwordMatchError.textContent = "비밀번호가 일치하지 않습니다.";
                return false;
            } else {
                passwordMatchError.textContent = "";
            }

            return true;
        }

        passwordInput.addEventListener("input", validatePassword);
        confirmPasswordInput.addEventListener("input", validatePassword);
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var form = document.getElementById("signupForm");
        var submitButton = document.getElementById("submitButton");

        function validateForm() {
            var isValid = form.checkValidity();
            if (isValid) {
                submitButton.removeAttribute("disabled");
            } else {
                submitButton.setAttribute("disabled", "disabled");
            }
        }

        form.addEventListener("input", validateForm);
    });
</script>



<script>
function idDupPopup(){
window.open('idDup.jsp','','width=200,height=300');
}
function memberSubmit(){
    var idDupChk= document.f1.userId.value;
    if(idDupChk =='t'){
    document.f1.submit();
    }else{
    alert('아이디 중복체크를 해주세요');
    }
    }
    </script>

</body>