/**
 *  로그인 페이지 스크립트
 */
const savedUserId = localStorage.getItem("userId");

/** 패스워드 입력 내용 보기 기능 */
$('#showPw').on("click", () => {
    $('#showPw').addClass('hidden');
    $('#hidePw').removeClass('hidden');
    $('input[name=password]').attr('type', 'text');
});

/** 패스워드 입력 내용 숨기기 기능 */
$('#hidePw').on("click", () => {
    $('#hidePw').addClass('hidden');
    $('#showPw').removeClass('hidden');
    $('input[name=password]').attr('type', 'password');
});

/**
 *  id, pw 입력 창 hover시 테두리 강조 기능
 */
$('.login-input-box').hover( e => {
    $(e.target).addClass('bd-color--blue');
    $(window).scroll( () => {
        $(e.target).removeClass('bd-color--blue');
    });
}, e=> {
    $(e.target).removeClass('bd-color--blue');
});

/** id, pw 입력 창 focus 시 테두리 강조 기능 */
$('.login-form__input').on('focus', e => {
    $(e.target).parent().addClass('bd-color--blue');
});

/** id, pw 입력 창 focusout 시 입력 내용 체크 기능 */
$('.login-form__input').on('focusout', e => {
    $(e.target).parent().removeClass('bd-color--blue');
    if(  $(e.target).val() == "" || $(e.target).val() == null ) { // 입력 내용이 없을 경우 테두리 강조 및 메시지 표시
        $(e.target).parent().addClass('bd-color--red');
        $(e.target).parent().next('div').children('span').removeClass('hidden');
    } else {
        $(e.target).parent().removeClass('bd-color--red');
        $(e.target).parent().next('div').children('span').addClass('hidden');
    }
});

/** 입력시 조건에 따라 입력 내용 체크 기능 */
$('.login-form__input').on('change keydown keyup paste', e => {
    if(  $(e.target).val() == "" || $(e.target).val() == null ) { // 입력 내용이 없을 경우 테두리 강조 및 메시지 표시
        $(e.target).parent().removeClass('bd-color--blue');
        $(e.target).parent().addClass('bd-color--red');
        $(e.target).parent().next('div').children('span').removeClass('hidden');
    } else {
        $(e.target).parent().removeClass('bd-color--red');
        $(e.target).parent().addClass('bd-color--blue');
        $(e.target).parent().next('div').children('span').addClass('hidden');
    }
});

/** 비밀번호 입력창에서 Enter 입력시 로그인 요청 */
$('#loginPw').on("keyup", (key) => {
    if(key.keyCode==13) {
        loginFormSubmit();
    }
})

/**
 * 로그인 폼 입력 여부 확인 함수
 * @returns {boolean} 하나라도 비어있으면 false, 전부 입력되어 있으면 true 반환
 */
function loginFormChk() {
    if($('#loginId').val() == '' || $('#loginId').val() == null) {
        $('#loginId').focus();
        return false;
    }
    if($('#loginPw').val() == '' || $('#loginPw').val() == null) {
        return false;
    }
    return true;
}

/**
 *  로그인 요청 함수
 */
function loginFormSubmit() {
    if(loginFormChk()) {
        const id = $('#loginId').val();
        const pw = $('#loginPw').val();
        const saveId = $('#saveId').is(':checked');
        const sendForm = { 'id' : id
                         , 'pw' : pw};

        $.ajax({
            type: "post",
            url: "login",
            traditional: true,
            contentType: "application/json",
            data: JSON.stringify(sendForm),
            dataType: "json",
            success: (res) => {
                if(res.chkLogin) {   // 로그인 성공시
                    if(saveId) {
                        if(savedUserId === null) {
                            localStorage.setItem("userId", id);
                        } else {
                            localStorage.removeItem("userId");
                            localStorage.setItem("userId", id);
                        }
                    } else {
                        localStorage.removeItem("userId");
                    }
                    location.replace("./");
                } else {    // 로그인 실패시
                    alert("로그인 실패");
                }
            }
        });
    }
}

function kakaoLogin() {

    $.ajax({
        url: 'login/getKakaoAuthUrl',
        type: 'get',
        async: false,
        dataType: 'text',
        success: function (res) {
            location.href = res;
        }
    });

}

$(document).ready( () => {
    if(savedUserId !== null) {
        $('#loginId').val(savedUserId);
        $('#saveId').prop('checked', true);
    }
});