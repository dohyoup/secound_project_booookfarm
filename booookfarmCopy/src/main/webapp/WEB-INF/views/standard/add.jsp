<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<c:set var="path" value="${pageContext.request.contextPath}" />
<head>
<meta charset="UTF-8">
<title>[관리자]도서등록</title>
<link rel="stylesheet" href="${path}/resources/css/styles.css">
<script type="text/javascript"
	src="${path}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>

	<%@ include file="/WEB-INF/views/module/header.jsp"%>
	<main class="st-ma">
		<div class="main-container">
			<div class="add-container">
				<div class="add-title">도서등록</div>
					<div  class="top-button">
						<button  class="addType_btn add-btn-grey grey">ISBN등록</button>
						<button  class="addType_btn add-btn-grey grey click">직접등록</button>
					</div>
					<div class="isbn_search disnone">
						<span>
							ISBN:
						</span>
							<div class="input_area">
								<div class="add-input">
									<input class="" type="text" placeholder="-를 제외하고 입력해주세요.">
								</div>
							</div>
						<div>
							<button class="isbn_btn grey" type="button">검색</button>
						</div>
					</div>
					
				<div class="add-item-cover">
					<form name="BAddform" class="form-add-container" method="post">
						<div class="form-add-img" id="profImglist">
							<div id="profImg" class="add-item-conainer add-thumbnail">
								<mat-icon class="add-item-icon"></mat-icon>
								<p class="add-book-title">대표 이미지 등록</p>
								<input id="profImgInput" class="hidden" type="file"
									name="uploadImg" value="이미지 선택" onchange="readURL(this)" accept="image/jpeg, image/png">
							</div>
						</div>
						<div class="add-form-select">
							<div class="form-category-title">
								<label>카테고리</label>
							</div>
							<div id="drop_down" class="dropdown" onclick="dropdown()">
								<div class="dropbtn">
									<span class="dropbtn_icon"></span> <span
										class="dropbtn_content">카테고리</span> <span
										class="dropbtn_click"
										style="font-family: Material Icons; font-size: 16px; color: #3b3b3b; float: right;">arrow_drop_down</span>
								</div>
								<div class="dropdown-content" id="dropdown-content-list">
								</div>
							</div>
						</div>
						<div class="add-form-input">
							<div class="form-category-title">
								<label>도서명</label>
							</div>
							<div class="form-add-box">
								<div class="add-input">
									<input class="title" type="text">
								</div>
							</div>
						</div>
						<div class="add-form-input ">
							<div class="form-category-title">
								<label>저자</label>
							</div>
							<div class="form-add-box double">
								<div class="add-input">
									<input class="author" type="text">
								</div>
							</div>
							<div class="form-category-title">
								<label>할인율</label>
							</div>
							<div class="form-add-box double">
								<div class="add-input">
									<input class="discount" type="text">
								</div>
							</div>
						</div>
						<div class="add-form-input">
							<div class="form-category-title">
								<label>출판사</label>
							</div>
							<div class="form-add-box">
								<div class="add-input">
									<input class="publisher" type="text">
								</div>
							</div>
						</div>
						<div class="add-form-input ">
							<div class="form-category-title">
								<label>정가</label>
							</div>
							<div class="form-add-box double">
								<div class="add-input">
									<input class="price" type="text">
								</div>
							</div>
							<div class="form-category-title">
								<label>재고</label>
							</div>
							<div class="form-add-box double">
								<div class="add-input">
									<input class="stock" type="text">
								</div>
							</div>
						</div>
						<div class="add-form-input">
							<div class="form-category-title">
								<label>ISBN</label>
							</div>
							<div class="form-add-box">
								<div class="add-input">
									<input class="isbn" type="text">
								</div>
							</div>
						</div>
						<div class="add-form-textarea">
							<div class="add-form-input">
								<div class="form-category-title ch-title">
									<label>책 정보</label>
								</div>
								<div class="form-add-box textbox textarea-h">
									<div class="add-input textarea-h">
										<textarea class="textarea-box" rows="15"></textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="add-form-input">
							<div class="form-category-title">
								<label>책상태</label>
							</div>
							<div class="form-add-box double">
								<select class="add-select">
									<option value="" disabled selected>선택</option>
									<option value="최상">최상</option>
									<option value="상">상</option>
									<option value="중">중</option>
									<option value="하">하</option>
								</select>
							</div>
							<div class="hide-modal">
								<img class="question-icon" src="${path}/resources/img/icon/question.png">
								<img class="manual-img manual-hidden" src="${path}/resources/img/manual.png">
							</div>
						</div>
						<div class="add-chkbox-container">
							<label class="chk-layout" for="a">
								<div class="chk-box-mr">
									<input name="book_condition" id="a" type="checkbox" value="겉표지 손상">
								</div>
								<span >겉표지 손상</span>
							</label>
							<label class="chk-layout" for="b">
								<div class="chk-box-mr">
									<input name="book_condition" id="b" type="checkbox" value="밑줄,필기있음">
								</div>
								<span >밑줄,필기있음</span>
							</label>
							<label class="chk-layout" for="c">
								<div class="chk-box-mr">
									<input name="book_condition" id="c" type="checkbox" value="색바램">
								</div>
								<span >색바램</span>
							</label>
							<label class="chk-layout" for="d">
								<div class="chk-box-mr">
									<input name="book_condition" id="d" type="checkbox" value="낙장">
								</div>
								<span >낙장</span>
							</label>
							<label class="chk-layout" for="e">
								<div class="chk-box-mr">
									<input name="book_condition" id="e" type="checkbox" value="제본상태불량">
								</div>
								<span >제본상태불량</span>
							</label>
							<label class="chk-layout" for="f">
								<div class="chk-box-mr">
									<input name="book_condition" id="f" type="checkbox" value="표지없음">
								</div>
								<span >표지없음</span>
							</label>
							<label class="chk-layout" for="g">
								<div class="chk-box-mr">
									<input name="book_condition" id="g" type="checkbox" value="대여점용">
								</div>
								<span >대여점용</span>
							</label>
							<label class="chk-layout" for="h">
								<div class="chk-box-mr">
									<input name="book_condition" id="h" type="checkbox" value="도서관,자료실직인">
								</div>
								<span >도서관,자료실직인</span>
							</label>
							<label class="chk-layout" for="i">
								<div class="chk-box-mr">
									<input name="book_condition" id="i" type="checkbox" value="교사용">
								</div>
								<span >교사용</span>
							</label>
							<label class="chk-layout" for="j">
								<div class="chk-box-mr">
									<input name="book_condition" id="j" type="checkbox" value="물기,젖음,얼룩">
								</div>
								<span >물기,젖음,얼룩</span>
							</label>
							<label class="chk-layout" for="k">
								<div class="chk-box-mr">
									<input name="book_condition" id="k" type="checkbox" value="세로 읽기">
								</div>
								<span >세로 읽기</span>
							</label>
							<label class="chk-layout" for="l">
								<div class="chk-box-mr">
									<input name="book_condition" id="l" type="checkbox" value="CD / 부록 있음">
								</div>
								<span >CD / 부록 있음</span>
							</label>
							<label class="chk-layout" for="m">
								<div class="chk-box-mr">
									<input name="book_condition" id="m" type="checkbox" value="스템플러 자국">
								</div>
								<span >스템플러 자국</span>
							</label>
							<label class="chk-layout" for="n">
								<div class="chk-box-mr">
									<input name="book_condition" id="n" type="checkbox" value="답지 없음">
								</div>
								<span >답지 없음</span>
							</label>
							<div class="add-notice">
								 실제 책상태가 다르다는 이유로 구매자가 반품할 경우 모든 책임은 판매자에게 있습니다.<br>
								 정확하게 책상태를 기재하시기 바랍니다. 
							</div>
						</div>
						<div class="add-form-textarea">
							<div class="add-form-input">
								<div class="form-category-title ch-title">
									<label>책 상태 소개</label>
								</div>
								<div class="form-add-box textbox textarea-h">
									<div class="add-input textarea-h">
										<textarea id="checkResult" class="textarea-box" rows="15"></textarea>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
					<div class="bottom-button">
						<button  class="outline_btn add-btn-grey grey">취소</button>
						<button class="primary_btn add-btn-blue blue"onclick="addFormSubmit();">등록</button>
					</div>
					<div class="common-top-title">
						<div class="title-text">책 판매하기 안내사항</div>
					</div>
					<div class="Accordion" id="Accordion_wrap">
					     <div class="que">
					      <span>금지 및 책임사항</span>
					       <div class="arrow-wrap">
					         <span class="arrow-top">↑</span>
					        <span class="arrow-bottom">↓</span>
					       </div>
					     </div>
					     <div class="anw">
						      <div class="text-content">
						      		<p>&nbsp&nbsp개인정보가 노출되는 도서의 판매는 금지되어 있습니다. (ex. 명부, 동기명부 등등)</p>
									<p>&nbsp&nbsp책상태나 발행년도를 정확히 기재하지 않는 경우 사후 책임은 판매자에게 있습니다.</p>
									   <p>&nbsp&nbsp반드시 소장하고계신 도서의 정보를 등록해주시기 바랍니다.</p>
							  </div>
					     </div>
					      <div class="que">
					     	 <span>ISBN이란?</span>
					     </div>
					     <div class="anw">
 							<div class="text-content">
							      	&nbsp&nbsp국제표준도서번호(International Standard Book Number)로 책의 고유번호를 말합니다.<br>
							        &nbsp&nbsp보통 책의 뒷면에 ISBN을 표시하고 있으며 2007년 이전에 발행된 도서는 10자리의 숫자 또는 숫자와 
							        &nbsp&nbsp문자, 2007년 이후에 발행된 도서는 13자리의 숫자로 구성되어 있습니다.<br>
									&nbsp&nbspISBN 입력시 ‘-‘을 제외하고 입력하세요.
							 </div>
					     </div>
					      <div class="que">
					      	<span>ISBN을 등록하면 어떤점이 유리할까?</span>
					     </div>
					     <div class="anw">
						      <div class="text-content">
						      		1. ISBN을 등록해야만! 책정보가 자동적으로 생성됩니다.<br>
									&nbsp&nbsp&nbsp&nbspISBN을 등록하기만 하면 자동적으로 책소개, 리뷰, 책갈피, 책이미지가 노출됩니다.<br>
									&nbsp&nbsp&nbsp&nbsp다양한 책정보가 있으면 판매율이 평균 30%가 올라갑니다. ISBN을 등록하지 않은 판매자에 비해서 
									&nbsp&nbsp&nbsp&nbsp더 많은 매출이 올라갑니다.<br>
									<br>
									2. ISBN을 등록해야만! 검색결과에 지속적으로 노출됩니다.<br>
									&nbsp&nbsp&nbsp&nbsp향후 북코아 검색방식에 ISBN을 등록한 도서 중심으로 노출될 예정입니다.<br>
									&nbsp&nbsp&nbsp&nbsp그동안 많은 책들이 표준화된 정보없이 등록되어 검색면에서 판매자와 구매자 모두에게 불편함을 
									&nbsp&nbsp&nbsp&nbsp야기시켰습니다.<br> 
									&nbsp&nbsp&nbsp&nbsp북코아의 모든 책들은 ISBN을 기반으로 묶여지고 검색되어질 예정입니다. <br>
									&nbsp&nbsp&nbsp&nbsp노출이 되어야 판매가 가능하니 책 뒷면에 ISBN이 있는 책을 등록할 경우 반드시 ISBN을 
									&nbsp&nbsp&nbsp&nbsp등록해주시기 바랍니다.<br>
							 </div>
					     </div>
					      <div class="que">
					      	<span>중고책은 얼마에 등록해야 할까?</span>
					     </div>
					     <div class="anw">
						      <div class="text-content">
					      		&nbsp&nbsp판매가는 책이 최상급일때 정가의 40%(60%할인)에 등록하시는 것이 적합합니다.<br>
								&nbsp&nbspex) 정가 : 10,000원 -> 판매가 : 4,000원(최상급)
							</div>
					     </div>
					</div>
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/module/footer.jsp"%>
</body>
<script type="text/javascript">


var btn = $('.top-button>button');
$('.addType_btn').click(function(e) {
        Array.from(btn).forEach(
             v => v.classList.remove('click')
         )
    $(e.target).addClass('click');
	var isbn = document.querySelector('.isbn_search');
	var isbn_btn = document.querySelector('.addType_btn');
	const hasClass = isbn_btn.classList.contains("click");
	
	if (hasClass) {
		$(isbn).removeClass("disnone");
	}else{wq
		$(isbn).addClass("disnone");
	}
});



$('input[name=book_condition]').change(function(e){
	checkBox(e.target);
});


function checkBox(checked){
    var result = document.getElementById("checkResult");
    if( checked.checked==true ){
        if(result.value == "" ){
            result.value = checked.getAttribute("value");
        }else{
            result.value += ", "+ checked.getAttribute("value");
        }
    }else {

        var resultArr = result.value.split(", ");
        for(var i=0; i<resultArr.length; i++){
            if(resultArr[i] == checked.getAttribute("value")){
                resultArr.splice(i,1);
                break;
            }
        }
        result.value  = resultArr.join(", ");

    }
 }




$(".que").click(function() {
	   $(this).next(".anw").stop().slideToggle(300);
	  $(this).toggleClass('open').siblings().removeClass('on');
	  $(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
	});

const profileImgSelect = document.querySelector('#profImgInput');
const profileImg = document.querySelector('#profImg');


if(profileImg) {
    profileImg.addEventListener('click', (e) => profileImgSelect.click());
    profileImgSelect.addEventListener("change", readURL(profileImgSelect));
}

var index = 0;
var img_count = 1;
function readURL(obj) {
    let reader = new FileReader();
    if(!obj.files.length) {
        return;
    }

    
    var img_count_string = img_count.toString();
    
    
    reader.onload = function (e) {
    	let close ='/boookfarm/resources/img/icon/close-icon.png';
        let img = '';
            img += '<div class="add-item-conainer"id="add-item"><img class="imgBox" id="img_'+(img_count_string)+'" src='+e.target.result+'></img>'
            img += '<img onclick="deleteImg()" class="close-icon" src='+close+'></img></div>'
        $('#profImglist').append(img);
        index ++;
        img_count++;
		if (index == 1) {
			$('#profImg').addClass("disnone");
		}
    }
    reader.readAsDataURL(obj.files[0]);
    
    formData.append('profImg' + img_count_string, obj.files[0]);
}

var formData = new FormData();
function addFormSubmit() {
	
	    const bookcode =  addBookCode();
	    const category  = $('.dropbtn_content').text();
        const title     = $('.title').val();
        const author    = $('.author').val();
        const discount  = $('.discount').val();
        const publisher = $('.publisher').val();
        const price     = $('.price').val();
        const stock     = $('.stock').val();
        const isbn      = $('.isbn').val();
        const bookInfo      = $('.textarea-box').val();
        const condition     = $('.add-select').val();
        const conditionInfo = $('#checkResult').val();
    	const bookImgUpload = document.querySelector('#profImgInput');
  		const file = bookImgUpload.files[0];
  		
  		formData.append("bookCode", bookcode);
  		formData.append("bookCategory", category);
  		formData.append("bookTitle", title);
  		formData.append("bookAuthor", author);
  		formData.append("bookDiscount", discount);
  		formData.append("publisher", publisher);
  		formData.append("bookPrice", price);
  		formData.append("stock", stock);
  		formData.append("isbn", isbn);
  		formData.append("bookInfo", bookInfo);
  		formData.append("bookCondition", condition);
  		formData.append("bookConditionInfo", conditionInfo);
    	
	    console.log(formData);
	    
	    $.ajax({
			type : 'POST',
			url : 'addbook/ajax',
		    enctype: "multipart/form-data",
			processData:false,
			contentType: false,
		    data: formData,
			success : function(json){
				alert("등록되었습니다.");
				location.href="/boookfarm/";				
			},
			error: function(xhr, status, error){
				alert("등록에 실패했습니다."+error);
				return false;
				
			}
		});
	    
	
}


function deleteImg() {
	$('#add-item').remove();
	$("#profImgInput").val("");
    index --;
    img_count--;
	if (index ==0) {
		$('#profImg').removeClass("disnone");
	}
}

function addBookCode() {
	let randomCode = '';
	let categoryCode = '';
	let ClassCode = document.querySelector('.dropbtn_content').getAttribute( 'id' );
	if (ClassCode < 10) {
		categoryCode = 0 + ClassCode;
	}
	
	let year = toDay();
	let rand = sixCode(6);
	
 	randomCode = year+categoryCode+rand;
 	
 	return randomCode;
}

function toDay() {
	let today = new Date();
	let year = today.getFullYear(); // 년도
	let twoYear = year.toString().substr(2)
	return twoYear;
}

function sixCode(lenth){
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for( var i=0; i < lenth; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    return text;
}


$('.question-icon').mouseover(function () {
    $('.manual-img').removeClass('manual-hidden');
})
$('.manual-img').mouseover(function () {
    $('.manual-img').removeClass('manual-hidden');
})
$('.manual-img').mouseout(function () {
    $('.manual-img').addClass('manual-hidden');
})

$('.question-icon').on('mouseout', e => {
    $('.manual-img').addClass('manual-hidden');
});

$('.add-input>input').on('focus', e => {
    $(e.target).parent().addClass('bd-color--blue');
});
$('.add-input>textarea').on('focus', e => {
    $(e.target).parent().addClass('bd-color--blue');
});


$('.add-input').hover( e => {
    $(e.target).addClass('bd-color--blue');
    $(window).scroll( () => {
        $(e.target).removeClass('bd-color--blue');
    });
}, e => {
    $(e.target).removeClass('bd-color--blue');
});
$('.textarea-box').hover( e => {
    $(e.target).addClass('bd-color--blue');
    $(window).scroll( () => {
        $(e.target).removeClass('bd-color--blue');
    });
}, e => {
    $(e.target).removeClass('bd-color--blue');
});

const categoryname=['전체보기','건강,취미 스포츠/잡지,만화','여행/요리,가정생활/예술','어린이교구,아동','초/중/고학습','日本書籍','Foreign Books/어린이 영어','외국어/한국소개도서'
	,'경제,경영,자기계발/정치,사회','과학,기술,컴퓨터','소설,시,에세이','인문,역사,문화,종교'];
	
	// 사이드바 전역 변수 let[초기화 후 재사용] 가능
	let _sidehtml ='';
	
	//반복문 사이드바[배열의 크기]
	for (var i = 1; i < categoryname.length; i++) {
		_sidehtml +=  '<div class="" id='+[i]+' onclick="showMenu(this)">'+categoryname[i]+'</div>'
	}
	//HTML 단 id="L-main-category-list" 위치에 반복한 _sidehtml .html 실행
	$('#dropdown-content-list').html(_sidehtml);
  
  window.onload=()=>{
	    document.getElementById('drop_down').onclick = ()=>{
	      dropdown();
	    }
	    document.getElementsByClassName('category').onclick = ()=>{
	      showMenu(value);
	    };
	    
	    dropdown = () => {
	      var v = document.querySelector('.dropdown-content');
	      var dropbtn = document.querySelector('.dropbtn')
	      v.classList.toggle('show');
	      dropbtn.style.borderColor = '#E0E0E0';
	    }

	    showMenu=(value)=>{
	      var dropbtn_icon = document.querySelector('.dropbtn_icon');
	      var dropbtn_content = document.querySelector('.dropbtn_content');
	      var dropbtn_click = document.querySelector('.dropbtn_click');
	      var dropbtn = document.querySelector('.dropbtn');

	      dropbtn_icon.innerText = '';
	      dropbtn_content.innerText = value.innerText;
	      document.querySelector('.dropbtn_content').id = value.id;
	      dropbtn_content.style.color = '#252525';
	      dropbtn.style.borderColor = '#3992a8';
	    }
	  }
	  window.onclick= (e)=>{
	    if(!e.target.matches('.dropbtn')){
	      var dropdowns = document.getElementsByClassName("dropdown-content");

	      var dropbtn_icon = document.querySelector('.dropbtn_icon');
	      var dropbtn_content = document.querySelector('.dropbtn_content');
	      var dropbtn_click = document.querySelector('.dropbtn_click');
	      var dropbtn = document.querySelector('.dropbtn');

	      var i;
	      for (i = 0; i < dropdowns.length; i++) {
	        var openDropdown = dropdowns[i];
	        if (openDropdown.classList.contains('show')) {
	          openDropdown.classList.remove('show');
	        }
	      }
	    }
	  }
</script>