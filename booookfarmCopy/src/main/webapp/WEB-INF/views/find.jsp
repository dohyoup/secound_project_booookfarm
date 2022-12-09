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
<nav class="navigation-container">
  <ul class="navigation-element">
    <li class="element"><a href="login">로그인</a></li>
    <li class="element"><a href="find">회원가입</a></li>
    <li class="element">1:1문의</li>
    <li class="element">마이페이지</li>
    <li class="element">장바구니</li>
  </ul>
</nav>
<header class="st-hd">
  <div class="head-container">
    <div class="mainlogo-img">
      <div class="mainlogo">
        <p class="page-name">booookfarm</p>
      </div>
    </div>
    <div class="full-sear">
      <div class="sear-place">
        <input class="sear" type="text">
      </div>
    </div>
  </div>
</header>
<main class="st-ma">
  <div class="main-container">
    <div class="find-container">
      <div class="find-nav">
        <button class="btn--rec btn--white">아이디 찾기</button>
        <button class="btn--rec btn--white">비밀번호 찾기</button>
      </div>

      <form id="findIdFormEmail" class="find-form">
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="이름">
          </div>
        </div>
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="가입 메일주소">
          </div>
        </div>
        <div class="find-btn-box">
          <button class="btn--rec btn--blue">확인</button>
        </div>
      </form>

      <form id="findIdFormPhone" class="find-form hidden">
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="이름">
          </div>
        </div>
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="핸드폰번호">
          </div>
          <button class="btn--rec btn--gray btn--w120h50 find-form__btn">인증번호 요청</button>
        </div>
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="인증번호 5자리">
            <span>5:00</span>
          </div>
          <button class="btn--rec btn--gray btn--w120h50 find-form__btn">인증번호 확인</button>
        </div>
        <div class="find-btn-box">
          <button class="btn--rec btn--blue">확인</button>
        </div>
      </form>

      <form id="findPwForm" class="find-form hidden">
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="아이디">
          </div>
        </div>
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="핸드폰번호">
          </div>
          <button class="btn--rec btn--gray btn--w120h50 find-form__btn">인증번호 요청</button>
        </div>
        <div class="find-input-box">
          <div class="find-form__input">
            <input type="text" placeholder="인증번호 5자리">
            <span>5:00</span>
          </div>
          <button class="btn--rec btn--gray btn--w120h50 find-form__btn">인증번호 확인</button>
        </div>
        <div class="find-btn-box">
          <button class="btn--rec btn--blue">확인</button>
        </div>
      </form>
    </div>
  </div>
</main>
<footer class="st-ft">
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
</html>