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
    <title>실험</title>
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
    #detailImg {width: 100%;height: 100%; object-fit: cover;}
    </style>
    <!------------------------------- style ----------------------------------->
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-2">
                                <button type="button" class="btn btn-success">
                                    뒤로가기
                                </button>
                            </div>
                            <div class="col-md-10">
                                <h3>
                                     ${chatItem.writer}님과의 대화
                                </h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3"> <!-- 글 상세 이미지 출력 -->
                                <a href="/board/${boardId}"><!-- 이미지 클릭 시 해당 상세글로 이동 -->
                                    <img alt="안갖고옴" src="${chatItem.images}" id="detailImg" />
                                </a>
                            </div>
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div>
                                              <label for="exampleSelect1" class="form-label mt-4">대여여부</label>
                                              <select class="form-select" id="exampleSelect1">
                                                <option>대여전</option>
                                                <option>대여중</option>
                                                <option>대여완료</option>
                                              </select>
                                            </div>
                                    </div>
                                    <div class="col-md-9">
                                        <h3>
                                            ${chatItem.title}
                                        </h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
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
                        <!-- 채팅폼 들어갈예정 -->
                        <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                    </div>
                                </div>
                                <!-- 대화 입력 박스 / 대화 내용 박스 -->
                                <!-- 연결상태 알림 -->
                                <div class="alert alert-success my-4">
                                    <strong id="status">채팅을 연결후 사용하세요....</strong>
                                    <div id="connectionStatus"></div>
                                </div>
                                <div id="showChat" style="display: none">
                                    <!-- 메시지 입력 -->
                                    <div class="mb-3 mt-3">
                                        <label for="inputMsg" class="form-label">메시지 : </label>
                                        <input onkeyup="sendInput(this.value)"
                                            type="text" class="form-control" id="inputMsg"
                                            placeholder="메시지를 입력하세요." name="inputMsg">
                                    </div>
                                    <!-- 대화 내용 -->
                                    <div id="taMsg" class="discussion"></div>
                                </div>
                            </div>
                            <!-- .container end -->
                        <!-- 채팅폼 들어갈예정 -->
                        <div class="row">
                           <div class="col-md-2">
                               <div class="dropdown">
                                   <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                       <img src="/images/plus.png"/>
                                   </a>
                                    <div class="dropdown-menu" style="">
                                       <a class="dropdown-item" href="#">파일첨부</a>
                                       <a class="dropdown-item" href="#" onclick="showReservationInput()">예약하기</a>
                                       <a class="dropdown-item" href="#">약속장소</a>
                                    </div>
                               </div>
                           </div>
                            <div class="col-md-10">
                <p>boardId: ${boardId}</p> <!-- boardId 값 출력 -->
                                <button id="chatButton" class="btn btn-primary chatButton" OnClick="chat_connect()">로그인</button>
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
    <!------------------------------- script ----------------------------------->
    <script language="javascript" type="text/javascript">
    let chat_id = 67; <!-- 테스트를 위한 임시 채팅방 아이디 -->
        let socket = null;
        let stompClient = null;
        let nickname;
        // ======================================= UI 제어 =======================================
        function setConnected(connected) // 연결 여부에 따라 UI 제어
        {
            if (connected)
            {
                document.getElementById('status').innerText = ''; // 연결 후 사용하세요 메시지 숨기기
                document.getElementById('showChat').style.display = 'block'; // 채팅창 보이기
            }
            else
            {
                document.getElementById('status').innerText = '채팅을 연결 후 사용하세요....'; // 연결 후 사용하세요 메시지 보이기
                document.getElementById('showChat').style.display = 'none'; // 채팅창 숨기기
            }
        } // setConnected() -----------
        // ======================================= UI 제어 =======================================
        // ======================================= 소켓 연결 =======================================
        function chat_connect()
        {
            socket = new SockJS("${pageContext.request.contextPath}/chat"); // end point => "/chat"
            stompClient = Stomp.over(socket); // 소켓을 이용하여 stomp 생성
            //stomp 이용해서 서버에 연결
            stompClient.connect({}, function(frame)
            {
                alert('연결됨: ' + frame);
                setConnected(true); // UI 보여 주기
                $('#inputMsg').focus(); // 대화 내용 입력 박스에 포커스 추가
                // 서버로 메시지 보내기
                stompClient.subscribe('/topic/messages', function(msg)
                {
                    console.log('subscribe topic → ', msg);
                    // alert(msg.body); // msg.body → json 형태의 문자열
                    let jsonMsg = JSON.parse(msg.body); // 문자열을 JSON 객체로 만들기
                    // alert(jsonMsg.text);
                    showChatMessage(jsonMsg);
                }); // subscribe end -------
                // 연결 상태에 따라 버튼 텍스트 변경
                document.getElementById("chatButton").innerText = "로그아웃";
                document.getElementById("chatButton").setAttribute("onclick", "chat_disconnect()");
                let connectedUsername = "testID"; // 연결된 사용자의 이름
                // 연결 메시지 출력
                let connectMessage = connectedUsername + " 님과 연결되었습니다."
                alert(connectMessage);
                document.getElementById("connectionStatus").innerText = connectMessage;
                document.getElementById("loginMessage").style.display = "none"; // 로그인 메시지 감추기
                setConnected(true);
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
            setConnected(false); // UI 감추기
            // 버튼 텍스트 변경
            document.getElementById("chatButton").innerText = "로그인";
            document.getElementById("chatButton").setAttribute("onclick", "chat_connect()");
            // 연결 상태 메시지 감추기
            document.getElementById("connectionStatus").innerText = "";
            document.getElementById("loginMessage").style.display = "block"; // 로그인 메시지 보이기
            setConnected(false);
        }
        // ======================================= 소켓 연결 해제 =======================================
        // ======================================= enter =======================================
        function sendInput(mymsg)
        {
            // alert(event.keyCode); // 이건 잘됨
            if(event.keyCode == 13) // 전송도 잘됨!
            {
                if(mymsg != '')
                {
                    sendMessage(nickname, 'all', mymsg); // 서버로 메시지 전송
                    $('#inputMsg').val(''); // jquery
                    // document.getElementById('inputMsg').value = ''; // javascript
                }
            }
        } // sendInput() ----------
        // ======================================= enter =======================================
        // ======================================= 서버로 메시지 보내기 =======================================
        function sendMessage(sender, target, content)
        {
            let obj =
            {
                    sender:sender,
                    target:target,
                    content:content,
                    mode:'all'
            }
            stompClient.send('/app/chat', {}, JSON.stringify(obj)); // json 객체를 직렬화
        } // ---------------------------------
        // ======================================= 서버로 메시지 보내기 =======================================
        // ======================================= 대화 내용 출력 함수 =======================================
        function showChatMessage(obj) { // 대화 내용을 출력해 주는 함수
            if(obj.sender == nickname) { // 내가 보낸 메시지라면
                let str = `
                <p>
                <label class='badge badge-success'>\${obj.sender}</label>
                &nbsp;&nbsp;&nbsp;
                \${obj.content}
                </p>
                `;
                addMessage('self', str, obj.time);
            } else { // 다른 사람이 보낸 메시지라면
                let str = `
                    <p>
                    <label class='badge badge-danger'>\${obj.sender}</label>
                    &nbsp;&nbsp;&nbsp;
                    \${obj.content}
                    </p>
                `;
                addMessage('other', str, obj.time);
            }
            // $('#taMsg').append(str);
        } // showChatMessage() -----------
        // ======================================= 대화 내용 출력 함수 =======================================
        // ======================================= 메시지 추가 =======================================
        function addMessage(who, msg, time)
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
                        <time>\${time}</time>
                    </div>
                </li>
            `;
            $('#taMsg').append(str);
            // 메시지가 쌓이면 스크롤바가 따라다니도록
            document.getElementById('taMsg').scrollTop = document.getElementById('taMsg').scrollHeight; // javascript
            // $('#taMsg').scrollTop($('taMsg')[0].scrollHeight) // jquery
        } // -------------
        // ======================================= 메시지 추가 =======================================
 function goChatList(){//뒤로가기 버튼 클릭시 채팅리스트로 이동
            let Id = thisUserId;
            alert(Id); //유저아이디 출력
        };//goChatList() end----
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
            form.setAttribute("action", "/chat/reserv"); // 컨트롤러의 엔드포인트로 설정
            //숨겨놓은 chatid
            let chatId = document.createElement("input");
            chatId.setAttribute("type", "hidden");
            chatId.setAttribute("name", "chatId");
            chatId.setAttribute("value", chat_id);
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
    </script>
    <!------------------------------- script ----------------------------------->
</body>
</html>