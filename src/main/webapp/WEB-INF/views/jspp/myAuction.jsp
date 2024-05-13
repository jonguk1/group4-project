<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Title</title>
    <script>
        function displayServerTime() {
            const eventSource = new EventSource('/time/${userId}');

            eventSource.onmessage = function(event) {
                const serverTime = new Date(event.data);
                const deadlineElements = document.querySelectorAll('.deadline');

                deadlineElements.forEach(deadlineElement => {
                     const deadline = new Date(deadlineElement.dataset.deadline);
                     const timeDifference = deadline.getTime() - serverTime.getTime();

                     if(timeDifference<=0){
                        return deadlineElement.innerText = "경매시간이 종료되었습니다";
                     }
                     const formattedDifference = formatTimeDifference(timeDifference);
                     deadlineElement.innerText = formattedDifference;

                });
            };
        }

        function formatTimeDifference(timeDifference) {
            const millisecondsInDay = 1000 * 60 * 60 * 24;

            if (timeDifference < millisecondsInDay) {
                const hours = Math.floor(timeDifference / (1000 * 60 * 60));
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

        $(document).ready(function() {
            $('.auction-details').hide();

            $('.form-check-input').change(function() {
                // 현재 스위치의 부모 요소인 .card를 찾음
                var card = $(this).closest('.card');
                // 해당 .card 내의 .auction-details를 찾음
                var details = card.find('.auction-details');

                // 현재 스위치와 연관된 .auction-details를 표시 또는 숨김
                details.toggle($(this).prop('checked'));
            });

            displayServerTime();

            $('.auction-form').submit(function(event) {
                event.preventDefault();
                var formData = $(this).serialize();

                $.ajax({
                    url: $(this).attr('action'),
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        if (response === 'emptyCurrentPrice') {
                            alert('금액을 입력하세요.');
                        }else if(response === 'maxCurrentPrice'){
                            alert('상한가를 넘게 입력하셧습니다. 다시 입력하세요');
                        }else if (response === 'ok') {
                            alert('경매 등록 성공!');
                            location.reload();
                        } else if (response === 'no') {
                            alert('경매 등록 실패!');
                        } else {
                            alert('알 수 없는 응답: ' + response);
                        }
                    },
                    error: function(xhr, status, error) {
                        // 요청이 실패했을 때 처리
                        console.error('Failed to update auction price:', error);
                        alert('서버와의 통신에 문제가 발생했습니다. 나중에 다시 시도해주세요.');
                    }
                });
            });
        });


    </script>
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

   <div class="row">
        <div class="col-md-2">
        </div>
        <div class="col-md-8 text-center">

        <span>
                <h3><c:out value="${userId}"/>님의 경매</h3>
                <div id="serverTime"></div>
        </span>

        </div>
        <div class="col-md-2">
        </div>
    </div>

       	<br><br>
   <div class="row">
        <div class="col-md-2" style="margin-left:25px">
            <%@ include file="/WEB-INF/views/jspp/include/mypage.jsp"%>
        </div>
        <div class="col-md-8">
            <div class="row auction-list">
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
                                        <div class="form-check form-switch">
                                          <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault">
                                          <label class="form-check-label" for="flexSwitchCheckDefault">가격 올리기</label>
                                        </div>
                                    </h5>
                                    <div class="card-body">
                                        <p class="card-text">
                                            <img src="/images/${auction.boards[0].itemImage1}" alt="대체_텍스트" style="width: 180px; height: 100px;">
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
                                                <p><span class="badge bg-danger">경매후</span>
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
                                                <span class="badge bg-success">대여후</span>
                                            </c:when>
                                        </c:choose>
                                        <br>
                                        <span><c:out value="${auction.boards[0].itemName}"/></span>
                                        <span><fmt:formatNumber value="${auction.boards[0].price}" pattern="#,###"/>원</span>
                                        <p>강원도 영월군 구포읍</p>
                                        <span>관심 <c:out value="${auction.boards[0].interestCnt}"/></span>
                                        <span>조회 <c:out value="${auction.boards[0].hits}"/></span>
                                        <br><br>
                                        <div class="auction-details">
                                            <h6>경매 마감 : <span class="deadline" data-deadline="${auction.boards[0].deadline}">
                                            </span></h6>
                                            <h6>현재 가격 : <fmt:formatNumber value="${auction.currentPrice}" pattern="#,###"/>원</h6>
                                            <h6>상한가 : <fmt:formatNumber value="${auction.maxPrice}" pattern="#,###"/>원</h6>
                                            <form class="d-flex auction-form" method="post" action="/auction/${auction.auctionId}/current-price">
                                                <input type="hidden" name="_method" value="put">
                                                <input type="text" name="currentPrice" style="margin-top:10px" placeholder="가격을 올려주세요"/>
                                                <button type="submit" class="btn btn-primary btn-sm" style="margin-top:10px">가격 올리기</button>
                                            </form>
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
</body>