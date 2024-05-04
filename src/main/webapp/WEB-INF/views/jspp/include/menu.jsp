<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

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
                <div class="dropdown-menu" id="lendServe">

                </div>
            </li>

            <li class="nav-item dropdown text-center">
                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려드려요</a>
                <div class="dropdown-menu"  id="lendServed">

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


