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

   <br><br><br>

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
            } else if (passwordInput.value.length > 20) {
                passwordLengthError.textContent = "비밀번호는 20자 이하여야 합니다.";
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
</body>