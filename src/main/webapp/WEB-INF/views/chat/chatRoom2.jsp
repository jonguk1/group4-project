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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery library -->
    <script
    	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <!-- websocket 라이브러리 추가 -->
    <!--  https://cdnjs.com/libraries/sockjs-client  -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
    <!--  https://cdnjs.com/libraries/stomp.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!------------------------------- style ----------------------------------->
    <style>
        .container { width: 600px; padding: 10px; border: 2px solid #3e3e41;}
    .talk_view { position: relative; width: 580px; height: 200px; padding: 5px; border: 1px dotted #3e3e41; overflow-y:scroll;}
    .talk_input { position: relative; margin-top: 20px; width: 500px; padding: 5px; border: 1px dotted #3e3e41; }

    #detailImg {width: 100%;height: 100%; object-fit: cover;}
    </style>
    <!------------------------------- style ----------------------------------->
    <!------------------------------- script ----------------------------------->
    <script>
        var thisUserId = "UserID"; // 아이디입력
        let chat_id = 67; <!-- 테스트를 위한 임시 채팅방 아이디 -->
        // 텍스트에 박스에 입력한 대화내용을 서버에 전송한다.
        function sendTalk() {
            var obj = document.getElementById("talk_input");
            if(obj) {
                addTalk(obj.value);  //대회내용을 추가
                obj.value = ""; //텍스트필드 초기화
                obj.focus();  //커서를 텍스트필드에 위치
            }
        }
        // 입력된 대화 내용을 대화창에 추가한다.
        function addTalk(content) {
            var obj = document.getElementById("talk_view");
            if(obj)
            {
                var line = thisUserId + " - " + content + "<br>";  //이름 -내용을 저장
                obj.innerHTML += line;  //내용을 추가한다.
            }
        }

        let socket = null;
        let stompClient = null;
        function chat_connect(){
            socket = new SockJS("${pageContext.request.contextPath}/chat"); // end point => "/chat"
            stompClient = Stomp.over(socket); // 소켓을 이용하여 stomp 생성
            //stomp 이용해서 서버에 연결
            stompClient.connect({}, function(frame){
                alert('연결됨: ' + frame);
                $('#talk_input').focus();

                sendMessage(thisUserId+"님이 접속했습니다.");
                //콘솔로그->서버가 받은 정보: ChatDTO(content=null, sender=UserID님이 접속했습니다., target=null)

                //                   Controller에 작성한 SendTo랑 같게
                stompClient.subscribe('/topic/messages', function(msg){
                    console.log('subscribe topic → ', msg);
                    // alert(msg.body); // msg.body → json 형태의 문자열
                    let jsonMsg = JSON.parse(msg.body); // 문자열을 JSON 객체로 만들기
                    // alert(jsonMsg.text);
                    //showChatMessage(jsonMsg);
                })//stompClient.subscribe() end ----------

            })//stompClient.connect() end---------
        }//chat_connect() end ----------------

        function sendMessage(sender,target,content){//서버로 메세지를 보내는 함수
            let obj = {
                sender : sender,
                target : target,
                content : content
            }
            stompClient.send('/app/chat',{},JSON.stringify(obj));
        }//sendMessage() end--------------

        function showChatMessage(obj){

        }//showChatMessage() end---------------

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
                                <button type="button" class="btn btn-success" onclick="goChatList()">
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
                            <div class="col-md-2" > <!-- 글 상세 이미지 출력 -->
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
                                <div id="talk_view" class="talk_view"></div>
                                <p>boardId: ${boardId}</p> <!-- boardId 값 출력 -->
                                <input type="text" class="talk_input" id="talk_input" placeholder="채팅을 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
                                <button class="btn btn-primary chatButton" OnClick="chat_connect()">연 결</button>
                                <button class="btn btn-primary chatButton" id="talk_send" OnClick="sendTalk()">전 송</button>
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
</body>
</html>