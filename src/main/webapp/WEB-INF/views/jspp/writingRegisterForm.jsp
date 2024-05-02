<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Title</title>

    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>
    <style>
        #map {
            width: 100%;
            height: 400px;
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

<br><br>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <form action="/board" enctype="multipart/form-data" method="post">
                        <fieldset>
                            <legend class="text-center">글 등록</legend> <br><br>
                            <fieldset>
                                <p>거래 방식</p>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="board_category_id" id="board_category_id1" value="1" checked="">
                                    <label class="form-check-label" for="optionsRadios1">빌려드려요</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="board_category_id" id="board_category_id2" value="2">
                                    <label class="form-check-label" for="optionsRadios2">빌려주세요</label>
                                </div>
                            </fieldset>

                            <div>
                                <label for="exampleInputEmail1" class="form-label mt-4">제목</label>
                                <input type="input" class="form-control" id="title" name="title"   placeholder="글 제목">
                            </div>
                            <div>
                                <label for="exampleInputPassword1" class="form-label mt-4">상품명</label>
                                <input type="input" class="form-control" id="item_name" name="item_name" placeholder="상품명" autocomplete="off">
                                <small id="emailHelp" class="form-text text-muted">상품명을 정확하게 입력해주세요 (예시 : 선풍기)</small>
                            </div>

                            <div>
                                <label for="exampleInputPassword1" class="form-label mt-4">희망 가격</label>
                                <input type="input" class="form-control" id="price" name="price" oninput="formatPrice()" placeholder="희망 가격" autocomplete="off">
                            </div>

                            <div>
                                <label for="item_category_id" class="form-label mt-4">상품 카테고리</label>
                                <select class="form-select" id="item_category_id" name="item_category_id">
                                    <option value="1">도서</option>
                                    <option value="2">생활용품</option>
                                    <option value="3">남성 의류</option>
                                    <option value="4">여성 의류</option>
                                    <option value="5">디지털 기기</option>
                                </select>
                            </div>

                            <br>

                            <div class="mb-3">
                                <label for="fileInput1" class="form-label">상품 이미지1</label>
                                <input class="form-control" type="file" id="fileInput1" name="fileInput">
                            </div>
                            <div class="mb-3">
                                <label for="fileInput2" class="form-label">상품 이미지2</label>
                                <input class="form-control" type="file" id="fileInput2" name="fileInput">
                            </div>

                            <div class="mb-3">
                                <label for="fileInput3" class="form-label">상품 이미지3</label>
                                <input class="form-control" type="file" id="fileInput3" name="fileInput">
                            </div>

                            <div>
                                <label for="exampleTextarea" class="form-label mt-4">자세한 설명</label>
                                <textarea class="form-control" id="content" name="content" rows="10"></textarea>
                            </div>

                            <br>

                            <p>희망 거래 장소</p>
                            <div id="map"></div>
                            <input type="hidden" id="latitude" name="latitude" >
                            <input type="hidden" id="longitude" name="longitude" >
                            <input type="hidden" id="longitude" name="writer" value="hong">
                            <br>

                            <fieldset class="row">
                                <div class="col">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="isMegaphone" name="isMegaphone">
                                        <label class="form-check-label" for="isMegaphone">확성기 사용</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="isAuction" name="isAuction">
                                        <label class="form-check-label" for="isAuction">경매(경매 참여 인원이 2명 이상이 되면 경매가 자동 시작 됩니다)</label>

                                    </div>
                                </div>
                            </fieldset>


                            <br>

                            <div class="row">
                                <div class="col">
                                    <label for="returnDate">반납 날짜</label>
                                    <input type="date" class="form-control" id="returnDate" name="returnDate">
                                </div>
                                <div class="col">
                                    <label for="deadline">경매 마감 날짜</label>
                                    <input type="date" class="form-control" id="deadline" name="deadline">
                                </div>
                            </div>

                            <br>

                            <button type="submit" class="btn btn-primary">글 등록</button>
                        </fieldset>
                    </form>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
    </div>
</div>

</body>


<script>
    // 경매 마감 날짜 입력란 비활성화
    document.getElementById('deadline').disabled = true;

    // 경매 스위치 체크 이벤트
    document.getElementById('isAuction').addEventListener('change', function() {
        // 경매 스위치가 활성화되었을 때
        if (this.checked) {
            // 경매 마감 날짜 입력란 활성화
            document.getElementById('deadline').disabled = false;
        } else {
            // 경매 스위치가 비활성화되었을 때
            // 경매 마감 날짜 입력란 비활성화 및 값 초기화
            document.getElementById('deadline').disabled = true;
            document.getElementById('deadline').value = '';
        }
    });

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
        center: new naver.maps.LatLng(37.5665, 126.9780), // 서울의 좌표
        zoom: 17 // 초기 줌 레벨
    };

    // 네이버 지도 생성
    var map = new naver.maps.Map('map', mapOptions);

    var marker = null; // 스탬프 마커
    var marker2 = null;

    marker2 = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.5665, 126.9780),
        map: map
    });

    // 정보 창 생성
    var infowindow2 = new naver.maps.InfoWindow({
        content: '<div style="padding:10px;">현재 위치</div>',
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
            content: '<div style="padding:10px;">거래 희망 위치</div>',
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


</html>
