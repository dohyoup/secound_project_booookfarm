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
- **Framework** : Spring 5.3.22
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
  <img src="https://user-images.githubusercontent.com/100770645/214567441-ea45935e-841d-4289-9f21-fff29402ab86.PNG" style="width:700px; height:600px;">
  
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
 
  - 보관함은 사용자가 관심은 있지만 당장 구매하지 않을 상품을 나중에라도 찾기 편하게하기위해 만들었으며<br>
  - 장바구니에서 위에있는 보관함 아이콘을 클릭하여 접근할 수 있습니다.<br>
  - 보관함에 상품을 추가해두면 장바구니를 비워둬도 상품을 쉽게 찾을 수 있습니다.<br>
  - 보관함은 장바구니와 디자인 측면이나 기능적으로 매우 유사한 페이지입니다.<br>
    <br>
  <h4>VIEW</h4>
  <img src="https://user-images.githubusercontent.com/100770645/214783029-88200b36-4047-4ee2-8a3c-4f7685db11c1.PNG" style="width:700px; height:600px;">
  
  - 기능은 삭제기능과 수량 가격표기가 있는데 장바구니와 구현 방식은 동일하게 진행하였습니다.  
 </details>
 <details>
    <summary><h4>4. 결제 페이지</h4></summary> 
 
 - 장바구니에서 구매상품과 수량을 선택하고 구매버튼을 누르면 결제페이지에 접근됩니다. <br>
 - 결제페이지에서 구현한 주요 기능으로는 카카오(Daum)API를 통한 주소설정 기능과 마일리지 적립 및 사용기능,<br>
 - 마지막으로 아임포트 Open API를 통한 이니시스 결제기능이 있습니다.<br>
 <br>
 <h4>VIEW</h4>
 <상><br>
 <img src="https://user-images.githubusercontent.com/100770645/214798338-191f134c-550e-40fc-a05e-fd920b0e5482.PNG" style="width:700px; height:600px;">
 <br>
 <하><br>
 <img src="https://user-images.githubusercontent.com/100770645/214798357-019b5302-6c34-4f9d-a10d-b27c79b4f7d6.PNG" style="width:700px; height:600px;">
 <br>
  
  <h5>구매자 정보 및 주소지정</h5>
  
   - 만약 구매자가 다른 배송지로 상품을 받기를 원할 경우를 위해 구현하였고<br>
   - 새로운 주소란에 추가로 입력하지 않으면 회원가입시에 기입한 기존 주소지로 설정됩니다.<br>
     <img src="https://user-images.githubusercontent.com/100770645/214828582-ececc8b8-92c4-4999-b28b-7c56e803408a.PNG" style="width:700px; height:600px;">
   - 주소 API는 카카오뿐만 아니라 각종 개발블로그에도 사용예시가 잘 정리되어 있어 메소드를 호출하는 것 만으로 간단하게 구현할 수 있었습니다.
  
  <h5>마일리지</h5>
  
   - 마일리지는 구매완료시 일정금액을 적립해주는 기능으로<br> 
   - 적립된 마일리지는 결제가격을 넘지않는 선에서 자유롭게 사용가능합니다.<br>
     <img src="https://user-images.githubusercontent.com/100770645/214840033-3602d371-5c6c-4e25-b9aa-314d1091af32.PNG" style="width:700px; height:600px;">
  
   - 결제는 아임포트에서 가맹점 식별 코드를 받은 뒤 결제관련 Open API를 사용하였고<br>
   - 결제가 성공적으로 이루어지면 주문정보를 폼 변수에 담아서 Controller로 전달 후 DB구매정보 테이블에 저장하는데<br>
   - 그중 마일리지는 변수에 담을 때 기존 보유 마일리지에서 사용한 마일리지, 새로 적립할 마일리지를 알맞게 계산한 값을<br> 
   - Controller로 전달합니다.
   
  <h5>결제</h5>
  
  <h4>VIEW</h4>
  <br>
     <img src="https://user-images.githubusercontent.com/100770645/214846653-bd07881e-abac-4a42-ad50-e5b81f344a8c.PNG" style="width:700px; height:600px;"><br>
  
   - 결제 기능 자체는 사실 처음 Open API를 적용하여 호출하는 부분만 해결하면 크게 어려울 것은 없는 기능이었습니다.<br>
   - 결제 기능을 구현하면서 시간이 오래걸린 이유는 사실상 결제가 이루어졌을 때의 후 처리 작업을 해주어야 했기 때문이었는데<br>
   - 위의 마일리지만해도 사용마일리지, 적립마일리지를 따로 구분해서 계산 후 업데이트 시켜줘야했고<br>
   - 또 구매를 했다면 상품이 판매 되었다는 의미이니 재고를 업데이트하는 코드도 신경써서 추가해주어야 했습니다.<br> 
   
     <img src="https://user-images.githubusercontent.com/100770645/214846028-8cf7ab83-676b-4688-a4ca-046c75a8359e.PNG" style="width:700px; height:600px;">
 </details>
 </details>
 
### 😤 회고

  ### [두 번째 프로젝트 회고 <= TstoryBlog](https://dohyoup.tistory.com/entry/%EB%91%90-%EB%B2%88%EC%A7%B8-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%9A%8C%EA%B3%A0) 
## 📜 Portfolio

### 📒 [노션 포트폴리오](https://www.notion.so/87662a3c2aef4ac7a1a38a7af370cd5f?p=333e360ddd774a1692c6e6338f1ef940&pm=c)


