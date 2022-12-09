package com.myweb.boookfarm.model;



import java.sql.Date;



public class BookDTO {
	private String bookCode;
	private String bookTitle;
	private String bookAuthor;
	private String bookInfo;
	private int bookPrice;
	private int bookDiscount;
	private String isbn;
	private String bookCategory;
	private int stock;
	private String publisher;
	private String bookCondition;
	private String bookConditionInfo;
	private String bookImgPath;
	private int hitCount;
	private String createDate;
	
	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public String getBookCode() {
		return bookCode;
	}
	
	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}
	
	public String getBookTitle() {
		return bookTitle;
	}
	
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	
	public String getBookAuthor() {
		return bookAuthor;
	}
	
	public void setBookAuthor(String bookAuthor) {
		this.bookAuthor = bookAuthor;
	}
	
	public String getBookInfo() {
		return bookInfo;
	}
	
	public void setBookInfo(String bookInfo) {
		this.bookInfo = bookInfo;
	}
	
	public int getBookPrice() {
		return bookPrice;
	}
	
	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}
	
	public int getBookDiscount() {
		return bookDiscount;
	}
	
	public void setBookDiscount(int bookDiscount) {
		this.bookDiscount = bookDiscount;
	}
	
	public String getIsbn() {
		return isbn;
	}
	
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	
	public String getBookCategory() {
		return bookCategory;
	}
	
	public void setBookCategory(String bookCategory) {
		this.bookCategory = bookCategory;
	}
	
	public int getStock() {
		return stock;
	}
	
	public void setStock(int stock) {
		this.stock = stock;
	}
	
	public String getPublisher() {
		return publisher;
	}
	
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	
	public String getBookCondition() {
		return bookCondition;
	}
	
	public void setBookCondition(String bookCondition) {
		this.bookCondition = bookCondition;
	}
	
	public String getBookConditionInfo() {
		return bookConditionInfo;
	}
	
	public void setBookConditionInfo(String bookConditionInfo) {
		this.bookConditionInfo = bookConditionInfo;
	}
	
	public String getBookImgPath() {
		return bookImgPath;
	}
	
	public void setBookImgPath(String bookImgPath) {
		this.bookImgPath = bookImgPath;
	}
	
	public String getCreateDate() {
		 return createDate;
	}
	
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "BookDTO [bookCode=" + bookCode + ", bookTitle=" + bookTitle + ", bookAuthor=" + bookAuthor
				+ ", bookInfo=" + bookInfo + ", bookPrice=" + bookPrice + ", bookDiscount=" + bookDiscount + ", isbn="
				+ isbn + ", bookCategory=" + bookCategory + ", stock=" + stock + ", publisher=" + publisher
				+ ", bookCondition=" + bookCondition + ", bookConditionInfo=" + bookConditionInfo + ", bookImgPath="
				+ bookImgPath + ", hitCount=" + hitCount + ", createDate=" + createDate + "]";
	}
	
	
}
