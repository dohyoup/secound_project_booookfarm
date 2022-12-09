/**
 * 로그인, 로그아웃시 로컬스토리지 null 비우기
 */
function logout() {
	location.href="logout";
	setLocalStorage('latelyViewItemList',null);
	}
	
function login() {
	location.href="login";
	setLocalStorage('latelyViewItemList',null);
}	



//최근 본 상품 목록 localStorage 활용
//최근본 아이템 삭제 기간
var LATELY_VIEW_ITEM_EXPIRATION_DATE = 1;
//최근본 아이템 최대 저장 개수
var LATELY_VIEW_ITEM_MAX_SAVE_COUNT = 12;
//최근본 아이템 페이징 사이즈
var LATELY_VIEW_ITEM_PAGEING_SIZE = 4;

/**
* 
* @param obj
* @returns
*/
function isNull(obj){
if(obj == '' || obj == null || obj == undefined || obj == NaN){ 
return true;
}else{
return false;
}
}

/**
* 로컬스토리지 저장
* @param name
* @param obj
* @returns
*/
function setLocalStorage(name,obj){
localStorage.setItem(name, obj);
}

/**
* 로컬 스토리지 삭제
* @param name
* @returns
*/
function removeLocalStorage(name){
localStorage.removeItem(name);
}

/**
* 로컬스토리지에서 특정 객체 가져오기
* @param name
* @returns
*/
function getItemLocalStorage(name){
return localStorage.getItem(name);
}

$(function(){
	 initLatelyViewItemList();

/**
* 최근 본 상품 관련 로컬 스토리지 공간 확보 일정 시간 지난 것 뺴고 재저장 페이지별 무조건 호출
* @returns
*/
function initLatelyViewItemList(){
  //로컬스토리지에서 latelyViewItemList 로 저장된 정보가 있는지 확인후
if(isNull(getItemLocalStorage('latelyViewItemList'))){

          //없을경우 공간 생성
setLocalStorage('latelyViewItemList',null);

          //상품을 표시할 div에 없을경우 화면 표시
$("#latelyViewItemList").append('<div class="not_item">최근 본 상품이<br>없습니다.</div>');
  		  //기존 정보가 있을 경우장된 정보를 가져오고
}else{
var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
          //실제 저장된 데이터가 있는경우 
if(latelyViewItemListJson != "null" || isNull(latelyViewItemListJson)){

var nowDate = new Date();

//문자열을 javascript 객체로 변환
var latelyViewItemList = JSON.parse(latelyViewItemListJson);

                  //일정시간 경과된 아이템을 제외하고 다시 넣기 위한 새로운 Array
var latelyViewItemListNew = new Array();

                  //상품 리스트를 돌면서 상품별 저장된 시간이 현재 시간보다 클경우만
                  //다시 latelyViewItemListNew  에 추가
for(var i in latelyViewItemList){
var viewTime = new Date(latelyViewItemList[i].viewTime);
//시간이 경과된경우 를 제외하고 재 저장
if(nowDate.getTime() < viewTime.getTime()){
latelyViewItemListNew.push(latelyViewItemList[i]);
}
}

//시간이 모두 경과된 경우 담긴 새로운 배열요소가 없으므로 로컬 스토리지를 비워줌.
if(latelyViewItemListNew.length == 0){
setLocalStorage('latelyViewItemList',null);
                  //재저장
}else{
setLocalStorage('latelyViewItemList',JSON.stringify(latelyViewItemListNew));
}
}
          //화면을 그리는 함수호출
LatelyViewItemRender(1);
}
}
});

/**
* 로컬 스토리지 저장 후 아이템 상세보기 페이지 이동
* @param itemSeq
* @returns
*/
function moveItemViewPage(itemSeq,itemImagePath,itemTitle,itemPrice){

var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
var viewTime = new Date();
//최근 본 상품이 없을경우 무조건 저장
if(latelyViewItemListJson == "null" || isNull(latelyViewItemListJson)){

            //새로 저장될 상품이 있을경우 로컬스토리지에 저장 
var latelyViewItemListNew = new Array();

var latelyViewItem = {
"itemSeq" : itemSeq
,"itemImagePath" : itemImagePath
,"itemTitle" : itemTitle
,"itemPrice" : itemPrice
,"viewTime" :viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
}
latelyViewItemListNew.unshift(latelyViewItem);
setLocalStorage('latelyViewItemList',JSON.stringify(latelyViewItemListNew));

// 최근 본 상품이 있을경우 
// 불러온 로컬스토리지를 객체로 변환
}else{
var latelyViewItemList = JSON.parse(latelyViewItemListJson);

// 새로 본 상품일 경우 아래의 if 조건문 실행
var isExistsItem = false;

// 최근 본 상품의 bookCode를 불러와 중복체크
// 중복일 경우 해당하는 배열을 삭제하고 if(else) 조건문 실행
for(var i in latelyViewItemList){
if((latelyViewItemList[i].itemSeq) == itemSeq){
	latelyViewItemList.splice(i,1);
    i --;
	//isExistsItem = true; 
	//break;
}
}

//새로본 상품일경우만 저장
if(!isExistsItem){
//최대 4개 일경우 마지막꺼 삭제 후제일 앞에 저장
if(latelyViewItemList.length == Number(LATELY_VIEW_ITEM_MAX_SAVE_COUNT)){
	latelyViewItemList.pop();
}

var latelyViewItem = {
		"itemSeq" : itemSeq
		,"itemImagePath" : itemImagePath
		,"itemTitle" : itemTitle
		,"itemPrice" : itemPrice
		,"viewTime" :viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
		}
latelyViewItemList.unshift(latelyViewItem);
setLocalStorage('latelyViewItemList',JSON.stringify(latelyViewItemList));

}else{
	var latelyViewItem = {
			"itemSeq" : itemSeq
			,"itemImagePath" : itemImagePath
			,"itemTitle" : itemTitle
			,"itemPrice" : itemPrice
			,"viewTime" :viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
			}
	latelyViewItemList.unshift(latelyViewItem);
}
}

    //상품페이지로 이동
location.href="main-detail?bookcode="+itemSeq;
}

/**
* 최근 본 상품 화면 셋팅(페이징)
* @param list
* @returns
*/
function LatelyViewItemRender(page){
    //기본적으로 일단 상품리스트를 비움
$('#latelyViewItemList').empty();

    //로컬스토리지에서 latelyViewItemList 값 확인
if(getItemLocalStorage('latelyViewItemList') != "null" || isNull(getItemLocalStorage('latelyViewItemList'))){

var latelyViewItemList = JSON.parse(getItemLocalStorage('latelyViewItemList'));

            //페이징을 해야하기때문에 전체 개수가 필요함
var length = latelyViewItemList.length;
console.log("페이징 아이템 전체 개수" + length);            
            //최대 나올수 있는 페이지를 셋팅.
var maxPage = length / LATELY_VIEW_ITEM_PAGEING_SIZE;
console.log("페이징 번호 개수 " + maxPage);            

            //페이징 처리부분 레이어 노출시킴
$("div#itemListPaging_div").css("display","");

            //함수호출시 전달받은 페이지 값으로 현재페이지 셋팅.
$("strong#nowLatelyViewItemPage_strong").text(page);

            //최대 페이지 개수 셋팅
$("span#totalLatelyViewItemPage_span").text(Math.ceil(maxPage))

let close_icon ='/boookfarm/resources/img/icon/close-icon.png';
//가져온 최근본상품리스트에서 노출해야할 인덱스을 구해서 노출
for(var i = ((page-1) * LATELY_VIEW_ITEM_PAGEING_SIZE); i < (page*LATELY_VIEW_ITEM_PAGEING_SIZE); i++){
            console.log(i);        
if(!isNull(latelyViewItemList[i])){
                            //상품 그리는 부분
let side_html__ = '';                            
	  side_html__ += '<div class="boookcard-view-box">';                   
	  side_html__ += '<a class="bookcard-view-a">';                   
	  side_html__ += '<img class="bookcard-view-img" onclick="moveItemViewPage(\''+latelyViewItemList[i].itemSeq+'\',\''+latelyViewItemList[i].itemImagePath+'\',\''+latelyViewItemList[i].itemTitle+'\',\''+latelyViewItemList[i].itemPrice+'\')" src="'+latelyViewItemList[i].itemImagePath+'"></img>';
	  side_html__ += '<img class="side-close-icon" src="'+close_icon+'" onclick="deletItem(\''+latelyViewItemList[i].itemSeq+'\')"></img>';
	  side_html__ += '<div class="more_info more_info_none">';
	  side_html__ += '<div class="boook-view-title"">'+latelyViewItemList[i].itemTitle+'</div>';
	  side_html__ += '<div class="boook-view-price">'+latelyViewItemList[i].itemPrice+'원</div>';
	  side_html__ += '</div>';
	  side_html__ += '</a>';
	  side_html__ += '</div>';
	  
	  $("#latelyViewItemList").append(side_html__);                      
                  
}
}
}else{
            //상품이 없을경우
$("#latelyViewItemList").append('<div class="not_item">최근 본 상품이<br>없습니다.</div>');
$("#itemListPaging_div").css("display","none");
}

}

/**
*  최근 본 상품 삭제 버튼 클릭
*/
function deletItem(code) {
	var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
	var latelyViewItemList = JSON.parse(latelyViewItemListJson);
	
	for(var i in latelyViewItemList){
		if((latelyViewItemList[i].itemSeq) == code){
			latelyViewItemList.splice(i,1);
		}
	}
	localStorage.setItem("latelyViewItemList", JSON.stringify(latelyViewItemList));
	
	if (latelyViewItemList.length == 0) {
		setLocalStorage('latelyViewItemList',null);
		}
	
	LatelyViewItemRender(1);
}



/**
* 최근 본 상품 페이지 버튼 클릭
* @param type
* @returns
*/
function latelyViewItemPageingPlusMinus(type){
if(type == "minus"){
if(Number($("strong#nowLatelyViewItemPage_strong").text()) > 1){
$("strong#nowLatelyViewItemPage_strong").text(Number($("strong#nowLatelyViewItemPage_strong").text()) - 1);
LatelyViewItemRender($("strong#nowLatelyViewItemPage_strong").text());
}

}else{
if(Number($("strong#nowLatelyViewItemPage_strong").text()) < Number($("span#totalLatelyViewItemPage_span").text())){
$("strong#nowLatelyViewItemPage_strong").text(Number($("strong#nowLatelyViewItemPage_strong").text()) + 1);
LatelyViewItemRender($("strong#nowLatelyViewItemPage_strong").text());
}
}
}