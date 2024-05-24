        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


        <!DOCTYPE html>
        <html lang="en">
        <head>

            <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=k495h0yzln"></script>


            <link rel="stylesheet" href="/css/bootstrap.min.css">

            <meta charset="UTF-8">
            <title>Title</title>

            <style>
                .alert {
                  position: fixed;
                  top: 50%;
                  left: 50%;
                  transform: translate(-50%, -50%);
                  padding: 20px;
                  background-color: #f44336; /* 빨간색 */
                  color: white;
                  display: none;
                  z-index: 1000; /* 다른 요소들 위에 나타나도록 */
                }

            </style>
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
                                        <li class="nav-item">
                                            <c:if test="${loggedIn}">
                                                <a class="nav-link" href="#" id="notificationIcon">
                                                    <img src="/images/icon/notificationIcon.png"  style="width:30px; height:30px;">
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
           <div class="container-fluid">
               <div class="row">
                   <div class="col-md-3"></div>
                   <div class="col-md-6 text-center">
                       <div class="row">
                           <div class="col-md-10">
                               <div class="row">
                                   <div class="col-md-2"></div>
                                   <div class="col-md-10 text-center">
                                       <c:if test="${not empty postById.isMegaphone}">
                                           <c:if test="${postsBySearchTerm[0].isMegaphone eq '급구'}">

                                               <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                           </c:if>
                                       </c:if>
                                       <span class="badge bg-danger">
                                           ${postById.isAuction}
                                       </span>
                                       <span class="badge bg-success">
                                           ${postById.isLend}
                                       </span>
                                   </div>
                               </div>
                           </div>
                           <div class="col-md-2 text-end">
                               <a href="#" onclick="sendEditRequest()">
                                   <img src="/images/icon/editIcon.png" style="width:25px; height:25px;">
                               </a>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3"></div>
               </div>
           </div>

                <br>

                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 text-center">
                        <span>
                            <h2>
                            ${postById.title}
                            </h2>
                        </span>
                    </div>
                    <div class="col-md-3"></div>
                </div>

                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 " >
                        <div id="myCarousel" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                <li data-target="#myCarousel" data-slide-to="1"></li>
                                <li data-target="#myCarousel" data-slide-to="2"></li>
                            </ol>

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner ">
                                  <c:if test="${not empty postById.itemImage[0]}">
                                    <div class="carousel-item active">
                                        <img src="${postById.itemImage[0]}" alt="Image 1" style="width: 100%; height: 500px;">

                                    </div>
                                  </c:if>

                                <c:if test="${not empty postById.itemImage[1]}">
                                    <div class="carousel-item">
                                        <img src="${postById.itemImage[1]}" alt="Image 1" style="width: 100%; height: 500px;">

                                    </div>
                                </c:if>

                                <c:if test="${not empty postById.itemImage[2]}">
                                    <div class="carousel-item">
                                        <img src="${postById.itemImage[2]}" alt="Image 1" style="width: 100%; height: 500px;">

                                    </div>
                                </c:if>
                            </div>

                            <!-- Left and right controls -->
                            <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">이전 사진</span>
                            </a>
                            <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">다음 사진</span>
                            </a>
                        </div>

                    </div>
                    <div class="col-md-3"></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                            <span>
                                 <img src="/images/people.png" alt="대체_텍스트" style="width: 50px;">
                            </span>
                                <a href="/user/${postById.writer}"><span>${postById.writer}</span></a>
                            <span>

                                <button type="button" class="btn btn-primary" onclick="chat()">채팅</button>
                            </span>
                            <span>
                                <c:if test="${not empty postById.isAuction and postById.isAuction ne '경매 불가'}">
                                    <button type="button" id="auctionButton" class="btn btn-primary">경매</button>
                                </c:if>
                            </span>

                            <span>
                                <button type="button" id="interestButton" class="btn btn-primary">관심</button>
                            </span>

                            <span>
                                <a href="#" id="blockUserLink">
                                    <img src="/images/ban.png" alt="대체" style="width: 50px; height:20px;">
                                </a>
                                <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
                                  <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                      <div class="modal-header">
                                        <h5 class="modal-title" id="confirmModalLabel">유저를 차단하겠습니까?</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                          <span aria-hidden="true">&times;</span>
                                        </button>
                                      </div>
                                      <div class="modal-body">
                                        차단한 유저는 더 이상 접근할 수 없습니다. 계속하시겠습니까?
                                      </div>
                                      <div class="modal-footer">
                                        <button type="button" id="cancelButton" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                        <button type="button" id="confirmButton" class="btn btn-primary">확인</button>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                            </span>

                            <span>
                                <img src="/images/singo.png" alt="대체" style="width: 50px; height:20px;">
                            </span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postById.regDate}</span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span id="address"><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">${postById.address}</span>
                        <c:if test="${loggedIn}">
                            <span style="color: orange;"> (${postById.distance}km)</span>
                        </c:if>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span id="price"><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postById.price}원</span>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

               <div class="row">
                   <div class="col-md-3">
                   </div>
                   <div class="col-md-6">
                       <span id="returnDate">
                           <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">&nbsp; 반납 희망일 :
                           <c:choose>
                               <c:when test="${postById.returnDate ne null}">
                                   ${postById.returnDate}
                               </c:when>
                               <c:otherwise>
                                   미정
                               </c:otherwise>
                           </c:choose>
                       </span>
                   </div>
                   <div class="col-md-3">
                   </div>
               </div>

              <div class="row">
                  <div class="col-md-3">
                  </div>
                  <div class="col-md-6">
                      <span id="deadline">
                          <c:if test="${postById.isAuction ne '경매 불가'}">
                            <img src="/images/icon/auctionIcon.png" style="width:25px; height:25px;">
                            경매 마감일 : ${postById.deadline}
                          </c:if>
                      </span>
                  </div>
                  <div class="col-md-3">
                  </div>
              </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <hr>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <p> ${postById.content}</p>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <span id="interestCnt"><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postById.interestCnt}</span>&nbsp;
                        <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postById.hits}</span>
                        <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 12</span>

                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                    <hr>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-4">
                                <span class="text-primary-emphasis">같은 물건 다른 글</span>
                            </div>
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-4 text-end">
                                <a class="nav-link"  href="/board?boardCategoryId=${postById.boardCategoryId}&itemCategoryId=${postById.itemCategoryId}"><span>전체글 보기</span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <br>
                <c:if test="${not empty postsBySearchTerm[0]}">
                <div class="row">
                        <div class="col-md-3">
                        </div>
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                        <h5 class="card-header">
                                            <c:if test="${postsBySearchTerm[0].isMegaphone eq '급구'}">

                                                    <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                            </c:if>
                                            <span>${postsBySearchTerm[0].title}</span>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <a href="/board/${postsBySearchTerm[0].boardId}">
                                                    <img src="${postsBySearchTerm[0].imgSrc}" alt="대체_텍스트" style="width: 200px; height: 200px;">
                                                </a>
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <span class="badge bg-danger">${postsBySearchTerm[0].isAuction}</span>
                                            <span class="badge bg-success">${postsBySearchTerm[0].isLend}</span>
                                            <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[0].regDate}</div>
                                            <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[0].address}</div>
                                            <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[0].price}원</div>
                                            <div>
                                                <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                <c:choose>
                                                    <c:when test="${postsBySearchTerm[0].returnDate ne null}">
                                                        ${postsBySearchTerm[0].returnDate}
                                                    </c:when>
                                                    <c:otherwise>
                                                        미정
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[0].interestCnt}</span>
                                            <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                            <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[0].hits}</span>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty postsBySearchTerm[1]}">
                                <div class="col-md-4">
                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                        <h5 class="card-header">
                                            <c:if test="${postsBySearchTerm[1].isMegaphone eq '급구'}">

                                                    <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                            </c:if>
                                            <span>${postsBySearchTerm[1].title}</span>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <a href="/board/${postsBySearchTerm[1].boardId}">
                                                    <img src="${postsBySearchTerm[1].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                </a>
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <span class="badge bg-danger">${postsBySearchTerm[1].isAuction}</span>
                                            <span class="badge bg-success">${postsBySearchTerm[1].isLend}</span>
                                            <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[1].regDate}</div>
                                            <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[1].address}</div>
                                            <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[1].price}원</div>
                                            <div>
                                                <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                <c:choose>
                                                    <c:when test="${postsBySearchTerm[1].returnDate ne null}">
                                                        ${postsBySearchTerm[1].returnDate}
                                                    </c:when>
                                                    <c:otherwise>
                                                        미정
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[1].interestCnt}</span>
                                            <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                            <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[1].hits}</span>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                                <c:if test="${not empty postsBySearchTerm[2]}">
                                <div class="col-md-4">
                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                        <h5 class="card-header">
                                            <c:if test="${postsBySearchTerm[2].isMegaphone eq '급구'}">

                                                    <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                            </c:if>
                                            <span>${postsBySearchTerm[2].title}</span>
                                        </h5>
                                        <div class="card-body">
                                            <p class="card-text">
                                                <a href="/board/${postsBySearchTerm[2].boardId}">
                                                    <img src="${postsBySearchTerm[2].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                </a>
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <span class="badge bg-danger">${postsBySearchTerm[2].isAuction}</span>
                                            <span class="badge bg-success">${postsBySearchTerm[2].isLend}</span>
                                            <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[2].regDate}</div>
                                            <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[2].price}원</div>
                                            <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[2].address}</div>
                                            <div>
                                                <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                <c:choose>
                                                    <c:when test="${postsBySearchTerm[2].returnDate ne null}">
                                                        ${postsBySearchTerm[2].returnDate}
                                                    </c:when>
                                                    <c:otherwise>
                                                        미정
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[2].interestCnt}</span>
                                            <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                            <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[2].hits}</span>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-3">
                        </div>
                    </div>
                </c:if>
                <br>
                 <c:if test="${not empty postsBySearchTerm[3]}">
                <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="card border-light mb-3" style="max-width: 20rem;">
                                                <h5 class="card-header">

                                                    <c:if test="${postsBySearchTerm[3].isMegaphone eq '급구'}">

                                                            <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                    </c:if>
                                                    <span>${postsBySearchTerm[3].title}</span>
                                                </h5>
                                                <div class="card-body">
                                                    <p class="card-text">
                                                        <a href="/board/${postsBySearchTerm[3].boardId}">
                                                            <img src="${postsBySearchTerm[3].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                        </a>
                                                    </p>
                                                </div>
                                                <div class="card-footer">
                                                    <span class="badge bg-danger">${postsBySearchTerm[3].isAuction}</span>
                                                    <span class="badge bg-success">${postsBySearchTerm[3].isLend}</span>
                                                    <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[3].regDate}</div>
                                                    <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[3].address}</div>
                                                    <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[3].price}원</div>
                                                    <div>
                                                        <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                        <c:choose>
                                                            <c:when test="${postsBySearchTerm[3].returnDate ne null}">
                                                                ${postsBySearchTerm[3].returnDate}
                                                            </c:when>
                                                            <c:otherwise>
                                                                미정
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[3].interestCnt}</span>
                                                    <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                    <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[3].hits}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${not empty postsBySearchTerm[4]}">
                                        <div class="col-md-4">

                                            <div class="card border-light mb-3" style="max-width: 20rem;">
                                                <h5 class="card-header">
                                                    <c:if test="${postsBySearchTerm[4].isMegaphone eq '급구'}">

                                                            <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                    </c:if>
                                                    <span>${postsBySearchTerm[4].title}</span>
                                                </h5>
                                                <div class="card-body">
                                                    <p class="card-text">
                                                        <a href="/board/${postsBySearchTerm[4].boardId}">
                                                            <img src="${postsBySearchTerm[4].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                        </a>
                                                    </p>
                                                </div>
                                                <div class="card-footer">
                                                    <span class="badge bg-danger">${postsBySearchTerm[4].isAuction}</span>
                                                    <span class="badge bg-success">${postsBySearchTerm[4].isLend}</span>
                                                    <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[4].regDate}</div>
                                                    <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[4].address}</div>
                                                    <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[4].price}원</div>
                                                    <div>
                                                        <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                        <c:choose>
                                                            <c:when test="${postsBySearchTerm[4].returnDate ne null}">
                                                                ${postsBySearchTerm[4].returnDate}
                                                            </c:when>
                                                         <c:otherwise>
                                                            미정
                                                         </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[4].interestCnt}</span>
                                                    <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                    <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[4].hits}</span>
                                                </div>
                                            </div>
                                            </c:if>
                                        </div>

                                        <c:if test="${not empty postsBySearchTerm[5]}">
                                        <div class="col-md-4">
                                            <div class="card border-light mb-3" style="max-width: 20rem;">
                                                <h5 class="card-header">
                                                    <c:if test="${postsBySearchTerm[5].isMegaphone eq '급구'}">

                                                            <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                    </c:if>
                                                    <span>${postsBySearchTerm[5].title}</span>
                                                </h5>
                                                <div class="card-body">
                                                    <p class="card-text">
                                                        <a href="/board/${postsBySearchTerm[5].boardId}">
                                                            <img src="${postsBySearchTerm[5].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                        </a>
                                                    </p>
                                                </div>
                                                <div class="card-footer">
                                                    <span class="badge bg-danger">${postsBySearchTerm[5].isAuction}</span>
                                                    <span class="badge bg-success">${postsBySearchTerm[5].isLend}</span>
                                                    <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[5].regDate}</div>
                                                    <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[5].address}</div>
                                                    <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${postsBySearchTerm[5].price}원</div>
                                                    <div>
                                                        <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                        <c:choose>
                                                            <c:when test="${postsBySearchTerm[5].returnDate ne null}">
                                                                ${postsBySearchTerm[5].returnDate}
                                                            </c:when>
                                                            <c:otherwise>
                                                                미정
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[5].interestCnt}</span>
                                                    <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                    <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${postsBySearchTerm[5].hits}</span>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                </div>
                            </div>

                </c:if>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <hr>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-4">
                                <span class="text-primary-emphasis">인기글</span>
                            </div>
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-4 text-end">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>
                <br>


                <br>
                <c:if test="${not empty interestPosts[0]}">
                <div class="row">
                                        <div class="col-md-3">
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                                        <h5 class="card-header">
                                                            <c:if test="${interestPosts[0].isMegaphone eq '급구'}">

                                                                    <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                            </c:if>
                                                            <span>${interestPosts[0].title}</span>
                                                        </h5>
                                                        <div class="card-body">
                                                            <p class="card-text">
                                                                <a href="/board/${interestPosts[0].boardId}">
                                                                    <img src="${interestPosts[0].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                                </a>
                                                            </p>
                                                        </div>
                                                        <div class="card-footer">
                                                            <span class="badge bg-danger">${interestPosts[0].isAuction}</span>
                                                            <span class="badge bg-success">${interestPosts[0].isLend}</span>
                                                            <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[0].regDate}</div>
                                                            <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[0].address}</div>
                                                            <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[0].price}원</div>
                                                            <div>
                                                                <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                                <c:choose>
                                                                    <c:when test="${interestPosts[0].returnDate ne null}">
                                                                        ${interestPosts[0].returnDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        미정
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[0].interestCnt}</span>
                                                            <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                            <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[0].hits}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${not empty interestPosts[1]}">
                                                <div class="col-md-4">
                                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                                        <h5 class="card-header">
                                                            <c:if test="${interestPosts[1].isMegaphone eq '급구'}">

                                                                    <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                            </c:if>
                                                            <span>${interestPosts[1].title}</span>
                                                        </h5>
                                                        <div class="card-body">
                                                            <p class="card-text">
                                                                <a href="/board/${interestPosts[1].boardId}">
                                                                    <img src="${interestPosts[1].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                                </a>
                                                            </p>
                                                        </div>
                                                        <div class="card-footer">
                                                            <span class="badge bg-danger">${interestPosts[1].isAuction}</span>
                                                            <span class="badge bg-success">${interestPosts[1].isLend}</span>
                                                            <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[1].regDate}</div>
                                                            <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[1].address}</div>
                                                            <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[1].price}원</div>
                                                            <div>
                                                                <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                                <c:choose>
                                                                    <c:when test="${interestPosts[1].returnDate ne null}">
                                                                        ${interestPosts[1].returnDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        미정
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[1].interestCnt}</span>
                                                            <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                            <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[1].hits}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                </c:if>
                                                <c:if test="${not empty interestPosts[2]}">
                                                <div class="col-md-4">
                                                    <div class="card border-light mb-3" style="max-width: 20rem;">
                                                        <h5 class="card-header">
                                                            <c:if test="${interestPosts[2].isMegaphone eq '급구'}">

                                                                    <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                            </c:if>
                                                            <span>${interestPosts[2].title}</span>
                                                        </h5>
                                                        <div class="card-body">
                                                            <p class="card-text">
                                                                <a href="/board/${interestPosts[2].boardId}">
                                                                    <img src="${interestPosts[2].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                                </a>
                                                            </p>
                                                        </div>
                                                        <div class="card-footer">
                                                            <span class="badge bg-danger">${interestPosts[2].isAuction}</span>
                                                            <span class="badge bg-success">${interestPosts[2].isLend}</span>
                                                            <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[2].regDate}</div>
                                                            <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[2].address}</div>
                                                            <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[2].price}원</div>
                                                            <div>
                                                                <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                                <c:choose>
                                                                    <c:when test="${interestPosts[2].returnDate ne null}">
                                                                        ${interestPosts[2].returnDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        미정
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[2].interestCnt}</span>
                                                            <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                            <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[2].hits}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                        </div>
                                    </div>

                                    </c:if>
                                    <br>
                                    <c:if test="${not empty interestPosts[3]}">
                                    <div class="row">
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <div class="card border-light mb-3" style="max-width: 20rem;">
                                                                            <h5 class="card-header">
                                                                                <c:if test="${interestPosts[3].isMegaphone eq '급구'}">

                                                                                        <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                                                </c:if>
                                                                                <span>${interestPosts[3].title}</span>
                                                                            </h5>
                                                                            <div class="card-body">
                                                                                <p class="card-text">
                                                                                    <a href="/board/${interestPosts[3].boardId}">
                                                                                        <img src="${interestPosts[3].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                                                    </a>
                                                                                </p>
                                                                            </div>
                                                                            <div class="card-footer">
                                                                                <span class="badge bg-danger">${interestPosts[3].isAuction}</span>
                                                                                <span class="badge bg-success">${interestPosts[3].isLend}</span>
                                                                                <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[3].regDate}</div>
                                                                                <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[3].address}</div>
                                                                                <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[3].price}원</div>
                                                                                <div>
                                                                                        <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                                                        <c:choose>
                                                                                            <c:when test="${interestPosts[3].returnDate ne null}">
                                                                                                ${interestPosts[3].returnDate}
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                미정
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[3].interestCnt}</span>
                                                                                <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                                                <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[3].hits}</span>
                                                                            </div>
                                                                        </div>
                                                                    <c:if test="${not empty interestPosts[4]}">
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="card border-light mb-3" style="max-width: 20rem;">
                                                                            <h5 class="card-header">
                                                                                <c:if test="${interestPosts[4].isMegaphone eq '급구'}">

                                                                                        <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                                                </c:if>
                                                                                <span>${interestPosts[4].title}</span>
                                                                            </h5>
                                                                            <div class="card-body">
                                                                                <p class="card-text">
                                                                                    <a href="/board/${interestPosts[4].boardId}">
                                                                                        <img src="${interestPosts[4].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                                                    </a>
                                                                                </p>
                                                                            </div>
                                                                            <div class="card-footer">
                                                                                <span class="badge bg-danger">${interestPosts[4].isAuction}</span>
                                                                                <span class="badge bg-success">${interestPosts[4].isLend}</span>
                                                                                <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[4].regDate}</div>
                                                                                 <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[4].address}</div>
                                                                                 <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[4].price}원</div>
                                                                                 <div>
                                                                                        <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                                                        <c:choose>
                                                                                            <c:when test="${interestPosts[4].returnDate ne null}">
                                                                                                ${interestPosts[4].returnDate}
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                미정
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                 <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[4].interestCnt}</span>
                                                                                 <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;">41</span>
                                                                                 <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[4].hits}</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty interestPosts[5]}">
                                                                    <div class="col-md-4">
                                                                        <div class="card border-light mb-3" style="max-width: 20rem;">
                                                                            <h5 class="card-header">
                                                                                <c:if test="${interestPosts[5].isMegaphone eq '급구'}">

                                                                                        <img src="/images/icon/megaphoneIcon.png" alt="급구 아이콘" style="width: 20px; height: 20px;">

                                                                                </c:if>
                                                                                <span>${interestPosts[5].title}</span>
                                                                            </h5>
                                                                            <div class="card-body">
                                                                                <p class="card-text">
                                                                                    <a href="/board/${interestPosts[5].boardId}">
                                                                                        <img src="${interestPosts[5].imgSrc}" alt="대체_텍스트" style="width: 180px; height: 200px;">
                                                                                    </a>
                                                                                </p>
                                                                            </div>
                                                                            <div class="card-footer">
                                                                                 <span class="badge bg-danger">${interestPosts[5].isAuction}</span>
                                                                                 <span class="badge bg-success">${interestPosts[5].isLend}</span>
                                                                                 <div><img src="/images/icon/postRegDateIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[5].regDate}</div>
                                                                                 <div><img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[5].address}</div>
                                                                                 <div><img src="/images/icon/moneyIcon.png" style="width: 20px; height: 20px;">&nbsp;${interestPosts[5].price}원</div>
                                                                                  <div>
                                                                                        <img src="/images/icon/returnDateIcon.png" style="width: 20px; height: 20px;">
                                                                                        <c:choose>
                                                                                            <c:when test="${interestPosts[5].returnDate ne null}">
                                                                                                ${interestPosts[5].returnDate}
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                미정
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                 <span><img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[5].interestCnt}</span>
                                                                                 <span><img src="/images/icon/chatIcon.png" alt="채팅 아이콘" style="width: 25px; height: 25px;"> 41</span>
                                                                                 <span><img src="/images/icon/hitsIcon.png" alt="조회수 아이콘" style="width: 20px; height: 20px;"> ${interestPosts[5].hits}</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>
                                                        </div>
                                            </c:if>

                                            <div id="myAlert" class="alert">
                                              <span class="closebtn" onclick="closeAlert()">&times;</span>
                                              <strong>로그인 하셔야 합니다!</strong>
                                            </div>

                        <br><br>
                        <input type="hidden" name="latitude" id="latitude" value="${postById.latitude}">
                        <input type="hidden" name="longitude" id="longitude" value="${postById.longitude}">
                        <input type="hidden" name="userId" id="userId" value="${userId}">
            </div>
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <div id="postById" style="display: none;">${postById}</div>
            <script src="/js/notification.js"></script>
            <link rel="stylesheet" type="text/css" href="/css/notification.css">
            <script>

                $(document).ready(function() {

                     var userId = document.getElementById("userId").value;
                     var dataString = document.getElementById("postById").textContent;
                     var boardIdMatch = dataString.match(/boardId=([^,]+)/);

                     // 현재 유저가 경매중 확인
                     $.ajax({
                         url: "/auction/is/" + userId,
                         type: "GET",
                         dataType: "text",
                         success: function(response) {

                             if (response === "ok") {
                                 document.getElementById('auctionButton').textContent = '경매참여중';
                             } else if (response === "no") {
                                 document.getElementById('auctionButton').textContent = '경매참여';
                             }
                         }
                     });

                     var boardId = {
                        boardId: boardIdMatch ? boardIdMatch[1] : null,
                     };

                     $.ajax({
                         url: "/favorite/is/" + boardId.boardId,
                         type: "GET",
                         dataType: "text",
                         success: function(response) {
                            if (response === "ok") {
                                document.getElementById('interestButton').textContent = '관심 해제';
                            } else if (response === "no") {
                                document.getElementById('interestButton').textContent = '관심';
                            }
                         }
                     });

                    $.ajax({
                        url: "/board/board-category",
                        type: "GET",
                        dataType: "json",
                        success: function(response) {
                            console.log(response);

                            $.each(response, function(index, value) {
                                $("#lendServe").append("<a class='dropdown-item' href='/board?boardCategoryId=1&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                                $("#lendServed").append("<a class='dropdown-item' href='/board?boardCategoryId=2&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                                $("#itemCategoryId").append("<option value='" + value.itemCategoryId + "'>" + value.itemCategoryName + "</option>")
                            });
                        }
                    });

                    var latitude = document.getElementById("latitude").value;
                    var longitude = document.getElementById("longitude").value;

                    $.ajax({
                        url: "/address?latitude=" + latitude + "&longitude=" + longitude,
                        type: "GET",

                        dataType: "json",
                        success: function(response) {
                            console.log(response);
                            var html = '<img src="/images/icon/mapIcon.png" style="width: 20px; height: 20px;"> ' + response.address.replace(/^"(.*)"$/, '$1');
                            $("#address").html(html);
                        },
                        error: function(xhr, status, error) {
                            console.error(xhr.responseText);
                        }
                    });

                    $('#carousel-340598').carousel({
                        interval: 2000
                    });
                });

                  document.getElementById('blockUserLink').addEventListener('click', function(event) {
                      event.preventDefault();

                      if (${loggedIn}) {
                          $('#confirmModal').modal('show');
                      } else {
                          showAlert();
                      }
                  });

                  document.getElementById('cancelButton').addEventListener('click', function(event) {
                      event.preventDefault();
                      $('#confirmModal').modal('hide');
                  });

                  document.getElementById('confirmButton').addEventListener('click', function(event) {
                      event.preventDefault();

                      var dataString = document.getElementById("postById").textContent;
                      var writerMatch = dataString.match(/writer=([^,]+)/);

                      var writer = {
                          writer: writerMatch ? writerMatch[1] : null,
                      };

                      $.ajax({
                          url: '/user/' + writer.writer + '/block',
                          type: 'POST',
                          success: function(response) {
                              console.log('Success:', response);

                              $('#confirmModal').modal('hide');
                          },
                          error: function(xhr, status, error) {
                              console.error('Error:', error);
                              $('#confirmModal').modal('hide');
                          }
                      });
                  });

                    function showAlert() {
                      document.getElementById("myAlert").style.display = "block";
                    }

                    function closeAlert() {
                      document.getElementById("myAlert").style.display = "none";
                    }

                   var dataString = document.getElementById("postById").textContent;
                   var boardIdMatch = dataString.match(/boardId=([^,]+)/);

                   var boardId = {
                       boardId: boardIdMatch ? boardIdMatch[1] : null,

                   };
                   document.getElementById('interestButton').addEventListener('click', function(event) {

                       if (${loggedIn}) {

                           var buttonText = document.getElementById('interestButton').textContent;
                           if (buttonText == '관심') {
                               // ajax 요청 보내서 관심 등록 후 버튼을 관심 취소로 바꾸기
                               $.ajax({
                                   url: '/board/' + boardId.boardId + '/favorite',
                                   type: 'POST',
                                   success: function(response) {
                                       var interestCntElement = document.getElementById('interestCnt');
                                       interestCntElement.innerHTML = '<img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;">&nbsp;' + response;
                                       var button = document.getElementById('interestButton');
                                       button.textContent = '관심 해제';
                                   }
                               });
                           } else if (buttonText == '관심 해제') {
                               // ajax 요청 보내서 관심 취소 후 버튼을 관심으로 바꾸기
                               $.ajax({
                                   url: '/board/' + boardId.boardId + '/favorite',
                                   type: 'DELETE',
                                   success: function(response) {
                                       var interestCntElement = document.getElementById('interestCnt');
                                       interestCntElement.innerHTML = '<img src="/images/icon/favoriteIcon.png" alt="관심 아이콘" style="width: 20px; height: 20px;">&nbsp;' + response;
                                       var button = document.getElementById('interestButton');
                                       button.textContent = '관심';
                                   }
                               });
                           }
                       } else {
                           // 로그인 되어 있지 않을 때

                           showAlert();
                       }


                   })

                   document.getElementById('auctionButton').addEventListener('click', function(event) {
                       var buttonText = this.textContent.trim();

                       if (${loggedIn}) {
                           if (buttonText !== '경매참여중') {
                               var dataString = document.getElementById("postById").textContent;
                               var boardIdMatch = dataString.match(/boardId=([^,]+)/);

                               var boardId = {
                                   boardId: boardIdMatch ? boardIdMatch[1] : null,
                               };

                               $.ajax({
                                   url: '/auction/' + boardId.boardId,
                                   type: 'POST',
                                   success: function(response) {
                                       document.getElementById('auctionButton').textContent = '경매참여중';
                                   },
                                   error: function(xhr, status, error) {
                                       // 에러 처리 로직
                                   }
                               });
                           } else {
                               alert('경매 참여중');
                           }
                       } else {
                           showAlert();
                       }
                   });



                // 글 상세 번호 채팅에 넘겨주기 위한 함수
                function chat() {//채팅방 열기
                    if (${loggedIn}) {
                        if("${userId}"=="${postById.writer}"){//만약 유저아이디랑 글쓴이가 같다면
                            window.location.href = "/chatList/"+"${userId}";//채팅리스트로 이동
                        } else {
                            //alert("글 상세번호 : " + "${postById.boardId}");
                            var boardId2 = parseInt("${postById.boardId}"); // 글 상세 번호
                            var form = document.createElement("form");
                            form.setAttribute("method", "post");
                            form.setAttribute("action", "/chat");

                            var hiddenField = document.createElement("input");
                            hiddenField.setAttribute("type", "hidden");
                            hiddenField.setAttribute("name", "boardId2");
                            hiddenField.setAttribute("value", boardId2);
                            form.appendChild(hiddenField);

                            document.body.appendChild(form);
                            form.submit();
                        }
                    } else {
                        showAlert();
                    }
                };



                  function sendEditRequest() {
                      let boardId = ${postById.boardId};

                      var dataToSend = {
                              boardId: boardId,
                      };

                      var queryString = $.param(dataToSend);

                      window.location.href = "/board/editForm?" + queryString;
                  }
            </script>

        </body>