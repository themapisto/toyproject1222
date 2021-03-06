<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/resources/css/error.css" rel="stylesheet" type="text/css">
<title>Error</title>
</head>
<body>
    <p>ERROR</p>
    <h2>We're Sorry. Something went wrong.</h2>
    <h3>죄송합니다. 요청하신 페이지를 찾을수 없습니다.</h3>
    <h3>이전 화면으로 돌아가시거나 메인 화면으로 이동하시기 바랍니다. </h3>
    <br>
    <button type="button" onclick="history.back();">이전</button> &nbsp;<button onclick="location.href='/';">메인으로</button>
</body>
</html>