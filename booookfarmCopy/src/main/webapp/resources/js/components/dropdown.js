const dropdownBtn = document.querySelectorAll('.dropdown-btn');

dropdownBtn.forEach( (item) => {
    item.addEventListener('mouseover', function(){  //  mouseover 시 hover 클래스 추가
        item.parentElement.classList.add('drop__hover');
    });
});
dropdownBtn.forEach( (item) => {
    item.addEventListener('mouseout', function(){   //  mouseout 시 hover 클래스 삭제
        item.parentElement.classList.remove('drop__hover');
    });
});

const joinMoimDropdownBtn = document.querySelector('#joinMoimDropdownBtn');
const joinMoimDropdownContent = document.querySelector('#joinMoimDropdownContent');
const joinMoimDropdownHeader = document.querySelector('#joinMoimDropdownHeader');

if(joinMoimDropdownBtn) {
    joinMoimDropdownBtn.addEventListener('click', () => {
        joinMoimDropdownContent.classList.toggle('hidden');
        joinMoimDropdownHeader.classList.toggle('drop__selected');
        changeDropBtn(joinMoimDropdownBtn);
    });
}

const bookMarkDropdownBtn = document.querySelector('#bookMarkDropdownBtn');
const bookMarkDropdownContent = document.querySelector('#bookMarkDropdownContent');
const bookMarkDropdownHeader = document.querySelector('#bookMarkDropdownHeader');

if(bookMarkDropdownBtn){
    bookMarkDropdownBtn.addEventListener('click', () => {
        bookMarkDropdownContent.classList.toggle('hidden');
        bookMarkDropdownHeader.classList.toggle('drop__selected');
        changeDropBtn(bookMarkDropdownBtn);
    });
}

const partDropdownBtn_1 = document.querySelector('#partDropdownBtn1');
const partDropdownBtn_2 = document.querySelector('#partDropdownBtn2');
const partDropdownBtn_3 = document.querySelector('#partDropdownBtn3');
const partDropdownContent_1 = document.querySelector('#partDropdownContent1');
const partDropdownContent_2 = document.querySelector('#partDropdownContent2');
const partDropdownContent_3 = document.querySelector('#partDropdownContent3');

if(partDropdownBtn_1){
    partDropdownBtn_1.addEventListener('click', () => {
        partDropdownContent_1.classList.toggle('hidden');

        changeDropBtn(partDropdownBtn_1);
    });
}
if(partDropdownBtn_2){
    partDropdownBtn_2.addEventListener('click', () => {
        partDropdownContent_2.classList.toggle('hidden');
        changeDropBtn(partDropdownBtn_2);
    });
}
if(partDropdownBtn_3){
    partDropdownBtn_3.addEventListener('click', () => {
        partDropdownContent_3.classList.toggle('hidden');
        changeDropBtn(partDropdownBtn_3);
    });
}

function changeDropBtn(item) {
    if(item.firstElementChild.className.includes('fa-angle-down')){
        item.removeChild(item.firstElementChild);
        const i = document.createElement('i');
        i.classList.add('fa-solid', 'fa-angle-up');
        item.appendChild(i);
    } else {
        item.removeChild(item.firstElementChild);
        const i = document.createElement('i');
        i.classList.add('fa-solid', 'fa-angle-down');
        item.appendChild(i);
    }
}