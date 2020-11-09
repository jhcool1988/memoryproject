console.log("Image Module........");

	var imageService = (function() {
		
		function getImage(param, callback, error) {
			//console.log("이미지 불러오는중........");
			
			var uuid = param.uuid;
			
			//console.log(uuid);
			
			$.getJSON("/board/getAttachList", {uuid: uuid},
					function(data) {
						if (callback){
							callback(data);
						}
					}).fail(function(xhr, status, err){
						if (error) {
							error();
						}
			});
		}
		
		function removeimg(uuid, callback, error){
/*			console.log("이미지 삭제 완료");
			console.log(uuid);*/
			
			$.ajax({
				type : 'delete',
				url : '/board/delete/' + uuid,
				success : function(deleteResult, status, xhr){
					if (callback){
						callback(deleteResult);
					}
				},
				error : function(xhr, status, er){
					if(error){
						error(er);
					}
				}
			});
			
			
		}
		
		return {
			getImage : getImage,
			removeimg : removeimg
		}
		
	})();