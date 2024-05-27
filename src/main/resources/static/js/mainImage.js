document.addEventListener("DOMContentLoaded", function() {

    var manImageDiv = document.getElementById("mainImage");

    var imgElement1 = document.createElement("img");
    imgElement1.src = "/images/main/smile.jpeg";
    imgElement1.style.width = "90%";
    imgElement1.style.height = "500px";
    imgElement1.style.margin = "0 auto";
    imgElement1.style.display = "block";
    var imgElement2 = document.createElement("img");
    imgElement2.src = "/images/main/family1.jpeg";
    imgElement2.style.width = "90%";
    imgElement2.style.height = "500px";
    imgElement2.style.margin = "0 auto";
    imgElement2.style.display = "block";
    var imgElement3 = document.createElement("img");
    imgElement3.src = "/images/main/family2.jpeg";
    imgElement3.style.width = "90%";
    imgElement3.style.height = "500px";
    imgElement3.style.margin = "0 auto";
    imgElement3.style.display = "block";

    manImageDiv.appendChild(imgElement1);
    manImageDiv.appendChild(imgElement2);
    manImageDiv.appendChild(imgElement3);

    // 슬라이드 이미지들을 선택
    var slides = manImageDiv.getElementsByTagName("img");
    var totalSlides = slides.length;
    var currentIndex = 0;

    // 모든 슬라이드 숨기기
    for (var i = 0; i < totalSlides; i++) {
        slides[i].style.display = "none";
    }

    // 첫 번째 슬라이드 표시
    slides[currentIndex].style.display = "block";

    // 다음 이미지를 보여주는 함수
    function showNextSlide() {
        slides[currentIndex].style.display = "none"; // 현재 이미지를 숨김
        currentIndex = (currentIndex + 1) % totalSlides; // 다음 이미지의 인덱스 계산
        slides[currentIndex].style.display = "block"; // 다음 이미지를 보여줌
    }

    // 일정 시간마다 다음 이미지를 보여주는 타이머
    setInterval(showNextSlide, 3000); // 3초마다 다음 이미지를 보여줌 (1000 = 1초)

});
