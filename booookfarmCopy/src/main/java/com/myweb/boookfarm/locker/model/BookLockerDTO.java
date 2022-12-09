package com.myweb.boookfarm.locker.model;

public class BookLockerDTO {
	private int lockerCode;
	private String memberId;
	private String bookCode;
	private int quantity;
	private int deliveryFee;
	
	public int getLockerCode() {
		return lockerCode;
	}
	
	public void setLockerCode(int lockerCode) {
		this.lockerCode = lockerCode;
	}
	
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public String getBookCode() {
		return bookCode;
	}
	
	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public int getDeliveryFee() {
		return deliveryFee;
	}
	
	public void setDeliveryFee(int deliveryFee) {
		this.deliveryFee = deliveryFee;
	}

	@Override
	public String toString() {
		return "BookLockerDTO [lockerCode=" + lockerCode + ", memberId=" + memberId + ", bookCode=" + bookCode
				+ ", quantity=" + quantity + ", deliveryFee=" + deliveryFee + "]";
	}
	
	
}
