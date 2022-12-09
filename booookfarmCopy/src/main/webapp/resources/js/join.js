/**
 *  회원가입 페이지 스크립트
 *  @todo alert->modal
 */
let joinType = "com";
let certificationNumber = "";
let cNumTimer = null;
let cNumTimerIsRun = false;
let chkTimeOver = false;
let isIdDupChk = false;
let isName = false;
let isId = false;
let isPw = false;
let isPwChk = false;
let isCNum = false;
let isEmail = false;
let isAddr = false;
let isDetailAddr = false;
let isUseInfoTerms = false;
let isOfferInfoTerms = false;
let isServiceTerms = false;
let naverLoginData;
let kakaoLoginData;

$(document).ready( () => {
    /**
     *  최초 naver 로그인 시 추가 정보 입력 요청 후
     *  DB에 추가 하기 위한 Form 수정 작업
     */
    if(naverLoginData != null) {  // naver 로그인 데이터 있는지 확인
        const phone = naverLoginData.mobile.replace(/-/g, '');  // 핸드폰 번호에서 '-' 제거

        $('.join-title').text('추가 정보 입력');
        joinType = "naver";
        $('#name').val(naverLoginData.name)
                  .closest('.join-form-line').addClass('hidden');
        isName = true;
        $('#id').val(naverLoginData.id)
                .closest('.join-form-line').addClass('hidden');
        isId = true;
        isIdDupChk = true;
        $('#pw').val(Math.random().toString(36).substring(2, 12))
                .closest('.join-form-line').addClass('hidden');
        isPw = true;
        $('#chkPw').closest('.join-form-line').addClass('hidden');
        isPwChk = true;
        $('#phone').val(phone)
                   .closest('.join-form-line').addClass('hidden');
        $('#chkPhone').closest('.join-form-line').addClass('hidden');
        isCNum = true;
        $('#email').val(naverLoginData.email)
                   .closest('.join-form-line').addClass('hidden');
        isEmail = true;
    }
    /**
     *  최초 kakao 로그인 시 추가 정보 입력 요청 후
     *  DB에 추가 하기 위한 Form 수정 작업
     */
    if(kakaoLoginData != null) {  // kakao 로그인 데이터 있는지 확인
        $('.join-title').text('추가 정보 입력');
        joinType = "kakao";
        $('#name').val(kakaoLoginData.nickname)
            .closest('.join-form-line').addClass('hidden');
        isName = true;
        $('#id').val(kakaoLoginData.id)
            .closest('.join-form-line').addClass('hidden');
        isId = true;
        isIdDupChk = true;
        $('#pw').val(Math.random().toString(36).substring(2, 12))
            .closest('.join-form-line').addClass('hidden');
        isPw = true;
        $('#chkPw').closest('.join-form-line').addClass('hidden');
        isPwChk = true;
        $('#email').val(kakaoLoginData.email)
            .closest('.join-form-line').addClass('hidden');
        isEmail = true;
    }
});

/** 패스워드 입력 내용 보기 기능 */
$('#showPw').on("click", () => {
    $('#showPw').addClass('hidden');
    $('#hidePw').removeClass('hidden');
    $('#pw').attr('type', 'text');
});

/** 패스워드 입력 내용 숨기기 기능 */
$('#hidePw').on("click", () => {
    $('#hidePw').addClass('hidden');
    $('#showPw').removeClass('hidden');
    $('#pw').attr('type', 'password');
});

/** 패스워드 확인 입력 내용 보기 기능 */
$('#showChkPw').on("click", () => {
    $('#showChkPw').addClass('hidden');
    $('#hideChkPw').removeClass('hidden');
    $('#chkPw').attr('type', 'text');
});

/** 패스워드 확인 입력 내용 숨기기 기능 */
$('#hideChkPw').on("click", () => {
    $('#hideChkPw').addClass('hidden');
    $('#showChkPw').removeClass('hidden');
    $('#chkPw').attr('type', 'password');
});

/** 약관 모달 보기 기능 */
$('#showUseInfoTerms').on('click', e => {
    $('#useInfoTerms').removeClass('hidden');
    $('body').css('overflow', 'hidden');
});

$('#showOfferInfoTerms').on('click', e => {
    $('#offerInfoTerms').removeClass('hidden');
    $('body').css('overflow', 'hidden');
});

$('#showServiceTerms').on('click', e => {
    $('#serviceTerms').removeClass('hidden');
    $('body').css('overflow', 'hidden');
});

/** 약관 모달 끄기 기능 */
$('.hide-modal').on('click', e => {
    $(e.target).closest($('.modal')).addClass('hidden');
    $('body').css('overflow', 'auto');
});

/**
 *  입력 창 hover 기능
 */
$('.join-form__input').hover( e => {
    $(e.target).addClass('bd-color--blue');
    $(window).scroll( () => {
        $(e.target).removeClass('bd-color--blue');
    });
}, e => {
    $(e.target).removeClass('bd-color--blue');
});

/** 입력 창 focus 시 테두리 강조 기능 */
$('.join-form__input>input').on('focus', e => {
    $(e.target).parent().addClass('bd-color--blue');
});

/** 입력 창 focusout 시 조건에 따라 입력 내용 체크 기능 */
$('.join-form__input>input').on('focusout', e => {
    if($(e.target).attr('name') == 'name') {
        chkName($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'id') {
        chkId($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'pw') {
        chkPw($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'chkPw') {
        chkChkPw($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'phone') {
        chkPhone($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'email') {
        chkEmail($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'detailAddress') {
        chkDetailAddress($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'chkPhone') {
        chkChkPhone($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'postalCode') {
        chkPostalCode($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'address') {
        chkAddress($(e.target), e.type);
    }
});

/** 입력 창 입력시 조건에 따라 입력 내용 체크 기능 */
$('.join-form__input>input').on('change keydown keyup paste', e => {
    if($(e.target).attr('name') == 'name') {
        chkName($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'id') {
        chkId($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'pw') {
        chkPw($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'chkPw') {
        chkChkPw($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'phone') {
        chkPhone($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'email') {
        chkEmail($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'detailAddress') {
        chkDetailAddress($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'chkPhone') {
        chkChkPhone($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'postalCode') {
        chkPostalCode($(e.target), e.type);
    }
    if($(e.target).attr('name') == 'address') {
        chkAddress($(e.target), e.type);
    }
});

/**
 * 이름 입력 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkName(element, type) {
    let name = element.val();
    if(name == '' || name == null) {    // 입력 내용 유무 체크
        showErrMsg(element, '.null-err');
        isName = false;
        return;
    } else {
        hideErrMsg(element, '.null-err', type);
    }

    if(name.length > 33) {      // 입력 내용 길이 체크
        showErrMsg(element, '.len-err');
        isName = false;
    } else {
        hideErrMsg(element, '.len-err', type);
        isName = true;
    }
};


/**
 *  아이디 입력 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkId(element, type) {
    let id = element.val();
    const reg = /[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi;    // 특수문자 체크용 변수
    const hangeulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;     // 한글 체크용 변수
    let idFlag = false;     // 각종 조건 일치 여부 확인 변수

    if(hangeulcheck.test(id)) {     // id에 한글이 있는지
        idFlag = true;
    } else if(id.search(/\s/) != -1) {      // 공백이 있는지
        idFlag = true;
    } else if(id.search(reg)>0) {       // 특수문자가 있는지
        idFlag = true;
    } else if(id.length < 5 || id.length > 15) {     // id 길이가 5~15자가 아닌지
        idFlag = true;
    } else {
        idFlag = false;
    }

    if(id == '' || id == null) {    // 입력 내용 유무 체크
        showErrMsg(element, '.null-err');
        isId = false;
        return;
    } else {
        hideErrMsg(element, '.null-err', type);
    }

    if(idFlag) {     // 각종 조건 체크
        showErrMsg(element, '.len-err');
        isId = false;
    } else {
        hideErrMsg(element, '.len-err', type);
        isId = true;
    }
}

/**
 *  패스워드 입력 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkPw(element, type) {
    let pw = element.val();
    const num = pw.search(/[0-9]/g);    // 숫자가 들어가는지
    const eng = pw.search(/[a-z]/ig);   // 영문자가 들어가는지
    const spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);   // 특수문자가 들어가는지
    let pwFlag = false;

    if(num < 0 || eng < 0 || spe <0) {  // 하나라도 불만족시
        pwFlag = true;
    }

    if(pw == '' || pw == null) {    // 입력 내용 유무 체크
        showErrMsg(element, '.null-err');
        isPw = false;
        return;
    } else {
        hideErrMsg(element, '.null-err', type);
    }

    if(pw.length <8 || pw.length > 15 || pwFlag) {      // 입력 내용 길이 체크
        showErrMsg(element, '.len-err');
        isPw = false;
    } else {
        hideErrMsg(element, '.len-err', type);
        isPw = true;
    }
}

/**
 *  패스워드 확인 입력 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkChkPw(element, type) {
    let pwChk = element.val();
    let pw = $('#pw').val();
    if(pw !== pwChk) {  // 패스워드와 일치 여부 체크
        showErrMsg(element, '.not-match-err');
        isPwChk = false;
    } else {
        hideErrMsg(element, '.not-match-err', type);
        isPwChk = true;
    }

}

/**
 *  핸드폰 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkPhone(element, type) {
    let phone = element.val();

    if(phone == '' || phone == null) {      // 입력 내용 유무 체크
        showErrMsg(element, '.null-err');
    } else {
        hideErrMsg(element, '.null-err', type);
    }
}

/**
 *  인증번호 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkChkPhone(element, type) {
    let chkPhone = element.val();

    if(chkPhone == '' || chkPhone == null) {
        showErrMsg(element, '');
    } else {
        hideErrMsg(element, '', type);
    }
}

/**
 *  이메일 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkEmail(element, type) {
    let email = element.val();
    let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');

    if(email == '' || email == null) {      // 입력 내용 유무 체크
        showErrMsg(element, '.null-err');
        isEmail = false;
        return;
    } else {
        hideErrMsg(element, '.null-err', type);
    }

    if(!(regex.test(email))) {
        showErrMsg(element, '.not-match-err');
        isEmail = false;
    } else {
        hideErrMsg(element, '.not-match-err', type);
        isEmail = true;
    }
}

/**
 *  우편번호 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkPostalCode(element, type) {
    let postalCode = element.val();

    if(postalCode == '' || postalCode == null) {
        showErrMsg(element, '');
        isAddr = false;
    } else {
        hideErrMsg(element, '', type);
        isAddr = true;
    }
}

/**
 *  기본주소 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkAddress(element, type) {
    let address = element.val();

    if(address == '' || address == null) {
        showErrMsg(element, '');
        isAddr = false;
    } else {
        hideErrMsg(element, '', type);
        isAddr = true;
    }
}

/**
 *  상세 주소 내용 체크 함수
 * @param element input 값
 * @param type 이벤트 종류
 */
function chkDetailAddress(element, type) {
    let detailAddress = element.val();

    if(detailAddress == '' || detailAddress == null) {      // 입력 내용 유무 체크
        showErrMsg(element, '.null-err');
        isDetailAddr = false;
    } else {
        hideErrMsg(element, '.null-err', type);
        isDetailAddr = true;
    }
}

/**
 * 오류 메시지 표시해주는 함수
 * @param element input element
 * @param className 표시할 오류 class명
 */
function showErrMsg(element, className) {
    element.parent().removeClass('bd-color--blue');
    element.parent().addClass('bd-color--red');
    if(!(className == '' || className == null)) {
        element.closest($('.join-form-line')).next('div').removeClass('hidden');
        element.closest($('.join-form-line')).next('div').find(className).removeClass('hidden');
    }
};

/**
 * 오류 메시지 숨겨주는 함수
 * @param element input element
 * @param className 숨길 오류 class명
 */
function hideErrMsg(element, className, type) {
    if(type == 'focusout') {
        element.parent().removeClass('bd-color--red');
        element.parent().removeClass('bd-color--blue');
    } else {
        element.parent().removeClass('bd-color--red');
        element.parent().addClass('bd-color--blue');
    }
    if(!(className == '' || className == null)) {
        element.parent().removeClass('bd-color--red');
        element.closest($('.join-form-line')).next('div').addClass('hidden');
        element.closest($('.join-form-line')).next('div').find(className).addClass('hidden');
    }
};

/**
 *  아이디 중복 체크 함수
 *  @todo 사용가능한 ID일 경우 사용 여부 묻는 기능 추가
 */
function idDupChk() {
    if(!isId) {
        alert("아이디를 확인해주세요.");
        return;
    }
    if(isIdDupChk) {
        alert('사용 가능한 아이디입니다.');
        return ;
    }

    const id = $('#id').val();
    const sendId = { 'id' : id };

    $.ajax({
        type: "post",
        url: "idDupChk",
        traditional: true,
        contentType: "application/json",
        data: JSON.stringify(sendId),
        dataType: "json",
        success: (res) => {
            if(res.dupChk) {
                alert('중복입니다.');
                $('#id').prop('readonly', false);
                isId = false;
            } else {
                alert('사용 가능한 아이디입니다.');
                $('#id').prop('readonly', true);
                isIdDupChk = true;
                isId = true;
            }
        }
    });
}

/**
 *  인증번호 SMS 발송 요청 함수
 *  @todo alert -> modal 변경
 */
function sendSMS() {
    if(isCNum) {    // 인증여부 확인
        alert('인증이 완료되었습니다.');
        return;
    }

    const pNum = $('#phone').val();
    const sendPhone = { 'joinType' : joinType
                      , 'pNum' : pNum };

    $.ajax({
        type: "post",
        url: "phoneChk",
        traditional: true,
        contentType: "application/json",
        data: JSON.stringify(sendPhone),
        dataType: "json",
        success: (res) => {
            if(res.phoneDupChk) {   // 이미 등록된 핸드폰일 경우
                alert("중복입니다.");
            } else {    // 등록된 정보가 없을 경우
                if(res.result == "sendSuccess"){    // 인증 메시지 발송 성공 시
                    alert("인증번호가 전송되었습니다.");
                    $('#phone').prop('readonly', true);    // 핸드폰 입력 부분 비활성화
                    certificationNumber = res.cNum; // 인증번호 저장
                    let display = $('#cNumTimer');  // 타이머 출력할 span
                    let leftSec = 300;  // 제한시간 5분 설정

                    if(cNumTimerIsRun){ // 이미 타이머가 작동중일 경우
                        clearInterval(cNumTimer);   // 타이머 중지
                        display.html("");   // 타이머 span 비우기
                        startTimer(leftSec, display);   // 타이머 다시 시작
                    } else {
                        startTimer(leftSec, display);   // 타이머 시작
                    }
                } else {
                    alert("인증번호 전송에 실패하였습니다.");
                }
            }
        }
    });
}

/**
 *  인증번호 인증 시간 제한
 * @param count 제한시간 (초 단위)
 * @param display 타이머 표시할 element
 */
function startTimer(count, display) {
    let minutes, seconds;
    chkTimeOver = false;
    cNumTimer = setInterval( () => {
        minutes = parseInt(count / 60, 10);
        seconds = parseInt(count % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;   // 01:01 형식으로 출력위한 삼항 연산

        display.html(minutes + ":" + seconds);  // 남은시간 출력

        if (--count < 0) {  // 제한시간이 초과될 경우
            clearInterval(cNumTimer);   // 타이머 종료
            display.html("00:00");  // 00:00 출력
            chkTimeOver = true; // 제한시간 초과 true
            cNumTimerIsRun = false; // 타이머 작동 false
        }
    }, 1000);
    cNumTimerIsRun = true; // 타이머 작동중
}

/**
 *  인증번호 일치 체크 함수
 *  @todo 인증 완료/실패시 처리 내용 추가, alert -> modal 변경
 */
function chkCNum() {
    const cNum = $('#chkPhone').val();
    if(certificationNumber === '' || certificationNumber === null) {
       alert("인증번호를 요청해주세요.");
       return;
    }

    if(chkTimeOver) {
        alert("인증 시간이 만료되었습니다. 다시 요청해주세요.");
        return ;
    }

    if(cNum == certificationNumber) {
        clearInterval(cNumTimer);
        $('#chkPhone').prop('disabled', true);
        isCNum = true;
        alert("인증이 완료되었습니다.");
    } else {
        alert("인증이 실패하였습니다.");
        isCNum = false;
    }
}

/**
 *  다음 우편번호 검색 API
 */
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
            document.getElementById('postalCode').value = data.zonecode;
            document.getElementById("address").value = addr + extraAddr;
            isAddr = true;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

/**
 *  약관 동의 체크 클릭시 기능 함수
 */
$('input[type=checkbox]').on('click', e => {
    const chkboxId = $(e.target).attr('id');
    let isAllChk = false;
    switch (chkboxId) {
        case "allCheck" :
            if($(e.target).is(':checked')) {
                $('input[type=checkbox]').prop('checked', true);
                isUseInfoTerms = true;
                isOfferInfoTerms = true;
                isServiceTerms = true;
            } else {
                $('input[type=checkbox]').prop('checked', false);
                isUseInfoTerms = false;
                isOfferInfoTerms = false;
                isServiceTerms = false;
            }
            break;
        case "chkUseInfoTerms" :
            isUseInfoTerms = $(e.target).is(':checked');
            isAllChk = isUseInfoTerms && isOfferInfoTerms && isServiceTerms;
            $('#allCheck').prop('checked', isAllChk);
            break;
        case "chkOfferInfoTerms" :
            isOfferInfoTerms = $(e.target).is(':checked');
            isAllChk = isUseInfoTerms && isOfferInfoTerms && isServiceTerms;
            $('#allCheck').prop('checked', isAllChk);
            break;
        case "chkServiceTerms" :
            isServiceTerms = $(e.target).is(':checked');
            isAllChk = isUseInfoTerms && isOfferInfoTerms && isServiceTerms;
            $('#allCheck').prop('checked', isAllChk);
            break;
    }
});

/**
 * 회원가입 폼 체크 함수
 * @returns {boolean} 각 정보 모두 문제가 없으면 true, 아닐 경우 false 반환
 */
function joinFormChk() {
    if(!isName) {
        alert("이름을 확인해주세요.");
        $('#name').focus();
        return false;
    }
    if(!isIdDupChk) {
        alert("아이디 중복 여부를 확인해주세요.");
        $('#id').focus();
        return false;
    }
    if(!isId) {
        alert("아이디를 확인해주세요.");
        $('#id').focus();
        return false;
    }
    if(!isPw) {
        alert("비밀번호를 확인해주세요.");
        $('#pw').focus();
        return false;
    }
    if(!isPwChk) {
        alert("비밀번호를 확인해주세요.");
        $('#chkPw').focus();
        return false;
    }
    if(!isCNum) {
        alert("핸드폰 인증을 진행해주세요.");
        $('#chkPhone').focus();
        return false;
    }
    if(!isEmail) {
        alert("이메일을 확인해주세요.");
        $('#email').focus();
        return false;
    }
    if(!isAddr) {
        alert("주소를 확인해주세요.");
        $('#address').focus();
        return false;
    }
    if(!isDetailAddr) {
        alert("상세주소를 확인해주세요.");
        $('#detailAddress').focus();
        return false;
    }
    if(!isUseInfoTerms || !isOfferInfoTerms || !isServiceTerms) {
        alert("약관에 동의해주세요.");
        $('#allCheck').focus();
        return false;
    }
    return true;
}

function joinFormSubmit() {
    if(joinFormChk()) {
        const name = $('#name').val();
        const id = $('#id').val();
        const pw = $('#pw').val();
        const phone = $('#phone').val();
        const email = $('#email').val();
        const postCode = $('#postalCode').val();
        const addr = $('#address').val();
        const detailAddr = $('#detailAddress').val();
        const gender = $('input[type=radio]:checked').length == 0 ? 'N' : $('input[type=radio]:checked').val();

        const sendForm = { 'name' : name
            , 'id' : id
            , 'pw' : pw
            , 'phone' : phone
            , 'email' : email
            , 'postCode' : postCode
            , 'addr' : addr
            , 'detailAddr' : detailAddr
            , 'gender' : gender
            , 'joinType' : joinType };

        $.ajax({
            type: "post",
            url: "join",
            traditional: true,
            contentType: "application/json",
            data: JSON.stringify(sendForm),
            dataType: "json",
            success: (res) => {
                if(res.joinRes) {
                    location.replace("./");
                } else {
                    alert("회원가입 실패");
                }
            }
        });
    }
}

/**
 * 네이버에서 받아온 유저 정보를 저장하는 함수
 * @param naverData 네이버에서 받아온 유저 정보
 */
function saveNaverData(naverData) {
    if(naverData != null && naverData != '') {
        if(naverData.resultcode === '00')
            naverLoginData = naverData.response;
    }
}

/**
 * 카카오에서 받아온 유저 정보를 저장하는 함수
 * @param kakaoData 카카오에서 받아온 유저 정보
 */
function saveKakaoData(kakaoData) {
    if(kakaoData != null && kakaoData != '') {
        kakaoLoginData = kakaoData;
    }
}

