<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <link rel="stylesheet" href="css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<body>

<div class="container bg-green text-center">
        <div class="row">
            <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
                <nav class="navbar navbar-expand-lg bg-green" data-bs-theme="light">
                    <a class="navbar-brand" href="#" style="color: black;">썸띵랜드</a>
                </nav>
            </div>
            <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
                <form class="d-flex">
                    <div class="input-group mt-3"> <!-- 여기에 mt-3 클래스 추가 -->
                        <input class="form-control me-2" type="search" placeholder="빌리고 싶은 물건을 입력하세요">
                        <button class="btn btn-secondary" type="submit">Search</button>
                    </div>
                </form>
            </div>
            <div class="col" style="border-radius: 10px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);">
                <nav class="navbar navbar-expand-lg bg-green">
                    <div class="container-fluid">
                        <div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">알림</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">로그아웃</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">채팅</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="color: black;">메시지</a>
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
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려주세요</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Separated link</a>
                    </div>
                </li>

                <li class="nav-item dropdown text-center">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">빌려드려요</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">도서</a>
                        <a class="dropdown-item" href="#">생활용품</a>
                        <a class="dropdown-item" href="#">의류</a>

                    </div>
                </li>

                <li class="nav-item dropdown text-center">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: black;">경매</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Separated link</a>
                    </div>
                </li>
            </ul>
        </nav>
    </div>

   <br><br>


    <div class="row">
           		<div class="col-md-2">
           		</div>
           		<div class="col-md-8 text-center">
           			<h3>
           				Lee Jae Woong 님의 빌린 목록
           			</h3>
           		</div>
           		<div class="col-md-2">
           		</div>
           	</div>

           	<br><br>

    <div class="container-fluid">
    	<div class="row">
    		<div class="col-md-2">
    		    <div class="accordion" id="accordionExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                여기 뭐 넣지?
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
                            <div class="accordion-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action">내 정보</a>
                                    <a href="#" class="list-group-item list-group-item-action">관심 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">빌려준 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">빌린 목록</a>
                                    <a href="#" class="list-group-item list-group-item-action">내 경매 목록</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
    		</div>
    		<div class="col-md-8">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card">
                            <h5 class="card-header">
                                집에 굴러다니는 청..
                            </h5>
                            <div class="card-body">
                                <p class="card-text">
                                    <img src="images/clean.jpeg" alt="대체_텍스트" style="width: 180px; height: 250px;">
                                </p>
                            </div>
                            <div class="card-footer">
                                <p><span class="badge bg-danger">경매중</span>
                                <span class="badge bg-success">대여전</span>
                                <span class="badge bg-warning">매너유저</span></p>
                                <p>2,500원</p>
                                <p>강원도 영월군 구포읍</p>
                                <span>관심 32</span>
                                <span>채팅 41</span>
                                <span>조회 312</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <h5 class="card-header">
                                Card title
                            </h5>
                            <div class="card-body">
                                <p class="card-text">
                                    Card content
                                </p>
                            </div>
                            <div class="card-footer">
                                Card footer
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <h5 class="card-header">
                                Card title
                            </h5>
                            <div class="card-body">
                                <p class="card-text">
                                    Card content
                                </p>
                            </div>
                            <div class="card-footer">
                                Card footer
                            </div>
                        </div>
                    </div>
                </div>
            </div>

    		<div class="col-md-2">
    		</div>
    	</div>

        <br>

    	<div class="row">
        		<div class="col-md-2">
        		</div>
        		<div class="col-md-8">
        			<div class="row">
        				<div class="col-md-4">
        					<div class="card">
        						<h5 class="card-header">
        							Card title
        						</h5>
        						<div class="card-body">
        							<p class="card-text">
        								Card content
        							</p>
        						</div>
        						<div class="card-footer">
        							Card footer
        						</div>
        					</div>
        				</div>
        				<div class="col-md-4">
        					<div class="card">
        						<h5 class="card-header">
        							Card title
        						</h5>
        						<div class="card-body">
        							<p class="card-text">
        								Card content
        							</p>
        						</div>
        						<div class="card-footer">
        							Card footer
        						</div>
        					</div>
        				</div>
        				<div class="col-md-4">
        					<div class="card">
        						<h5 class="card-header">
        							Card title
        						</h5>
        						<div class="card-body">
        							<p class="card-text">
        								Card content
        							</p>
        						</div>
        						<div class="card-footer">
        							Card footer
        						</div>
        					</div>
        				</div>
        			</div>
        		</div>
        		<div class="col-md-2">
        		</div>
        	</div>

        	<br>

            <div class="row">
            		<div class="col-md-2">
            		</div>
            		<div class="col-md-8">
            			<div class="row">
            				<div class="col-md-4">
            				</div>
            				<div class="col-md-4">
            					<nav>
            						<ul class="pagination">
            							<li class="page-item">
            								<a class="page-link" href="#">Previous</a>
            							</li>
            							<li class="page-item">
            								<a class="page-link" href="#">1</a>
            							</li>
            							<li class="page-item">
            								<a class="page-link" href="#">2</a>
            							</li>
            							<li class="page-item">
            								<a class="page-link" href="#">3</a>
            							</li>
            							<li class="page-item">
            								<a class="page-link" href="#">4</a>
            							</li>
            							<li class="page-item">
            								<a class="page-link" href="#">5</a>
            							</li>
            							<li class="page-item">
            								<a class="page-link" href="#">Next</a>
            							</li>
            						</ul>
            					</nav>
            				</div>
            				<div class="col-md-4">
            				</div>
            			</div>
            		</div>
            		<div class="col-md-2">
            		</div>
            	</div>
    </div>
</body>
