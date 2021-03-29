<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page session="false" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>

<head>

	<title>Movie!!!!</title>

</head>

<body>


 <body>
 <table>
 <thead>
  <tr>
   <th>순위</th>
   <th>제목</th>
   <th>개봉일</th>
   <th>관객수</th>
   <th>판매량</th>
  </tr>
 </thead>

 <tbody>
  <c:forEach items="${list}" var="list">
 <tr>
  <td>${list.rank}</td>
  <td>${list.movieNm}</td>
  <td>${list.openDt}</td>
  <td>${list.audiAcc}</td>
  <td>${list.salesAmt}</td>
 </tr>
</c:forEach>
 </tbody>

</table>


</body>

</html>