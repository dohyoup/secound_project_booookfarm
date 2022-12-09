package com.myweb.boookfarm.basket.model;

public class BookBasketDTO {
	private int basketCode;
	private String memberId;
	private String bookCode;
	private int quantity;
	private int deliveryFee;
	
	public int getBasketCode() {
		return basketCode;
	}
	
	public void setBasketCode(int basketCode) {
		this.basketCode = basketCode;
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
		return "BookBasketDTO [basketCode=" + basketCode + ", memberId=" + memberId + ", bookCode=" + bookCode
				+ ", quantity=" + quantity + ", deliveryFee=" + deliveryFee + "]";
	}
	
	
}
