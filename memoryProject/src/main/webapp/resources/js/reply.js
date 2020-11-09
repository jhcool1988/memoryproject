console.log("reply Module........");

	var replyService = (function() {
		
		function getList(param, callback, error) {
			
			var idx = param;
			
			
			$.getJSON("/reply/list/" + idx + ".json",
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
		
		
		function add(reply, callback, error){
			console.log("add board.............");
			
			$.ajax({
				type : 'post',
				url : '/reply/new',
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr){
					if(callback){
						callback(result);
					}
				},
				error : function(xhr, status, er){
					if(error){
						error(er);
					}
				}
			});
		}
		
		
		function remove(bno, callback, error){
			$.ajax({
				type : 'delete',
				url : '/reply/' + bno,
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
		
		function displayTime(timeValue) {
			var today = new Date();
			
			var gap = today.getTime() - timeValue;
			
			var dateObj = new Date(timeValue);
			var str = "";
			
			if (gap < (1000 * 60 * 60 * 24)) {
				
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
				
				return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');
				
			} else {
				var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
				var dd = dateObj.getDate();
				
				return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
			}
		};
		
		function update(reply, callback, error){
			console.log("content: " + content);
			

			$.ajax({
				type: 'put',
				url : '/reply/' + reply.idx,
				data : JSON.stringify(content),
				contentType: "application/json; charset=utf-8",
				success : function(result, status, xhr){
					if(callback){
						callback(result);
					}
				},
				error : function(xhr, status, er){
					if(error){
						error(er);
					}
				}
			});
		}
		
		// 댓글 전체삭제를 위한 함수 생성
		function removeall(idx, callback, error){
			$.ajax({
				type : 'delete',
				url : '/reply/removeall/' + idx,
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
			getList : getList,
			add : add,
			remove : remove,
			displayTime : displayTime,
			update : update,
			removeall : removeall
		};
		
		
	})();