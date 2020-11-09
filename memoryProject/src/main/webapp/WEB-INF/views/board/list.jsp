<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang=ko>
<head>
    <meta charset="utf-8">
    <title>우리들 이야기</title>

<!-- css 링크  -->
<link href="/resources/css/header.css" rel="stylesheet">
<link href="/resources/css/instragram.css" rel="stylesheet">
<link href="/resources/css/map.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.1/css/lightbox.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<!--내부 js 파일-->
<script type="text/javascript" src="/resources/js/list.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript" src="/resources/js/image.js"></script>  

<!-- 외부 js 파일 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.1/js/lightbox.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.12.0/lodash.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6cba759251da0ee9238500ed3933657c&libraries=services"></script>


</head>
<body style="background-color: #f5f5f5;">
<section class="search-header card-panel grey lighten-4" style="padding: 5px;margin-bottom:1.5rem;margin-top: 0.5rem;">
  <div class="container">
    <div class="input-field">
      <i class="material-icons prefix" style="position: absolute;top: 10px; left: -5%;">search</i>
      <form onsubmit="searchPlaces(); return false;">
      <input placeholder="장소를 검색하시오" id="keyword" type="text"  value="${param.placename}">
		<button type="button" id="newBoard" onclick="location.href='/board/register?placename=${param.placename}'" style="font-size: 15px; position: absolute;" class="btn btn-outline-secondary">새글쓰기</button>
      </form>
    </div>
  </div>
  <div class="progress search-progress">
    <div class="indeterminate"></div>
  </div>
</section>

<div class="map_wrap">
    <div id="map" style="width:98%;height:100%;position:relative;overflow:hidden; margin-top:10px;"></div>
	<div class="hAddr">
        <span class="title">지도중심기준 행정동 주소정보</span>
        <span id="centerAddr"></span>
    </div>

    <div id="menu_wrap" class="bg_white" style="background:#ffffff8f">
        <div class="option">
            <div>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
<div style ="position: absolute;left: 70%;top: 100px">
<div class="bv-curations-cleanslate bv-columns-wrapper">
<div id="bv-col-gallery">
<div class="fm-columnshub-container bv-columns-theme-classic" >
</div>
</div></div>
</div>

<script>
$(document).ready(function (){
	
	var placename = '${param.placename}'; // 파라미터를 통해 값을 이동
	var contextUL = $(".fm-columnshub-container"); // html 값을 넣기 부분 선택자
	showList(1);
		// 해당 게시물을 보여주는 함수
		function showList(){
			// 파라미터를 통해 받아온 placename을 이용해서 해당 주소 글들을 getList 함수를 통해 getjson으로 받아옴
			contextService.getList(placename, function(list){
				var str="";
				// 값이 없으면 빈 값을 넣기 위한 if 문
				if(list == null || list.length == 0){
					contextUL.html("");
					return;
				}
				// 해당 게시물들을 함수를 통해 list[]로 불러옴
				// 각각의 값을 도출해내기 위해 for문을 만들어서 도출
				for( var i = 0, len = list.length || 0; i < len; i++){
					
					// 게시물마다 선택자 지정을 위해 하나씩 이름을 지정
					var reply = "insertreply"+list[i].idx;
					
					str +='<div class="fm-block" data-fm-source="0" data-fm-content="16859">'
					str +='<div class="fm-update fm-tracked clearfix fm-show-preview" data-id="16859">'
					str +='<div class="fm-update-wrapper fm-has-photo fm-has-media">'
					str +='<div class="fm-info">'
					str +='<div class="fm-avatar">'
					str +='<a href="#" target="_blank">'
					str +='<img src="https://movie-phinf.pstatic.net/20200922_187/1600766020751jJdur_JPEG/movie_image.jpg&amp;checksum=6705346548142112954"></a>'
					str +='</div>'
					str +='<div class="fm-twitter-author"> '
					str +='<a target="_blank" href="https://twitter.com/RDSBarath/">'     
					str +=list[i].writer 
					str +='</a></div>'
					str +='<div class="fm-twitter-username">'
					str +='<a target="_blank" href="https://twitter.com/RDSBarath/">'
					str +=list[i].placename
					str +='</a></div>'
					str +='<div class="fm-timestamp">'   
					//str +='<button id="modBtn'+i+'" value="'+list[i].idx+'">수정</button>'
					str +='<button name="deletebtn" id="removeBtn'+i+'" value="'+list[i].idx+'" style="'
					str +='font-size: 0.5rem;'
					str +='width: 30px;'
					str +='height: 15px;'
					str +='padding: 0px;'
					str +='border-right-width: 1px;'
					str +='margin-right: 3px;'
					str +='"class="btn btn-outline-secondary" >삭제</button>'
					str +='<button name="updatebtn" id="updateBtn'+i+'" value="'+list[i].idx+'" style="'
					str +='font-size: 0.5rem;'
					str +='width: 30px;'
					str +='height: 15px;'
					str +='padding: 0px;'
					str +='border-right-width: 1px;'
					str +='margin-right: 3px;'
					str +='"class="btn btn-outline-secondary">수정</button>'
					str +=contextService.displayTime(list[i].updateDate)
					str +='</div></div>'
					str +='<div class="fm-media">'  
					str +='<div class="fm-photo-wrapper" id="insertImage'+ list[i].uuid+'">'
					/* str +='<img class="fm-photo" src="+list[i].img+">' */
					//str +='<img class="fm-photo" src="https://movie-phinf.pstatic.net/20201014_169/1602658084349Db9Hs_JPEG/movie_image.jpg&amp;width=260&amp;height=500">'
					str +='</div></div>'
					str +='<div class="fm-text">'
					str +='<p class="fm-text-main">'
					str +=list[i].context
					str +='</p></div>'
						// 게시물마다 선택자 지정을 위해 하나씩 이름을 지정
					str +='<div id="'+reply+'">'
					str +='</div>'
					str +='<div class="feed-footer">'
					str +='<input name="inre'+i+'" type="text" class="ny" placeholder="Add a comment..." style="font-size: 0.8rem;" value=""/>'
					str +='<button id="inrebtn'+i+'"  type="button" class="btn btn-outline-secondary" style="'
					str +='font-size: 0.5rem;'
					str +='width: 30px;'
					str +='height: 15px;'
					str +='padding: 0px;'
					str +='border-right-width: 1px;'
					str +='margin-right: 3px;'
					str +='">생성</button>'
					str +='<input type="hidden" value="'+list[i].idx+'" name="inreidx'+i+'">'
					str +='<input type="hidden" name="uuid'+list[i].idx+'" value="'+list[i].uuid+'">'
					str +='</div></div></div></div>'
				}

				// 일단 도출한 str를  html로 표현을 하여 생성을 함
				contextUL.html(str);
				
				// 이미지 파일 입력
				// 게시물 마다 하나씩 존재하는 값을 불러내기 위해 button[name="deletebtn"] 선택자 사용
				// 게시물당 하나씩만 존재한다면 다른 선택자도 가능
				$('button[name="deletebtn"]').each(function(i){

					var str1 = "";
					var uuid = list[i].uuid;
					// 저장된 함수를 이용하여 getjson을 통해서 리스트를 가져옴
					imageService.getImage({uuid:list[i].uuid}, function(arr){
						
						var image2 = "#insertImage" + list[i].uuid;
						var str1 = "";
	
						// 함수를 통해 도출된 arr 파일을 .each를 이용해서 하나씩 값을 뽑아냄
						// 그러면서 데이터 베이스 안에 저장된 경로 이름을 도출
						$(arr).each(function(i, attach){
								var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_"+attach.uuid+"_"+attach.fileName);
								var originPath = attach.uploadPath+ "\\"+ attach.uuid + "_"+ attach.fileName;
								// 뽑아낸 값의 정리를 위해 /로 대체를 해줌
								originPath = originPath.replace(new RegExp(/\\/g),"/");
								//console.log("fileCallPath : " + fileCallPath);
								// a 태그에 컨트롤에 정의된 display함수를 이용해서 그림을 도출
								// 클래스를 주어 외부에서 가져온 그림 확대 기능을 추가
								str1 += "<a href='/display?fileName="+originPath+"' data-title='"+list[i].context+"' data-lightbox='example-set'><img class='fm-photo' src='/display?fileName="+originPath+"&amp;width=260&amp;height=500'></a>";
					
						});

						$(image2).html(str1);
				
					});
				});
				
				// i 값을 불러내기 위해 각 게시물마다 하나씩 있는 선택자를 불러옴
				// 불러온 후 each 문을 이용해서 list[i]값을 불러냄
				$('button[name="deletebtn"]').each(function(i){
				// 위에 지정한 개시물 id 값을 불러내기 위해 이 함수를 사용
				var reply2 = "#insertreply"+list[i].idx;
				// reply.js에 정의해둔 함수를 불러서 reply 리스트를 뽑아냄
				// 함수 값으로 위에 i를 이용해서 각 게시물의 idx값을 이용해서 값을 넣어 해당 글의 댓글(reply)을 도출함
				replyService.getList(list[i].idx, function(reply){
				// 값이 아무것도 없으면 넣지 않음
				if(reply == null || reply.length == 0){					
					$(reply2).append("");					
					return;
				}
				// html로 도출하기 위한 변수 선언
				var replyidx="";
				// 해당글의 댓글을 다 도출해 낸 후 하나씩 값을 입력을 하기 위해 for문을 하나 더 생성
				for( var j = 0, len = reply.length || 0; j < len; j++){
					replyidx +='<input type="hidden" name="removeAllReply'+i+'" value="'+list[i].idx+'">'
					replyidx +='<div class="replynum '+reply[j].bno+'"><strong>'+ reply[j].replyer+' : </strong>'+reply[j].reply
					replyidx +='<button class="delreplynum" class="btn-outline-secondary" style="padding-bottom: 0px;'
					replyidx +='padding-top: 0px; padding-left: 3px; padding-right: 3px;'
					replyidx +='height: 19px;" value="'+reply[j].bno+'">X</button>'
					replyidx +='</div>'
				}	
				// 그리고 위에 지정한 값을 찾아서 스크립트를 통해 생성된 게시판을 찾아서 
				// html에 넣어줌
				$(reply2).html(replyidx);
				
				// 개별 댓글 삭제  
				$(".delreplynum").on("click", function(){
					// 누른 버튼의 bno 값을 가져옴
					var replybno = $(this).val();
					// 누른 버튼의 bno 값을 함수에 입력하여 해당 댓글을 삭제함
					replyService.remove(replybno, function(result){
							alert("해당 댓글삭제완료");
						});
						location.reload();
					});
				});
				});
				
				
				// i를 불러내기 위한 반복문
				// 게시물 마다 하나씩 존재하는 값을 불러내기 위해 button[name="deletebtn"] 선택자 사용
				// 게시물당 하나씩만 존재한다면 다른 선택자도 가능
		        $('button[name="deletebtn"]').each(function(i){ 
		        	
		        	// 지정한 선택자를 변수로 만듬
		        	var mid = "#updateBtn"+i;
		            var did = "#removeBtn"+i;
	        
		            // 삭제 버튼 스크립트
		            $(did).on("click", function(){
		            // 지정한 선택자 값을 가져옴
		            var upd = $(did).val();
		           // 대입하여 해당 글 삭제
		           // 함수는 ajax를 사용해서 삭제를함
		            contextService.remove(upd, function(result){
		               alert(result);
		            }); 	            
		           // 해당 게시물 댓글 전체 삭제
		           // 선택자 지정후 삭제를 가능하게 해줌
		            var replyremoveidx =  $('input[name="removeAllReply'+i+'"]').val()
		           // 해당글에 있는 모든 댓글을 삭제를 해줌
		            replyService.removeall(replyremoveidx)
		            // 이미지 선택자 지정
		            var uuid2 = $('input[name="uuid'+upd+'"]').val()
		            // 해당 글에 있는 이미지를 같이 삭제를 해줌
		            imageService.removeimg(uuid2);
		            
		            // 삭제후 새로고침으로 이동
		            //self.location ="/board/list";
		            location.reload();
		         }); 
		            // 수정버튼 클릭후
		            $(mid).on("click", function(){
			            
			            var upd = $(mid).val();

			            // 삭제후 새로고침으로 이동
			            self.location ="/board/update?idx="+upd;
			         });
			         			         
			         // 댓글 생성 함수
			         var inreply = $('input[name="inre'+i+'"]');
			         var inrebtn = $('#inrebtn'+i+'');
			         var inreidx = $('input[name="inreidx'+i+'"]');
			         // 함수를 눌렀을때 해당 replys를 json 값으로 넣어
			         // ajax를 통해 값을 데이터 베이스에 입력함
			         inrebtn.on("click",function(){
			        	 var replys={
			        			 idx :inreidx.val(),
			        			 reply: inreply.val(),
			        			 replyer : "sim"
			        	 }
			         
			          replyService.add(replys);
			        	 location.reload();
			
			         });
	         
		         });

			});// end function
	
		}// end showList

});
</script>

<script>
// 마커를 담을 배열입니다
var markers = [];

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    level: 1 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

//현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);

//지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
        detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
        
        var placename = "/board/list?placename="+result[0].address.address_name
        
        var content = '<div class="bAddr">' +
                        '<span class="title">법정동 주소정보</span>' + 
                        // by.jhcool1988 controller로 주소 파라미터 전송시키기 위하여 기존 api코드를 수정 20.10.20
                        '<form role="form" action="/board/list" method="post">' +
                        detailAddr +
                        '<a href="'+placename+'">Submit Button</a>' +
                    '</form></div>';
        // 마커를 클릭한 위치에 표시합니다 
        marker.setPosition(mouseEvent.latLng);
        marker.setMap(map);
        // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
        infowindow.setContent(content);
        infowindow.open(map, marker);
        
        console.log(result[0].address.address_name);
    }   
});
});

//중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
// 좌표로 행정동 주소 정보를 요청합니다
geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
// 좌표로 법정동 상세 주소 정보를 요청합니다
geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

//지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
if (status === kakao.maps.services.Status.OK) {
    var infoDiv = document.getElementById('centerAddr');

    for(var i = 0; i < result.length; i++) {
        // 행정동의 region_type 값은 'H' 이므로
        if (result[i].region_type === 'H') {
            infoDiv.innerHTML = result[i].address_name;
            break;
        }
    }
}    
}
 
</script>
</body>
</html>