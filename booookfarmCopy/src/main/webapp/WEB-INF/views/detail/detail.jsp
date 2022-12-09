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
<title>책 정보 페이지</title>
<link rel="stylesheet" href="${path}/resources/css/styles.css">
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/module/header.jsp" %>
<!-- 왼쪽 사이드 퀵메뉴(최근 본 목록) css: quick -->
<!-- <div class="quickmenu">
  <div class="quickmenu-title">
  	<div>최근 본 상품</div>
  		<div class="quickmenu-contianer">
  			<div></div>
  		</div>
  </div>
</div> -->
<main class="st-ma">
	<div class="main-container">
	<div class="book-info-container">
		<div class="book--info">
			<div id="m_info" class="main--info">
				<input id="book_code" name="bookCode" type="hidden" value="${book_code}">
			</div>
			<div class="book-detail-layout">
				<div id="c_info" class="book-detail-card">
				
				</div>
			</div>
		</div>
		<div class="book-intro-container">
			<div class="book-intro-layout">
				<div id="i_info" class="book-intro-card">
				</div>
			</div>
		</div>
	</div>
	<div class="order-select-container">
		<div class="order-inner-layout">
			<div class="order-frame">
				<div class="col-name">
					수량
				</div>
				<div class="quantity-img-box">
					<img class="minus-img" src="${path}/resources/img/icon/minus.png" onclick="get_detail_stock('minus')">
				</div>
				<div class="col-amount">
					<input id="d-stock" class="detail-stock" name="stockValue" type="text" value="1" disabled="disabled">
				</div>
				<div class="quantity-img-box">
					<img class="plus-img" src="${path}/resources/img/icon/plus.png" onclick="get_detail_stock('plus')">						
				</div>
			</div>
			<div class="order-frame alpa">
				<div class="col-name delta">
					결제예정금액
				</div>
				<div class="col-price">
					<input id="d-amount" class="detail-amount" name="amountValue" type="text" value="0" disabled="disabled">
				</div>
				<div class="col-won">
					원
				</div>
			</div>
			<div class="order-button-frame">
				<div class="botton-col left">
					<button class="basket-btn" type="button"><span>장바구니</span></button>
				</div>
			</div>
		</div>
	</div>
	</div>
</main>
<footer class="st-ft-detail">
	<div class="book-recommend-container">
			<div class="book-recommend-layout">
				<div class="recommend-card">
					<div class="recommend-title">
						<div class="recommend-name">북팜 최신 등록도서</div>
					</div>
					<div id="r_info" class="book-rsort">
					</div>		
				</div>
			</div>
		</div>
	<div class="footer-container">
		<div class="footer-layout">
			<div class="footer-frame">
				<div class="footer-menu">
					<p class="ft-link">회사소개</p>
					|
					<p class="ft-link">개인정보취급방침</p>
					|
					<p class="ft-link">이용약관</p>
					|
					<p class="ft-link">고객센터</p>
				</div>
				<div class="footer-info">
					Copyright(c) 2022 ㈜ 시퀀스엔. All Rights Reserved [사업자정보] 대표전화 : 1544 -2949 | 대표(CEO) : 양종선 | 개인정보 보호책임자 : 양종선 사업자등록번<br>
					호 : 285-81-00634 | 통신판매업 신고번호 : 제 2017-서울서초-0272호. 서울시 서초구 서초대로 397 부띠크모나코 A동 301호 | Email : help@bookoa.com 
				</div>
				<div class="cs-frame">
					<div class="cs-inner">
						<div class="cus">고객만족센터</div>
						<div class="cus-num">1544-2949</div>
					</div>
				</div>
				<div class="cs-info web">
					<a href="#">상담시간 안내</a>
				</div>
			</div>
		</div>		
	</div>
</footer>
</body>
<!-- 왼쪽 퀵 메뉴(최근 본 상품) 조절 스크립트 -->
<script type="text/javascript">
let d_stock = '';
function get_detail_page() {
	$.ajax({
		url: "./view?bookCode="+ $('#book_code').val(),
		type: "GET",
		dataType: "json",
		success: function(res) {
			let _html = '';
				_html += '<div class="book--condition">'+res.bookCondition+'</div>';
				_html += '<div class="book--name">'+res.bookTitle+'</div>';
				_html += '<div class="book--detail-info">';
				_html += '<span>저자 '+res.bookAuthor+'</span>&nbsp;|&nbsp;';
				_html += '<span>출판사 '+res.publisher+'</span>&nbsp;|&nbsp;';
				_html += '<span>상품등록일 '+res.createDate+'</span>';
				_html += '</div>';
			$('#m_info').html(_html);
			let _pay= Math.floor((res.bookPrice - (res.bookPrice * (res.bookDiscount*0.01)))/10)*10;
			let _html2 = '';
				_html2 += '<div class="book-img">';
				_html2 += '<img class="book--img" src="'+res.bookImgPath+'">';
				_html2 += '</div>';
				_html2 += '<div class="detail-card-info">';
				_html2 += '<div class="row-info">';
				_html2 += '<div class="row-title">카테고리</div>';
				_html2 += '<div class="basic-data">';
				_html2 += '<div class="cate-info">';
				_html2 += ''+res.bookCategory+'';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '<div class="row-info">';
				_html2 += '<div class="row-title">ISBN</div>';
				_html2 += '<div class="basic-data">';
				_html2 += '<div class="isbn-info">';
				_html2 += ''+res.isbn+'';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '<div class="row-info">';
				_html2 += '<div class="row-title">판매가</div>';
				_html2 += '<div class="basic-data">';
				_html2 += '<div class="price-info">';
				_html2 += ''+_pay.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
				_html2 += '</div>';
				_html2 += '<div class="sale-percent">';
				_html2 += ''+res.bookDiscount+'%';
				_html2 += '</div>';
				_html2 += '<div class="common-direction">';
				_html2 += '<div class="down-arrow">➔</div>';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '<div class="row-info">';
				_html2 += '<div class="row-title">정가</div>';
				_html2 += '<div class="basic-data">';
				_html2 += '<div class="origin-price">';
				_html2 += ''+res.bookPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '<div class="row-info">';
				_html2 += '<div class="row-title">배송비</div>';
				_html2 += '<div class="basic-data">';
				_html2 += '<div class="delivery-fee">';
				_html2 += '3,000원';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '<div class="row-info">';
				_html2 += '<div class="basic-data">';
				_html2 += '<div class="delivery-info">';
				_html2 += '판매자 상품 30,000원이상 구매시 무료배송';
				_html2 += '</div>';
				_html2 += '</div>';
				_html2 += '</div>';
			$('#c_info').html(_html2);
			
			let _html3='';
				_html3 += '<div class="book-card">';
				_html3 += '<div class="row-intro">';
				_html3 += '<div class="row-intro-title">판매자 책설명</div>';
				_html3 += '</div>';
				_html3 += '<div class="row-intro-data">';
				_html3 += '<div class="intro-data">';
				_html3 += ''+res.bookInfo+'';
				_html3 += '</div>';
				_html3 += '</div>';
				_html3 += '</div>';
				_html3 += '<div class="book-card">';
				_html3 += '<div class="row-intro">';
				_html3 += '<div class="row-intro-title">책소개</div>';
				_html3 += '</div>';
				_html3 += '<div class="row-intro-data">';
				_html3 += '<div class="intro-data">';
				_html3 += ''+res.bookConditionInfo+'';
				_html3 += '</div>';
				_html3 += '</div>';
				_html3 += '</div>';
				_html3 += '<div class="book-card">';
				_html3 += '<div class="row-intro">';
				_html3 += '<div class="row-intro-title rule">북팜 안내사항</div>';
				_html3 += '</div>';
				_html3 += '<div class="row-intro-data">';
				_html3 += '<div class="intro-rule">';
				_html3 += '- 위 판매상품은 판매자가 직접 등록/판매하는 상품으로 판매자가 해당 상품과 내용에 모든 책임을 지며 중개시스템만 &nbsp;&nbsp;제공하는 북팜은 일체책임을 지지않습니다.<br>';
				_html3 += '- 북팜에서는 개인정보보호법을 위반하는 개인정보가 포함된 도서는 판매금지입니다.위반내용이 접수되는 경우 북팜 &nbsp;&nbsp;에서는 임의로 해당도서를 삭제할 수 있습니다.<br>';	
				_html3 += '- 북팜에서 판매되는 중고상품의 취소 및 반품은 판매자와 별도 협의 후 진행 가능합니다.<br>';	
				_html3 += '- ISBN으로 등록된 도서 이미지 및 정가는 실제와 다를 수 있습니다.';	
				_html3 += '</div>';
				_html3 += '</div>';
				_html3 += '</div>';
			$('#i_info').html(_html3);
			d_stock= res.stock;
		}
	});
}

function get_detail_list(){
	$.ajax({
		url: "./detail-list?bookCode="+ $('#book_code').val(),
		type: "GET",
		dataType: "json",
		success: function(data){
			let _html='';
			for (var j=0; j < data.dataList.length; j++) {
				_html += '<div class="book-sort">';
				_html += '<div class="book-fix">';
				_html += '<div class="latest-book-img">';
				_html += '<div class="latest-book">';
				_html += '<img class="latest-recommend" src="'+data.dataList[j].bookImgPath+'">';
				_html += '</div>';
				_html += '</div>';
				_html += '<div class="book-name-place">';
				_html += '<div class="latest-book-name">'+data.dataList[j].bookTitle+'</div>';
				_html += '</div>';
				_html += '<div class="author-name-place">';
				_html += '<div class="recommend-author">'+data.dataList[j].bookAuthor+'</div>';
				_html += '</div>';
				_html += '</div>';
				_html += '</div>';
			}
		$('#r_info').html(_html);
		}
	});
}

function get_detail_stock(type){
	const resultElement = document.getElementById('d-stock');
	let stock = resultElement.value;
	if(type === "plus") {
		stock = parseInt(stock) >= d_stock ? d_stock : parseInt(stock) + 1;
	}else if(type === "minus") {
		stock = parseInt(stock) <= 1 ? 1 : parseInt(stock) - 1;
	}
	resultElement.value = stock;
	get_detail_amount();
}
//수량에 맞게 자동계산이 적용이 안됨. = 해결 => 수량 클릭이벤트때마다 가격 계산함수 가 실해되어야 함.
function get_detail_amount(){
	const resultAmount = document.getElementById('d-amount');
	const resultStock = document.getElementById('d-stock');
	let amount = resultAmount.value;
	let stock = resultStock.value;
	amount = (${book_info.bookPrice} - (${book_info.bookPrice} * (${book_info.bookDiscount}*0.01))) * parseInt(stock);
	resultAmount.value = (Math.floor(amount/10)*10).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
}
//디테일 페이지에서 장바구니 버튼클릭시 데이터 전달 코드
/*FormData는 ajax로 이미지 파일을 업로드할 때 사용 */
function add_cart() {
	if(${book_info.stock} != 0){
		const form = {
			bookCode:'${book_info.bookCode}',
			bookTitle:'${book_info.bookTitle}',
			bookAuthor: '${book_info.bookAuthor}',
			bookInfo: '${book_info.bookInfo}',
			bookPrice: ${book_info.bookPrice},
			bookDiscount: ${book_info.bookDiscount},
			isbn: '${book_info.isbn}',
			bookCategory: '${book_info.bookCategory}',
			stock: ${book_info.stock},
			publisher: '${book_info.publisher}',
			bookCondition: '${book_info.bookCondition}',
			bookConditionInfo: '${book_info.bookConditionInfo}',
			bookImgPath: '${book_info.bookImgPath}',
			createDate: '${book_info.createDate}' //지정한 날짜 형식이 맞지 않아 에러발생
		}
	$.ajax({
		url: "./basket-info",
		type:"POST",
		data: JSON.stringify(form),
		dataType: "json",
		contentType : "application/json; charset=UTF-8",
		success: function(data){
			if(data.code == 'success'){
				alert("장바구니에 추가되었습니다.");
			}else if(data.code == 'fail'){
				alert("이미 담겨진 상품입니다.");
			}
		}
	});
	}else{
		alert("재고가 모두 소진된 상품입니다.");
		return;
}
}
//장바구니 버튼 이벤트
$('.basket-btn').on('click', function(e) {
	add_cart();
});

$(document).ready(function(){
  get_detail_page();
  get_detail_list();
  get_detail_amount();
});

</script>
</html>