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
    <!------------------------------- style ----------------------------------->
    <style type="text/css">
        .discussion {
            list-style: none;
            background: #ededed;
            margin: 0;
            padding: 0 0 50px 0;
        }
        .discussion li {
            padding: 0.5em;
            overflow: hidden;
            display: flex;
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


    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <button type="button" onclick="chatList()" class="btn btn-success">
                                    채팅목록
                                </button>
                            </div>
                            <div class="col-md-9">
                                <h3>
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

                        </div>
                        <div class="row">
                            <div class="col-md-3 text-center" > <!-- 글 상세 이미지 출력 -->
                                <a href="/board/${boardId}"><!-- 이미지 클릭 시 해당 상세글로 이동 -->
                                    <img alt="안갖고옴" src="${chatItem.images}" id="detailImg" />
                                </a>
                            </div>
                            <div class="col-md-9">
                                <h1>${chatItem.title}</h1>
                                <div class="row">
                                    <div class="col-md-9">
                                        <select class="form-select" id="isLend">
                                            <option>대여전</option>
                                            <option>대여중</option>
                                            <option>대여완료</option>
                                        </select>
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
                                        <div class="btn-group btn-group-md" role="group">
                                            <button class="btn btn-secondary" type="button">
                                                신고
                                            </button>
                                            <button class="btn btn-secondary" type="button">
                                                차단
                                            </button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                        <!-- 채팅폼 들어갈예정 -->
                        <div class="container">
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
                                       <a class="dropdown-item" href="#" onclick="showReservationInput()">예약하기</a>
                                       <a class="dropdown-item" href="#" onclick="showReservInput()">약속장소</a>
                                    </div>
                               </div>
                           </div>
                            <div class="col-md-11">
                            <input onkeyup="sendInput(this.value)"
                            type="text" class="form-control" id="inputMsg"
                            placeholder="메시지를 입력하세요." name="inputMsg">
                                <!-- 예약하기 클릭시 달력 나타나기 -->
                                <form id="reservForm">
                                    <input type="datetime-local" name="hiddenInput" id="hiddenInput" style="display:none">
                                    <input type="button" id="hiddenButton" value="완료" style="display:none">
                                </form>
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
            const selectBox = document.getElementById('isLend');

            selectBox.addEventListener('change', function(event) {
                let selectedOption = event.target.value;

                $.ajax({
                    url: '/board/' + boardId + '/isLend',
                    method: 'PUT',
                    contentType: 'text/plain',
                    data: selectedOption,
                    success: function(response) {

                    },
                    error: function(xhr, status, error) {

                    }
                });
            });

            if (lendState === '대여전') {
                selectBox.value = '대여전';
            } else if (lendState == '대여중') {
                selectBox.value = '대여중';
            } else if (lendState == '대여 완료') {
                selectBox.value = '대여완료';
                selectBox.setAttribute('disabled', 'disabled');
            }

            const modal = document.getElementById('myModal');
            let selectedStars = 0;

            if ('${userId}' === '${chatItem.writer}') {
                reviewee = '${chatRoomDTO.lendy}';
            } else {
                reviewee = '${chatItem.writer}';
            }

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

                        // 리뷰 등록

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
        let chatId = "<c:out value='${chatId}'/>"; <!-- 처음 생성될때 만들어지는 채팅방 아이디 -->
        let lendy="<c:out value='${userId}'/>"//현재 접속자(구매자-랜디, 채팅방이 처음 생성될때 메세지 보내는 사람)
        let lender="<c:out value='${chatItem.writer}'/>"//상세글쓴이(판매자-랜더, 채팅방이 처음 생성될때는 메세지 받는 사람)

        //제일 처음 메세지를 보내는 사람
        let from = lendy;//메세지 보내는 사람 -> 구매자
        let to = lender;//메세지 받는 사람 -> 판매자

        let sendTime = "<c:out value='${sendTime}'/>";
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
            //alert(sendTime);
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
                    sendTime: sendTime
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
                console.log("보내는 사람은 : "+from);
                console.log("받는 사람은 : "+to)
                let str = `
                    <label class="text-primary-emphasis medium-font">\${obj.from}</label>
                    <p class='text-primary large-font message'>
                    &nbsp;&nbsp;
                    \${obj.content}
                    </p>
                `;
                 console.log("***********self");
                addMessage('self', str, obj.sendTime);
            } else { // 다른 사람이 보낸 메시지라면
                let str = `
                    <label class="text-primary-emphasis medium-font">\${obj.from}</label>
                    <p class='text-primary large-font message'>
                    &nbsp;&nbsp;
                    \${obj.content}
                    </p>
                `;
                  console.log("############other");
                addMessage('other', str, obj.sendTime);
            }//else
        }//else-----------------------

           // $('#taMsg').append(str);
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
            // 메시지가 쌓이면 스크롤바가 따라다니도록
            //document.getElementById('taMsg').scrollTop = document.getElementById('taMsg').scrollHeight; // javascript
            // $('#taMsg').scrollTop($('taMsg')[0].scrollHeight) // jquery
        } // -------------
        // ======================================= 메시지 추가 =======================================
// 예약하기 누르면 달력 출력 되면서 예약 시스템 활성화
        function showReservationInput() {
            //input datetime-local 나타나게 하기
            let hiddenInput = document.getElementById("hiddenInput");
            hiddenInput.removeAttribute("style"); // 스타일 속성 제거하여 기본적인 화면 표시 상태로 변경
            hiddenInput.disabled = false; // input 요소 활성화

            //확인 버튼 나타나게 하기
            let hiddenButton = document.getElementById("hiddenButton");
            hiddenButton.removeAttribute("style"); // 스타일 속성 제거하여 기본적인 화면 표시 상태로 변경
            hiddenButton.disabled = false; // input 요소 활성화

            //form 태그
            let form = document.getElementById("reservForm");
            form.setAttribute("method", "post");
            form.setAttribute("action", "/caht/reserv"); // 컨트롤러의 엔드포인트로 설정

            //숨겨놓은 chatid
            let chatId = document.createElement("input");
            chatId.setAttribute("type", "hidden");
            chatId.setAttribute("name", "chatId");
            chatId.setAttribute("value", chatId);
            form.appendChild(chatId);

            // hiddenButton에 onclick 이벤트 추가
            hiddenButton.onclick = function() {
                //console.log(hiddenInput.value);
                let datetime = hiddenInput.value;
                // 새로운 input 요소 생성
                let datetimeInput = document.createElement("input");
                datetimeInput.setAttribute("type", "hidden");
                datetimeInput.setAttribute("name", "datetimeInput"); // 원하는 이름으로 변경
                datetimeInput.setAttribute("value", datetime);
                form.appendChild(datetimeInput);
                //console.log(datetime);
                form.submit();
            };
        }// showReservationInput() end------------
        // ======================================= chatList로 돌아가기 =======================================
        function chatList()
        {
            window.location.href = "/chatList/"+"${userId}";
        }
        // ======================================= chatList로 돌아가기 =======================================
    </script>
    <!------------------------------- script ----------------------------------->
</body>

    <script src="/js/chatRoom.js"></script>
</html>