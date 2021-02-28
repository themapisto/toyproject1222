<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="/css/default.css" rel="stylesheet" type="text/css">
	<title>insert title here</title>
</head>
<<<<<<< HEAD
<body>
=======
<<<<<<< HEAD

<link rel="stylesheet" href="/resources/css/reset.css" type="text/css">
<link rel="stylesheet" href="/resources/css/list.css" type="text/css">

<body> 
>>>>>>> bbb8a0d797cc0aa3dacce885f6fc9a4142ecca00

<!DOCTYPE html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Ensures optimal rendering on mobile devices. -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge" /> <!-- Optimal Internet Explorer compatibility -->
</head>

<script src="https://www.paypal.com/sdk/js?client-id=AQPrrIuemnOd2qvQmtxdrRwxteZcdhs3o-0y5hZxVAdr5NqGarbDmeY0jExpXYGIVXDVK7oRpRqJ6yhz"></script>
<script>paypal.Buttons().render('body');</script>






 <body>
<<<<<<< HEAD
=======
 
<div class="img-thumbnail">
<h3>1위</h3>
 <img src="/resources/images/1.jpg" alt="국평" class="img-kp" >
<h3>신세계</h3>
<a href="/board/reservation">예매하기</a>
 </div>

 <div class="img-thumbnail">
 <h3>2위</h3>
 <img src="/resources/images/2.jpg" alt="국평" class="img-kp">
<h3>신세계</h3>
=======
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>

<table>
 <thead>
  <tr>
   <th>번호</th>
   <th>제목</th>
   <th>작성일</th>
   <th>작성자</th>
   <th>조회수</th>
  </tr>
 </thead>
>>>>>>> Bchan
 
 </div>
  <div class="img-thumbnail">
  <h3>3위</h3>
 <img src="/resources/images/3.jpg" alt="국평" class="img-kp">
<h3>신세계</h3>
 
 </div>
  <div class="img-thumbnail">
  <h3>4위</h3>
 <img src="/resources/images/4.jpg" alt="국평"class="img-kp">
<h3>신세계</h3>
 
 </div>

 

 
>>>>>>> bbb8a0d797cc0aa3dacce885f6fc9a4142ecca00
 <table>
 <thead>
  <tr>
   <th>번호</th>
   <th>제목</th>
   <th>작성일</th>
   <th>작성자</th>
   <th>조회수</th>
  </tr>
 </thead>
 
 <tbody>
  <c:forEach items="${list}" var="list">
 <tr>
<<<<<<< HEAD
  <td>${list.userId}</td>
  <td>${list.userNm}</td>
  <td>${list.regDt}</td>
  <td>${list.grade}</td>
  <td>${list.userState}</td>
=======
<<<<<<< HEAD
  <td>${list.movieCd}</td>
  <td>${list.movieNm}</td>

=======
  <td>${list.bno}</td>
  <td>${list.title}</td>
  <td>${list.regDate}</td>
  <td>${list.writer}</td>
  <td>${list.viewCnt}</td>
>>>>>>> Bchan
>>>>>>> bbb8a0d797cc0aa3dacce885f6fc9a4142ecca00
 </tr>
</c:forEach>
 </tbody>

</table>

<div id="paypal-button-container">
  <script>
  paypal.Buttons({
    createOrder: function(data, actions) {
      // This function sets up the details of the transaction, including the amount and line item details.
      return actions.order.create({
        purchase_units: [{
          amount: {
            value: '20'
          }
        }]
      });
    }
  }).render('#paypal-button-container');
  </script>
</div>


</body>
  











</html>