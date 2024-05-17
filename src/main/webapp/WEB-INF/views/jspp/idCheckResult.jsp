<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<style>
    .jumbotron,
    .navbar {
        display: none;
    }

    #wrap {
        width: 490px;
        text-align: center;
        margin: 0 auto 0 auto;
    }

    #chk {
        text-align: center;
    }
</style>
<script>
    function id_check() {
        var id = idf.userId.value;

        if (!id) {
            alert('아이디를 입력하세요');
            idf.userId.focus();
            return false;
        } else if (/[^a-zA-Z0-9]/.test(id)) {
            alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
            return false;
        } else {
            return true;
        }
    }

    function setId(uid) {
        //중복체크 결과 idCheck 값 전달~
        opener.document.signup.idDuplication.value = "idCheck";
        //window>document>form>input,select,
        //opener==>부모창(window객체)
        opener.document.signup.userId.value = uid;

        //self ==>자기창(window객체)
        self.close(); //팝업창 닫기
    }
</script>

<!-- idCheck.jsp -->
<div id="wrap" class="container">
    <br>
    <b><font size="4" color="gray">아이디 중복체크</font></b>
    <hr size="1" width="460">
    <br>
    <div id="chk">
        <form name="idf" action="idCheck" method="post" onsubmit="return id_check()" class="row g-3 justify-content-center">
            <div class="col-auto">
                <label for="userId" class="visually-hidden">아이디</label>
                <input type="text" name="userId" id="userId" class="form-control" placeholder="ID" autofocus="autofocus">
            </div>
            <div class="col-auto">
                <button class="btn btn-primary">확   인</button>
            </div>
        </form>
        <div id="idResult" style="margin:1em auto">
            <h3 style='color:blue'>${msg}</h3>
            <br>
            <c:if test="${result eq 'ok' }">
                <button onclick="setId('${uid}')"
                    class="btn btn-outline-info">아이디 사용하기</button>
            </c:if>
        </div>
    </div>
</div>
