<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채팅하기</title>
    <link rel="stylesheet" href="/css/notification.css">
    <link rel="stylesheet" href="/css/chatRoom.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.0.0/dist/minty/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- websocket 라이브러리 추가 -->
    <!--  https://cdnjs.com/libraries/sockjs-client  -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
    <!--  https://cdnjs.com/libraries/stomp.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- 지도 api 추가 -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>
    <!------------------------------- style ----------------------------------->
    <style type="text/css">
        .discussion {
            list-style: none;
            background: #ededed;
            margin: 0;
            padding: 0 0 0 0;
        }
        .scroller {
            overflow: auto;
            height: 50vh;
            display: flex;
            flex-direction: column-reverse;
            overflow-anchor: auto !important;
        }
        .discussion li {
            padding: 0.5em;
            overflow: hidden;
            display: flex;
            transform: translateZ(0);
        }
        .discussion .avatar {
            width: 40px;
            position: relative;
        }
        .discussion .avatar img {
            display: block;
            width: 100%;
        }
        /* 자신이 보낸 메시지 */
        .self {
            justify-content: flex-end;
        }
        .self .messages {
            text-align: right;
        }
        /* 상대방이 보낸 메시지 */
        .other .messages {
            text-align: left;
        }
        .large-font {
            font-size: 20px;
        }

        .medium-font {
            font-size: 16px;
        }

        /* 지도 크기 설정 */
        #map {
            width: 100%;
            height: 400px;
        }

        /* 지도 크기 설정 */
        #reservMap {
            width: 100%;
            height: 400px;
        }
        #other{
            text-align : right;
        }
        #title{
            text-align : right;
        }
        #isLend {
            width: 150px;
            float: right;
        }


    #detailImg {width: 250px;height: 250px; object-fit: cover;}
    </style>
    <!------------------------------- style ----------------------------------->
</head>
<body>

<%
    // 현재 시간을 구해서 request 속성으로 설정
    java.util.Date now = new java.util.Date();
    request.setAttribute("time", now);
%>
<fmt:formatDate pattern="yy-MM-dd HH:mm:ss" value="${time}" var="sendTime" />
 <div class="container bg-green text-center">


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
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">

                            <div class="col-md-9">
                                <h3 id="other">
                                     <!--${chatItem.writer}님과의 대화-->
                                    <c:choose>
                                        <%--만약 유저아이디와 상세글쓴이가 같다면 --%>
                                        <c:when test="${userId eq chatItem.writer}">
                                            <%-- 챗룸의 랜디로 변경 --%>
                                            ${chatRoomDTO.lendy}님과의 대화
                                        </c:when>
                                        <c:otherwise>
                                            <%-- 아닐경우 상세글쓴이 --%>
                                            ${chatItem.writer}님과의 대화
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>

                            <div class="col-md-3">
                                <div class="btn-group btn-group-md" role="group">

                                    <span id="singoSpan">
                                        <button class="btn btn-secondary" type="button" id="singoLink">
                                            신고
                                        </button>

                                        <div class="modal fade" id="singoModal" tabindex="-1" role="dialog" aria-labelledby="singoModalLabel" aria-hidden="true">
                                          <div class="modal-dialog" role="document">
                                            <div class="modal-content" >
                                              <div class="modal-header" >
                                                <img src="/images/singo.png" alt="대체" style="width: 50px; height:20px;">
                                                <h5 class="modal-title" id="confirmModalLabel" style="color: red;">신고 등록</h5>

                                              </div>
                                              <div class="modal-body">
                                                <div id="title-error" style="display: none;">
                                                    <span class="badge bg-danger"></span>
                                                </div>
                                                <input type="input" class="form-control" id="singoTitle" name="singoTitle" placeholder="글 제목" autocomplete="off"> <br>
                                                <div id="content-error" style="display: none;">
                                                    <span class="badge bg-danger"></span>
                                                </div>
                                                <textarea class="form-control" id="singoContent" name="singoContent" rows="10" placeholder="신고 내용"></textarea>
                                              </div>
                                              <div class="modal-footer">
                                                <button type="button" id="singoCancelButton" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                                <button type="button" id="singoConfirmButton" class="btn btn-primary">등록</button>
                                              </div>
                                            </div>
                                          </div>
                                        </div>

                                    </span>

                                    <span id="blockSpan">
                                        <button class="btn btn-secondary" type="button" id="blockUserLink">
                                            차단
                                        </button>

                                        <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
                                          <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                              <div class="modal-header">
                                                <img src="/images/ban.png" alt="대체" style="width: 50px; height:20px;">&nbsp;
                                                <h5 class="modal-title" id="confirmModalLabel" style="color: red;">유저를 차단하겠습니까?</h5>

                                              </div>
                                              <div class="modal-body">
                                                차단한 유저는 더 이상 접근할 수 없습니다. 계속하시겠습니까?
                                              </div>
                                              <div class="modal-footer">
                                                <button type="button" id="blockCancelButton" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                                <button type="button" id="blockConfirmButton" class="btn btn-primary">확인</button>
                                              </div>
                                            </div>
                                          </div>
                                        </div>
                                    </span>

                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-md-3 text-center" > <!-- 글 상세 이미지 출력 -->
                                <a href="/board/${chatItem.boardId}"><!-- 이미지 클릭 시 해당 상세글로 이동 -->
                                    <img alt="이미지 없음" src="${chatItem.images}" id="detailImg" />
                                </a>
                            </div>

                            <div class="col-md-9">
                                <div class="row">
                                    <div class="col-md-9">
                                        <!-- 글 제목 출력 -->
                                        <h1 id="title">${chatItem.title}</h1>
                                    </div>
                                    <div class="col-md-3">
                                        <button type="button" onclick="chatList()" class="btn btn-success">
                                            채팅목록
                                        </button>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-9">
                                        <select class="form-select" id="isLend">
                                            <option>대여전</option>
                                            <option>대여중</option>
                                            <option>대여완료</option>
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-success">
                                            리뷰등록
                                        </button>
                                    </div>

                                    <div id="myModal" class="modal">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <div>
                                                        <h5 class="modal-title">
                                                            <c:choose>
                                                                <c:when test="${userId eq chatItem.writer}">
                                                                    ${chatRoomDTO.lendy}님과의 거래는 어떠셨나요?
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${chatItem.writer}님과의 거래는 어떠셨나요?
                                                                </c:otherwise>
                                                            </c:choose>


                                                        </h5>
                                                    </div>

                                                    <div id="star-error" style="display: none;">
                                                        <span class="badge bg-danger"></span>
                                                    </div>
                                                    <div class="rating" style="text-align: center;" >

                                                        <span>☆</span>
                                                        <span>☆</span>
                                                        <span>☆</span>
                                                        <span>☆</span>
                                                        <span>☆</span>
                                                    </div>

                                                </div>
                                                <div class="modal-body">
                                                    <div id="content-error" style="display: none;">
                                                        <span class="badge bg-danger"></span>
                                                    </div>
                                                    <textarea class="form-control" id="content" name="content" rows="10"></textarea>
                                                </div>
                                                <div class="modal-footer">

                                                    <button type="button" id="reviewReg" class="btn btn-primary">리뷰 등록</button>
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-md-3">
                                        <button type="button" id="reviewButton" class="btn btn-success" style="display: none;">리뷰등록</button>
                                    </div>

                                </div>

                            </div>

                        </div>
                        <!-- 채팅폼 들어갈예정 -->
                        <div class="container scroller" style="background: #ededed;">
                                <div class="row">
                                    <div class="col-md-12">
                                    </div>
                                </div>
                                <!-- 대화 입력 박스 / 대화 내용 박스 -->
                                <!-- 연결상태 알림 -->
                                <div class="alert alert-success my-4" style="display: none">
                                    <strong id="status">채팅을 연결후 사용하세요....</strong>
                                    <div id="connectionStatus"></div>
                                </div>
                                <div id="showChat">
                                    <!-- 메시지 입력 -->
                                    <div class="mb-3 mt-3">
                                    </div>
                                    <!-- 대화 내용 -->
                                    <div id="taMsg" class="discussion"></div>
                                </div>
                            </div>
                            <!-- .container end -->
                        <!-- 채팅폼 들어갈예정 -->
                        <div class="row">
                           <div class="col-md-1">
                               <div class="dropdown">
                                   <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                       <img src="/images/plus.png"/>
                                   </a>
                                    <div class="dropdown-menu" style="">
                                       <a class="dropdown-item" href="#">파일첨부</a>
                                       <a class="dropdown-item" id="modal_btn_reserv">약속하기</a>
                                       <a class="dropdown-item" href="#" id="modal_btn_infoReserv">약속정보</a>
                                    </div>
                               </div>
                           </div>
                            <div class="col-md-11">
                            <input onkeyup="sendInput(this.value)"
                            type="text" class="form-control" id="inputMsg"
                            placeholder="메시지를 입력하세요." name="inputMsg">
                                <!-- ---약속하기 클릭시 지도랑 달력 출력 모달 나타나기--- -->
                                    <div class="modal" id="reservModal">
                                          <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                      <div class="modal-header">
                                                            <c:choose>
                                                                <c:when test="${reservList.latitude != 0}">
                                                                    <h5 class="modal-title">약속 다시 정하기</h5>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <h5 class="modal-title">약속하기</h5>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                                              <span aria-hidden="true"></span>
                                                            </button>
                                                      </div>
                                                      <div class="modal-body">
                                                          <div id="map"></div>
                                                          <label for="reservationDate">예약 날짜와 시간:</label>
                                                          <input type="datetime-local" id="reservationDate" name="reservationDate">
                                                      </div>
                                                      <div class="modal-footer">
                                                        <c:choose>
                                                            <c:when test="${reservList.latitude != 0}">
                                                                <button type="button" class="btn btn-primary" id="completeChange">약속 다시 정하기</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" class="btn btn-primary" id="completeReserv">약속 정하기</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                      </div>
                                                </div>
                                          </div>
                                                        <!-- 유저 정보에서 가져온 위도 경도 -->
                                          <c:choose>
                                            <c:when test="${reservList.latitude != 0}">
                                                <input type="text" name="latitude" id="latitude" value="${reservList.latitude}">
                                                <input type="text" name="longitude" id="longitude" value="${reservList.longitude}">
                                                <input type="text" name="reservationDateTime" id="reservationDateTime" value="${reservList.selectedDateTime}">
                                                <input type="text" name="userId" id="userId" value="${userId}">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="text" name="latitude" id="latitude" value="${latiAndLong.latitude}">
                                                <input type="text" name="longitude" id="longitude" value="${latiAndLong.longitude}">
                                                <input type="text" name="reservationDateTime" id="reservationDateTime" value="">
                                                <input type="text" name="userId" id="userId" value="${userId}">
                                            </c:otherwise>
                                          </c:choose>
                                    </div>
                                <!-- ---약속하기 클릭시 지도랑 달력 출력 모달 나타나기--- -->

                                <!-- ---약속정보 클릭시 약속 된 장소 지도랑 시간 달력 출력 모달 나타나기--- -->
                                    <div class="modal" id="reservInfoModal">
                                          <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                      <div class="modal-header">
                                                             <h5 class="modal-title">약속정보</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                                              <span aria-hidden="true"></span>
                                                            </button>
                                                      </div>
                                                      <div class="modal-body">
                                                        <div id="reservMap"></div>
                                                      </div>
                                                      <h5>약속 시간</h5>
                                                      <input type="text" name="reservTime" id="reservTime" readonly>
                                                      <div class="modal-footer">
                                                        <button type="button" class="btn btn-primary" id="changeReserv">약속을 수정 하시겠습니까?</button>
                                                      </div>
                                                </div>
                                          </div>
                                                        <!-- 메세지에서 가져온 위도 경도 -->
                                          <input type="text" name="reservLatitude" id="reservLatitude">
                                          <input type="text" name="reservLongitude" id="reservLongitude">
                                          <input type="text" name="userId" id="userId" value="${userId}">
                                          <input type="text" name="messageId" id="messageId">

                                    </div>
                                <!-- ---약속정보 클릭시 약속 된 장소 지도랑 시간 달력 출력 모달 나타나기--- -->

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
        </div>
    </div>

    <script src="/js/notification.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {

            let lendState = '${chatItem.lendState}';
            let boardId = '${chatItem.boardId}';
            let userId = '${userId}';
            const selectBox = document.getElementById('isLend');

            selectBox.addEventListener('change', function(event) {
                let selectedOption = event.target.value;

                // 대여 상태 변경
                $.ajax({
                    url: '/board/' + boardId + '/isLend',
                    method: 'PUT',
                    contentType: 'text/plain',
                    data: selectedOption,
                    success: function(response) {
                        console.log(response);
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            });

            if ('${userId}' === '${chatItem.writer}') {
                reviewee = '${chatRoomDTO.lendy}';
            } else {
                reviewee = '${chatItem.writer}';
            }

            if (lendState === '대여전') {
                selectBox.value = '대여전';
            } else if (lendState == '대여중') {
                selectBox.value = '대여중';
            } else if (lendState == '대여 완료') {
                // 리뷰 등록을 하지 않은 상태면
                $.ajax({
                    url: '/user/' + userId + '/review',
                    method: 'GET',
                    contentType: 'text/plain',
                    success: function(response) {
                        if ($.isEmptyObject(response)) {
                            reviewModal();
                            var reviewButton = document.getElementById('reviewButton');
                            reviewButton.style.display = 'block';
                        } else {
                             if (hasValueInArray(response, reviewee)) {
                                 reviewButton.style.display = 'none';
                             } else {
                                 reviewModal();
                                 reviewButton.style.display = 'block';
                             }
                        }
                    },
                    error: function(xhr, status, error) {

                    }
                });
                selectBox.value = '대여완료';
                selectBox.setAttribute('disabled', 'disabled');
            }

            function hasValueInArray(array, value) {
                for (var i = 0; i < array.length; i++) {
                    var obj = array[i];
                    for (var key in obj) {
                        if (obj[key] === value) {
                            return true;
                        }
                    }
                }
                return false;
            }

            document.getElementById("reviewButton").addEventListener("click", function() {
                reviewModal();
            });

            const modal = document.getElementById('myModal');
            let selectedStars = 0;

            selectBox.addEventListener('change', function () {
                const selectedValue = selectBox.value;

                if (selectedValue === '대여완료') {
                    reviewModal();
                }
            });

            $('#reviewReg').click(function() {
                var isError = false;
                var starErrorEle = document.getElementById('star-error');
                var contentErrorEle = document.getElementById('content-error');
                starErrorEle.style.display = 'none';
                contentErrorEle.style.display = 'none';
                var cnt = 0;
                const stars = document.querySelectorAll('.rating span');
                for (let i = 0; i < stars.length; i++) {
                    if (stars[i].textContent === '☆') {
                        cnt = cnt + 1;
                    }

                }
                if (cnt === 5) {
                    var spanElement = starErrorEle.querySelector('span');
                    spanElement.textContent = '별점을 입력하세요';
                    starErrorEle.style.display = 'block';
                    isError = true;
                }

                var content = document.getElementById('content').value;

                if (content.length > 200) {
                    var spanElement = contentErrorEle.querySelector('span');
                    spanElement.textContent = '글 내용 200자 초과';
                    contentErrorEle.style.display = 'block';
                    isError = true;
                }

                if (content === null || content === '') {
                    var spanElement = contentErrorEle.querySelector('span');
                    spanElement.textContent = '리뷰내용을 입력해주세요';
                    contentErrorEle.style.display = 'block';
                    isError = true;
                }

                if (isError === false) {
                    var content = document.getElementById('content').value;
                    $.ajax({
                        url: '/review',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            reviewer: '${userId}',
                            reviewee: reviewee,
                            content: content,
                            star: selectedStars
                        }),
                        success: function(response) {
                            if (response === 'ok') {
                                alert('리뷰 등록 완료');
                                $('#myModal').modal('hide');
                                selectBox.setAttribute('disabled', 'disabled');
                            }
                        },
                        error: function(xhr, status, error) {
                             if (xhr.status == 500) {
                                console.error("서버에서 내부 오류가 발생했습니다.");
                            } else if (xhr.status == 400) {
                                var errors = xhr.responseJSON;
                                var contentErrorEle = document.getElementById('content-error');
                                contentErrorEle.style.display = 'none';
                                if (errors?.content) {
                                    var spanElement = contentErrorEle.querySelector('span');
                                    spanElement.textContent = errors.content;
                                    contentErrorEle.style.display = 'block';
                                }
                            }
                        }
                    });
                }
            });

            var textarea = document.getElementById('content');

            // 재입력 시 에러메세지 삭제
            textarea.addEventListener('input', function(event) {
                var contentErrorEle = document.getElementById('content-error');
                contentErrorEle.style.display = 'none';
            });

            // 포커스 시 에러메세지 삭제
            textarea.addEventListener('focus', function(event) {
                var contentErrorEle = document.getElementById('content-error');
                contentErrorEle.style.display = 'none';
            });

            function reviewModal() {
                var textarea = document.getElementById('content');
                textarea.value = '';
                $('#myModal').modal('show');
                var starErrorEle = document.getElementById('star-error');
                var contentErrorEle = document.getElementById('content-error');
                starErrorEle.style.display = 'none';
                contentErrorEle.style.display = 'none';
                const stars = document.querySelectorAll('.rating span');

                // 별 초기화
                for (let i = 0; i < stars.length; i++) {
                    stars[i].textContent = '☆';
                }

                stars.forEach((star, index) => {
                    star.addEventListener('click', () => {
                        starErrorEle.style.display = 'none';
                        for (let i = 0; i < stars.length; i++) {
                            if (i >= index) {
                                stars[i].textContent = '★';
                            } else {
                                stars[i].textContent = '☆';
                            }
                        }
                        selectedStars = 5 - index;
                    });
                });
            }

        chat_connect();
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
    <!------------------------------- script ----------------------------------->
    <script language="javascript" type="text/javascript">
        function getCurrentTime() {
            var now = new Date();
            var year = now.getFullYear();
            var month = (now.getMonth() + 1).toString().padStart(2, '0'); // Months are 0-based
            var date = now.getDate().toString().padStart(2, '0');
            var hours = now.getHours().toString().padStart(2, '0');
            var minutes = now.getMinutes().toString().padStart(2, '0');
            var seconds = now.getSeconds().toString().padStart(2, '0');
            return year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
        }

        let chatId = "<c:out value='${chatId}'/>"; <!-- 처음 생성될때 만들어지는 채팅방 아이디 -->
        let lendy="<c:out value='${userId}'/>"//현재 접속자(구매자-랜디, 채팅방이 처음 생성될때 메세지 보내는 사람)
        let lender="<c:out value='${chatItem.writer}'/>"//상세글쓴이(판매자-랜더, 채팅방이 처음 생성될때는 메세지 받는 사람)

        //제일 처음 메세지를 보내는 사람
        let from = lendy;//메세지 보내는 사람 -> 구매자
        let to = lender;//메세지 받는 사람 -> 판매자

        let sendTime = getCurrentTime();
        let socket = null;
        let stompClient = null;

        // ======================================= UI 제어 =======================================

        // ======================================= UI 제어 =======================================
        // ======================================= 소켓 연결 =======================================

        function chat_connect()
        {

            socket = new SockJS("${pageContext.request.contextPath}/chatCon"); // end point => "/chat"
            stompClient = Stomp.over(socket); // 소켓을 이용하여 stomp 생성
            //stomp 이용해서 서버에 연결
            stompClient.connect({}, function(frame)
            {
                alert('연결됨: ' + frame+"/"+$('#taMsg').html());
                $('#taMsg').html('');
                $('#inputMsg').focus(); // 대화 내용 입력 박스에 포커스 추가
                let obj={
                    from:from,
                    to:to,
                    content:'#100',
                    chatId:chatId,
                    sendTime: ''
                }
                //alert('/app/chatCon/'+chatId);
                stompClient.send('/app/chatCon/'+chatId, {}, JSON.stringify(obj));

                stompClient.subscribe('/topic/messages/'+chatId, function(msg)
                {
                    console.log('subscribe topic → ', msg);
                    //alert(msg.body); // msg.body → json 형태의 문자열
                    let jsonMsg = JSON.parse(msg.body); // 문자열을 JSON 객체로 만들기
                   // alert(jsonMsg.length);

                        $.each(jsonMsg, function(i, msg){

                            showChatMessage(msg);
                        });


                }); // subscribe end -------

                // 연결 메시지 출력
                let connectMessage = lender + "님과 연결되었습니다."
                if("${userId}" == "${chatItem.writer}"){
                    connectMessage = "${chatRoomDTO.lendy}" + "님과 연결되었습니다."
                }
                alert(connectMessage);

            }); // stomp.connect() end
        }//chat_connect() end ----------------
        // ======================================= 소켓 연결 =======================================
        // ======================================= 소켓 연결 해제 =======================================
        function chat_disconnect()
        {
            if (stompClient !== null)
            {
                stompClient.disconnect();
            }

        }
        // ======================================= 소켓 연결 해제 =======================================
        // ======================================= enter =======================================
        function sendInput(content)
        {
            //alert(event.keyCode); // 이건 잘됨
            //alert(content);
            //alert(getCurrentTime());
            if(event.keyCode == 13) // 전송도 잘됨!
            {
                if(content != '')
                {
                    sendMessage(from, to, content,chatId,sendTime); // 서버로 메시지 전송
                    $('#inputMsg').val(''); // jquery
                    // document.getElementById('inputMsg').value = ''; // javascript
                }
            }
        } // sendInput() ----------
        // ======================================= enter =======================================
        // ======================================= 서버로 메시지 보내기 =======================================
        function sendMessage(from,to, content, chatId, sendTime)
        {
            let obj =
            {
                    from:from,
                    to:to,
                    content:content,
                    chatId:chatId,
                    sendTime: getCurrentTime()
            }
            stompClient.send('/app/chatCon/'+chatId, {}, JSON.stringify(obj)); // json 객체를 직렬화
        } // ---------------------------------
        // ======================================= 서버로 메시지 보내기 =======================================
        // ======================================= 대화 내용 출력 함수 =======================================
        function showChatMessage(obj) { // 대화 내용을 출력해 주는 함수
           // alert("obj****"+JSON.stringify(obj));
           //alert(obj.content);
            if (obj.content == '#100') {
                // alert('111');
                $('#taMsg').html('');

            }else{

                if(obj.from == "<c:out value='${userId}'/>") {
                    //console.log("보내는 사람은 : "+from);
                    //console.log("받는 사람은 : "+to)
                    let str = `
                        <label class="text-primary-emphasis medium-font">\${obj.from}</label>
                        <p class='text-primary large-font message'>
                        &nbsp;&nbsp;
                        \${obj.content}
                        </p>
                    `;
                    //console.log("***********self");
                    addMessage('self', str, obj.sendTime);
                } else { // 다른 사람이 보낸 메시지라면
                    let str = `
                        <label class="text-primary-emphasis medium-font">\${obj.from}</label>
                        <p class='text-primary large-font message'>
                        &nbsp;&nbsp;
                        \${obj.content}
                        </p>
                    `;
                      //console.log("############other");
                    addMessage('other', str, obj.sendTime);

                    if (obj.content == "약속이 정해졌습니다") {
                        $("#modal_btn_reserv").addClass("disabled");
                    }

                }//else
            }//else-----------------------
            scroll();

        } // showChatMessage() -----------
        // ======================================= 대화 내용 출력 함수 =======================================
        // ======================================= 메시지 추가 =======================================
        function addMessage(who, msg, sendTime)
        {
            let img = "<img src='/images/me.png'>";
            if(who == 'other')
            {
                img = "<img src='/images/other.png'>";
            }
            let str = `
                <li class='\${who}'>
                    <div class='avatar'>
                    \${img}
                    </div>
                    <div class="messages">
                        <p>\${msg}</p>
                        <time>\${sendTime}</time>
                    </div>
                </li>
            `;
            $('#taMsg').append(str);

        }

        function scroll(){
            var ht = 0;
            $("#taMsg li").each(function() {
              ht += $(this).height();
            });
            $("#scroll").animate({scrollTop: ht})
        }
        // -------------
        // ======================================= 메시지 추가 =======================================
        // ======================================= 약속하기 모달 =======================================
        $(document).ready(function(){
            // 지도를 표시할 영역을 설정
            // 클릭한 위치의 위도와 경도를 저장할 변수
            var clickedLatitude = null;
            var clickedLongitude = null;
            var map;
            var marker;

            //약속된 위도
            let reservLatitude = document.getElementById("latitude").value;               //${reservList.latitude};
            console.log("여기서 값이 제대로 넘어오는지 : "+ reservLatitude)

            //약속된 경도
            let reservLongitude = document.getElementById("longitude").value;
            console.log("여기서 값이 제대로 넘어오는지 : "+ reservLongitude)

            //약속된 정보에 따른 메세지 아이디
            let messageId = ${reservList.messageId}
            console.log("메세지 아이디는 : "+messageId);

            //약속된 날짜
            let reservTime = document.getElementById("reservationDateTime").value == null ? '0' : document.getElementById("reservationDateTime").value;
            console.log("저장한 날짜는 : "+reservTime);


            $('#reservModal').on('shown.bs.modal', function (){
                // 모달 body의 크기를 가져옴
                var modalBody = $(this).find('.modal-body');
                var width = modalBody.width();

                // 지도의 크기를 동적으로 설정
                $('#map').css({
                    width: width
                });

                //만약 약속 위도 경도가 0이라면 유저 정보에서 가져온 위도 경도 넣어주기
                if(reservLatitude != ${latiAndLong.latitude} && reservLongitude != ${latiAndLong.longitude}){
                   //reservLatitude = ${latiAndLong.latitude},
                   //reservLongitude = ${latiAndLong.longitude}

                  reservLatitude = $("#reservLatitude").val(),
                  reservLongitude = $("#reservLongitude").val()

                }

                //else {
                //   reservLatitude = $("#reservLatitude").val(),
               //    reservLongitude = $("#reservLongitude").val()
                //}


                // 네이버 지도 초기화
                var mapOptions = {
                    center: new naver.maps.LatLng(reservLatitude, reservLongitude),
                    zoom: 17,
                    zoomControl: true,
                    zoomControlOptions: {
                        position: naver.maps.Position.TOP_RIGHT
                    },
                    mapDataControl: false
                };

                // 네이버 지도 객체 생성
                map = new naver.maps.Map('map', mapOptions);

                var marker = null; // 스탬프 마커
                var marker2 = null;

                marker2 = new naver.maps.Marker({
                    position: new naver.maps.LatLng(reservLatitude, reservLongitude),
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

            });

             // 버튼 클릭 시 모달 창 열기
            $("#modal_btn_reserv").click(function(e){
                e.stopPropagation();

                console.log("뭘까요??",reservLatitude);
                console.log("뭘까요??",reservLongitude);
                if($("#latitude").val() != ${latiAndLong.latitude} && $("#longitude").val() != ${latiAndLong.longitude}){
                    alert("약속이 이미 정해졌습니다. 약속정보를 확인해주세요");
                }else{
                    $("#reservModal").modal("show");
                }
            });// 버튼 클릭 시 모달 창 열기 END=================

            // 약속 정하기 클릭 시 모달 창 닫기
            // 버튼의 온클릭 이벤트 핸들러 설정
            $("#completeReserv").click(function() {
                alert("약속이 정해졌습니다.")
                let reservLat = $("#latitude").val();
                let reservLong = $("#longitude").val();
                let selectedDateTimeString = $("#reservationDate").val();
                let selectedDateTime = new Date(selectedDateTimeString);

                console.log("내가 선택한 날짜와 시간은?:", selectedDateTimeString);

                $.ajax({
                    url: "/chat/{chatId}/appointed-place-date",
                    method: "post",
                    data: {
                        reservLat: reservLat,
                        reservLong: reservLong,
                        chatId : chatId,
                        from : from,
                        to : to,
                        content: "약속이 정해졌습니다",
                        sendTime : getCurrentTime(),
                        selectedDateTime : selectedDateTime
                    },
                    success: function(response) {
                        console.log("요청 성공:", response);

                        // 예약이 성공적으로 완료되면 채팅창에 메시지를 출력
                        showChatMessage({
                            from: from,
                            content: "약속이 정해졌습니다",
                            sendTime: getCurrentTime()
                        });

                        // 모달 창 닫기
                        $("#reservModal").modal('hide');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error("Ajax 요청 에러:", error);
                    }
                });
            });

            //약속 다시 정하기 버튼 눌렀을때 이벤트
            $("#completeChange").click(function(){
                alert("약속을 다시 정했어요")
                let reservLat = $("#latitude").val();
                let reservLong = $("#longitude").val();
                let selectedDateTimeString = $("#reservationDate").val();
                let selectedDateTime = new Date(selectedDateTimeString);

                //console.log("다시 정한 약속 위도는 : "+reservLat)
                //console.log("다시 정한 약속 경도는 : "+reservLong)
                console.log("다시 정한 약속 날짜는 : "+selectedDateTime)

                $.ajax({
                    url: "/chat/{chatId}/appointed-place-date",
                    method: "put",
                    data: {
                        reservLat: reservLat,
                        reservLong: reservLong,
                        chatId : chatId,
                        from : from,
                        to : to,
                        content: "약속을 다시 정했어요",
                        sendTime : getCurrentTime(),
                        messageId : messageId,
                        selectedDateTime : selectedDateTime
                    },
                    success: function(response) {
                        console.log("요청 성공:", response);

                        // 예약이 성공적으로 완료되면 채팅창에 메시지를 출력
                         //function sendMessage(from,to, content, chatId, sendTime)
                       // sendMessage(from,to,"약속을 다시 정했어요",chatId, getCurrentTime());
                        showChatMessage({
                            from: from,
                            content: "약속을 다시 정했어요",
                            sendTime: getCurrentTime()
                        });

                        // 모달 창 닫기
                        $("#reservModal").modal('hide');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error("Ajax 요청 에러:", error);
                    }
                });
            })


        });//$(document).ready(function() END================

        // ======================================= 약속하기 모달 =======================================
        // ======================================= 약속정보 모달 =======================================
         $(document).ready(function(){
            var map;
            var marker;
            //모달 이벤트 핸들러
            $('#reservInfoModal').on('shown.bs.modal', function (){
                // 모달 body의 크기를 가져옴
                var modalBody = $(this).find('.modal-body');
                var width = modalBody.width();

                // 지도의 크기를 동적으로 설정
                $('#reservMap').css({
                    width: width
                });

                // 네이버 지도 초기화
                var mapOptions = {
                    center: new naver.maps.LatLng(${reservList.latitude}, ${reservList.longitude}),
                    zoom: 17,
                    zoomControl: true,
                    zoomControlOptions: {
                        position: naver.maps.Position.TOP_RIGHT
                    },
                    mapDataControl: false
                };

                // 네이버 지도 객체 생성
                map = new naver.maps.Map('reservMap', mapOptions);

                // 이전에 저장된 위치가 있으면 마커를 생성하여 표시
                var savedLat = parseFloat($('#reservLatitude').val());
                var savedLng = parseFloat($('#reservLongitude').val());

                if (savedLat && savedLng) {
                    var savedPosition = new naver.maps.LatLng(savedLat, savedLng);
                    marker = new naver.maps.Marker({
                        position: savedPosition,
                        map: map
                    });
                    map.setCenter(savedPosition);
                }

            })//(#reservInfoModal').on('shown.bs.modal END ------------------

            // 버튼 클릭 시 모달 창 열기
            $("#modal_btn_infoReserv").click(function(){
                if($("#reservLatitude").val() == 0 && $("#reservLongitude").val() == 0){
                    alert("약속을 정하지 않았어요. 약속을 정해주세요");
                }else{
                     $.ajax({
                        type : "get",
                        url : '/chat/' + chatId + '/appointed-place-date',
                        contentType:"application/json; charset=UTF-8",
                        dataType:"json",
                        data:{chatId},
                        success : function(data){
                             //console.log("성공성공", data);
                             //console.log("성공??", data.latitude);

                             $("#reservLatitude").val(data.latitude);
                             $("#reservLongitude").val(data.longitude);
                             $("#messageId").val(data.messageId);
                             $("#reservTime").val(data.selectedDateTime);

                            $("#reservInfoModal").modal("show");
                        },
                        error:function(err){
                            console("실패실패", err)
                        }

                    })
                }


            });// 버튼 클릭 시 모달 창 열기 END=================
            //수정하시겠습니까 버튼 클릭 시 액션
            $(document).on('click',"#changeReserv", function(){
                console.log("이거 눌리는지 띄워봐");
                // 모달 창 닫기
                $("#reservInfoModal").modal('hide');
                $("#reservModal").modal("show");
            })


         })//document).ready(function() END ---------------------------

        // ======================================= 약속정보 모달 =======================================
        // ======================================= chatList로 돌아가기 =======================================
        function chatList()
        {
            window.location.href = "/chatList/"+"${userId}";
        }
        // ======================================= chatList로 돌아가기 =======================================
        // ======================================= 차단하기 =======================================
        document.getElementById('blockUserLink').addEventListener('click', function(event) {
              event.preventDefault();

              if (${loggedIn}) {
                  $('#confirmModal').modal('show');
              } else {
                  showAlert();
              }
        });

        document.getElementById('blockCancelButton').addEventListener('click', function(event) {
              event.preventDefault();
              $('#confirmModal').modal('hide');
        });

        // 차단 확인을 누를 때
        document.getElementById('blockConfirmButton').addEventListener('click', function(event) {
              event.preventDefault();

              let writer = "<c:out value='${chatItem.writer}'/>";
              if("<c:out value='${userId}'/>" == writer){
                    writer = "<c:out value='${chatRoomDTO.lendy}'/>"
              }

              //alert(writer);
              $.ajax({
                    url: '/user/${userId}/block',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        writer

                    }),
                    success: function(response) {
                        console.log('Success:', response);

                        window.location.href = "/chatList/"+"${userId}";
                    },
                    error: function(xhr, status, error) {

                        console.error('Error:', error);
                        $('#confirmModal').modal('hide');
                    }
              });
        });

        // ======================================= 차단하기 =======================================
        // ======================================= 신고하기 =======================================
        document.getElementById('singoLink').addEventListener('click', function(event) {
            event.preventDefault();

            if (${loggedIn}) {
              $('#singoModal').modal('show');
            } else {
              showAlert();
            }
        });

        document.getElementById('singoCancelButton').addEventListener('click', function(event) {
            event.preventDefault();
            $('#singoModal').modal('hide');
        });

        document.getElementById('singoConfirmButton').addEventListener('click', function(event) {
            event.preventDefault();

            // writer, title, content, boardId;
            var writer = '${chatItem.writer}';
            var boardId = '${chatItem.boardId}';
            var title = document.getElementById('singoTitle').value;
            var content = document.getElementById('singoContent').value;

            $.ajax({
                url: '/report',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ writer: writer, boardId: boardId, title: title, content: content }),
                success: function(response) {
                    if (response === 'ok') {
                        alert('신고글 등록 완료');
                    }
                    $('#singoModal').modal('hide');
                },
                error: function(xhr, status, error) {

                    if (xhr.status == 500) {
                        console.error("서버에서 내부 오류가 발생했습니다.");
                    } else if (xhr.status == 400) {
                        var errors = xhr.responseJSON;
                        var titleErrorEle = document.getElementById('title-error');
                        var contentErrorEle = document.getElementById('content-error');
                        titleErrorEle.style.display = 'none';
                        contentErrorEle.style.display = 'none';

                        if (errors && errors.hasOwnProperty('title')) {
                            var spanElement = titleErrorEle.querySelector('span');
                            spanElement.textContent = errors.title;
                            titleErrorEle.style.display = 'block';
                        }
                        if (errors && errors.hasOwnProperty('content')) {
                            var spanElement = contentErrorEle.querySelector('span');
                            spanElement.textContent = errors.content;
                            contentErrorEle.style.display = 'block';
                        }
                    } else if (xhr.status == 429) {
                        alert(xhr.responseText);
                    }
                }
            });
        });
        // ======================================= 신고하기 =======================================
    </script>
    <!------------------------------- script ----------------------------------->
</body>

    <script src="/js/chatRoom.js"></script>
</html>