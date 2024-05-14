<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<header>
            <div class="head">
                <h1>Test</h1>
<div class="container">

	<h1 class="text-center">MyPage- 마이 페이지</h1>
	<p class="alert alert-success py-5">
		회원들만 들어올 수 있는 페이지 입니다.
		<br>
		<ul>
			<li>회원 아이디: ${user.userId } </li>
			<li>회원 이름 : ${user.name}</li>

			<li>연 락 처 : ${user.phoneNumber}</li>
			<li>주  소 : ${user.address}</li>
		</ul>

	</p>
</div>




                    <div class="logout">
                        <form action="/logout" method="post">
                            <button type="submit"><span class="skip_info">로그아웃</span><i class="fas fa-sign-out-alt"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </header>
</body>
</html>