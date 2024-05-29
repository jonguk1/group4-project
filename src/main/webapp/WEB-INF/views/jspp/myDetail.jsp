<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="/js/menuControl.js"></script>
     <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
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

        .star-ratings-container {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
            margin-top:-5px;
        }

        .star-ratings {
          font-size: 28px;
          color: #aaa9a9;
          position: relative;
          unicode-bidi: bidi-override;
          width: max-content;
          -webkit-text-fill-color: transparent;
          -webkit-text-stroke-width: 1.3px;
          -webkit-text-stroke-color: #2b2a29;
        }

        .star-ratings,
        #avgRating {
            margin: 0; /* 기본 마진 제거 */
            display: inline-block; /* 가로로 배치하기 위해 인라인 블록 요소로 설정 */
        }

        #avgRating{
            font-size:20px;
            margin-top:10px;
        }

        .star-ratings-fill {
          color: #fff58c;
          padding: 0;
          position: absolute;
          z-index: 1;
          display: flex;
          top: 0;
          left: 0;
          overflow: hidden;
          -webkit-text-fill-color: gold;
        }

        .star-ratings-base {
          z-index: 0;
          padding: 0;
        }

    </style>
    <script>
        var map;
        var marker;
        var selectedAddress = '';
        var lat, lng;

        $(document).ready(function(){
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

                    lat=latlng.lat();
                    lng=latlng.lng();
                });
            });

            $("#chargeBtn").click(function(){
                $("#chargeModal").modal("show");
            });

            function askForChargeConfirmation() {
                return confirm("충전하시겠습니까?");
            }

            $("#completeChangeBtn").click(function(){
                var chargeAmount = $('#money').val();
                if (askForChargeConfirmation()) {
                    $.ajax({
                        url: "/user/${userId}/charge",
                        type: "PUT",
                        data: {
                            money: chargeAmount
                        },
                        dataType: "text",
                        success: function(response) {
                            if (response === 'ok') {
                                alert('충전이 완료되었습니다');
                                $("#chargeModal").modal("hide");
                                location.reload();
                            } else if (response === 'no') {
                                alert('충전이 실패하셧습니다');
                                return;
                            } else {
                                alert('알 수 없는 응답: ' + response);
                                return;
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error(xhr.responseText);
                        }
                    });
               } else {

               }
            });

            // 버튼 클릭 시 모달 창 열기
            $("#openMapBtn").click(function(){
                $("#mapModal").modal("show");
            });

            function askForConfirmation() {
                return confirm("수정하시겠습니까?");
            }

             // 완료 버튼 클릭 시 모달 창 닫기
            $("#completeBtn").click(function(){
             if (askForConfirmation()) {
                $.ajax({
                    url: "/user/${userId}/address",
                    type: "PUT",
                    data: {
                        latitude: lat,
                        longitude: lng
                    },
                    dataType: "text",
                    success: function(response) {
                        if (response === 'ok') {
                            alert('동네 변경이 완료되었습니다');
                            location.reload();
                        } else if (response === 'no') {
                            alert('동네 변경 실패!');
                            return;
                        } else {
                            alert('알 수 없는 응답: ' + response);
                            return;
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                }).done(function() {
                    // 사용자 주소 업데이트 후 주소 정보 가져오기
                    $.ajax({
                        url: "/address?latitude=" + lat + "&longitude=" + lng,
                        type: "GET",
                        dataType: "json",
                        success: function(response) {
                            console.log(response);
                            var selectedAddress = response.address.replace(/^"(.*)"$/, '$1');

                            // 주소 정보를 화면에 표시
                            $('#latitude').val(lat);
                            $('#longitude').val(lng);
                            $("#myAroundHome").val(selectedAddress);
                            $("#mapModal").modal("hide");
                        },
                        error: function(xhr, status, error) {
                            console.error(xhr.responseText);
                        }
                    });
                });
               } else {

               }
            });

             $('#deleteUserBtn').click(function() {
                if (confirm('탈퇴하시겠습니까?')) {
                    var userId = '${userId}';

                    $.ajax({
                        url: '/user/' + userId,
                        type: 'DELETE',
                        success: function(response) {
                            if (response === 'ok') {
                                alert('탈퇴가 완료되었습니다.');
                                window.location.href = '/login';
                            } else {
                                alert('탈퇴에 실패했습니다.');
                            }
                        },
                        error: function() {
                            alert('서버와 통신 중 오류가 발생했습니다.');
                        }
                    });
                }
             });

              const avgStarValue = parseFloat("${avgStar}");
              const ratingToPercent = (avgStarValue * 20) + 1.5;
              $('.star-ratings-fill').css('width', ratingToPercent + '%');
        });
    </script>
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

                                        <li>
                                            <div id="messageContainer" style="display: none;">

                                            </div>
                                        </li>
                                        <span id="notificationMessage" class="notification-message" >여기에 알림 메시지를 입력하세요.</span>
                                         <li class="nav-item">
                                             <c:if test="${loggedIn}">
                                                 <a class="nav-link" href="#" id="notificationIcon" style="position: relative;">
                                                      <img src="/images/icon/notificationIcon.png" style="width:30px; height:30px;">
                                                      <span id="notificationMessage" class="notification-message" >여기에 알림 메시지를 입력하세요.</span>
                                                      <span id="messageCount" class="badge badge-danger" style="color: white; background-color: red; position: absolute; top: -0px; left: -10px; width: 20px; height: 20px; border-radius: 50%; text-align: center; line-height: 10px; font-size: 12px;"></span>
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
                                                 <a class="nav-link" href="/user/${userId}" style="color: black;">${userId}님</a>
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
       				<c:if test="${userId eq sessionUserId}">
       				    <c:out value="${userId}"/>님의 정보
       				</c:if>
       				<c:if test="${userId ne sessionUserId}">
       				    <c:out value="${notSessionUserId}"/>님의 정보
       				</c:if>
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
           <c:if test="${userId eq sessionUserId}">
               <%@ include file="/WEB-INF/views/jspp/include/mypage.jsp"%>
           </c:if>
           </div>
           <div class="col-md-2">
           </div>
           <div class="col-md-4">
                   <div class="form-group">
                       <label for="inputDefault">아이디</label>
                       <p>&nbsp;<c:out value="${details.userId}"/></p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">이름</label>
                       <p>&nbsp;<c:out value="${details.name}"/></p>
                   </div>
                   <c:if test="${userId eq sessionUserId}">
                   <div class="form-group">
                       <label for="inputDefault">전화번호</label>
                       <p>&nbsp;<c:out value="${details.phoneNumber}"/></p>
                   </div>
                   </c:if>
                   <div class="form-group">
                       <label for="inputDefault">가입일</label>
                       <p>
                        &nbsp;<fmt:formatDate value="${details.regDate}" pattern="yyyy"/>년
                        <fmt:formatDate value="${details.regDate}" pattern="MM"/>월
                        <fmt:formatDate value="${details.regDate}" pattern="dd"/>일
                       </p>
                   </div>
                   <c:if test="${userId eq sessionUserId}">
                   <div class="form-group">
                       <label for="inputDefault">포인트</label>
                       <p>&nbsp;<fmt:formatNumber value="${details.point}" pattern="#,###"/> 포인트</p>
                   </div>
                   <div class="form-group">
                       <label for="inputDefault">충전한 돈</label>
                       <div>
                           <span>&nbsp;<fmt:formatNumber value="${details.money}" pattern="#,###"/> 원</span>
                           <button type="submit" class="btn btn-primary" id="chargeBtn">
                               충전
                           </button>
                       <div>
                   </div>
                   <div id="chargeModal" class="modal fade" tabindex="-1" role="dialog">
                       <div class="modal-dialog modal-lg" role="document">
                           <div class="modal-content">
                               <div class="modal-header">
                                   <h5 class="modal-title">충전하기</h5>
                               </div>
                               <div class="modal-body">
                                   <div style="display: flex; align-items: center;">
                                       <h5 style="margin-right: 10px;">충전할 금액:</h5>
                                       <input type="text" class="form-control" id="money" style="width:300px;border: 1px solid;"/>
                                       <h5 style="margin-left: 10px;">원</h5>
                                   </div>
                               </div>
                               <div class="modal-footer">
                                   <button type="button" class="btn btn-primary" id="completeChangeBtn">충전하기</button>
                               </div>
                           </div>
                       </div>
                   </div>
                   </c:if>
                   <div class="form-group">
                       <label for="inputDefault" style="margin-top:10px">
                           내 동네
                       </label>
                       <div class="row">
                          <div class="col-md-8 text-start">
                              <div class="form-group">
                                  <input type="input" class="form-control" id="myAroundHome" value="${details.address}" placeholder="내 동네를 설정해주세요"
                                  <c:if test="${userId ne sessionUserId}">readonly="readonly"</c:if>/>
                              </div>
                          </div>
                          <c:if test="${userId eq sessionUserId}">
                          <div class="col-md-4 text-start">
                              <div class="form-group">
                                  <button type="submit" class="btn btn-primary" id="openMapBtn">
                                      동네변경
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
                                            <button type="button" class="btn btn-primary" id="completeBtn">등록하기</button>
                                        </div>
                                    </div>
                                </div>
                          </div>
                          <input type="hidden" name="latitude" id="latitude" value="${details.latitude}">
                          <input type="hidden" name="longitude" id="longitude" value="${details.longitude}">
                          </c:if>
                      </div>
                      <c:if test="${userId ne sessionUserId}">
                      <br>
                      <div class="form-group">
                        <label for="inputDefault">평균 별점</label>
                            <div class="star-ratings-container">
                                <div class="star-ratings">
                                    <div class="star-ratings-fill space-x-2 text-lg">
                                        <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                    </div>
                                    <div class="star-ratings-base space-x-2 text-lg">
                                        <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                    </div>
                                </div>
                                <p id="avgRating">&nbsp;<fmt:formatNumber value="${avgStar}" pattern=".00"/>점</p>
                            </div>
                        </label>
                      </div>
                      </c:if>
                   </div>
               <br>
               <c:if test="${userId eq sessionUserId}">
               <div class="row">
                   <div class="col-md-6 text-start">
                       <form class="d-flex" method="get" action="/user/${userId}/edit">
                           <div class="form-group">
                               <button type="submit" class="btn btn-primary">
                                   회원수정
                               </button>
                           </div>
                       </form>
                   </div>
                   <div class="col-md-6 text-end">
                       <div class="form-group">
                           <button type="submit" class="btn btn-primary" id="deleteUserBtn">
                               회원탈퇴
                           </button>
                       </div>
                   </div>
               </div>
               </c:if>
           </div>
           <div class="col-md-2">
           </div>
           <div class="col-md-2">
           </div>
       </div>
   </div>


</body>
