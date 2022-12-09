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
<title>주문서작성/결제</title>
<link rel="stylesheet" href="${path}/resources/css/styles.css">
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/module/header.jsp" %>
<section id="start_page">
<main class="st-ma">
	<div class="main-container">
	<div class="basket-container">
		<div class="basket-layout">
			<div class="basket-title">
				<div class="basket-name">주문서작성 / 결제</div>
			</div>
			<div class="basket-icon">
				<div class="bas-icon non-pointer">
					<img src="${path}/resources/img/icon/basketicon-grey.svg">
				</div>
				<div class="bas-name non-pointer">장바구니</div>
				<div class="bas-doticon">
					<img src="${path}/resources/img/icon/18-px-grey-5-dot.png">
				</div>
				<div class="bas-icon non-pointer">
					<img src="${path}/resources/img/icon/48-px-payment-active.svg">
				</div>
				<div class="bas-name non-pointer">주문서작성/결제</div>
				<div class="bas-doticon">
					<img src="${path}/resources/img/icon/18-px-grey-5-dot.png">
				</div>
				<div class="bas-icon non-pointer">
					<img src="${path}/resources/img/icon/48-px-complete-normal.svg">
				</div>
				<div class="bas-name non-pointer">주문완료</div>
			</div>
		</div>
		<div class="basket-list-container">
			<div class="basket-list-layout">
				<div class="order-title">
					주문상품
				</div>
				<div class="book-list-sort">	
					<div class="book-list">
						<div class="title-table">
							<table class="sort-test">
								<thead>
									<tr class="element-name-table">
										<th class="list-element-info">상품정보</th>
										<th class="list-element-price">판매가</th>
										<th class="list-element-quantity">수량</th>
										<th class="list-element-seller">판매자</th>
										<th class="list-element-delivery">배송비</th>
									</tr>
								</thead>
								<tbody id="order_list" class="table-body">
								</tbody>
								<tfoot>	
									<tr class="shop-total">
										<td class="calculation" colspan="6">
											<strong id="total_book_price">0</strong> + 
											<strong>3,000</strong>원(유료배송) = 
											<strong id="total_pay">0</strong>
										</td>
									</tr>
								<tfoot>	
							</table>	
						</div>
					</div>
					<div id="test1" class="basket-order-container">
						<div id="test2" class="basket-order-layout">
							<div class="box-title">
								주문 금액
							</div>
							<div class="box-content">
								<div class="box-row">
									<div class="row--title">
										총 상품금액
									</div>
									<div id="order_price" class="row--data">
										2,000원
									</div>
								</div>
								<div class="box-row">
									<div class="row--title">
										배송비
									</div>
									<div class="row--data">
										3,000원
									</div>
								</div>
								<div class="box-row">
									<div class="row--title">
										도서산간료
									</div>
									<div class="row--data">
										0원
									</div>
								</div>
								<div class="box-row">
									<div class="row--title">
										포인트 사용
									</div>
									<div id="use__mileage"class="row--data">
										0원
									</div>
								</div>
								<div class="divided"></div>	
								<div class="box-row as">
									<div class="row--title">
										총 결제금액
									</div>
									<div id="total_price" class="row--amount">
										0
									</div>
								</div>
							</div>
							<div>
								<button id="order_button" class="order-box-button" type="button">결제하기</button>
							</div>
						</div>
					</div>
				</div>	
			</div>	
		</div>
		<form class="order-info-container">
			<div class="order-info-layout">
				<div class="title-area">주문자 정보</div>
				<div class="detail-area">
					<div class="payment-input-container">
						<div class="order-info-title">주문하신 분</div>
						<div class="input-area">
							<input class="input-order-info static-info" type="text" value="${userData.memName}" disabled="disabled">
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">연락처</div>
						<div class="input-area">
							<input class="input-order-info static-info" type="text" value="${userData.phone}" disabled="disabled">
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">이메일</div>
						<div class="input-area">
							<input class="input-order-info static-info" type="text" value="${userData.email}" disabled="disabled">
						</div>
					</div>		
				</div>
			</div>
			<div class="order-info-layout">
				<div class="title-area">배송지 정보</div>
				<div class="detail-area">
					<div class="payment-input-container">
						<div class="order-info-title">배송지</div>
						<div class="input-area">
							<button class="address-toggle1 on" type="button" >기본주소</button>
							<button class="address-toggle2 off" type="button" >새로운주소</button>
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">받으시는 분</div>
						<div class="input-area">
							<input name="memName" class="input-order-info info-border origin-info" type="text" value="${userData.memName}" disabled="disabled">
							<input name="memName" class="input-order-info info-border hidden-info" type="hidden" value="홍길동">
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">연락처</div>
						<div class="input-area">
							<input name="phone" class="input-order-info info-border origin-info" type="text" value="${userData.phone}" disabled="disabled">
							<input name="phone" class="input-order-info info-border hidden-info" type="hidden" value="010-0000-0000">
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">이메일</div>
						<div class="input-area">
							<input name="email" class="input-order-info info-border origin-info" type="text" value="${userData.email}" disabled="disabled">
							<input name="email" class="input-order-info info-border hidden-info" type="hidden" value="honggildong@naver.com">
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">주소</div>
						<div class="input-area">
							<input id="postalCode" name="postalCode" class="input-order-info-address info-border origin-info" type="text" value="${userData.postCode}" disabled="disabled">
							<input id="postalCode2" name="postalCode" class="input-order-info-address info-border hidden-info" type="hidden" value="우편번호">
						</div>
						<div class="address-button-frame">
							<input id="address_button" class="address-btn" type="button" onclick="daumPostcode()" value="우편번호 검색" disabled="disabled">
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title"></div>
						<div class="input-area">
							<input id="address" name="address" class="input-order-info info-border origin-info" type="text" value="${userData.addr}" disabled="disabled">
							<input id="address2" name="address" class="input-order-info info-border hidden-info" type="hidden" value="기본 주소">
						</div>
					</div>	
					<div class="payment-input-container">
						<div class="order-info-title"></div>
						<div class="input-area">
							<input id="detailAddress" name="detailAddress" class="input-order-info info-border origin-info" type="text" value="${userData.detailAddr}" disabled="disabled">
							<input id="detailAddress2" name="detailAddress" class="input-order-info info-border new-address hidden-info" type="hidden" value="상세 주소">
						</div>
					</div>
				</div>
			</div>
			<div class="order-info-layout">
				<div class="title-area">결제정보</div>
				<div class="detail-area">
					<div class="payment-input-container">
						<div class="order-info-title">E-Money 사용</div>
						<div class="input-area">
							<input id="user_mileage" class="input-order-info-emoney info-border" type="number"  value="0" min="0" max="${userData.mileage}">
						</div>
						<div class="order-info-title-half">
							<div class="possess-emoney">보유 E-Money ${userData.mileage} 원</div>
						</div>
						<div>
							<button id="all_point" class="use-mileage"type="button">전액사용</button>
						</div>
					</div>
					<div class="payment-input-container">
						<div class="order-info-title">결제수단</div>
						<div class="input-area">
							<div class="depositor">입금자명</div>
							<input class="depositor-name info-border" type="text" placeholder="입금자명을 입력해주세요.">
						</div>
					</div>
					<div class="payment-input-container pay_on">
						<div class="order-info-title"></div>
						<div class="input-area">
							<div class="depositor">환불계좌</div>
							<input class="depositor-name info-border" type="text" placeholder="계좌번호를 입력해주세요.">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	</div>
</main>
<%@include file="/WEB-INF/views/module/footer.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</section>
<section id="second_page" class="page_hidden">
	<div class="main-container">
	<div class="basket-container">
		<div class="basket-layout">
			<div class="basket-title com_title">
				<div class="basket-name com_alert">주문이 정상적으로 완료되었습니다.</div>
			</div>
			<div class="basket-icon">
				<div class="bas-icon non-pointer">
					<img src="${path}/resources/img/icon/basketicon-grey.svg">
				</div>
				<div class="bas-name non-pointer">장바구니</div>
				<div class="bas-doticon">
					<img src="${path}/resources/img/icon/18-px-grey-5-dot.png">
				</div>
				<div class="bas-icon non-pointer">
					<img src="${path}/resources/img/icon/48-px-payment-normal.svg">
				</div>
				<div class="bas-name non-pointer">주문서작성/결제</div>
				<div class="bas-doticon">
					<img src="${path}/resources/img/icon/18-px-grey-5-dot.png">
				</div>
				<div class="bas-icon non-pointer">
					<img src="${path}/resources/img/icon/48-px-complete-active.svg">
				</div>
				<div class="bas-name non-pointer">주문완료</div>
			</div>
			<div class="c_address_info">
				<div class="c_title">
					배송지정보
				</div>
				<div class="c_info">
					<div class="sty_input">
						<input class="c_postal" type="text"  value="${userData.postCode}" disabled="disabled">
					</div>
					<div class="sty_input">
						<input class="c_address" type="text" value="${userData.addr}" disabled="disabled">
					</div>
					<div class="sty_input">
						<input class="c_detail_address"type="text" value="${userData.detailAddr}" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="c_btn_menu">
				<button id="shop_btn" class="shop_btn" type="button">쇼핑계속하기</button>
				<button id="cancel_btn" class="cancel_btn" type="button" onclick="cancelPay()">주문취소</button>
			</div>
		</div>
	</div>
	</div>	
<%@include file="/WEB-INF/views/module/footer.jsp" %>
</section>
</body>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">

function order_info(){
	var bookData =${bookCode};
	let _html = '';
	for(var i = 0; i < bookData.dataList.length; i++){
	let price = Math.floor(((bookData.dataList[i].bookPrice - (bookData.dataList[i].bookPrice * (bookData.dataList[i].bookDiscount * 0.01)))*bookData.dataList[i].sel_stock)/10)*10;
		_html += '<tr class="element-table">';
		_html += '<td class="accurate-info">';
		_html += '<div class="accurate-info-layout">';
		_html += '<div class="info-img">';
		_html += '<div class="basket-book-img">';
		_html += '<img class="basket--img" src="'+bookData.dataList[i].bookImgPath+'">';
		_html += '</div>';
		_html += '</div>';
		_html += '<div class="info-name">';
		_html += '<div class="basket-book-name">';
		_html += ''+bookData.dataList[i].bookTitle+'';
		_html += '</div>';
		_html += '</div>';
		_html += '</div>';
		_html += '</td>';
		_html += '<td class="accurate-price">';
		_html += '<div class="accurate-price-layout">';
		_html += '<div class="origin-price-won stan">';
		_html += '<div class="basket-book-price">';
		_html += ''+Math.floor(bookData.dataList[i].bookPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
		_html += '</div>';
		_html += '</div>';
		_html += '<div class="discount-price-won stan">';
		_html += '<div class="basket-book-price">';
		_html += price.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원';
		_html += '<input id="d_price_'+i+'" type="hidden" name="order_price" value="'+price+'">';
		_html += '</div>';
		_html += '</div>';
		_html += '</div>';
		_html += '</td>';
		_html += '<td class="accurate-quantity">';
		_html += '<div class="accurate-quantity-layout">';
		_html += '<div class="quantity-num stan-2">';
		_html += '<div class="basket-book-quantity">';
		_html += bookData.dataList[i].sel_stock;
		_html += '</div>';
		_html += '</div>';
		_html += '</div>';
		_html += '</td>';
		_html += '<td class="accurate-seller">';
		_html += '<div class="accurate-seller-layout">';
		_html += '<div class="seller-name stan-3">';
		_html += '<div class="basket-book-seller">';
		_html += '북팜 중고만화';
		_html += '</div>';
		_html += '</div>';
		_html += '</div>';
		_html += '</td>';
		_html += '<td class="accurate-delivery-fee">';
		_html += '<div class="accurate-delivery-fee-layout">';
		_html += '<div class="delivery-fee-won stan-4">';
		_html += '<div class="basket-book-delivery-fee">';
		_html += '3,000원';
		_html += '</div>';
		_html += '</div>';
		_html += '</div>';
		_html += '</td>';
		_html += '</tr>';
	}
	$('#order_list').html(_html);
};

function order_sum(){
	let sum= 0;
	let price = $('#order_price');
	let total_price = $('#total_price');
	let book_price = $('#total_book_price');
	let total_book_price = $('#total_pay');
	 $("input[name='order_price']").each(function(){
		 let arr = $(this).attr("id").split("_");
		 let idx = arr[2];
		 let amount = $('#d_price_'+idx).val();
		 sum += parseInt(amount);
	 })
	price.html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	total_price.html((sum+3000).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	book_price.html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	total_book_price.html((sum+3000).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
}

function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            }

            // 우편번호와 주소 정보+참고항목을 해당 필드에 넣는다.
            document.getElementById('postalCode2').value = data.zonecode;
            document.getElementById("address2").value = addr + extraAddr;
            isAddr = true;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress2").focus();
        }
    }).open();
}
//결제기능
var test1 = '';
$("#order_button").click(function () {
	let _sum = 0;
	let h_price = 0;
	let use_mileage = $('#user_mileage').val();
	let _bookData = ${bookCode};
	let _bookCode = '';
	let _selStock = '';
	let _bookTitle = '';
	test1 ='merchant_'+new Date().getTime();
	console.log(test1);
	for(let i = 0; i < _bookData.dataList.length; i++){
		_bookCode += _bookData.dataList[i].bookCode +",";
		_selStock += _bookData.dataList[i].sel_stock +",";
		_bookTitle += _bookData.dataList[i].bookTitle +",";
	}
	let _bookCodes = _bookCode.substr(0, _bookCode.length - 1);
	let _stocks = _selStock.substr(0, _selStock.length - 1);
	let _bookTitles = _bookTitle.substr(0, _bookTitle.length - 1);
	$("input[name='order_price']").each(function(){
		 let arr = $(this).attr("id").split("_");
		 let idx = arr[2];
		 let amount = $('#d_price_'+idx).val();
		 _sum += parseInt(amount);
	 });
	h_price = (_sum + 3000) - use_mileage; // amount에 넣으면됨.
	
	var IMP = window.IMP; // 생략가능
	IMP.init('imp31788281');  // 가맹점 식별 코드
	IMP.request_pay({
	    pg : 'html5_inicis.INIpayTest', // 결제방식
	    pay_method : 'card',	// 결제 수단
	    merchant_uid: 'merchant_'+new Date().getTime(),
        name: "북팜 중고책",
        amount: 100,
        buyer_email: $("input[name='email']").val(),
        buyer_name: $("input[name='memName']").val(),
        buyer_tel: $("input[name='phone']").val(),
        buyer_addr: $("input[name='address']").val(),
        buyer_postcode: $("input[name='postalCode']").val()
	}, function(rsp) {
		if ( rsp.success ) { // 성공시
			// 주문정보 테이블에 구매 정보가 저장되는 로직
			var msg = '결제가 완료되었습니다.';
			msg += '고유ID : ' + rsp.imp_uid;
			msg += '상점 거래ID : ' + rsp.merchant_uid;
			msg += '결제 금액 : ' + rsp.paid_amount;
			msg += '카드 승인번호 : ' + rsp.apply_num;
			const form ={
							orderNum: 'merchant_'+new Date().getTime(),
							bookCode: _bookCodes,
							bookTitle: _bookTitles,
							quantity: _stocks,
							useMileage: $('#user_mileage').val(),
							mileage: Math.floor((${userData.mileage}+(h_price * 0.01)-$('#user_mileage').val())/10)*10,
							price: h_price,
							memId:'${userData.memId}',
							postCode: $("input[name='postalCode']").val(),
							addr: $("input[name='address']").val(),
							detailAddr: $("input[name='detailAddress']").val(),
							phone: ${userData.phone},
							imp_uid: rsp.imp_uid
						}
			$.ajax({
				url:'./order-info',
				type:"POST",
				dataType:"json",
				contentType: "application/json; charset=UTF-8",
				data: JSON.stringify(form),
				success: function(result){
				}
			});
		alert(msg);
		$('#start_page').addClass("page_hidden");	
		$('#second_page').removeClass("page_hidden");	
		} else { // 실패시
			var msg = '결제에 실패하였습니다.';
			msg += '에러내용 : ' + rsp.error_msg;
		}
	});
});
//환불 기능
function cancelPay() {
	if(confirm("주문 취소는 구매 12시간 이내에만 가능합니다. 취소하시겠습니까?") == false) {
		return;
	}
    jQuery.ajax({
      "url": "./cancle", // 예: http://www.myservice.com/payments/cancel
      "type": "POST",
      "contentType": "application/json",
      "data": JSON.stringify({
        "merchant_uid": test1, // 예: ORD20180131-0000011
     //   "cancel_request_amount": 100, // 환불금액
     //   "reason": "테스트 결제 환불" // 환불사유
     //   "refund_holder": "이도엽", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
     //   "refund_bank": "" // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
     //   "refund_account": "" // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
      }),
      "dataType": "json",
      success: function(){
      }
    });
    	  alert("주문이 정상적으로 취소되었습니다.");
  }

//결제비용보다 클때 가격보다 크게 쓸수없다//내가 가진값보다 크게쓸수없다
$('#user_mileage').on('keyup', function(key){
	let _sum = 0;
	let h_price = 0;
	$("input[name='order_price']").each(function(){
		 let arr = $(this).attr("id").split("_");
		 let idx = arr[2];
		 let amount = $('#d_price_'+idx).val();
		 _sum += parseInt(amount);
	});
	h_price = _sum + 3000; 
	if($('#user_mileage').val() > ${userData.mileage}){
		$('#user_mileage').val("0");
		alert("보유 마일리지를 초과했습니다.");
	}else if($('#user_mileage').val() > h_price){
		$('#user_mileage').val("0");
		alert("총 결제금액을 넘길 수 없습니다.");
	}	
	if(key.keyCode==13){
		$('#use__mileage').html($('#user_mileage').val()+'원');
		$('#total_price').html((h_price-$('#user_mileage').val()).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	}
	$('#user_mileage').focusout(function(){
		$('#use__mileage').html($('#user_mileage').val()+'원');
		$('#total_price').html((h_price-$('#user_mileage').val()).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	});
})
//마일리지 전액사용 버튼 이벤트
$('#all_point').on('click', function(){
	let _sum = 0;
	let h_price = 0;
	$("input[name='order_price']").each(function(){
		 let arr = $(this).attr("id").split("_");
		 let idx = arr[2];
		 let amount = $('#d_price_'+idx).val();
		 _sum += parseInt(amount);
	});
	h_price = _sum + 3000;
	if(h_price-${userData.mileage} > 0){
		$('#user_mileage').val(${userData.mileage});
		$('#use__mileage').html(${userData.mileage}+'원');
		$('#total_price').html((h_price-$('#user_mileage').val()).toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")+'원');
	}else{
		$('#user_mileage').val("0");
		alert("총 결제금액을 넘길 수 없습니다.");
	}
});

<!--결제 박스 -->
function order_box(){
     let orderBox = parseInt($("#test2").css("top"));
     $(window).scroll(function() {
   		 let orderPosition = $(window).scrollTop();
   		 $("#test2").stop().animate({"top":orderPosition+orderBox-150+"px"},1000);
     });
}
<!--주소 버튼-->	
function address_btn(){	
	$('.address-toggle2').click(function(){
		let o_hidden = document.querySelectorAll(".origin-info");
		for(let i = 0; i < o_hidden.length; i++) {
			let item = o_hidden.item(i);
			item.setAttribute("type", "hidden");
		}
	});
}

function address_btn2(){
	$('.address-toggle2').click(function(){
		let of_hidden = document.querySelectorAll(".hidden-info");
		for(let j = 0; j < of_hidden.length; j++) {
			let items = of_hidden.item(j);
			items.setAttribute("type", "text");
		}
		$('#address_button').attr('disabled', false);
	});
}

function address_btn3(){	
	$('.address-toggle1').click(function(){
		let o_hidden = document.querySelectorAll(".origin-info");
		for(let i = 0; i < o_hidden.length; i++) {
			let item = o_hidden.item(i);
			item.setAttribute("type", "text");
		}
		$('#address_button').attr('disabled', true);
	});
}

function address_btn4(){
	$('.address-toggle1').click(function(){
		let of_hidden = document.querySelectorAll(".hidden-info");
		for(let j = 0; j < of_hidden.length; j++) {
			let items = of_hidden.item(j);
			items.setAttribute("type", "hidden");
		}
	});
}
<!--결제방식 버튼-->
function payment_method(){
	$('.payment-toggle1').click(function(){
		let of_hidden = document.querySelector(".payment-input-container");
		of_hidden.setAttribute("type", "");
	});
}

function payment_method2(){
	$('.payment-toggle2').click(function(){
		let o_hidden = document.querySelector(".payment-input-container");
		o_hidden.setAttribute("type", "hidden");
	});
}

$('#shop_btn').on('click', function(){
	location.href="/boookfarm/";
});

$(document).ready(function(){
	  order_info();
	  order_box();
	  address_btn();
	  address_btn2();
	  address_btn3();
	  address_btn4();
	  payment_method();
	  payment_method2();
	  order_sum();
}); 

<!--버튼 on off -->
$('.address-toggle2').on('click', function(){
	$('.address-toggle2').removeClass('off');
	$('.address-toggle2').addClass('on');
	$('.address-toggle1').removeClass('on');
	$('.address-toggle1').addClass('off');
});

$('.address-toggle1').on('click', function(){
	$('.address-toggle1').addClass('on');
	$('.address-toggle2').removeClass('on');
	$('.address-toggle1').removeClass('off');
	$('.address-toggle2').addClass('off');
});

$('.payment-toggle2').on('click', function(){
	$('.payment-toggle2').removeClass('p_off');
	$('.payment-toggle2').addClass('p_on');
	$('.payment-toggle1').removeClass('p_on');
	$('.payment-toggle1').addClass('p_off');
});

$('.payment-toggle1').on('click', function(){
	$('.payment-toggle1').addClass('p_on');
	$('.payment-toggle2').removeClass('p_on');
	$('.payment-toggle1').removeClass('p_off');
	$('.payment-toggle2').addClass('p_off');
});

<!--결제수단별 디스플레이 on off -->
$('.p_off').on('click', function(){
	$('.pay_on').addClass('pay_off');
});

$('.p_on').on('click', function(){
	$('.pay_on').removeClass('pay_off');
})
</script>
</html>