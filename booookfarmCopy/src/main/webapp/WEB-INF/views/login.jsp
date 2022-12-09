<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<c:set var="path" value="${pageContext.request.contextPath}" />
<head>
  <meta charset="UTF-8">
  <title>BooookFarm</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css"
        integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="${path}/resources/css/styles.css" />
  <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/module/header.jsp" %>
<main class="st-ma">
  <div class="main-container">
    <div class="login-container">
      <div class="login-title">
        로그인
      </div>
      <form class="login-form">
        <div class="login-input-box">
          <input id="loginId" class="login-form__input" type="text" name="id" placeholder="아이디를 입력해주세요.">
        </div>
        <div class="login-err-box">
          <span class="login-err-msg hidden">아이디를 입력해주세요.</span>
        </div>
        <div class="login-input-box">
          <input id="loginPw" class="login-form__input" type="password" name="password" placeholder="비밀번호를 입력해주세요.">
          <i id="showPw" class="fa-solid fa-eye"></i>
          <i id="hidePw" class="fa-solid fa-eye-slash hidden"></i>
        </div>
        <div class="login-err-box">
          <span class="login-err-msg hidden">비밀번호를 입력해주세요.</span>
        </div>
        <div class="login-check-box">
          <input id="saveId" class="login-form__checkbox" type="checkbox">
          <label for="saveId">아이디 기억하기</label>
        </div>
        <button class="login-form__btn btn--rec btn--blue" type="button" onclick="loginFormSubmit();">로그인</button>
      </form>
      <button id="naverLogin" class="login-form__btn btn--rec btn--green" type="button" onclick="location.href='${urlNaver}'"><img src="${path}/resources/img/logos/naver-logo.png" /><span>네이버 아이디로 로그인</span></button>
      <button class="login-form__btn btn--rec btn--yellow" type="button" onclick="kakaoLogin();"><img src="${path}/resources/img/logos/kakao-logo.png" /><span>카카오 아이디로 로그인</span></button>
      <div class="login-row">
        <span><a href="join">회원가입</a></span>
        <span><a href="find">아이디찾기</a></span>
        <span><a href="find">비밀번호찾기</a></span>
      </div>
    </div>
  </div>
</main>
<%@include file="/WEB-INF/views/module/footer.jsp" %>
<script src="${path}/resources/js/login.js"></script>
<script>
    $(document).ready( ()=> {

        var kakaoInfo = '${kakaoInfo}';

        if(kakaoInfo != ""){
            var data = JSON.parse(kakaoInfo);

            alert("카카오로그인 성공 \n accessToken : " + data['accessToken']);
            alert(
                "user : \n" + "email : "
                + data['email']
                + "\n nickname : "
                + data['nickname']);
        }
    });
</script>

</body>
</html>