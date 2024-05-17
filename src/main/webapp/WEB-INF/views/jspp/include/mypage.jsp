
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div class="accordion" id="accordionExample">
     <div class="accordion-item">
       <h2 class="accordion-header" id="headingOne">
         <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
           마이페이지
         </button>
       </h2>
       <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
         <div class="accordion-body">
            <div class="list-group">
              <a href="/user/${userId}" class="list-group-item list-group-item-action">내 정보</a>
              <a href="/favorite/${userId}" class="list-group-item list-group-item-action">관심 목록</a>
              <a href="/user/${userId}/lender" class="list-group-item list-group-item-action">빌려준 목록</a>
              <a href="/user/${userId}/lendy" class="list-group-item list-group-item-action">빌린 목록</a>
              <a href="/review/${userId}/sent" class="list-group-item list-group-item-action">보낸 리뷰 목록</a>
              <a href="/review/${userId}/received" class="list-group-item list-group-item-action">받은 리뷰 목록</a>
              <a href="/user/${userId}/block" class="list-group-item list-group-item-action">차단 목록</a>
              <a href="/auction/${userId}" class="list-group-item list-group-item-action">내 경매 목록</a>
            </div>
         </div>
       </div>
     </div>
</div>