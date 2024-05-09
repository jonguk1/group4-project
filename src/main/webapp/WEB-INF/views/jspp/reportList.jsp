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
    <meta charset="UTF-8">
    <title>Title</title>
    <script>
        $(function(){
            $('.test').click(function(e){
                var index=$('.index').val();
                alert(index);
            })
        })
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
                    <div class="input-group mt-3">
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
                            <a href="#" class="test">
                                <c:out value="${report.boards[0].writer}"/>
                                <input type="text" class="index" value="${status.index}"/>
                            </a>
                            </td>
                            <td><c:out value="${report.writerCnt}"/>회</td>
                            <td>
                                <c:if test="${report.writerCnt >=6}">
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
    <div class="row">
        <div class="col-md-2">
        </div>
        <div class="col-md-8 text-left">
            <h3>
                테스트님의 신고목록
            </h3>
        </div>
        <div class="col-md-2">
        </div>
    </div>

    <br>

    <div class="container-fluid" style="margin-left:50px;">
        <div class="row">
            <div class="col-md-2" style="margin-right:30px" >
            </div>
            <div class="col-md-8">
                <table class="table">
                    <tr>
                      <th scope="col">작성자</th>
                      <th scope="col">제목</th>
                      <th scope="col">내용</th>
                      <th scope="col">등록일</th>
                    </tr>
                    <tr style="font-size:1.25rem">
                        <td>작성자1</td>
                        <td>신고합니다</td>
                        <td>신고합니다</td>
                        <td>2023/04/01 23:00:01</td>
                    </tr>
                    <tr style="font-size:1.25rem">
                        <td>작성자1</td>
                        <td>신고합니다</td>
                        <td>신고합니다</td>
                        <td>2023/04/01 23:00:01</td>
                    </tr>
                     <tr style="font-size:1.25rem">
                         <td>작성자1</td>
                         <td>신고합니다</td>
                         <td>신고합니다</td>
                         <td>2023/04/01 23:00:01</td>
                     </tr>
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
                    <ul class="pagination">
                        <li class="page-item disabled">
                          <a class="page-link" href="#">&laquo;</a>
                        </li>
                        <li class="page-item active">
                          <a class="page-link" href="#">1</a>
                        </li>
                        <li class="page-item">
                          <a class="page-link" href="#">2</a>
                        </li>
                        <li class="page-item">
                          <a class="page-link" href="#">3</a>
                        </li>
                        <li class="page-item">
                          <a class="page-link" href="#">4</a>
                        </li>
                        <li class="page-item">
                          <a class="page-link" href="#">5</a>
                        </li>
                        <li class="page-item">
                          <a class="page-link" href="#">&raquo;</a>
                        </li>
                      </ul>
                </nav>
            </div>
            <div class="col-md-2">
            </div>
        </div>
    </div>
</body>
