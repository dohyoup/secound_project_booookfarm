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
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/module/header.jsp" %>
<main class="st-ma">
  <div class="main-container">
    <div class="join-container">
      <div class="join-title">
        회원가입
      </div>
      <div class="est-guide">
        <span class="dot--red"></span>
        <span>필수 입력사항</span>
      </div>
      <form class="join-form" method="post" action="join">
        <div class="join-form-line">
          <div class="join-label-box">
            <label>이름</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="name" type="text" placeholder="이름을 입력해주세요." name="name">
            </div>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg null-err hidden">이름을 입력해주세요.</span>
          <span class="join-err-msg len-err hidden">이름이 너무 깁니다. 관리자에게 문의해주세요.</span>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>아이디</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="id" type="text" placeholder="아이디를 입력해주세요." name="id">
            </div>
            <button class="btn--rec btn--gray btn--w120h50 join-form__btn" type="button" onclick="idDupChk();">중복확인</button>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg null-err hidden">아이디를 입력해주세요.</span>
          <span class="join-err-msg len-err hidden">아이디는 5~15자의 영문자와 숫자만 사용가능합니다.</span>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>비밀번호</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="pw" type="password" placeholder="비밀번호를 입력해주세요." name="pw">
              <i id="showPw" class="fa-solid fa-eye"></i>
              <i id="hidePw" class="fa-solid fa-eye-slash hidden"></i>
            </div>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg null-err hidden">비밀번호를 입력해주세요.</span>
          <span class="join-err-msg len-err hidden">비밀번호는 8~15자의 영문자, 숫자, 특수문자를 모두 사용해야합니다.</span>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>비밀번호 확인</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="chkPw" type="password" placeholder="동일한 비밀번호를 입력해주세요." name="chkPw">
              <i id="showChkPw" class="fa-solid fa-eye"></i>
              <i id="hideChkPw" class="fa-solid fa-eye-slash hidden"></i>
            </div>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg not-match-err hidden">비밀번호가 일치하지 않습니다.</span>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>핸드폰</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="phone" type="text" maxlength="13" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="-없이 숫자만 입력해주세요." name="phone">
            </div>
            <button class="btn--rec btn--gray btn--w120h50 join-form__btn" type="button" onclick="sendSMS();">인증번호 요청</button>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg null-err hidden">핸드폰 번호를 입력해주세요.</span>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="chkPhone" type="text" placeholder="인증번호 5자리" name="chkPhone">
              <span id="cNumTimer"></span>
            </div>
            <button class="btn--rec btn--gray btn--w120h50 join-form__btn" type="button" onclick="chkCNum();">인증번호 확인</button>
          </div>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>이메일</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input id="email" type="text" placeholder="이메일을 입력해주세요." name="email">
            </div>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg null-err hidden">이메일을 입력해주세요.</span>
          <span class="join-err-msg not-match-err hidden">이메일 형식으로 입력해주세요.</span>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>성별</label>
          </div>
          <div class="join-input-box">
            <input class="join-form_gender" type="radio" value="M" name="gender"><span>남</span>
            <input class="join-form_gender" type="radio" value="W" name="gender"><span>여</span>
          </div>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>주소</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input type="text" id="postalCode" placeholder="우편번호" name="postalCode" readonly>
            </div>
            <button class="btn--rec btn--gray btn--w120h50 join-form__btn" type="button" onclick="daumPostcode()">우편번호 검색</button>
          </div>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input type="text" id="address" placeholder="기본 주소" name="address" readonly>
            </div>
          </div>
        </div>
        <div class="join-form-line">
          <div class="join-label-box">
            <label>상세 주소</label>
            <span class="dot--red"></span>
          </div>
          <div class="join-input-box">
            <div class="join-form__input">
              <input type="text" id="detailAddress" placeholder="상세 주소" name="detailAddress">
            </div>
          </div>
        </div>
        <div class="join-err-line hidden">
          <span class="join-err-msg null-err hidden">상세 주소를 입력해주세요.</span>
        </div>
        <div class="join-terms-box">
          <div class="join-form-terms">
            <div>
              <input id="allCheck" type="checkbox">
              <span>전체약관에 동의합니다.</span>
            </div>
          </div>
          <div class="join-form-terms">
            <div>
              <input id="chkUseInfoTerms" type="checkbox">
              <span class="terms-est">[필수]</span>
              <span>개인정보 수집/이용 안내</span>
            </div>
            <div>
              <span id="showUseInfoTerms" class="show-terms">전문보기</span>
            </div>
          </div>
          <div class="join-form-terms">
            <div>
              <input id="chkOfferInfoTerms" type="checkbox">
              <span class="terms-est">[필수]</span>
              <span>개인정보 제3자 제공</span>
            </div>
            <div>
              <span id="showOfferInfoTerms" class="show-terms">전문보기</span>
            </div>
          </div>
          <div class="join-form-terms">
            <div>
              <input id="chkServiceTerms" type="checkbox">
              <span class="terms-est">[필수]</span>
              <span>회원이용 약관</span>
            </div>
            <div>
              <span id="showServiceTerms" class="show-terms">전문보기</span>
            </div>
          </div>
        </div>
        <div class="join-btn-box">
          <button class="btn--rec btn--white" type="button">취소</button>
          <button class="btn--rec btn--blue" type="button" onclick="joinFormSubmit();">회원가입</button>
        </div>
      </form>
    </div>
  </div>

  <div id="useInfoTerms" class="modal hidden">
    <div class="modal-body">
      <div class="modal-title">
        개인정보 수집/이용 안내
        <i class="fa-solid fa-x hide-modal"></i>
      </div>
      <div class="modal-content scroll-y">
        <h6>개인정보의 수집/이용</h6>
        <h6>■ 수집하는 개인정보 항목</h6>
        <p>
          회사는 개인정보 보호법 제32조에 따라 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.<br>
          수집항목 : 이름, ID, 암호, 생년월일, 성별, 연락처1, 연락처2, 우편번호, 주소, 이메일, 직업, 알게된경로, 정보메일수신여부, 추천인ID, 주문결제기록, 접속 IP 정보, 쿠키, 서비스 이용 기록, 물품배송에 필요한 정보, 필요시 대금결제 및 환불에 필요한 신용카드정보, 은행계좌정보<br>
          개인정보 수집방법 : 홈페이지(회원가입, 주문결제), 전화/팩스, 배송요청
        </p>
        <h6>■ 개인정보의 수집 및 이용목적</h6>
        <p>
          회사는 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.<br>
          가. 홈페이지 회원가입 및 관리<br>
          - 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.<br>
          나. 민원사무 처리<br>
          - 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.<br>
          다. 재화 또는 서비스 제공<br>
          - 물품배송, 서비스 제공, 연령인증, 요금결제·정산, 채권추심 등을 목적으로 개인정보를 처리합니다.<br>
          라. 마케팅 및 광고에의 활용<br>
          - 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 서비스의 유효성 확인 등을 목적으로 개인정보를 처리합니다.
        </p>
        <h6>■ 개인정보의 보유 및 이용기간</h6>
        <p>
          회사는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집시에 동의 받은 개인정보 보유, 이용기간 내에서 개인정보를 처리, 보유합니다. 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.<br>
          가. 홈페이지 회원가입 및 관리<br>
          - '홈페이지 회원가입 및 관리'와 관련한 개인정보는 수집, 이용에 관한 동의일로부터 [탈퇴신청 후 3개월] 까지 위 이용목적을 위하여 보유.이용됩니다.<br>
          - 보유근거 : 부정적 거래분쟁의 차단<br>
          - 보유기간 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년<br>
          - 예외사유 : 거래분쟁 소지가 없거나, 재가입시 즉시삭제<br>
          나. 민원사무 처리<br>
          - '민원사무 처리'와 관련한 개인정보는 수집, 이용에 관한 동의일로부터 [5년]까지 위 이용목적을 위하여 보유.이용됩니다.<br>
          - 보유근거 : 전자상거래등에서의 소비자보호에 관한 법률(민원발생에 대한 이력관리)<br>
          - 보유기간 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 , 계약 또는 청약철회 등에 관한 기록 : 5년<br>
          - 예외사유 : 거래분쟁 소지가 없는 일반적 내용의 삭제요청<br>
          다. 재화 또는 서비스 제공<br>
          - 보유근거 : 전자상거래등에서의 소비자보호에 관한 법률<br>
          - 보유기간 : 신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년, 대금결제 및 재화 등의 공급에 관한 기록 : 5년, 계약 또는 청약철회 등에 관한 기록 : 5년<br>
          라. 마케팅 및 광고에의 활용<br>
          - 보유기간 : 표시/광고에 관한 기록 : 6개월
        </p>
      </div>
    </div>
  </div>

  <div id="offerInfoTerms" class="modal hidden">
    <div class="modal-body">
      <div class="modal-title">
        개인정보 취급 방침
        <i class="fa-solid fa-x hide-modal"></i>
      </div>
      <div class="modal-content scroll-y">
        <h6>개인정보의 제 3자 제공</h6>
        <p>
          회사는 서비스 향상을 위해서 아래와 같이 이벤트 진행시에<br>
          개인정보를 제3자와 제휴하고 있으며, 관계 법령에 따라 개인정보를<br>
          제3자 제공시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.<br>
          회사의 개인정보 제3자 제공 내용은 아래와 같습니다.<br>
          <br>
          - 개인정보를 제공받는 자 : 이벤트 진행업체<br>
          - 개인정보 이용 목적 : 이벤트 참가 및 당첨처리<br>
          - 제공하는 개인정보 항목 : 로그인ID, 이름, 생년월일<br>
          - 보유 기간 : 당첨시 당첨발표 및 상품전달시까지, 미당첨시 즉시 파기됨<br>
          <br>
          **** 현재 자체 이벤트 진행은 없으며 이에 제3자 제휴가 없습니다.<br>
          추후 이벤트 진행시 이벤트 접수페이지에서 제3자 동의를 별도로 받습니다. ****
        </p>
      </div>
    </div>
  </div>

  <div id="serviceTerms" class="modal hidden">
    <div class="modal-body">
      <div class="modal-title">
        이용약관
        <i class="fa-solid fa-x hide-modal"></i>
      </div>
      <div class="modal-content scroll-y">
        <h6>(주)시퀀스엔 이용약관</h6>
        <h6>제 1조(목적)</h6>
        <p>
          본 약관은 (주)시퀀스엔(이하 "회사"라 한다.)에서 운영하는 웹사이트 'BooookFarm'(이하 "사이트")에서 제공하는 인터넷 관련 서비스(이하 "서비스")를 이용함에 있어 사이트와 이용자간의 권리, 의무 및 책임사항 및 절차 등을 규정함을 목적으로 합니다.<br>
          *PC통신, 스마트폰 앱, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 준용합니다.
        </p>
        <h6>제2조(용어의 정의)</h6>
        <p>
          ① "사이트"란 회사가 재화·용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하 여 재화·용역을 거래할 수 있도록 설정한 가상의 영업장 또는 회사가 운영하는 웹사이트를 말하며, 통합된 하나의 회원 계정(ID 및 비밀번호)을 이용하여 서비스를 제공받을 수 있는 아래의 사이트를 의미합니다. 아울러 사이트를 운영하는 사업자의 의미로도 사용합니다. http://www.booookfarm.com<br>
          ② "이용자"란 "사이트”에 접속하여 이 약관에 따라 "사이트"가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>
          ③ “회원”이라 함은 "사이트"에 개인정보를 제공하여 회원등록을 한 자로서, "사이트"의 정보를 지속적으로 제공받으며, "사이트"가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.<br>
          ④ “비회원”이라 함은 회원에 가입하지 않고 "사이트”가 제공하는 서비스를 이용하는 자를 말합니다.<br>
          ⑤ 위 가항에서 정의되지 않은 이 약관상의 용어의 의미는 일반적인 거래관행에 의합니다.
        </p>
        <h6>제3조 (약관의 명시, 효력 및 변경)</h6>
        <p>
          ① “사이트”는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 “사이트”의 초기 서비스화면(전면)에 게시합니다.<br>
          ② “사이트”는 약관의 규제 등에 관한 법률, 전자거래 기본법, 전자서명법, 정보통신망 이용촉진등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
          ③ "사이트”가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 장터의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.<br>
          ④ "장터"가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다.<br>
          ⑤ 이 약관은 회사와 회원간에 성립되는 서비스이용계약의 기본약정입니다. 회사는 필요한 경우 특정 서비스에 관하여 적용될 사항(이하 "개별약관"이라고 합니다)을 정하여 미리 공지할 수 있습니다. 회원이 이러한 개별약관에 동의하고 특정 서비스를 이용하는 경우에는 개별약관이 우선적으로 적용되고, 이 약관은 보충적인 효력을 갖습니다. 개별약관의 변경에 관해서는 위 ④항을 준용합니다.<br>
          ⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 정부가 제정한 전자거래소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.
        </p>
        <h6>제4조(서비스의 제공 및 변경)</h6>
        <p>
          ① “사이트”는 다음과 같은 업무를 수행합니다.<br>
          1. 재화 또는 용역에 대한 정보 제공<br>
          2. 기타 “사이트”가 정하는 업무
        </p>
        <h6>제5조(서비스의 중단)</h6>
        <p>
          ① "장터"는 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.<br>
          ② 제1항에 의한 서비스 중단의 경우에는 "사이트"는 제8조에 정한 방법으로 이용자에게 통지합니다.
        </p>
        <h6>제6조(이용계약의 성립)</h6>
        <p>
          ① 'BooookFarm' 서비스 이용계약(이하 "이용계약"이라고 합니다)은 'BooookFarm' 서비스를 이용하고자 하는 자의 이용신청에 대하여 회사가 승낙함으로써 성립합니다.<br>
          ② 이용신청의 방법은 회사가 온라인으로 제공하는 가입신청양식 중 회원가입란을 이용합니다. 회원 가입은 제시된 각각의 항목(실명가입, ID, 생년월일 등의 필수항목)을 채우시면 됩니다.<br>
          ③ 비회원으로 'BooookFarm' 서비스를 이용하기 위해서는 제2항의 이용신청방법과는 별도로 비회원 인증절차를 거쳐야 합니다<br>
          ④ 'BooookFarm' 서비스를 이용하기 위해서는 본 약관의 내용과 본 약관이 이용계약의 일부가 됨을 동의하여야 합니다.
        </p>
        <h6>제7조(서비스 이용신청)</h6>
        <p>
          ① 서비스를 이용하고자 하는 자는 회사 소정의 가입신청양식을 제출하여야 합니다. 가입양식에는 다음 각호의 정보가 요구됩니다.<br>
          1) 이름 또는 회사명<br>
          2) 생년월일<br>
          3) 회원 아이디<br>
          4) 비밀번호<br>
          5) 주소<br>
          6) 전화번호<br>
          7) 기타 가입신청양식에서 필수적으로 요구하는 사항<br>
          ② 이용신청은 반드시 실명으로 하여야 합니다.
        </p>
        <h6>제8조(회원가입)</h6>
        <p>
          ① 이용자는 "사이트"가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.<br>
          ②"사이트"는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하는 경우 회원가입을 승낙하지 아니 합니다.<br>
          1. 등록 내용에 허위, 기재누락, 오기가 있는 경우<br>
          2. 회원으로 등록하는 것이 "장터"의 기술상 현저히 지장이 있다고 판단되는 경우<br>
          3. 회사가 신청양식에서 정한 회원정보가 미비 되었을 경우<br>
          4. 기타 이 약관상의 제반 사항을 위반하며 신청하는 경우<br>
          ③ 회원가입계약의 성립시기는 등록을 완료한 시점으로 합니다.<br>
          ④ 회원은 제7조 제1항에 의한 등록사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 "장 터"에 대하여 그 변경사항을 알려야 합니다.
        </p>
        <h6>제9조(회원 탈퇴 및 자격 상실 등)</h6>
        <p>
          ① 회원 언제든지 회사에 해지의사를 통지함으로써 탈퇴를 할 수 있습니다. 이 경우 사이트의 탈퇴유예 제도에 의해 3개월 동안은 개인정보가 남아있습니다. 이는, 신규회원을 위한 FM 충전을 위해 회원탈퇴/재가입을 반복, 시스템을 악용하는 것을 방지하기 위함이며, 3개월 이후에는 회원정보가 DB에서 완전히 삭제됩니다.<br>
          ② 회원이 다음 각호의 사유에 해당하는 경우, 사이트는 회원자격을 제한 및 정지시킬 수 있습니다.<br>
          1. 가입 신청시에 허위 내용을 등록한 경우<br>
          2. 다른 사람의 사이트 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우<br>
          3. 사이트를 이용하여 법령과 이 약관이 금지하거나 미풍 양속에 반하는 행위를 하는 경우<br>
          ③ 사이트가 회원 자격을 제한·정지시킨 후, 동일한 행위가 2회이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 사이트는 회원자격을 상실시킬 수 있습니다.<br>
          ⑤ 사이트가 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지합니다.<br>
          ⑥ 회사는 이용계약의 종료로 인한 손해 또는 손실에 대하여 일체의 책임을 지지 않습니다
        </p>
        <h6>제10조 (회원에 대한 통지)</h6>
        <p>
          ① “사이트” 회원이 회사에 제출한 전자우편을 이용하여 회원에 대한 통지를 할 수 있습니다.<br>
          ② “사이트”는 불특정다수 회원에 대한 통지의 경우 1주일 이상 사이트 또는 사이트의 게시판 에 게시함으로써 개별 통지를 갈음할 수 있습니다.
        </p>
        <h6>제11조(직거래와 책임 소재)</h6>
        <p>
          "직거래"라 함은 구매를 원하는 사람과 판매를 원하는 판매자 간에 직접 거래를 하는 행위를 말합니다. "사이트"는 직거래로 인한 어떤 피해에도 책임을 질 수 없습니다. 만약 피해가 발생했을 경우에는 해당 당사자에게 책임이 있습니다.<br>
        </p>
        <h6>제12조(재화 교환)</h6>
        <p>
          ① "사이트는 이용자가 이미 구매한 재화 또는 용역에 대해 판매자의 승인 하에 재화 또는 용역을 교환할 수 있습니다. 따라서 교환이 이루어진 시점에서는 구매자 임의로 교환을 결정할 수 없습니다.<br>
        </p>
        <h6>제13조(개인정보보호)</h6>
        <p>
          ① "사이트"는 이용자의 정보수집 시 필요한 최소한의 정보를 수집합니다. 다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다.<br>
          1. 성명<br>
          2. 주소<br>
          3. 전화번호<br>
          4. 희망ID(회원의 경우)<br>
          5. 비밀번호(회원의 경우)<br>
          6. 전자우편주소(또는 이동전화번호)<br>
          ② "사이트"가 이용자의 개인식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.<br>
          ③ 제공된 개인정보는 당해 이용자의 동의 없이 목적 외의 이용이나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 “사이트”가 집니다. 다만, 다음의 경우에는 예외로 합니다.<br>
          1. 배송업무상 배송업체에게 배송에 필요한 최소한의 이용자의 정보(성명, 주소, 전화번호)를 알려주는 경우<br>
          2. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우<br>
          3. 재화 등의 거래에 따른 대금정산을 위하여 필요한 경우<br>
          4. 도용방지를 위하여 본인확인에 필요한 경우<br>
          5. 법률의 규정 또는 법률에 의하여 필요한 불가피한 사유가 있는 경우<br>
          ④ "사이트"가 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보 보호책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은 자, 제공목적 및 제공할 정보의 내용) 등 정보통신망이용촉진 등에 관한 법률 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.<br>
          ⑤ 이용자는 언제든지 "사이트”가 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 "사이트"는 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 "사이트"는 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.<br>
          ⑥ "사이트”는 개인정보 보호를 위하여 관리자를 한정하여 그 수를 최소화하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.<br>
          ⑦ "사이트” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.
        </p>
        <h6>제14조(회원의 ID 및 비밀번호에 대한 의무)</h6>
        <p>
          ① ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.<br>
          ② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.<br>
          ③ 회원이 자신의 ID 및 비밀번호를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "사이트”에 통보하고 “사이트”의 안내가 있는 경우에는 그에 따라야 합니다.
        </p>
        <h6>제15조(이용자의 의무)</h6>
        <p>
          이용자는 다음 행위를 하여서는 안됩니다.<br>
          1. 신청 또는 변경시 허위내용의 등록<br>
          2. 타인의 정보 동용<br>
          3. "사이트"에 게시된 정보의 변경<br>
          4. "사이트"가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시<br>
          5. “사이트”, 기타 제 3자의 저작권 등 지적재산권에 대한 침해<br>
          6. "사이트"에 등록한 제3자의 명예를 손상시키거나 업무를 방해하는 행위<br>
          7. 외설 또는 폭력적인 메시지, 화상, 음성 기타 공공질서와 미풍양속에 반하는 정보를 공개 또는 게시하는 행위
        </p>
        <h6>제16조(저작권의 귀속 및 이용제한)</h6>
        <p>
          ① "사이트”가 작성한 저작물에 대한 저작권 기타 지적재산권은 'BooookFarm'에 귀속합니다.<br>
          ② 이용자는 "사이트”를 이용함으로써 얻은 정보를 "장터"의 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
        </p>
        <h6>제17조(분쟁해결)</h6>
        <p>
          ① "사이트”는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치·운영합니다.<br>
          ② "사이트”는 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보하여 드립니다.<br>
          ③ "사이트”와 이용자간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.
        </p>
        <h6>제18조(재판권 및 준거법)</h6>
        <p>
          ① "회사”와 이용자간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 회사의 주소지 관할 법원으로 합니다.<br>
          ② “사이트”와 이용자간에 제기된 전자상거래 소송에는 한국법을 적용합니다.
        </p>
        <h6>*부칙</h6>
        <p>
          1. 이 약관은 2022년 12월 1일부터 적용됩니다.
        </p>
      </div>
    </div>
  </div>
</main>
<%@include file="/WEB-INF/views/module/footer.jsp" %>
<script>
    $(document).ready( () => {
        /**
         *  네이버 로그인 API 데이터 저장
         */
        if(${not empty sessionScope.naverLoginData}) {  // 네이버 로그인 데이터가 있으면
            saveNaverData(${sessionScope.naverLoginData});
            <%
               session.removeAttribute("naverLoginData");  // 사용한 로그인 데이터 삭제
            %>
        }
        if(${not empty sessionScope.kakaoLoginData}) {
            saveKakaoData(${sessionScope.kakaoLoginData})
            <%
               session.removeAttribute("kakaoLoginData");  // 사용한 로그인 데이터 삭제
            %>
        }
    });
</script>
<script src="${path}/resources/js/join.js"></script>

</body>
</html>