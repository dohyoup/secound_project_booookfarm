# Spring-Project-BooookFarm

스프링 프레임워크 + JSP 모임 커뮤니티 사이트


## 🖥️ 프로젝트 소개
관리자가 등록한 중고 도서를 등급에 따라 저렴하게 구매할 수 있는 도서 판매 서비스입니다.
<br>

## 🕰️ 개발 기간
* 22.10.16일 - 22.12.04일

### 🧑‍🤝‍🧑 맴버구성
 - 팀장  : 김형섭 - 로그인, 회원가입, ID찾기, PW찾기 기능
 - 팀원1 : 강승호 - 메인 페이지 검색, 도서등록 기능=> [작업한 리포지터리 LINK](https://github.com/kkang4913/booookfarm)
 - 팀원2 : 이도엽 - 도서 상세정보 페이지, 장바구니, 보관함, 결제페이지 기능
 - 공통 : DB설계 및 관리

### ⚙️ 개발 환경
- `Java 11`
- `JDK 11.0.14`
- **IDE** : Eclipse
- **Framework** : Spring
- **Database** : Oracle DB (18c)
- **ORM** : Mybatis

## 📌 Detail_Info
### 😵 주요 구현 기능
<details>
  <summary><h4>기능설명</h4></summary>

<!-- summary 아래 한칸 공백 두고 내용 삽입 -->
<details>
    <summary><h4>1. 도서상세 페이지</h4></summary>
 
- 메인 페이지에서 관리자가 등록한 도서의 상세정보를 보여주는 페이지 입니다.<br>
- 페이지 기능으로는 도서정보를 보여주는 것 이외에 최신 등록도서를 6개 까지 보여주는 기능과 장바구니 추가 기능이 있습니다.<br>
  <br>
  <h4>VIEW</h4>
  <img src="https://user-images.githubusercontent.com/100770645/214355928-c774f0fa-bb17-4ba9-b2b4-b3de3902e546.PNG" style="width:600px; height:700px;">
 
  <h4>최신 등록도서</h4>  
 
  - DB의 도서 테이블에서 최근 등록된 1~6 번 째의 도서정보를 불러와 보여주는 것이 목표입니다.<br>
  - ROWNUM을 부여하여 RNUM이 1~6에 속하는 도서 정보를 불러옵니다.<br>
    <img src="https://user-images.githubusercontent.com/100770645/214370893-b9e2cd88-4c19-4358-918b-9829e977c130.PNG">
  
  - 불러온 정보를 JSONArray객체에 담아 JSP로 보내 줍니다.<br>
    <img src="https://user-images.githubusercontent.com/100770645/214516001-b7d39cf7-32e3-4a69-830d-3cf20c120d86.PNG">
 
  - 받은 최신 도서정보를 사용자 화면에 리스트 형태로 보여줍니다.<br>
  - JSTL을 사용하고 싶지 않아서 스크립트 단에서 jQuery를 활용하여 구현하였습니다.<br>
    <img src="https://user-images.githubusercontent.com/100770645/214516008-5ec85ae2-dd73-428d-8ad2-08b55a5007ef.PNG">
  
  <h4>장바구니 추가</h4>
 
  - 사용자가 요청한 상품과 수량을 장바구니에 추가되게하는 것이 목표입니다.<br>
  - 기능동작은 사용자가 '장바구니 추가' 버튼을 클릭하면 사용자의 로그인상태와 계정 장바구니의 동일상품 존재유무를 확인 후<br> 
  - DB 장바구니 테이블에 추가합니다.<br>
    <img src="https://user-images.githubusercontent.com/100770645/214570034-136dd4fa-930c-4869-9353-240d1e8a0046.PNG">
  - 부가적인 기능으로는 사용자가 설정한 수량에 따라 가격을 표시해주는 기능이 있습니다.<br> 
 
</details>
<details>
    <summary><h4>2. 장바구니</h4></summary> 

- 장바구니는 사용자가 구매를 원하는 상품을 저장해두는 페이지 입니다.<br>
- 장바구니 기능으로는 크게 상품을 추가, 삭제하는 기능, 그리고 보관함에 추가하는 기능이 있고<br>
- 선택한 상품을 원하는 수량으로 구매할 수 있게하는 기능도 제공합니다.<br>
  <h4>VIEW</h4>
  <img src="https://user-images.githubusercontent.com/100770645/214567441-ea45935e-841d-4289-9f21-fff29402ab86.PNG" style="width:600px; height:600px;">
  
  <h5>삭제</h5>
 
  - 삭제는 선택상품 전체 삭제 와 개별상품 삭제 버튼을 따로 제공해 사용자 편의성을 높였습니다.<br>
  - 사용자 삭제 요청을 받으면 다음의 함수를 통해 확인알림 후 삭제요청 상품정보를 Controller로 전달하고<br>
    <img src="https://user-images.githubusercontent.com/100770645/214576351-000e079e-b40d-4b8f-9e68-8934a1409c80.PNG">
  
  - Controller에선 받은 요청 데이터를 Mapper로 전달하여 최종적으로 DB삭제를 진행합니다.<br>
    <img src="https://user-images.githubusercontent.com/100770645/214576338-95549ddd-4ca4-48c2-b114-f50bf316992f.PNG">
 
  <h5>수량 및 가격</h5>
    
  - 추가된 상품별로 구매할 수량을 선택할 수 있고 구매에 필요한 가격을 계산하여 보여줍니다.<br>
  - 추가적으로 오른쪽에 주문 금액 박스는 구매를 결정한 상품을 체크하면 그 상품의 배송비를 포함한 총 결제가격을 계산해서<br>
  - 보여줍니다.<br>
    <img src="https://user-images.githubusercontent.com/100770645/214642791-182a6b64-0e36-4d51-b3a1-841855511aeb.PNG">       
</details>
<details>
    <summary><h4>3. 보관함</h4></summary> 
 
  - 공통 에러 페이지를 설정해 두지 않으면 웹 컨테이너가 제공하는 기본 에러 페이지가 출력되는데<br>
  - 해당 페이지 내용에 어떤 오류인지에 대한 정보가 출력되기 때문에 보안상 문제가 있으며<br>
  - 또 미관상 보기에 좋지 않으니 사용자 편의를 증진 시키기 위해 구현 합니다.<br>
      <img src="https://user-images.githubusercontent.com/100770645/213181824-19865af6-25a6-4fa8-9f28-7bb03cfe24e3.PNG"><br>
  - Web.xml에 error-page태그를 활용하여 간단하게 JSP페이지와 연동할 수 있었습니다.<br>
 
      <img src="https://user-images.githubusercontent.com/100770645/213184377-75f82821-8377-4916-bc67-415fd624faa4.PNG"><br>
  - 페이지 오류 발생시 연결해둔 공통 JSP페이지로 자동 넘어가 사용자 편의성을 올릴 수 있었습니다.
 </details>
 <details>
    <summary><h4>4. 결제 페이지</h4></summary> 
 
  - 공통 에러 페이지를 설정해 두지 않으면 웹 컨테이너가 제공하는 기본 에러 페이지가 출력되는데<br>
  - 해당 페이지 내용에 어떤 오류인지에 대한 정보가 출력되기 때문에 보안상 문제가 있으며<br>
  - 또 미관상 보기에 좋지 않으니 사용자 편의를 증진 시키기 위해 구현 합니다.<br>
      <img src="https://user-images.githubusercontent.com/100770645/213181824-19865af6-25a6-4fa8-9f28-7bb03cfe24e3.PNG"><br>
  - Web.xml에 error-page태그를 활용하여 간단하게 JSP페이지와 연동할 수 있었습니다.<br>
 
      <img src="https://user-images.githubusercontent.com/100770645/213184377-75f82821-8377-4916-bc67-415fd624faa4.PNG"><br>
  - 페이지 오류 발생시 연결해둔 공통 JSP페이지로 자동 넘어가 사용자 편의성을 올릴 수 있었습니다.
 </details>
 </details>
 
### 😤 회고

  - 블로그 링크 추후 공개예정 
## 📜 Portfolio

### 📒 [노션 포트폴리오](https://www.notion.so/87662a3c2aef4ac7a1a38a7af370cd5f?p=53c2b32d45204bb890521e7106585cc1&pm=c)


