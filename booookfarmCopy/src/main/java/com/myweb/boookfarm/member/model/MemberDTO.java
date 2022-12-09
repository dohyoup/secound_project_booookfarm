package com.myweb.boookfarm.member.model;

import java.sql.Date;

public class MemberDTO {
	String memId;
	String memPw;
	String memName;
	String phone;
	String email;
	String postCode;
	String addr;
	String detailAddr;
	String mileage;
	String socialType;
	String memPos;
	Date joinDate;
	
	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemPw() {
		return memPw;
	}

	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}

	public String getMileage() {
		return mileage;
	}

	public void setMileage(String mileage) {
		this.mileage = mileage;
	}

	public String getSocialType() {
		return socialType;
	}

	public void setSocialType(String socialType) {
		this.socialType = socialType;
	}

	public String getMemPos() {
		return memPos;
	}

	public void setMemPos(String memPos) {
		this.memPos = memPos;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	@Override
	public String toString() {
		return "MemberDTO{" +
				"memId='" + memId + '\'' +
				", memPw='" + memPw + '\'' +
				", memName='" + memName + '\'' +
				", phone='" + phone + '\'' +
				", email='" + email + '\'' +
				", postCode='" + postCode + '\'' +
				", addr='" + addr + '\'' +
				", detailAddr='" + detailAddr + '\'' +
				", mileage='" + mileage + '\'' +
				", socialType='" + socialType + '\'' +
				", memPos='" + memPos + '\'' +
				", joinDate=" + joinDate +
				'}';
	}
}
