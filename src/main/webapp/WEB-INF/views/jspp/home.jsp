<!DOCTYPE HTML>
<!--
	Eventually by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
	<head>
	<!-- 부트스트랩 CSS -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
      <!-- Swiper CSS -->
      <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
      <style>
        .swiper-container {
              width: 100%;
              height: 400px; /* 슬라이드의 높이 설정 */
            }
        .swiper-slide {
          display: inline-block;
          width: auto; /* 각 슬라이드의 너비를 자동으로 조정 */
        }
        .swiper-slide img {
              width: 100%;
              height: 100%; /* 이미지를 슬라이드에 꽉 채우도록 설정 */
              object-fit: cover; /* 이미지 비율 유지 및 부모 요소에 꽉 채우기 */
            }
      </style>
		<title>Eventually by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>

	<body class="is-preload">

		<!-- Header -->
			<header id="header">
				<h1 style="display: flex; align-items: center;">
                    <img src="/images/icon/logo.png" style="width: 50px; height: auto; margin-right: 10px;">
                    무엇을 빌리고 싶으신가요?
                </h1>
				<p>사기에는 아까운 물건이 있으세요?<br>
				    쓰지 않는 물건이 있으세요? <br>
				    썸띵랜드에서 빌리고 빌려주세요!</p>
			</header>

		<!-- Signup Form -->
		<form id="signup-form" method="get" action="/board/search">
			<input type="text" name="searchTerm" id="searchTerm" placeholder="빌리고 싶은 물건을 입력하세요" />
			<input type="submit" value="빌려주세요" />
			<input type="submit" value="빌려드려요" />
		</form>


		<!-- Footer -->

			<footer id="footer">
			</footer>




		<!-- Scripts -->
			<script src="assets/js/main.js"></script>

            <!-- 부트스트랩 JS 및 종속성 -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
            <!-- Swiper JS -->
            <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	</body>

	<script>
      $(document).ready(function() {
        var swiper = new Swiper('.swiper-container', {
          slidesPerView: 'auto', // 자동으로 슬라이드 개수 조정
          spaceBetween: 15, // 슬라이드 사이 간격 설정
          loop: true, // 무한 루프 설정
          autoplay: {
            delay: 2000, // 2초마다 이미지 이동
            disableOnInteraction: false, // 사용자 상호 작용 후에도 자동 재생 유지
          },
          pagination: {
            el: '.swiper-pagination', // 페이징 요소 클래스 지정
            clickable: true, // 페이징 요소를 클릭하여 이동 가능
          },
        });

        document.getElementById('signup-form').addEventListener('submit', function (event) {
                    // 폼 제출을 방지합니다.
                    event.preventDefault();

                    // 폼을 직접 제출합니다.
                    this.submit();
                });
      });
    </script>
</html>

