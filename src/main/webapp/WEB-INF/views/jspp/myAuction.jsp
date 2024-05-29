<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script src="/js/menuControl.js"></script>
      <script src="/js/notification.js"></script>
      <link rel="stylesheet" type="text/css" href="/css/notification.css">
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .auction-details-content {
            border: 2px solid rgba(0, 0, 0, 0.2);
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
    <script>

    let currentServerTime = null;

        function displayServerTime() {
            const eventSource = new EventSource('/time');

            let alertDisplayed = false;

            eventSource.onmessage = function(event) {
                const currentServerTime = new Date(event.data);
                const deadlineElements = document.querySelectorAll('.deadline');

                deadlineElements.forEach(deadlineElement => {
                    const deadline = new Date(deadlineElement.dataset.deadline);
                    const timeDifference = deadline.getTime() - currentServerTime.getTime();

                    if (timeDifference <= 0) {
                        deadlineElement.innerText = "경매시간이 종료되었습니다";
                        const auctionId = deadlineElement.closest('.auction-details').querySelector('input[name="auctionId"]').value;
                        updateAuctionStatus(auctionId);
                        const auctionDetails = deadlineElement.closest('.auction-details');
                        const inputElement = auctionDetails.querySelector('input[name="currentPrice"]');
                        const buttonElement = auctionDetails.querySelector('button[type="submit"]');
                        if (inputElement) {
                            inputElement.disabled = true;
                        }
                        if (buttonElement) {
                            buttonElement.disabled = true;
                        }

                    } else {
                        const formattedDifference = formatTimeDifference(timeDifference);
                        deadlineElement.innerText = formattedDifference;
                    }
                });
            };
        }

        function formatTimeDifference(timeDifference) {
            const millisecondsInDay = 1000 * 60 * 60 * 24;

            if (timeDifference < millisecondsInDay) {
                const hours = Math.floor(timeDifference / (1000 * 60 * 60)) % 24;
                const minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

                const formattedHours = hours < 10 ? '0' + hours : hours;
                const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;
                const formattedSeconds = seconds < 10 ? '0' + seconds : seconds;

                return formattedHours + '시간 ' + formattedMinutes + '분 ' + formattedSeconds + '초';
            } else {
                const days = Math.floor(timeDifference / millisecondsInDay);
                return days + '일';
            }
        }

        function updateAuctionStatus(auctionId) {
            $.ajax({
                url: '/auction/' + auctionId + '/isAuction',
                type: 'PATCH',
                success: function(response) {
                    if (response === "ok") {
                        $('#badge-' + auctionId).text("경매완료");
                    } else {
                        alert("상태 업데이트 실패");
                    }
                },
                error: function() {
                    alert("오류 발생");
                }
            });
        }

        $(document).ready(function() {
            displayServerTime();

            $('.auction-details').hide();

            $('.form-check-input').change(function() {
                var card = $(this).closest('.card');
                var details = card.find('.auction-details');
                details.toggle($(this).prop('checked'));
            });

            $('.auction-form').submit(function(event) {
                event.preventDefault();
                const auctionDetails = $(this).closest('.auction-details');
                const deadlineElement = auctionDetails.find('.deadline');
                const deadline = new Date(deadlineElement.data('deadline'));

                if (currentServerTime && currentServerTime.getTime() >= deadline.getTime()) {
                    alert('경매 시간이 종료되어 등록할 수 없습니다.');
                    return;
                }
                var formData = $(this).serialize();

                $.ajax({
                    url: $(this).attr('action'),
                    method: 'PUT',
                    data: formData,
                    success: function(response) {
                        const messages = {
                                'emptyCurrentPrice': '입찰가을 입력하세요.',
                                'maxCurrentPrice': '상한가를 넘게 입력하셧습니다. 다시 입력하세요.',
                                'lowCurrentPrice': '현재 등록된 입찰가보다 낮게 입력하셧습니다. 다시 입력하세요.',
                                'overDate':'경매 마감시간이 지났습니다.',
                                'noMoney':'충전된 돈이 입력하신 금액에 비해 부족합니다.',
                                'duplicateUserId':'이미 입찰금액을 등록하셨습니다.',
                                'ok': '경매 등록 성공!',
                                'no': '경매 등록 실패!'
                            };
                        if (response in messages) {
                            alert(messages[response]);
                            if (response === 'ok') {
                                location.reload();
                            }
                            return;
                        }

                        alert('알 수 없는 응답: ' + response);
                        return;
                    },
                    error: function(xhr, status, error) {
                        console.error('경매 등록에 실패하였습니다:', error);
                        alert("오류 발생");
                    }
                });
            });

            $('.auction-cancel-form').submit(function(event) {
                event.preventDefault();
                var formData = $(this).serialize();

                $.ajax({
                    url: $(this).attr('action'),
                    method: 'PUT',
                    data: formData,
                    success: function(response) {
                        const messages = {
                                'ok': '경매 취소 성공!',
                                'no': '경매 취소 실패!'
                            };
                        if (response in messages) {
                            alert(messages[response]);
                            if (response === 'ok') {
                                location.reload();
                            }
                            return;
                        }

                        alert('알 수 없는 응답: ' + response);
                        return;
                    },
                    error: function(xhr, status, error) {
                        console.error('경매 취소에 실패하였습니다:', error);
                        alert("오류 발생");
                    }
                });


            });
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
                <div class="dropdown-menu"  id="lendServed">

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
                <h3><c:out value="${userId}"/>님의 경매 목록</h3>
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
            <div class="col-md-8">
                <div class="row auction-list">
                    <ul class="nav nav-pills">
                       <li class="nav-item dropdown">
                           <a class="nav-link dropdown-toggle" id="statusLink" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">상태</a>
                           <div class="dropdown-menu" style="">
                               <a class="dropdown-item" href="/auction/${userId}" id="auctionStatus">경매중</a>
                               <a class="dropdown-item" href="/auction/${userId}/complete" id="auctionComplete">경매완료</a>
                           </div>
                       </li>
                    </ul>
                    <c:choose>
                        <c:when test="${auctions eq null or empty auctions}">
                            <div class="col-md-8">
                                경매 목록이 존재하지 않습니다
                            </div>
                        </c:when>
                        <c:otherwise>
                           <c:forEach var="auction" items="${auctions}">
                                <div class="col-md-4">
                                    <div class="card">
                                        <h5 class="card-header">
                                            <c:out value="${auction.boards[0].title}"/>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                            <a href="/board/${auction.boards[0].boardId}">
                                                <img src="/postimage/${auction.boards[0].itemImage1}" alt="대체_텍스트" style="width: 180px; height: 100px;">
                                            </a>
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                           <c:choose>
                                                <c:when test="${auction.boards[0].isAuction eq 0}">
                                                    <p><span class="badge bg-danger">경매전</span>
                                                </c:when>
                                                <c:when test="${auction.boards[0].isAuction eq 1}">
                                                    <p><span class="badge bg-danger">경매중</span>
                                                </c:when>
                                                <c:when test="${auction.boards[0].isAuction eq 2}">
                                                    <p><span class="badge bg-danger">경매완료</span>
                                                </c:when>
                                           </c:choose>
                                           <c:choose>
                                                <c:when test="${auction.boards[0].isLend eq 0}">
                                                    <span class="badge bg-success">대여전</span>
                                                </c:when>
                                                <c:when test="${auction.boards[0].isLend eq 1}">
                                                    <span class="badge bg-success">대여중</span>
                                                </c:when>
                                                <c:when test="${auction.boards[0].isLend eq 2}">
                                                    <span class="badge bg-success">대여완료</span>
                                                </c:when>
                                           </c:choose>
                                           <br>
                                           <span><c:out value="${auction.boards[0].itemName}"/></span>
                                           <c:if test="${auction.boards[0].isAuction eq 1}">
                                                <p>현재 경매 가격: <fmt:formatNumber value="${auction.currentPrice}" pattern="#,###"/>원 </p>
                                           </c:if>
                                           <c:choose>
                                                <c:when test="${auction.boards[0].isAuction eq 1}">
                                                    <p>최근 내가 올린 가격: <fmt:formatNumber value="${auction.participantAuctions[0].currentPrice}" pattern="#,###"/>원</p>
                                                </c:when>
                                                <c:when test="${auction.boards[0].isAuction eq 2}">
                                                    <p>낙찰 가격: <fmt:formatNumber value="${auction.currentPrice}" pattern="#,###"/>원</p>
                                                </c:when>
                                           </c:choose>
                                           <c:choose>
                                                <c:when test="${auction.boards[0].isAuction eq 1}">
                                                    <p>현재 최고가를 올린사람:
                                                </c:when>
                                                <c:when test="${auction.boards[0].isAuction eq 2}">
                                                    <p>낙찰자:
                                                </c:when>
                                           </c:choose>
                                           <c:choose>
                                                <c:when test="${auction.userId eq null}">
                                                    아직 없습니다
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${auction.userId}"/>님
                                                </c:otherwise>
                                           </c:choose>
                                           </p>
                                           <span>관심 <c:out value="${auction.boards[0].interestCnt}"/></span>
                                           <span>조회 <c:out value="${auction.boards[0].hits}"/></span>
                                           <div class="form-check form-switch">
                                              <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault">
                                              <label class="form-check-label" for="flexSwitchCheckDefault">가격 올리기</label>
                                           </div>
                                           <div class="auction-details">
                                                <div class="auction-details-content">
                                                    <h6>경매 마감 : <span class="deadline" data-deadline="${auction.boards[0].deadline}">
                                                    </span></h6>
                                                    <c:if test="${auction.boards[0].isAuction eq 1}">
                                                        <h6>현재 입찰 가격 : <fmt:formatNumber value="${auction.currentPrice}" pattern="#,###"/>원</h6>
                                                        <h6>상한가 : <fmt:formatNumber value="${auction.maxPrice}" pattern="#,###"/>원</h6>
                                                    </c:if>
                                                </div>
                                                <form class="d-flex auction-form" method="post" action="/auction/${auction.auctionId}/current-price">
                                                    <input type="hidden" name="_method" value="put">
                                                    <input type="hidden" name="userId" value="${userId}">
                                                    <input type="text" name="currentPrice" style="margin-top:10px" placeholder="가격을 올려주세요" autocomplete='off'/>
                                                    <button type="submit" class="btn btn-primary btn-sm" style="margin-top:10px">가격 올리기</button>
                                                </form>
                                                <form class="d-flex auction-cancel-form" method="post" action="/auction/${userId}/cancel">
                                                    <input type="hidden" name="_method" value="put">
                                                    <input type="hidden" name="auctionId" value="${auction.auctionId}">
                                                    <button type="submit" class="btn btn-danger btn-sm">경매 취소</button>
                                                </form>
                                                <input type="hidden" name="auctionId" value="${auction.auctionId}">
                                           </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="col-md-2">
            </div>
        </div>

        <br>
        <c:if test="${not (auctions eq null or empty auctions)}">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-4">
                        </div>
                        <div class="col-md-4">
                            <nav>
                                <c:out value="${pageNavi}" escapeXml="false"/>
                            </nav>
                        </div>
                        <div class="col-md-4">
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </c:if>
    </div>
</body>
