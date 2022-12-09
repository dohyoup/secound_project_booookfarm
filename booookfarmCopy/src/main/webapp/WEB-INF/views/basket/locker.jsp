<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>     
<!DOCTYPE html>
<html>
<c:set var="path" value="${pageContext.request.contextPath}" />
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="${path}/resources/css/styles.css">
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/module/header.jsp" %>
<!-- 왼쪽 사이드 퀵메뉴(최근 본 목록) css: quick -->
<div class="quickmenu">
  <div class="quickmenu-title">
  	<div>최근 본 상품</div>
  		<div class="quickmenu-contianer">
  			<div></div>
  		</div>
  </div>
</div>
<main class="st-ma">
	<div class="main-container">
	<div class="basket-container">
		<div class="basket-layout">
			<div class="basket-title">
				<div class="basket-name">보관함</div>
			</div>
			<div class="basket-icon">
				<div class="bas-icon to-bas-icon">
					<img src="${path}/resources/img/icon/basketicon-grey.svg">
				</div>
				<div class="bas-name to-bas-icon">장바구니</div>
				<div class="bas-doticon">
					<img src="${path}/resources/img/icon/18-px-grey-5-dot.png">
				</div>
				<div class="bas-icon to-locker-icon">
					<img src="${path}/resources/img/icon/basketicon.svg">
				</div>
				<div class="bas-name to-locker-icon">보관함</div>
			</div>
		</div>
		<div class="basket-list-container">
			<div class="basket-list-layout">
				<div class="total-delete-btn total-delete-locker-btn">
					<button class="total-delete-button" type="button" onclick="locker_select_remove()">선택상품 삭제</button>
				</div>
				<div class="book-list-sort locker-list-sort">	
					<div class="book-list locker-list">
						<div class="title-table">
							<table class="sort-test">
								<thead>
									<tr class="element-name-table">
										<th class="total-checkbox"><input id="cbx_checkAll" class="total-checkbox" type="checkbox"  onclick="selectAll(this)"></th>
										<th class="list-element-select">전체</th>
										<th class="list-element-info">상품정보</th>
										<th class="list-element-price">판매가</th>
										<th class="list-element-quantity">수량</th>
										<th class="list-element-seller">판매자</th>
										<th class="list-element-delivery">배송비</th>
										<th class="list-element-delete">선택</th>
									</tr>
								</thead>
								<tbody id="locker_list" class="table-body">
									
								</tbody>
								<tfoot>
									<tr class="shop-total">
										<td class="calculation" colspan="8">
											<strong id="total_book_price">0</strong>  + 3,000원(유료배송) = 
											<strong id="total_pay">0원</strong>
										</td>
									</tr>
								</tfoot>
							</table>	
						</div>
					</div>
				</div>	
			</div>	
		</div>
	</div>
	</div>
</main>
<%@include file="/WEB-INF/views/module/footer.jsp" %>
</body>
<script type="text/javascript">
function get_locker_list(){
	$.ajax({
		url:"./locker-info",
		type: "POST",
		dataType: "json",
		success: function(data){
			let _html='';
			for(var i=0; i < data.dataList.length; i++){
				_html += '<tr class="element-table">';
				_html += '<td class="checkbox"><input id="book_select_'+i+'" name="bookCheck" class="checkbox click_chk" type="checkbox" value="'+data.dataList[i].bookCode+'"></td>';
				_html += '<td class="accurate-select"></td>';
				_html += '<td class="accurate-info">';
				_html += '<div class="accurate-info-layout">';
				_html += '<div class="info-img">';
				_html += '<div class="basket-book-img">';
				_html += '<img class="basket--img" src="'+data.dataList[i].bookImgPath+'">';
				_html += '</div>';
				_html += '</div>';
				_html += '<div class="info-name">';
				_html += '<div class="basket-book-name">';
				_html += '<a href="/boookfarm/detail?bookcode='+data.dataList[i].bookCode+'">'+data.dataList[i].bookTitle+'/'+data.dataList[i].bookAuthor+'</a>';
				_html += '</div>';
				_html += '</div>';
				_html += '</div>';
				_html += '</td>';
				_html += '<td class="accurate-price">';
				_html += '<div class="accurate-price-layout">';
				_html += '<div class="origin-price-won">';
				_html += '<div class="basket-book-price">';
				_html += ''+(data.dataList[i].bookPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
				_html += '</div>';
				_html += '</div>';
				_html += '<div class="discount-price-won">';
				_html += '<div id="d_amount_'+i+'" class="basket-book-price">';
				_html += (Math.floor((data.dataList[i].bookPrice - (data.dataList[i].bookPrice * (data.dataList[i].bookDiscount*0.01)))/10)*10).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
				_html += '</div>';
				_html += '</div>';
				_html += '</div>';
				_html += '</td>';
				_html += '<td class="accurate-quantity">';
				_html += '<div class="accurate-quantity-layout">';
				_html += '<div class="quantity-num">';
				_html += '<div class="basket-book-minus">';
				_html += '<img class="minus-btn" src="${path}/resources/img/icon/24-px-grey-7-remove.png" onclick="get_locker_stock(\'minus\',\''+i+'\')">';
				_html += '</div>';
				_html += '</div>';
				_html += '<div class="quantity-num">';
				_html += '<div class="basket-book-quantity">';
				_html += '<input id="d_stock_'+i+'" class="detail-stock" name="stockValue" type="text" value="1" disabled="disabled">';
				_html += '<input id="max_stock_'+i+'" class="detail-stock" type="hidden" value="'+data.dataList[i].stock+'" disabled="disabled">';
				_html += '<input id="amount_'+i+'" class="detail-amount" type="hidden" value="'+(data.dataList[i].bookPrice - (data.dataList[i].bookPrice * (data.dataList[i].bookDiscount*0.01)))+'" disabled="disabled">';
				_html += '<input id="bookcode_'+i+'" class="detail-bookcood" type="hidden" value="'+data.dataList[i].bookCode+'" disabled="disabled">';
				_html += '</div>';
				_html += '</div>';
				_html += '<div class="quantity-num">';
				_html += '<div class="basket-book-plus">';
				_html += '<img class="plus-btn" src="${path}/resources/img/icon/24-px-grey-7-add.png" onclick="get_locker_stock(\'plus\',\''+i+'\')">';
				_html += '</div>';
				_html += '</div>';
				_html += '</div>';
				_html += '</td>';
				_html += '<td class="accurate-seller"';
				_html += '<div class="accurate-seller-layout">';
				_html += '<div class="seller-name">';
				_html += '<div class="basket-book-seller">';
				_html += '북팜 중고만화';
				_html += '</div>';
				_html += '</div>';
				_html += '</div>';
				_html += '</td>';
				_html += '<td class="accurate-delivery-fee">';
				_html += '<div class="accurate-delivery-fee-layout">';
				_html += '<div class="delivery-fee-won">';
				_html += '<div class="basket-book-delivery-fee">';
				_html += '3,000원';
				_html += '</div>';
				_html += '</div>';
				_html += '</div>';
				_html += '</td>';
				_html += '<td class="delete-select">';
				_html += '<div class="delete-select-layout">';
				_html += '<div class="delete-btn">';
				_html += '<button id="remove_'+i+'" class="delete-button" onclick="locker_list_remove(\''+i+'\')">삭제</button>';
				_html += '</div>';
				_html += '</div>';
				_html += '</td>';
				_html += '</tr>';
			}
			$('#locker_list').html(_html);
		}
	});	
}
//장바구니 리스트 수량 적용
function get_locker_stock(type, idx){
	const d_stock = document.getElementById('max_stock_' +idx).value;
	let resultElement = document.getElementById('d_stock_'+idx);
	let stock = resultElement.value;
	if(type === "plus") {
		stock = parseInt(stock) >= d_stock ? d_stock : parseInt(stock) + 1;
	}else if(type === "minus") {
		stock = parseInt(stock) <= 1 ? 1 : parseInt(stock) - 1;
	}
	resultElement.value = stock;
	get_locker_amount(idx);
	order_box_info();
}
//장바구니 리스트 수량에 따른 가격 적용 
function get_locker_amount(idx){
	const d_amount = document.getElementById('amount_'+idx).value;
	let stock = document.getElementById('d_stock_'+idx).value;
	const resultAmount = document.getElementById('d_amount_'+idx);
	let amount = d_amount * parseInt(stock);
	resultAmount.innerHTML = (Math.floor(amount/10)*10).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
}
//삭제버튼 클릭 이벤트
function locker_list_remove(idx){
	const d_bookcode = document.getElementById('bookcode_'+idx).value;
	if(confirm("삭제 하시겠습니까?") == false) {
		return;
	}
	$.ajax({
		url:"./locker-remove-list",
		type: "POST",
		data: d_bookcode,
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(result){
			if(result.code == 'success'){
				alert("삭제가 완료되었습니다.");
				get_locker_list();
			}else{
				alert("삭제가 실패되었습니다.");
			}
		}
	});
}
//선택상품 삭제 이벤트
function locker_select_remove(){
	//눌렀을때 input checkbox의 속성이 checked면 삭제 
    let select_list = [];
	$('input[name=bookCheck]:checked').each(function(){
		 select_list.push($(this).val());
	});
	let user_select = {"bookCode": select_list};
	if(confirm("삭제 하시겠습니까?") == false) {
		return;
	}
	 $.ajax({
		url: "./locker-remove-selection",
		type: "POST",
		data: JSON.stringify(user_select),
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(result){
			if(result.code == 'success'){
				alert("삭제가 완료되었습니다.");
				get_locker_list();
			}else{
				alert("삭제가 실패되었습니다.");
			}
		}
	 });
}
//선택상품 가격 자동 합산
function order_box_info(){
	let sum = 0;
	let total = 0;
	let delivry = 3000;
	$('input[name=bookCheck]:checked').each(function(){
		let arr = $(this).attr("id").split("_");
		let idx = arr[2];
		const d_amount = $('#amount_'+idx).val();
		const d_stock = $('#d_stock_'+idx).val();
		let pay = d_amount * d_stock;
		sum += Math.floor(pay/10)*10;
	});
	$('#total_book_price').html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	$('#total_pay').html((sum + delivry).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
}
//장바구니 아이콘 클릭 이벤트
$('.to-bas-icon').on('click', function(){
	location.href="/boookfarm/basket";
})
//이동 위젯 및 이벤트 호출
$(document).ready(function(){
  var currentPosition = parseInt($(".quickmenu").css("top"));
  $(window).scroll(function() {
    var position = $(window).scrollTop();
    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},500);
  });
  get_locker_list();
  $('#locker_list').on('click', '.click_chk', function() {
	order_box_info();  
  });
  $('#cbx_checkAll').click(function(){
  	if($('#cbx_checkAll').is(":checked"))
	   $("input[name=bookCheck]").prop("checked", true); 
 	else $("input[name=bookCheck]").prop("checked", false);
  	order_box_info();
  });
}); 
</script>
</html>	