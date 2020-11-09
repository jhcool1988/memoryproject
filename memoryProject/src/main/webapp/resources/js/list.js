console.log("List Module........");

	var contextService = (function() {
		
		function getList(placename, callback, error) {
			//console.log("리스트 불러오는중........");
			
			
			
			//console.log(placename);
			
			$.getJSON("/board/list/" + placename + ".json",
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
		
		
		function add(board, callback, error){
			console.log("add board.............");
			
			$.ajax({
				type : 'post',
				url : '/board/new',
				data : JSON.stringify(board),
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
		
		
		function remove(idx, callback, error){
			$.ajax({
				type : 'delete',
				url : '/board/' + idx,
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
		
		function update(context, callback, error) {

			console.log("idx: " + context);

			$.ajax({
				type : 'put',
				url : '/board/' + context.idx,
				data : JSON.stringify(context),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if (error) {
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
			update : update
		};
	})();