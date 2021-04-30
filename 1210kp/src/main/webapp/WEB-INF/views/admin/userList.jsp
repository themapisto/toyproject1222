<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>

<title>회원관리 리스트</title>
<link href="/resources/css/default.css?p" rel="stylesheet" type="text/css">
<link href="/resources/css/userList.css?" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/admin/header.jsp" %>
<%@include file="/WEB-INF/views/admin/sidebar.jsp" %>
<div id="contents">
	<div id="contents_title"><span>|회원목록</span></div>
	<form id="filter" name="filter" method="get" action="/admin/userList">
		<div id="flex">
		<select id="state" name="state">
			<option value="">전체</option>
			<option value="1" ${pageDto.state eq "1"? "selected":"" }>가입</option>
			<option value="8" ${pageDto.state eq "8"? "selected":"" }>잠김</option>
			<option value="9" ${pageDto.state eq "9"? "selected":"" }>탈퇴</option> 
		</select>
		<select id="option" name="option">
			<option value="userNm" ${pageDto.option eq "userNm"? "selected":"" }>이름</option>
			<option value="userId" ${pageDto.option eq "userId"? "selected":"" }>아이디</option>
		</select>
		<input type="text" id="keyword" name="keyword" value="${pageDto.keyword}">
    	<button type="submit" id="searchBtn">검색</button>
    	</div>
	</form>
<table id="userTable">
    <colgroup>
        <col style="width:10%;">
        <col style="width:10%;">
        <col style="width:15%;">
        <col style="width:15%;">
        <col style="width:20%;">
        <col style="width:30%;">
    </colgroup>

    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">회원등급</th>
            <th scope="col">이름</th>
            <th scope="col">아이디</th>
            <th scope="col">가입일자</th>
            <th scope="col">회원상태<br><font size="2">가입/잠김/탈퇴</font></th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${userList}" var="user" varStatus="status">
        <tr>
            <td>${pageDto.startIdx + status.count}</td>
            <td>일반회원</td>
            <td>${user.userNm}</td>
            <td class="userId">${user.userId}</td>
            <td>
            	<fmt:formatDate value="${user.regDt}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
            	<select class="userState" name="userState">
					<option value="1" ${user.userState eq "1"? "selected":"" }>가입</option>
					<option value="8" ${user.userState eq "8"? "selected":"" }>잠김</option>
					<option value="9" ${user.userState eq "9"? "selected":"" }>탈퇴</option> 
				</select>
            	<button
            		type="button" id="modifyBtn" class="modifyBtn"
            		onClick="modifyState(this, '${user.userId}');">
            		회원상태 변경✓
            	</button>
            </td>
            
        </tr>
        </c:forEach>   
    </tbody>
</table>
<div id="pages" style="display: block; text-align: center;">
		<c:if test="${pageDto.prev == true }">
			<a href="/admin/userList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.startPage - 1 }">&lt;</a>
		</c:if>
		<c:forEach begin="${pageDto.startPage}" end="${pageDto.endPage}" var="p">
			<c:choose>
				<c:when test="${p == pageDto.page}">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != pageDto.page}">
					<a href="/admin/userList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${p }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${pageDto.next == true}">
			<a href="/admin/userList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.endPage+1 }">&gt;</a>
		</c:if>
</div>
</div>

<script type="text/javascript">
    
    $(document).ready(function () {
    	
    	
    	/* $("#modify").on('click', function() {
    		modifyState();
    	})
    	
    	$("#modify0").on('click', function() {
    		modifyState();
    	});
    	$("#modify1").on('click', function() {
    		modifyState();
    	});
    	$("#modify2").on('click', function() {
    		modifyState();
    	});
    	$("#modify10").on('click', function() {
    		modifyState();
    	}); */
    	
    	// const modifyBtnList = $('.modifyBtn'); // 배열! 그러니까.. 리스트!
    	
    	/* for (let i = 0; i < modifyBtnList.length; i++) {
    		// const id = '#modify' + i; // #modify0, #modify1, #modify2, #modify3, ... #modify10
    		//$(id).on('click', function() {
   			//modifyBtnList[i].on('click', function() {
   				
 			$(modifyBtnList[i]).on('click', function() {
        		modifyState(i);
        	});
    	} */
    	
    	/* $('.modifyBtn').each(function(i) { // jquery 방식의 고차함수지만, 나중에 javascript의 map, reduce, forEach 등의 고차함수를 쓰면 또 좋음!
    		$(this).on('click', function() {
    			// i: 현재 반복문 중에서 몇번째 i인지
    			// this: $('.modifyBtn')이라는 jquery 리스트에 들어있는 하나 하나의 item(= <button ... ></button>) 중 i번째 item
    			// 사실, 프로그래밍에서 this는 굉장히 "특별!!!"한 글자여서 여기저기에서 저마다 따로 쓰일거에요
        		
    			// $($('#modify0').parent().parent().children('td')[3]).text()
    			
    			
    			
    			// A) jquery object
    			// B) DOM object (=HTML object)
    			// 요거 두개가 서로 다르다!
    			// 하여, .text() 라는걸 쓰려면, jquery object로 바꿔줘야 하는데...
    			// 그걸, $() = jquery selector를 통해서, 바꿔줄 수 있다.
    			// const td = $(this).parent().parent().children('td')[3]; // 즉, 이 td는 현재 jquery object가 아니고, 일반 DOM object이다
    			// const td = $(this).parent().parent().children('td.userId'); // 'td .userId' = jquery selector query
    			
    			const btnObject = this;
    			const tr = $(btnObject).parent().parent();
    			const select = $(tr).find('select.userState')[0];
    			const userState = $(select).val();
    			
    			
    			// const id = $(td).text(); // .text(): jquery의 방식! https://api.jquery.com/text/
    			// const id = td.innerText; // .innerText: DOM element의 방식! https://developer.mozilla.org/ko/docs/Web/API/HTMLElement/innerText
    			const userId = $(this).attr('userId');
    			
    			modifyState(userId, userState);
        	});
    	}); */
    	// 장점 1: 쭐일 수 있다!
    	// 장점 2: 사실.. 그닥 줄이진 않는데 (머쓱) 다른 사람이 이렇게 줄여놓은걸 이해할 수 있따.
    	
    	
    	// $('#modify0')
    	// $(): jqeury selector
    	// jquery의 방식으르 통해서 html element를 선택하는 방법!
    	// "#" : id로 element를 선택함-> id니까, 1개뿐!
    	// "." : class로 element 들을 선택함-> class니까, 여러개! = 배열
    	
    	// : jquery를 통해서 html element중 id가 <modify0>인 element 하나를! 찾아서 
    	
    	// .on('click', 
		// 거기에 <'click'>이벤트가 발생하면,
    	
		// = .on(이벤트명
		// 앞의, selector에서 <이벤트명> 의 이벤트가 발생한다면,
				
		// function() {});
    	// 이 함수의 내용을 실행해주세요
    	
    	
    	
    	
    });
    
    let stateMap = new Map([
        ["1", "가입"],
        ["8", "잠김"],
        ["9", "탈퇴"]
    ]);
    
   	function modifyState(btnObject, userId) {
   		const tr = $(btnObject).parent().parent();
		const select = $(tr).find('select.userState')[0];
		const userState = $(select).val();
    	var confirmResult = confirm(userId+"님을 "+stateMap.get(userState)+"상태로 변경하시겠습니까?");
    	if(confirmResult == true){
    		$.ajax({
                url: "/admin/modifyState",
                type: "POST",
                data: {
                	userId:userId,
                	userState:userState
                },
                success: function(data){
                    alert(data.Msg);
                },
                error: function(){
                    alert("잠시 후 다시 시도해주세요");
                }
          	});
    	}
    }
    
</script>
</body>
</html>