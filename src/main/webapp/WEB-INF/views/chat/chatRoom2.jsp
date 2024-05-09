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
    <!------------------------------- style ----------------------------------->
    <style>
        .container { width: 600px; padding: 10px; border: 2px solid #3e3e41;}
    .talk_view { position: relative; width: 580px; height: 200px; padding: 5px; border: 1px dotted #3e3e41; overflow-y:scroll;}
    .talk_input { position: relative; margin-top: 20px; width: 500px; padding: 5px; border: 1px dotted #3e3e41; }
    </style>
    <!------------------------------- style ----------------------------------->
    <!------------------------------- script ----------------------------------->
    <script language="javascript" type="text/javascript">
        var thisUserId = "UserID"; // 아이디입력
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

            })

        }//chat_connect() end ----------------

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

                                <button type="button" class="btn btn-success">
                                    뒤로가기
                                </button>
                            </div>
                            <div class="col-md-10">
                                <h3>
                                    000님과의 대화
                                </h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3"> <!-- 글 상세 이미지 출력 -->
                                <img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="dropdown">

                                            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                                대여전
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                 <a class="dropdown-item disabled" href="#">대여전</a> <a class="dropdown-item" href="#">대여중</a> <a class="dropdown-item" href="#">대여완료</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <h3>
                                            글 상세 제목 출력
                                        </h3>
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

                        <!-- 채팅폼 들어갈예정 -->

                        <!-- 채팅폼 들어갈예정 -->
                        <div class="row">
                            <div class="col-md-2">
                                <div class="dropdown">

                                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                        <img src="/images/plus.png"/>
                                    </a>
                                     <div class="dropdown-menu" style="">
                                        <a class="dropdown-item" href="#">파일첨부</a>
                                        <a class="dropdown-item" href="#">예약하기</a>
                                        <a class="dropdown-item" href="#">약속장소</a>
                                      </div>
                                </div>
                            </div>
                            <div class="col-md-10">
                                <div id="talk_view" class="talk_view"></div>
                                <input type="text" class="talk_input" id="talk_input" placeholder="채팅을 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
                                <button class="btn btn-primary chatButton" id="connectBtn" OnClick="chat_connect()">연 결</button>
                                <button class="btn btn-primary chatButton" id="talk_send" OnClick="sendTalk()">전 송</button>
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
