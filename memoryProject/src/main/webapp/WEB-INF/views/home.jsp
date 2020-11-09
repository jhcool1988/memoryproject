<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/resources/css/enterance.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
	<div class="gap"></div>
	<div style="height: 528px;">
		<div style="position: absolute;" >
		<img src="/resources/img/wall20_1920_4.png">
		</div>
		<div class="ourstorybox">
			<img src="/resources/img/our_story_trans.png">
		</div>
		<div class="formbox">
			<form action="/board/enterance" method="post">
				<div class="form-group">
			    <label for="id">Email address</label>
			    <input type="text" class="form-control" name="id" id="exampleInputEmail1" aria-describedby="emailHelp">
			  	</div>
			  	<div class="form-group">
			    <label>Password</label>
			    <input type="password" class="form-control" id="exampleInputPassword1">
			  	</div>
			  <button type="submit" class="btn btn-info">Login</button>
			</form>
		</div>
	</div>
	<div class="gap"></div>
</body>
</html>