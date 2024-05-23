<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/notification.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/notification.css">

    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>
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
                            <a class="navbar-brand" href="/" style="color: black; font-size: 25px;" id="logo">썸띵랜드</a>
                        </nav>
                    </div>
                    <div class="col" >
                        <form class="d-flex" method="get" action="/board/search">
                            <div class="input-group mt-3">
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
                                            <a class="nav-link" href="#" id="notificationIcon">
                                                <img src="/images/icon/notificationIcon.png" style="width:30px; height:30px;">
                                                <span id="notificationMessage" class="notification-message" >여기에 알림 메시지를 입력하세요.</span>
                                            </a>
                                            </c:if>
                                        </li>
                                        <li>
                                            <div id="messageContainer" style="display: none;">

                                            </div>
                                        </li>

                                        <li class="nav-item">
                                            <c:if test="${loggedIn}">
                                                <a class="nav-link" href="#">
                                                    <img id="notificationIcon" src="/images/icon/chatIcon.png" style="width:37px; height:37px;">

                                                </a>
                                            </c:if>
                                        </li>

                                         <li class="nav-item">

                                             <c:if test="${loggedIn &&  !authorization}">
                                                 <a class="nav-link" href="/user/${userId}" style="color: black;">${userId}님</a>
                                             </c:if>
                                             <c:if test="${loggedIn &&  authorization}">
                                                <a class="nav-link" href="/report" style="color: black;">${userId}님</a>
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
                <div class="dropdown-menu"  id="lendServed">

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
				<div class="col-md-2 text-center">
				</div>
				<div class="col-md-8 text-center">
				    <div class="row">
				        <div class="col-md-4">
				            <div class="input-group mt-3">
                                <input class="form-control me-2 " type="search" name="searchTermDetail" id="searchTermDetail" placeholder="검색어 (제목 + 내용)">
                                <button class="btn btn-light" type="submit" id="searchTermDetailButton">검색</button>
                            </div>
				        </div>
				        <div class="col-md-6">
				        </div>
				        <div class="col-md-2">
				            <c:if test="${loggedIn}">
				                <a href="/board/boardForm" class="btn btn-dark">글쓰기</a>
				            </c:if>
				        </div>
                    </div>
				</div>
				<div class="col-md-2">
				</div>
			</div>
        </div>
    </div>

<br><br>
       <div class="row">
           <div class="col-md-12">
               <div class="row">
               <div class="col-md-2">
               </div>
               <div class="col-md-8">
                   <ul class="nav nav-pills">
                       <li class="nav-item dropdown">
                           <a class="nav-link dropdown-toggle" id="top" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">정렬</a>
                           <div class="dropdown-menu" style="">
                               <a class="dropdown-item" href="/board/hits" id="recent-link">최신순</a>
                               <a class="dropdown-item" href="/board/hits" id="hits-link">조회순</a>
                               <a class="dropdown-item" href="/board/interest" id="interest-link">관심순</a>
                               <c:if test="${loggedIn}">
                                <a class="dropdown-item" href="/board/distance" id="distance-link">거리순</a>
                               </c:if>
                               <a class="dropdown-item" href="/board/price" id="low-price-link">가격 낮은순</a>
                           </div>
                       </li>
                    </ul>
               </div>
               <div class="col-md-2">
               </div>
               </div>
           </div>
       </div>

       <div id="postContainer">
        </div>

	<br><br>

	</div>

	<div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8 d-flex justify-content-center">
                    <button class="btn btn-lg btn-light" type="button" id="loadMoreBtn" style="width: 100%;">더보기</button>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="whatIsCureentState" name="whatIsCureentState" value="hiddenInputValue">
</div>
    <script id="allPostsByCategorys" type="application/json">${allPostsByCategorys}</script>

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

    document.addEventListener("DOMContentLoaded", function() {
        start();
    });

    // 최신순을 클릭했을 때
    document.getElementById('recent-link').addEventListener('click', function(event) {

        event.preventDefault();
        var container = document.getElementById("postContainer");
        container.innerHTML = "";
        document.getElementById("loadMoreBtn").style.display = "block";
        var allPostsByCategorysJson = $("#allPostsByCategorys").html();

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/hits', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var responseData = xhr.responseText;
                var allPostsByCategorysScript = document.getElementById('allPostsByCategorys');
                allPostsByCategorysScript.textContent = responseData;

                document.getElementById('top').textContent = '최신순';
                start();

            }
        };
        xhr.send(allPostsByCategorysJson);
    });


    // 조회순을 클릭했을 때
    document.getElementById('hits-link').addEventListener('click', function(event) {

        event.preventDefault();
        var container = document.getElementById("postContainer");
        container.innerHTML = "";
        document.getElementById("loadMoreBtn").style.display = "block";
        var allPostsByCategorysJson = $("#allPostsByCategorys").html();

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/hits', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var responseData = xhr.responseText;
                var allPostsByCategorysScript = document.getElementById('allPostsByCategorys');
                allPostsByCategorysScript.textContent = responseData;

                document.getElementById('top').textContent = '조회순';

                start();

            }
        };
        xhr.send(allPostsByCategorysJson);
    });

    // 관심순을 클릭했을 때
    document.getElementById('interest-link').addEventListener('click', function(event) {

        event.preventDefault();
        var container = document.getElementById("postContainer");
        container.innerHTML = "";
        document.getElementById("loadMoreBtn").style.display = "block";
        var allPostsByCategorysJson = $("#allPostsByCategorys").html();


        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/interest', true); // 요청할 URL 설정
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var responseData = xhr.responseText;
                var allPostsByCategorysScript = document.getElementById('allPostsByCategorys');
                allPostsByCategorysScript.textContent = responseData;

                document.getElementById('top').textContent = '관심순';

                start();
            }
        };
        xhr.send(allPostsByCategorysJson);
    });

    // 가격 낮은순을 클릭했을 때
    document.getElementById('low-price-link').addEventListener('click', function(event) {

        event.preventDefault();
        var container = document.getElementById("postContainer");
        container.innerHTML = "";
        document.getElementById("loadMoreBtn").style.display = "block";

        var allPostsByCategorysJson = $("#allPostsByCategorys").html();


        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/price', true); // 요청할 URL 설정
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var responseData = xhr.responseText;
                var allPostsByCategorysScript = document.getElementById('allPostsByCategorys');

                allPostsByCategorysScript.textContent = responseData;

                document.getElementById('top').textContent = '가격 낮은순';

                start();
            }
        };
        xhr.send(allPostsByCategorysJson); // JSON 데이터를 문자열로 변환하여 요청 본문에 포함시킵니다.
    });


    // 거리순을 클릭했을 때
    $('#distance-link').click(function(event) {
        event.preventDefault();
        var container = document.getElementById("postContainer");
        container.innerHTML = "";
        document.getElementById("loadMoreBtn").style.display = "block";


        var allPostsByCategorysJson = $("#allPostsByCategorys").html();

        $.ajax({
            type: 'POST',
            url: '/board/distance',
            contentType: 'application/json',
            data: allPostsByCategorysJson,
            success: function(responseData) {
                $('#allPostsByCategorys').empty().text(responseData);
                $('#top').text('거리순');
                start();
            },
            error: function(xhr, status, error) {
                console.error('AJAX request failed:', status, error);
            }
        });
    });

    // 제목 + 내용 검색어 입력
    document.getElementById('searchTermDetailButton').addEventListener('click', function(event) {

        event.preventDefault();
        var searchTermDetail = document.getElementById("searchTermDetail").value;
        var allPostsByCategorysJson = $("#allPostsByCategorys").html();
        var allPostsByCategorysObject = JSON.parse(allPostsByCategorysJson);
        var jsonObject = {
            "searchTermDetail": searchTermDetail,
            "boardCategoryId": allPostsByCategorysObject[0].boardCategoryId,
            "itemCategoryId": allPostsByCategorysObject[0].itemCategoryId
        };

        // AJAX 요청 보내기
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/titleAndContent', true); // 요청할 URL 설정
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {

                var responseData = xhr.responseText;
                var allPostsByCategorysScript = document.getElementById('allPostsByCategorys');
                allPostsByCategorysScript.textContent = responseData;

                start();
            }
        };
        xhr.send(JSON.stringify(jsonObject)); // JSON 데이터를 문자열로 변환하여 요청 본문에 포함시킵니다.
    });

    function start() {

        var container = document.getElementById("postContainer");
        container.innerHTML = "";

        var allPostsByCategorysJson = $("#allPostsByCategorys").html();

        var allPostsByCategorys = JSON.parse(allPostsByCategorysJson);
        var numberOfPosts = allPostsByCategorys.length;
        var visiblePosts = 9;

        function renderPosts(startIndex, count) {

            var container = document.getElementById("postContainer");

            var postHtml = '<div class="row">' +
                '<div class="col-md-2"></div>' +
                '<div class="col-md-8">' +
                '<div class="row">'; // 새로운 행 시작

            for (var i = startIndex; i < startIndex + count && i < allPostsByCategorys.length; i++) {
                var post = allPostsByCategorys[i];

                if ((i - startIndex) % 3 == 0) {

                    postHtml += '</div>' +
                        '</div>' +
                        '</div>' +
                        '<br>';

                    postHtml += '<div class="row">' +
                        '<div class="col-md-2"></div>' +
                        '<div class="col-md-8">' +
                        '<div class="row">';
                }

                postHtml += '<div class="col-md-4">' +
                    '<div class="card border-light mb-3" style="max-width: 20rem;">' +
                    '<div class="card-header">' +
                    '<span class="badge bg-danger">' + post.isMegaphone + '</span>' +
                    '&nbsp;<span>' + post.title + '</span>' +
                    '</div>' +

                    '<div class="card-body">' +

                    '<a href="/board/' + post.boardId + '">' +
                    '<img src="' + post.imgSrc + '" style="width: 100%; height: 200px">' +
                    '</a>' +

                    '</div>' +
                    '<div class="card-footer">' +
                    '<div class="d-flex justify-content-start">' +
                    '<span class="badge bg-danger">' + post.isAuction + '</span>' +
                    '<span class="badge bg-primary">' + post.isLend + '</span>' +
                    '</div>' +
                    '<div><img src="/images/icon/postRegDateIcon.png" alt="Product Image" style="width: 20px; height: 20px;">&nbsp;' + post.regDate + '</div>' +
                    '<div><img src="/images/icon/mapIcon.png" alt="Product Image" style="width: 20px; height: 20px;">&nbsp;' + post.address + (post.distance ? ' <span style="color: orange;">(' + post.distance + ' km)</span>' : '') + '</div>' +

                    '<div><img src="/images/icon/moneyIcon.png" alt="Product Image" style="width: 20px; height: 20px;">&nbsp;' + post.price + '원</div>' +
                    '<div><img src="/images/icon/returnDateIcon.png" alt="Product Image" style="width: 20px; height: 20px;">&nbsp;반납 희망일 : ' + (post.returnDate ? post.returnDate : '미정') + '</div>' +
                    '<div class="d-flex justify-content-start">' +
                    '<span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;">&nbsp;' + post.interestCnt + '&nbsp;</span>' +
                    '<span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41&nbsp;</span>' +
                    '<span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;">&nbsp;' + post.hits + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
                if (post.isMegaphone === "급구") {
                    postHtml = postHtml.replace('<span class="badge bg-danger">' + post.isMegaphone + '</span>', '<img src="/images/icon/megaphoneIcon.png" style="width: 20px; height: 20px;">');
                }

            }

            postHtml += '</div>'; // row 닫기
            container.innerHTML += postHtml;
        }

        var loadedPosts = 9;

        function loadMorePosts() {

            var postsToAdd = 9;
            renderPosts(loadedPosts, postsToAdd);
            loadedPosts += postsToAdd;
            if (loadedPosts >= allPostsByCategorys.length) {
                document.getElementById("loadMoreBtn").style.display = "none";
            }
        }

        $('#loadMoreBtn').off('click').on('click', loadMorePosts);

        renderPosts(0, visiblePosts);

    }





</script>


</body>
</html>
