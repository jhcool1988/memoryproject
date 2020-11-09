<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang=ko>
<head>
    <meta charset="utf-8">
    <title>게시물 수정</title>
    <link href="/resources/css/update.css" rel="stylesheet">
</head>


<body>
<div id="form-div">
<form role="form" method="post" class="form" id="form1">

        <p class="writer">
            <input name="writer" type="text" class="validate[required,custom[onlyLetter],length[0,100]] feedback-input" placeholder="글쓴이" id="name"
            value= "<c:out value="${list.writer}" />" />
        </p>
        
        <p class="addr">
            <input name="addr" type="text" class="validate[required,custom[email]] feedback-input" id="email" placeholder="지역이름" 
            value="<c:out value="${list.addr}" />"/>
        </p>
        
        <p class="context">
            <textarea name="context" class="validate[required,length[6,300]] feedback-input" id="comment" placeholder="내용"
            value="<c:out value="${list.context}" />"></textarea>
        </p>
        <div class="submit">
            <input type="submit" value="SEND" id="button-blue"/>
            <div class="ease"></div>
        </div>

    	<input name="placename" type="hidden" value="${list.placename}">
</form>
</div>



<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/list.js"></script>
<script>
$(document).ready(function(){
	
	var registerBtn = $("#button-blue");
	var place = $("input[name='placename']").val();
	
	registerBtn.on("click", function(e){
		
		console.log("수정중입니다.....");
		
		e.preventDefault();
		
		var board = {
				idx: ${param.idx},
				context: $("textarea[name='context']").val()
		};
		
		contextService.update(board, function(result){
			
			self.location="/board/list?placename="+ place
			
			
			
		});
		
		
		

	});


	

});
</script>



</body>
</html>