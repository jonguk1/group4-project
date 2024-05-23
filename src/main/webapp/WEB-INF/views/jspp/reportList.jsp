<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/menuControl.js"></script>
    <script src="/js/notification.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/notification.css">
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        a {
          text-decoration-line: none;
        }
    </style>
    <script>
        $(document).ready(function() {
            $('.test').click(function(event) {
                event.preventDefault();
                var writer = this.getAttribute('data-writer');
                fetchReportsWriter(writer);
            });

            $(document).on('click', '.page2 .pagination .page-link', function(event) {
                event.preventDefault();

                var pageNum = $(this).attr('href').split('=')[1];

                console.log("pageNum:" + pageNum);

                var href = $(this).attr('href');
                var parts = href.split('/');
                var writer = parts[parts.length - 1];
                writer = writer.split('?')[0];

                console.log("writer:" + writer);

                fetchReportsWriterPage(writer, pageNum);
            });

            $('.btn-primary').click(function(event) {
                event.preventDefault();
                var writer = $(this).closest('tr').find('.test').data('writer');

                if (confirm(writer + "님을 영구적으로 정지하시겠습니까?")) {
                    $.ajax({
                        url: '/report/' + writer + '/ban',
                        method: 'PUT',
                        success: function(response) {
                            if (response === "ok") {
                                alert(writer+"님을 영구적으로 정지하였습니다");
                                location.reload();
                            } else {
                                alert("정지에 실패하였습니다");
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('AJAX request failed:', error);
                        }
                    });
                }
            });
        });

        function fetchReportsWriter(writer) {
            $.ajax({
                url: '/report/' + writer,
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    let str='';
                    str +=`
                        <div class="row">
                            <div class="col-md-2">
                            </div>
                            <div class="col-md-8 text-left">
                                <h3>
                                    \${writer}님의 신고목록
                                </h3>
                            </div>
                            <div class="col-md-2">
                            </div>
                        </div>

                        <br>
                    `;
                    str+=`
                    <div class="container-fluid" style="margin-left:50px;">
                        <div class="row">
                            <div class="col-md-2" style="margin-right:30px" >
                            </div>
                            <div class="col-md-8">
                                <table class="table">
                                    <tr>
                                      <th scope="col">신고자</th>
                                      <th scope="col">제목</th>
                                      <th scope="col">내용</th>
                                      <th scope="col">작성일</th>
                                    </tr>
                        `;
                    $(data.reportsWriter).each(function(i, item){
                        str+=`
                            <tr style="font-size:1.25rem">
                              <td>\${item.userId}</td>
                              <td>\${item.title}</td>
                              <td>\${item.content}</td>
                              <td>\${formatDate(item.regDate)}</td>
                            </tr>
                        `;
                    })
                    str+=`
                                </table>
                            </div>

                            <div class="col-md-2">
                            </div>
                        </div>

                        <div class="row" style="margin-left:300px">
                            <div class="col-md-2">
                            </div>
                            <div class="col-md-8">
                                <nav class="page2">
                                    \${data.pageNavi}
                                </nav>
                            </div>
                            <div class="col-md-2">
                            </div>
                        </div>
                    </div>
                    `;
                    $('#result').html(str);
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 요청 실패:', error);
                }
            });
        }
        function fetchReportsWriterPage(writer, pageNum) {
            $.ajax({
                url: '/report/' + writer + '?pageNum=' + pageNum,
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log(data)
                    updatePage(data);
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 요청 실패:', error);
                }
            });
        }

        function updatePage(data) {
            let str='';
            str +=`
                <div class="row">
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-8 text-left">
                        <h3>
                            \${data.writer}님의 신고목록
                        </h3>
                    </div>
                    <div class="col-md-2">
                    </div>
                </div>
                <br>
            `;
            str+=`
            <div class="container-fluid" style="margin-left:50px;">
                <div class="row">
                    <div class="col-md-2" style="margin-right:30px" >
                    </div>
                    <div class="col-md-8">
                        <table class="table">
                            <tr>
                              <th scope="col">신고자</th>
                              <th scope="col">제목</th>
                              <th scope="col">내용</th>
                              <th scope="col">작성일</th>
                            </tr>
                `;
            $(data.reportsWriter).each(function(i, item){
                str+=`
                    <tr style="font-size:1.25rem">
                      <td>\${item.userId}</td>
                      <td>\${item.title}</td>
                      <td>\${item.content}</td>
                      <td>\${formatDate(item.regDate)}</td>
                    </tr>
                `;
            })
            str+=`
                        </table>
                    </div>

                    <div class="col-md-2">
                    </div>
                </div>

                <div class="row" style="margin-left:300px">
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-8">
                        <nav class="page2">
                            \${data.pageNavi}
                        </nav>
                    </div>
                    <div class="col-md-2">
                    </div>
                </div>
            </div>
            `;
            $('#result').html(str);
        }

        function formatDate(dateTimeString) {
            var date = new Date(dateTimeString);
            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString().padStart(2, '0');
            var day = date.getDate().toString().padStart(2, '0');
            var hours = date.getHours().toString().padStart(2, '0');
            var minutes = date.getMinutes().toString().padStart(2, '0');
            var seconds = date.getSeconds().toString().padStart(2, '0');

            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
        }
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
                                                <a class="nav-link" href="#">
                                                    <img src="/images/icon/notificationIcon.png" id="notificationIcon" style="width:30px; height:30px;">
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

   <br>


    <div class="row">
        <div class="col-md-2">
        </div>
        <div class="col-md-8 text-left">
           	<h3>
           	    신고목록
           	</h3>
        </div>
        <div class="col-md-2">
        </div>
    </div>

    <br>
    <c:choose>
        <c:when test="${reports eq null or empty reports}">
            <div class="container-fluid" style="margin-left:50px;">
                <div class="row">
                    <div class="col-md-2" style="margin-right:30px" >
                    </div>
                    <div class="col-md-8">
                        등록된 신고 목록이 없습니다
                    </div>
                    <div class="col-md-2" style="margin-right:30px" >
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="container-fluid" style="margin-left:50px;">
                <div class="row">
                    <div class="col-md-2" style="margin-right:30px" >
                    </div>
                    <div class="col-md-8">
                        <table class="table">
                            <tr>
                              <th scope="col">악성 유저</th>
                              <th scope="col">신고 횟수</th>
                              <th scope="col">정지(5회 이상)</th>
                            </tr>
                            <c:forEach var="report" items="${reports}" varStatus="status">
                                <tr style="font-size:1.25rem">
                                    <td>
                                    <a href="javascript:void(0);" class="test" data-writer="${report.boards[0].writer}">
                                        <c:out value="${report.boards[0].writer}"/>
                                    </a>
                                    </td>
                                    <td><c:out value="${report.writerCnt}"/>회</td>
                                    <td>
                                        <c:if test="${report.writerCnt >=5}">
                                            <button type="button" class="btn btn-primary">정지</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>

                    <div class="col-md-2">
                    </div>
                </div>

                <div class="row" style="margin-left:300px">
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-8">
                        <nav>
                            <c:out value="${pageNavi}" escapeXml="false"/>
                        </nav>
                    </div>
                    <div class="col-md-2">
                    </div>
                </div>
            </div>

            <div id="result"></div>
            </div>
        </c:otherwise>
    </c:choose>
</body>