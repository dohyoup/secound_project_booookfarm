package com.myweb.boookfarm.model;

import java.util.ArrayList;
import java.util.List;

public class PagingDTO {

    private int offset; //시작위치
	private int limit;  //한 페이지에 보여줄 목록 수 제한
	private int currentPageNumber; // 현재 페이지
	private int nextPageNumber;  //다음페이지
	private int prevPageNumber; //이전페이지
	private List<Integer>  pageNumberList; //페이지 목록
	private List<Integer>  totalPageList;
	private List<Integer>  pageList; //페이지 목록
	private List<Object> pageData; //ex)첫번째 페이지에 출력하는 실제데이타
	
	public PagingDTO(List<Object> datas , int currentPageNumber,int limit) {
		
		
		
		this.offset = limit * (currentPageNumber - 1);
		this.limit = limit;
		this.currentPageNumber = currentPageNumber;
		this.nextPageNumber = currentPageNumber + 1;
		this.prevPageNumber = currentPageNumber - 1;
		int pageNum = 1;
		this.pageNumberList = new ArrayList<Integer>();
		for(int i = 0; i < datas.size(); i += limit) { //limit의수를 더해서 i에 넣어라 (증감식), 즉limit가 3일때는 3씩증가
			//datas.size()가 7일경우 3번반복 (i:0,3,6)
			//페이징 datas.size(),limit필요
		
			
			this.pageNumberList.add(pageNum++); //페이지 목록 번호나오게하는거
			//pageNum을 먼저 사용한후에 1증가라는 의미
			//pageNum:1먼저사용한후에(pageNumberList에 1추가) +1더해서 pageNumberList에 1추가시켜줌
			//3번반복시켰으므로 최종 pageNumberList에 [1,2,3]이 추가됨
			
		}
		
		//더한max값이 datas.size() 보다 크면 에러가 발생하기떄문에 에러안나게 코드추가
		//ex)예를들어 datas list에는 10개밖에 없는데 limit값을 30으로 지정하면,  datas.subList()해줬을때 범위를 넘어가기때문에 자를수가 없기때문에 에러가 발생한다. 
		int max = this.offset + this.limit; 
		max = max < datas.size() ? max : datas.size();
		//list에서 일부분을 자를경우사용,max앞에값사용
		this.pageData = datas.subList(this.offset, max);
		
		
		
	}
	
    public PagingDTO(int total_cnt , int currentPageNumber,int limit) {
    	int pageCount = 5;
		this.offset = limit * (currentPageNumber - 1); // 5 * (10 -1) = 45
		this.limit = limit;
		this.currentPageNumber = currentPageNumber;
		this.nextPageNumber = currentPageNumber + 1;
		this.prevPageNumber = 1 > currentPageNumber - 1 ? 1 : currentPageNumber - 1;
		int pageNum = 1 + (((currentPageNumber - 1) / pageCount) * pageCount);
		this.pageList = new ArrayList<Integer>();
		this.totalPageList = new ArrayList<Integer>();
		int cnt = 1;
		for (int i = 0; i < total_cnt; i += limit) { //limit의수를 더해서 i에 넣어라 (증감식), 즉limit가 3일때는 3씩증가
			if (cnt <= pageCount) {
				this.pageList.add(pageNum); //페이지 목록 번호나오게하는거
			}
			this.totalPageList.add(pageNum);
			pageNum++;
			cnt++;
			if (pageNum > (int) Math.ceil((float)total_cnt / (float)limit)) {
				break;
			}
		}
	}
	
	
	public int getOffset() {
		return offset;
	}
	
	public int getLimit() {
		return limit;
	}
	
	public int getCurrentPageNumber() {
		return currentPageNumber;
	}
	
	public int getNextPageNumber() {
		return nextPageNumber;
	}
	
	public int getPrevPageNumber() {
		return prevPageNumber;
	}
	
	public List<Integer> getPageNumberList() {
		return pageNumberList;
	}
	
	public List<Integer> getPageList() {
		return pageList;
	}
	
	public List<Integer> getPageNumberList(int start , int end) {//페이지일부분만 보여주는거 ex)100page다 보여줄수는 없으니깐 5페이지씩 보여줘라 이런식으로 만들어주기만든 메서드
		//실제 필요한 번호만 가르는 경우
		//ex)1~5 페이지까지 출력시키는경우 
		//start는 0번 인덱스가 되어야하기때문에 -1 , end에 -1 안한이유는 그 전까지만 추출된다. 즉 인덱스4에서 잘림
		//board.jsp에서 -2 ,+2한 값이 범위를 넘어갔을경우 해결해주기위한 코드 추가
		start = start > 0 ? start : 1;
		end = end < this.pageNumberList.size() ? end : this.pageNumberList.size();
		return pageNumberList.subList(start - 1, end);
	}
	
	
	public List<Object> getPageData() {
		return pageData;
	}
	
	public boolean hasNextPage() { //다음페이지가 있나없나 알기위한 메서드
		//ex)nextPageNumber가 6일떄  pageNumberList에 6을 포함하고 있느냐 없느냐
		//pageNumberList에는 이미 총 페이지수가 저장되어있음
		return this.pageNumberList.contains(this.nextPageNumber);
	}
	public boolean isNextPage() {
		return this.totalPageList.contains(this.nextPageNumber);
	}
	public boolean hasPrevPage() { //이전페이지가 있나없나 알기위한 메서드
		//ex)prevPageNumber가 1일떄  pageNumberList에 1보다 이전페이지를 포함하고 있느냐 없느냐 
		//pageNumberList에는 이미 총 페이지수가 저장되어있음
		return this.pageNumberList.contains(this.prevPageNumber);
	}
	public boolean isPrevPage() { 
		return this.prevPageNumber <= 1 ? false : this.totalPageList.contains(this.prevPageNumber);
	}


}
