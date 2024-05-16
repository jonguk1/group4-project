<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.min.css">

    <meta charset="UTF-8">
    <title>Title</title>

    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>
    <style>
        #map {
            width: 100%;
            height: 400px;
        }
    </style>

    <script>

    </script>
</head>

<body>
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
<br><br>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <form action="/board/edit" enctype="multipart/form-data" method="post">

                        <fieldset>
                            <legend class="text-center">글 등록</legend> <br><br>
                            <fieldset>
                                <p>거래 방식</p>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="boardCategoryId" id="boardCategoryId1" value="1" >
                                    <label class="form-check-label" for="optionsRadios1">빌려드려요</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="boardCategoryId" id="boardCategoryId2" value="2">
                                    <label class="form-check-label" for="optionsRadios2">빌려주세요</label>
                                </div>
                            </fieldset>

                            <div>
                                <label for="title" class="form-label mt-4">제목</label>
                                <c:if test="${postRegistrationBindingResult.hasFieldErrors('title')}">
                                    <div>
                                        <span class="badge bg-danger">${postRegistrationBindingResult.getFieldError('title').defaultMessage}</span>
                                    </div>
                            </c:if>
                                <input type="input" class="form-control" id="title" name="title" value="${postById.title}" placeholder="글 제목" autocomplete="off">

                            </div>
                            <div>
                                <label for="item_name" class="form-label mt-4">상품명</label>
                                <c:if test="${postRegistrationBindingResult.hasFieldErrors('itemName')}">
                                    <div>
                                        <span class="badge bg-danger">${postRegistrationBindingResult.getFieldError('itemName').defaultMessage}</span>
                                    </div>
                                </c:if>
                                <input type="text" class="form-control" id="itemName" name="itemName" value="${postById.itemName}" placeholder="상품명" autocomplete="off">
                                <small id="itemNameHelp" class="form-text text-muted">상품명을 정확하게 입력해주세요 (예시 : 선풍기)</small>

                            </div>

                            <div>
                                <label for="price" class="form-label mt-4">희망 가격</label>
                                <c:if test="${postRegistrationBindingResult.hasFieldErrors('price')}">
                                    <div><span class="badge bg-danger">${postRegistrationBindingResult.getFieldError('price').defaultMessage}</span></div>
                                </c:if>
                                <div class="input-group mb-3">
                                <span class="input-group-text">₩</span>
                                <input type="input" class="form-control" id="price" name="price" value="${postById.price}" aria-label="Amount (to the nearest dollar)" oninput="formatPrice()" placeholder="희망 가격" autocomplete="off">
                                </div>
                            </div>

                            <div>
                                <label for="itemCategoryId" class="form-label mt-4">상품 카테고리</label>
                                <select class="form-select" id="itemCategoryId" name="itemCategoryId">
                                </select>
                            </div>

                            <br>

                           <div class="row">
                               <div class="col-md-4">
                                   <div class="text-center" id="existingProductImage1">기존 상품 이미지1</div>

                                   <c:if test="${postById.itemImage[0] ne null}">
                                       <img src="${postById.itemImage[0]}" class="changingImage1" style="width:320px; height:300px;">
                                   </c:if>

                                   <c:if test="${postById.itemImage[0] eq null}">
                                       <img src="/images/icon/noImage.png" class="changingImage1" style="width:320px; height:300px;">
                                   </c:if>
                               </div>
                               <div class="col-md-4">
                                   <div class="text-center" id="existingProductImage2">기존 상품 이미지2</div>
                                   <c:if test="${postById.itemImage[1] ne null}">
                                       <img src="${postById.itemImage[1]}" class="changingImage2" style="width:320px; height:300px;">
                                   </c:if>

                                   <c:if test="${postById.itemImage[1] eq null}">
                                       <img src="/images/icon/noImage.png" class="changingImage2" style="width:320px; height:300px;">
                                   </c:if>
                               </div>
                               <div class="col-md-4">
                                   <div class="text-center" id="existingProductImage3">기존 상품 이미지3</div>
                                   <c:if test="${postById.itemImage[2] ne null}">
                                       <img src="${postById.itemImage[2]}" class="changingImage3" style="width:320px; height:300px;">
                                   </c:if>

                                   <c:if test="${postById.itemImage[2] eq null}">
                                       <img src="/images/icon/noImage.png" class="changingImage3" style="width:320px; height:300px;">
                                   </c:if>
                               </div>
                           </div>

                            <br>

                            <div class="mb-3">
                                <label for="fileInput1" class="form-label">수정할 상품 이미지1</label>&nbsp;&nbsp;
                                <button type="button" class="btn btn-dark" id="updateExistingImage1">기존 이미지 선택</button>
                                <input class="form-control" type="file" id="fileInput1" name="fileInput" >

                            </div>
                            <div class="mb-3">
                                <label for="fileInput2" class="form-label">수정할 상품 이미지2</label>&nbsp;&nbsp;
                                <button type="button" class="btn btn-dark" id="updateExistingImage2">기존 이미지 선택</button>
                                <input class="form-control" type="file" id="fileInput2" name="fileInput" >

                            </div>

                            <div class="mb-3">
                                <label for="fileInput3" class="form-label">수정할 상품 이미지3</label>&nbsp;&nbsp;
                                <button type="button" class="btn btn-dark" id="updateExistingImage3">기존 이미지 선택</button>
                                <input class="form-control" type="file" id="fileInput3" name="fileInput" >

                            </div>


                            <div>
                                <label for="exampleTextarea" class="form-label mt-4">자세한 설명</label>
                                <c:if test="${postRegistrationBindingResult.hasFieldErrors('content')}">
                                    <div><span class="badge bg-danger">${postRegistrationBindingResult.getFieldError('content').defaultMessage}</span></div>
                                </c:if>
                                <textarea class="form-control" id="content" name="content"  rows="10">${postById.content}</textarea>
                            </div>

                            <br>

                            <p>희망 거래 장소</p>
                            <c:if test="${postRegistrationBindingResult.hasFieldErrors('latitude')}">
                                <div><span class="badge bg-danger">${postRegistrationBindingResult.getFieldError('latitude').defaultMessage}</span></div>
                            </c:if>
                            <div id="map"></div>
                            <input type="hidden" id="latitude" name="latitude" >
                            <input type="hidden" id="longitude" name="longitude" >
                            <input type="hidden" id="longitude" name="writer" value="hong">
                            <br>

                            <div class="row">
                                <div class="col">
                                    <label for="returnDate">반납 날짜</label>
                                    <input type="date" class="form-control" id="returnDate" name="returnDate" value="${postById.returnDate}">
                                </div>
                                <div class="col">

                                    <c:if test="${postRegistrationBindingResult.hasFieldErrors('deadlineSetForAuctions')}">
                                        <div>
                                            <span class="badge bg-danger">${postRegistrationBindingResult.getFieldError('deadlineSetForAuctions').defaultMessage}</span>
                                        </div>
                                    </c:if>

                                </div>
                            </div>

                            <br>

                            <button type="submit" class="btn btn-primary">글 수정</button>

                            <br><br><br>
                        </fieldset>
                    </form>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
    </div>

</div>

    <script>
        $(document).ready(function() {


                    $('input[type="file"]').change(function(e){
                        var id = $(this).attr('id');
                        previewImage(this, id);
                    });

                    function previewImage(input, id) {


                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                if (id === 'fileInput1') {
                                    document.getElementById('existingProductImage1').innerText = '변경할 이미지1';
                                    var imgElement = document.querySelector('.changingImage1');
                                    imgElement.src = e.target.result;

                                } else if (id === 'fileInput2') {
                                    document.getElementById('existingProductImage2').innerText = '변경할 이미지2';
                                    var imgElement = document.querySelector('.changingImage2');
                                    imgElement.src = e.target.result;
                                } else if (id === 'fileInput3') {
                                    document.getElementById('existingProductImage3').innerText = '변경할 이미지3';
                                    var imgElement = document.querySelector('.changingImage3');
                                    imgElement.src = e.target.result;
                                }
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    document.getElementById('updateExistingImage1').addEventListener('click', function() {
                        document.getElementById('existingProductImage1').innerText = '기존 이미지1';
                        var imgElement = document.querySelector('.changingImage1');
                        var fileInput = document.getElementById('fileInput1');
                        if ("${postById.itemImage[0]}" === '' || "${postById.itemImage[0]}" === 'null') {
                            imgElement.src = "/images/icon/noImage.png";
                            fileInput.value = null;
                        } else {
                            imgElement.src = "${postById.itemImage[0]}";
                            fileInput.value = null;
                        }


                    });

                    document.getElementById('updateExistingImage2').addEventListener('click', function() {
                        document.getElementById('existingProductImage2').innerText = '기존 이미지2';
                        var imgElement = document.querySelector('.changingImage2');
                        var fileInput = document.getElementById('fileInput2');
                        if ("${postById.itemImage[1]}" === '' || "${postById.itemImage[1]}" === 'null') {
                            imgElement.src = "/images/icon/noImage.png";
                            fileInput.value = null;
                        } else {
                            imgElement.src = "${postById.itemImage[1]}";
                            fileInput.value = null;
                        }
                    });
                    document.getElementById('updateExistingImage3').addEventListener('click', function() {
                        document.getElementById('existingProductImage3').innerText = '기존 이미지3';
                        var imgElement = document.querySelector('.changingImage3');
                        var fileInput = document.getElementById('fileInput3');
                        if ("${postById.itemImage[2]}" === '' || "${postById.itemImage[2]}" === 'null') {
                            imgElement.src = "/images/icon/noImage.png";
                            fileInput.value = null;
                        } else {
                            imgElement.src = "${postById.itemImage[2]}";
                            fileInput.value = null;
                        }

                    });

                    $.ajax({
                        url: "/board/board-category",
                        type: "GET",
                        dataType: "json",
                        success: function(response) {
                            console.log(response);

                            $.each(response, function(index, value) {
                                $("#lendServe").append("<a class='dropdown-item' href='/board?boardCategoryId=1&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                                $("#lendServed").append("<a class='dropdown-item' href='/board?boardCategoryId=2&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                                if (value.itemCategoryId === ${postById.itemCategoryId}) {
                                    $("#itemCategoryId").append("<option value='" + value.itemCategoryId + "' selected>" + value.itemCategoryName + "</option>");
                                } else {
                                    $("#itemCategoryId").append("<option value='" + value.itemCategoryId + "'>" + value.itemCategoryName + "</option>");
                                }
                            });
                        },
                        error: function(xhr, status, error) {
                           console.error("요청 실패:", status, error);
                        }
                    });
                });

         var boardCategoryId = "${postById.boardCategoryId}";

         if (boardCategoryId === "1") {
             document.getElementById("boardCategoryId1").checked = true;
         } else if (boardCategoryId === "2") {
             document.getElementById("boardCategoryId2").checked = true;
         }

        function formatPrice() {
            // 입력 필드에서 값을 가져옴
            let input = document.getElementById('price').value;

            // 쉼표를 추가하여 형식 변환
            let formattedPrice = input.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");

            // 변환된 값을 다시 입력 필드에 설정
            document.getElementById('price').value = formattedPrice;
        }

        // 지도를 표시할 영역을 설정
        // 클릭한 위치의 위도와 경도를 저장할 변수
        var clickedLatitude = null;
        var clickedLongitude = null;

        var mapOptions = {
            center: new naver.maps.LatLng(${postById.latitude}, ${postById.longitude}), // 서울의 좌표
            zoom: 17 // 초기 줌 레벨
        };

        // 네이버 지도 생성
        var map = new naver.maps.Map('map', mapOptions);

        var marker = null; // 스탬프 마커
        var marker2 = null;

        marker2 = new naver.maps.Marker({
            position: new naver.maps.LatLng(${postById.latitude}, ${postById.longitude}),
            map: map
        });

        // 정보 창 생성
        var infowindow2 = new naver.maps.InfoWindow({
            content: '<div style="padding:10px;">거래 위치</div>',
            backgroundColor: '#fff',
            borderColor: '#000',
            anchorSize: new naver.maps.Size(0, 0),
            anchorSkew: true
        });
        // 정보 창을 지도에 열어둠
        infowindow2.open(map, marker2);

        // 클릭 이벤트 핸들러 추가
        naver.maps.Event.addListener(map, 'click', function(e) {
            // 클릭한 위치의 좌표 가져오기
            var latlng = e.coord;

            // 이전에 찍은 스탬프 마커가 있으면 지우기
            if (marker !== null) {
                marker.setMap(null);
            }

            // 마커 생성
            marker = new naver.maps.Marker({
                position: latlng,
                map: map
            });

            // 클릭한 위치의 위도와 경도를 변수에 저장
            clickedLatitude = latlng.lat();
            clickedLongitude = latlng.lng();

            // 정보 창 생성
            var infowindow = new naver.maps.InfoWindow({
                content: '<div style="padding:10px;">거래 희망 위치 수정</div>',
                backgroundColor: '#fff',
                borderColor: '#000',
                anchorSize: new naver.maps.Size(0, 0),
                anchorSkew: true
            });

            // 정보 창을 마커 위에 표시
            infowindow.open(map, marker);

             // 위도와 경도를 hidden 필드에 설정
            document.getElementById('latitude').value = clickedLatitude;
            document.getElementById('longitude').value = clickedLongitude;
        });

        // 마커를 클릭했을 때 정보 창 열기
        naver.maps.Event.addListener(marker2, 'click', function() {
            infowindow2.open(map, marker2);
        });

        // 마커를 클릭했을 때 정보 창 열기
        naver.maps.Event.addListener(marker, 'click', function() {
            infowindow.open(map, marker);
        });

        // 지도를 클릭했을 때 정보 창이 닫히지 않도록 설정
        naver.maps.Event.addListener(map, 'click', function() {
            // 정보 창이 열려있을 때만 닫히도록 설정
            if (infowindow2.getMap()) {
                infowindow2.close();
            }
        });


    </script>
</body>
</html>
