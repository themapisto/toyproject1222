
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>회원관리 리스트</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>    
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
<form id="filter" name="filter">
    &nbsp;&nbsp;회원등급 :
    <select id="grade">
        <option value="all">전체</option>
        <option value="1">일반회원</option>
        <option value="2">관리자</option>
    </select>
    이름 :<input type="text" id="userName" name="userName">
    아이디 :<input type="text" id="userId" name="userId">
    회원상태 :
    <select id="state" name="state">
        <option value="all">전체</option>
        <option value="1">가입</option>
        <option value="2">탈퇴</option>
        <option value="3">잠김</option>
    </select>
    가입일자 :
    <span>
        <input type="text" id="datepickerStart" readonly >
        ~
        <input type="text" id="datepickerEnd" readonly >
    </span>
    
    
    <button type="button">검색</button>
</form>    
<table id="userTable">
    <colgroup>
        <col style="width:10%;">
        <col style="width:10%;">
        <col style="width:15%;">
        <col style="width:30%;">
        <col style="width:20%;">
        <col style="width:15%;">
    </colgroup>

    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">회원등급</th>
            <th scope="col">이름</th>
            <th scope="col">아이디</th>
            <th scope="col">회원상태(가입/탈퇴/잠김/휴면)</th>
            <th scope="col">가입일자</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>2</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>3</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>4</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>5</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>6</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>7</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>8</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>9</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
        <tr>
            <td>10</td>
            <td>일반회원</td>
            <td>배찬</td>
            <td>baechan</td>
            <td>가입</td>
            <td>2017-03-15</td>
        </tr>
    </tbody>
</table>


<script type="text/javascript">
    $("#datepickerStart, #datepickerEnd").datepicker({
        dateFormat:'yy-mm-dd',
        changeYear:true,
        changeMonth:true
    });
</script>
</body>
</html>