<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Завершення реєстрації</title>
<style type="text/css">
 body {
    background-color: #eee;
  }

</style>
</head>
<body>
<jsp:include page="include/header.jsp" />
<div id="wrap" style="padding-top:20%;text-shadow: 1px 1px 1px #000;color:#d2d2e2;">
		<h1 class="text-center">Шановний ${user.firstname}, реєстрацію завершено!</h1>
		<h1 class="text-center"> Дякуємо за реєстрацію!</h1>
		<h1 class="text-center">Тепер ви зможете зайти на сайт!</h1>
	
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>