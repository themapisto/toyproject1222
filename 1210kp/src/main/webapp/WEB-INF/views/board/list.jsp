<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert title here</title>
</head>
<body>

<!DOCTYPE html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Ensures optimal rendering on mobile devices. -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge" /> <!-- Optimal Internet Explorer compatibility -->
</head>

<script src="https://www.paypal.com/sdk/js?client-id=AQPrrIuemnOd2qvQmtxdrRwxteZcdhs3o-0y5hZxVAdr5NqGarbDmeY0jExpXYGIVXDVK7oRpRqJ6yhz"></script>
<script>paypal.Buttons().render('body');</script>






 <body>
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
  <td>${list.userId}</td>
  <td>${list.userNm}</td>
  <td>${list.regDt}</td>
  <td>${list.grade}</td>
  <td>${list.userState}</td>
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