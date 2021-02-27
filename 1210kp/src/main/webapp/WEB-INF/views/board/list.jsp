<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>


<head>
<meta charset="UTF-8">
<title>insert title here</title>
</head>

<link rel="stylesheet" href="/resources/css/reset.css" type="text/css">
<link rel="stylesheet" href="/resources/css/list.css" type="text/css">

<body> 

<!DOCTYPE html>


<head>
  <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Ensures optimal rendering on mobile devices. -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge" /> <!-- Optimal Internet Explorer compatibility -->
</head>

<script src="https://www.paypal.com/sdk/js?client-id=AQPrrIuemnOd2qvQmtxdrRwxteZcdhs3o-0y5hZxVAdr5NqGarbDmeY0jExpXYGIVXDVK7oRpRqJ6yhz"></script>






 <body>
 
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

 

 
 <table>

 <tbody>
  <c:forEach items="${list}" var="list">
 <tr>
  <td>${list.movieCd}</td>
  <td>${list.movieNm}</td>

 </tr>
</c:forEach>
 </tbody>

</table>

<div id="paypal-button-container">
  <script>
  //가격
  var people=3;
  var price=6*people;
  
  paypal.Buttons({
    createOrder: function(data, actions) {
      // This function sets up the details of the transaction, including the amount and line item details.
      return actions.order.create({
        purchase_units: [{
          amount: {
            value: price
          }
        }]
      });
    }
  }).render('#paypal-button-container');
  </script>
</div>


</body>
  











</html>