<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="/js/menuControl.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
     <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>
      <script src="/js/notification.js"></script>
      <link rel="stylesheet" type="text/css" href="/css/notification.css">
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .form-group label {
            margin-bottom: 3px; /* 아래 여백 조정 */
        }
        .form-group p,
        .form-group span {
            font-size: 1.1em; /* 글꼴 크기 조정 */
        }
        #map {
            width: 100%;
            height: 400px;
        }
    </style>
</head>

<script>

    var map;
    var marker;
    var selectedAddress = '';
    var lat, lng;

    $(document).ready(function(){
        var passwordsMatch = false;

        function comparePasswords() {
            var pw = $("#pw").val();
            var pwConfirm = $("#pwConfirm").val();
            var message = $("#error-password");
            var successMessage = $(".valid-feedback");
            var pwField = $("#pw");
            var pwConfirmField = $("#pwConfirm");

            // 값이 일치하는지 확인
            if (pw === pwConfirm && pw.trim() !== "") {
                passwordsMatch = true;
                pwField.removeClass("is-invalid").addClass("is-valid");
                pwConfirmField.removeClass("is-invalid").addClass("is-valid");
                message.html("");
                successMessage.html("비밀번호가 일치합니다");
            } else if(pw.trim() === "" || pwConfirm.trim() === ""){
                passwordsMatch = false;
                pwField.removeClass("is-valid").addClass("is-invalid");
                pwConfirmField.removeClass("is-valid").addClass("is-invalid");
                successMessage.html("");
                message.html("비밀번호를 입력해주세요");
            }else{
                passwordsMatch = false;
                pwField.removeClass("is-valid").addClass("is-invalid");
                pwConfirmField.removeClass("is-valid").addClass("is-invalid");
                successMessage.html("");
                message.html("비밀번호가 불일치 합니다 다시 입력하세요");
            }
        }
        $("#compare").click(function(){
            comparePasswords();
        });

        $("#editButton").click(function(){
            if (!passwordsMatch) {
                alert("중복체크를 해주세요.");
                return;
            }
            var pw = $("#pw").val();

            var updateUserDTO = {
                userId: "${userId}",
                name: $("input[name='name']").val(),
                pw: pw,
                phoneNumber: $("input[name='phoneNumber']").val(),
                latitude: $("input[name='latitude']").val(),
                longitude: $("input[name='longitude']").val()
            };

            $.ajax({
                type: "PUT",
                url: "/user/${userId}",
                contentType: "application/json",
                data: JSON.stringify(updateUserDTO),
                success: function(response) {
                    console.log("서버 응답:", response);
                    if(response.message === "ok") {
                        alert("수정하셧습니다");
                        window.location.href = "/user/${userId}";
                    } else {
                        alert("수정에 실패하셧습니다");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("에러 발생:", error);

                    var errorNameMessage = $("#error-name");
                    var errorPwMessage = $("#error-password");
                    var errorPhoneNumberMessage = $("#error-phoneNumber");

                    $("#name").removeClass("is-invalid").addClass("is-valid");
                    $("#pw").removeClass("is-invalid").addClass("is-valid");
                    $("#phoneNumber").removeClass("is-invalid").addClass("is-valid");
                    errorNameMessage.html("");
                    errorPwMessage.html("");
                    errorPhoneNumberMessage.html("");

                    var errors = xhr.responseJSON;
                    if (errors.name) {
                       $("#name").removeClass("is-valid").addClass("is-invalid");
                       errorNameMessage.html(errors.name);
                    }
                    if (errors.pw) {
                        $("#pw").removeClass("is-valid").addClass("is-invalid");
                        errorPwMessage.html(errors.pw);
                    }
                    if (errors.phoneNumber) {
                       $("#phoneNumber").removeClass("is-valid").addClass("is-invalid");
                       errorPhoneNumberMessage.html(errors.phoneNumber);
                    }
                }
            });
        });

        $("#cancelButton").click(function(){
            window.location.href = "/user/${userId}";
        });

        // 모달이 열릴 때 이벤트를 감지
        $('#mapModal').on('shown.bs.modal', function () {
            // 모달 body의 크기를 가져옴
            var modalBody = $(this).find('.modal-body');
            var width = modalBody.width();

            // 지도의 크기를 동적으로 설정
            $('#map').css({
                width: width
            });

            // 네이버 지도 초기화
            var mapOptions = {
                center: new naver.maps.LatLng(37.3595704, 127.105399),
                zoom: 17,
                zoomControl: true,
                zoomControlOptions: {
                    position: naver.maps.Position.TOP_RIGHT
                },
                mapDataControl: false
            };

            // 네이버 지도 객체 생성
            map = new naver.maps.Map('map', mapOptions);

            // 이전에 저장된 위치가 있으면 마커를 생성하여 표시
            var savedLat = parseFloat($('#latitude').val());
            var savedLng = parseFloat($('#longitude').val());
            if (savedLat && savedLng) {
                var savedPosition = new naver.maps.LatLng(savedLat, savedLng);
                marker = new naver.maps.Marker({
                    position: savedPosition,
                    map: map
                });
                map.setCenter(savedPosition);
            }

            // 지도 클릭 이벤트 추가
            naver.maps.Event.addListener(map, 'click', function(e) {
                var latlng = e.coord; // 클릭한 위치의 경도와 위도

                // 기존 마커가 있으면 제거
                if (marker) {
                    marker.setMap(null);
                }

                // 새로운 마커 생성
                marker = new naver.maps.Marker({
                    position: latlng,
                    map: map
                });

               // 위도와 경도를 hidden input에 설정
               lat=latlng.lat();
               lng=latlng.lng();

               $.ajax({
                   url: "/address?latitude=" + latlng.lat() + "&longitude=" + latlng.lng(),
                   type: "GET",

                   dataType: "json",
                   success: function(response) {
                       console.log(response);
                       selectedAddress = response.address.replace(/^"(.*)"$/, '$1');
                   },
                   error: function(xhr, status, error) {
                       console.error(xhr.responseText);
                   }
               });
            });
        });

        // 버튼 클릭 시 모달 창 열기
        $("#openMapBtn").click(function(){
            $("#mapModal").modal("show");
        });

         // 완료 버튼 클릭 시 모달 창 닫기
        $("#completeBtn").click(function(){
            $('#latitude').val(lat);
            $('#longitude').val(lng);
            $("#myAroundHome").val(selectedAddress);
            $("#mapModal").modal("hide");
        });

    });
</script>

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
                                                 <a class="nav-link" href="#" id="notificationIcon" style="position: relative;">
                                                     <img src="/images/icon/notificationIcon.png" style="width:30px; height:30px;">
                                                     <span id="notificationMessage" class="notification-message" >여기에 알림 메시지를 입력하세요.</span>
                                                     <span id="messageCount" class="badge badge-danger" style="color: white; background-color: red; position: absolute; top: -0px; left: -10px; width: 20px; height: 20px; border-radius: 50%; text-align: center; line-height: 10px; font-size: 12px;"></span>
                                                 </a>
                                             </c:if>
                                         </li>

                                         <li>
                                             <div id="messageContainer" style="display: none;">

                                             </div>
                                         </li>
                                         <li class="nav-item">
                                             <c:if test="${loggedIn}">
                                                 <a class="nav-link" href="/chatList/${userId}">
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

                     </ul>
                 </nav>
             </div>
   <br><br>

   <div class="row">
       		<div class="col-md-2">
       		</div>
       		<div class="col-md-8 text-center">

       		<span>
       				<h3>
       				    <c:out value="${userId}"/>님의 수정페이지
       				</h3>
       		</span>
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
           <div class="col-md-2">
           </div>
           <div class="col-md-4">
                   <div class="form-group">
                       <label for="inputDefault">이름</label>
                       <input type="text" class="form-control" name="name" id="name" value="${edit.name}">
                       <div class="invalid-feedback" id="error-name"></div>
                   </div>
                   <br>
                   <div class="form-group">
                      <label for="inputDefault">비밀번호</label>
                      <input type="password" class="form-control" id="pw" name="pw" value="${edit.pw}">
                      <div class="valid-feedback"></div>
                      <div class="invalid-feedback" id="error-password"></div>
                   </div>
                   <br>
                   <div class="form-group">
                     <label for="inputDefault">비밀번호 확인</label>
                     <div class="row">
                       <div class="col-md-8 text-start">
                           <div class="form-group">
                               <input type="password"  name="pwConfirm" id="pwConfirm" class="form-control">
                           </div>
                       </div>
                       <div class="col-md-4 text-start">
                           <div class="form-group">
                               <button class="btn btn-primary" type="button" id="compare">중복체크</button>
                           </div>
                       </div>
                     </div>
                   </div>
                   <br>
                   <div class="form-group">
                       <label for="inputDefault">전화번호</label>
                       <input type="text" class="form-control" name="phoneNumber" id="phoneNumber" value="${edit.phoneNumber}">
                       <div class="invalid-feedback" id="error-phoneNumber"></div>
                   </div>
                   <br>
                   <div class="form-group">
                       <label for="inputDefault" style="margin-top:10px">
                           내 동네
                       </label>
                       <div class="row">
                          <div class="col-md-8 text-start">
                              <div class="form-group">
                                  <input type="input" class="form-control" id="myAroundHome" value="${edit.address}" placeholder="내 동네를 설정해주세요"/>
                              </div>
                          </div>
                          <div class="col-md-4 text-start">
                              <div class="form-group">
                                  <button type="submit" class="btn btn-primary" id="openMapBtn">
                                      위치검색
                                  </button>
                              </div>
                          </div>
                          <div id="mapModal" class="modal fade" tabindex="-1" role="dialog">
                              <div class="modal-dialog modal-lg" role="document">
                                  <div class="modal-content">
                                      <div class="modal-header">
                                          <h5 class="modal-title">지도</h5>
                                      </div>
                                      <div class="modal-body">
                                          <div id="map"></div>
                                      </div>
                                      <div class="modal-footer">
                                          <button type="button" class="btn btn-primary" id="completeBtn">완료</button>
                                      </div>
                                  </div>
                              </div>
                          </div>
                          <input type="hidden" name="latitude" id="latitude" value="${edit.latitude}">
                          <input type="hidden" name="longitude" id="longitude" value="${edit.longitude}">
                      </div>
                   </div>
               <br>
               <div class="row">
                   <div class="col-md-6 text-start">
                       <div class="form-group">
                           <button type="submit" class="btn btn-primary" id="editButton">
                               수정
                           </button>
                       </div>
                   </div>
                   <div class="col-md-6 text-end">
                       <div class="form-group">
                           <button type="submit" class="btn btn-primary" id="cancelButton">
                               취소
                           </button>
                       </div>
                   </div>
               </div>
           </div>
           <div class="col-md-2">
           </div>
           <div class="col-md-2">
           </div>
       </div>
   </div>


</body>
