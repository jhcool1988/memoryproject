<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang=ko>
<head>
    <meta charset="utf-8">
    <title>게시물 등록</title>
    <link href="/resources/css/register.css" rel="stylesheet">
</head>


<body>
<div id="form-div">
<form role="form" action="/board/register" method="post" class="form" id="form1">
    	<div class='uploadResult'>
		<ul>
		
		
		</ul>
	</div>
	
	<div class = 'bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
    	<div class="uploadDiv">
		<input type="file" name='uploadFile' multiple>
	</div>
        <p class="writer">
            <input name="writer" type="text" class="validate[required,custom[onlyLetter],length[0,100]] feedback-input" placeholder="글쓴이" id="name" />
        </p>
        
        <p class="addr">
            <input name="addr" type="text" class="validate[required,custom[email]] feedback-input" id="email" placeholder="지역이름" />
        </p>
        
        <p class="context">
            <textarea name="context" class="validate[required,length[6,300]] feedback-input" id="comment" placeholder="내용"></textarea>
        </p>
        <div class="submit">
            <input type="submit" value="SEND" id="button-blue"/>
            <div class="ease"></div>
        </div>

    	<input name="placename" type="hidden" value="${param.placename}">
</form>
</div>



<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/list.js"></script>
<script>
// 썸네일 클릭시 이미지 원본 확장 출력
function showImage(fileCallPath){
	// alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display","flex").show();
	
	$(".bigPicture")
	.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
	.animate({width:'100%', height: '100%'}, 1000);
	
	// 확장된 이미지 클릭시 이미지 사라짐
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(() => {
			$(this).hide();
		}, 1000); 
	});
}

$(document).ready(function(){
	
	// 첨부파일 삭제
	$(".uploadResult").on("click","button", function(e){
		
		console.log("delete file......");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType:'text',
			type:'POST',
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		}); // $.ajax
	});
	
	
	var regex = new RegExp("(.*?)\.(png|img|jpg|jpeg|gif)$");
	var maxSize = 5242880; // 5MB
	
	// 파일 사이즈 확인, 이미지 파일 확인
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("업로드 성공!!");
			return true;
		} else {
			alert("이미지 파일만 업로드할수 있습니다.");
			return false;
		}
		return true;
	}
	
	// 아무 내용이 없는 input type='file' 객체가 포함된 div 를 복사함
	var cloneObj = $(".uploadDiv").clone();
	
	// ajax를 이용하는 업로드 파일을 FormData객체를 이용하여 전송
	// $("#uploadBtn").on("click", function(e){
	// 클릭버튼에서 내용변경시 업로드로 변경
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
		
		// formdata에 파일데이터 추가
		for(var i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
			
		}
		
		
		$.ajax({
			url: '/uploadAjaxAction',
				processData: false, // 반드시 false
				contentType: false, // 반드시 false
				data: formData, // formData 자체를 전송
				type: 'POST',
				dataType: 'json',
				success: function(result){
					
					console.log(result);
					
					showUploadResult(result);
					
					$(".uploadDiv").html(cloneObj.html());
					
				}
		}); // $.ajax
		
	});
	
	
	// 업로드 된 파일 목록 보여주기
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){return;}
	
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
				
				// Get 방식의 첨부파일 사용시 파일이름에 포함된 한글이나 공백이 문제가 될수 있으므로
				// 이를 수정하기 위해 URI 호출에 적합한 문자열로 인코딩 처리
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
				
				str += "<li data-path='"+obj.uploadPath+"'";
				str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'><img src='/resources/img/deletebutton.jpg'></button><br>"
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "<input type='hidden' name='uuid' value='"+obj.uuid+"'>";
				str += "</div></li>";
			
		});
		
		uploadUL.append(str);
	}
	

});
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	
	var registerBtn = $("#button-blue");
	var formObj = $("form[role='form']");
	
	registerBtn.on("click", function(e){
		
		console.log("서버에 전송중입니다....");
		
		e.preventDefault();
		
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+encodeURIComponent(jobj.data("filename"))+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		
		formObj.append(str).submit();
		
		var board = {
				writer: $("input[name='writer']").val(),
				context: $("textarea[name='context']").val(),
				addr: $("input[name='addr']").val(),
				uuid: $("input[name='uuid']").val(),
				placename: $("input[name='placename']").val(),
		};
		
		contextService.add(board, function(result){
			
			alert(result);
			
			
			
		});

	});
	
});
</script>


</body>
</html>