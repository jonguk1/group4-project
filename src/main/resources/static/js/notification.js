$(document).ready(function() {

    // 이벤트가 발생했을 때 실행되는 코드
    function showNotification(message) {
        // 알림 메시지 업데이트
        document.getElementById("notificationMessage").textContent = message;
        // 알림 메시지 표시
        document.getElementById("notificationMessage").style.display = "block";

        setTimeout(function() {
            document.getElementById("notificationMessage").style.display = "none";
        }, 3000);
    }

    const eventSource = new EventSource('/subscribe');
    eventSource.addEventListener('auction', event => {
        if (event.data === "first message") {
            return;
        }
        showNotification(event.data);

    });

    $.ajax({
        url: "/notification",
        type: "GET",
        dataType: "json",
        success: function(response) {
            if (response.length === 0) {
                addMessage("알림이 존재하지 않습니다");

            }
            response.forEach(function(notification) {

                var message = "<div class='row'><div class='col-md-2'></div><div class='col-md-8'>" + notification.notiRegDate + "</div><div class='col-md-2'><img src='/images/icon/xIcon.png' id='" + notification.notiId + "' style='width:15px; height:15px;' class='xIcon'></div></div>" + notification.content + "<br> <a href='/board/" + notification.boardId + "'><img src='/images/icon/rightDirectionIcon.png' style='width:20px; height:20px;'> 해당 글로 가기</a> <hr>";

                addMessage(message);

            });

            messageCount(response.length);
        },
        error: function(xhr, status, error) {
            // 에러 처리
        }
    });

    // 새로운 메시지가 추가될 때마다 스크롤을 아래로 이동하는 함수
    function scrollToBottom() {
        var messageContainer = document.getElementById('messageContainer');
        messageContainer.scrollTop = messageContainer.scrollHeight;
    }

    document.getElementById('notificationIcon').addEventListener('click', function() {
        loadNotifications();
        var messageContainer = document.getElementById('messageContainer');
        if (messageContainer.style.display === 'block') {
            messageContainer.style.display = 'none';
        } else {
            messageContainer.style.display = 'block';
        }
    });

    // 새로운 메시지를 추가하는 함수
    function addMessage(message) {
        var messageContainer = document.getElementById('messageContainer');
        var newMessage = document.createElement('div');
        newMessage.innerHTML = message;
        messageContainer.appendChild(newMessage);
        scrollToBottom();


    }

    // 메시지 개수
    function messageCount(messageCount) {

        var messageContainer = document.getElementById('messageContainer');
        var messageCountSpan = document.getElementById('messageCount');
        messageCountSpan.textContent = messageCount;
    }

    // 알림창안 X를 클릭했을 때
    $(document).on('click', '.xIcon', function() {
        var clickedId = $(this).attr('id');

        // 알림 삭제 요청
        $.ajax({
            url: '/notification/' + clickedId,
            type: 'DELETE',

            success: function(response) {
                alert('알림 삭제 성공');
                loadNotifications();
            },
            error: function(xhr, status, error) {
                console.error('AJAX request failed');
                console.error(error);
            }
        });

    });

    // 알림 불러오는 함수
    function loadNotifications() {
        $.ajax({
            url: "/notification",
            type: "GET",
            dataType: "json",
            success: function(response) {

                // 기존 알림을 모두 삭제
                $("#messageContainer").empty();

                if (response.length === 0) {
                    addMessage("알림이 존재하지 않습니다");
                }
                // 새로운 알림 추가
                response.forEach(function(notification) {
                    var message = "<div class='row'><div class='col-md-2'></div><div class='col-md-8'>" + notification.notiRegDate + "</div><div class='col-md-2'><img src='/images/icon/xIcon.png' id='" + notification.notiId + "' style='width:15px; height:15px;' class='xIcon'></div></div>" + notification.content + "<br> <a href='/board/" + notification.boardId + "'><img src='/images/icon/rightDirectionIcon.png' style='width:20px; height:20px;'> 해당 글로 가기</a> <hr>";
                    addMessage(message);
                });

                messageCount(response.length);
            },
            error: function(xhr, status, error) {
                // 에러 처리
            }
        });
    }
});