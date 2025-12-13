<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Go title here</title>
<style>
	body {
		margin: 0;
		padding: 0;
		display: flex;
		justify-content: center;
		align-items: center;
		height:100vh;
	}
	
	.btn {
		padding:1rem;
		border-radius: 2em;
		cursor:pointer;
		margin-inline:3rem;
	}
</style>
</head>
<body>
	<button class="btn" onclick="window.location.href='./login.jsp'">Login</button>
	<button class="btn" onclick="window.location.href='./register.jsp'">Register</button>
	<button class="btn" onclick="window.location.href='./update.jsp'">Update</button>
	<button class="btn" onclick="window.location.href='./delete.jsp'">Delete</button>
</body>
</html>