package com.myweb.boookfarm.member.service;

import com.myweb.boookfarm.member.model.MemberDAO;
import com.myweb.boookfarm.member.model.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	public MemberDTO getMemData(String memId) {
		MemberDTO data = dao.getMemData(memId);
		return data;
	}

	/**
	 * 로그인 데이터 요청 메서드
	 * @param loginId 요청 로그인 id
	 * @param loginPw 요청 로그인 pw
	 * @return 로그인 데이터 반환
	 */
	public MemberDTO getLoginData(String loginId, String loginPw) {
		MemberDTO reqLoginData = new MemberDTO();
		reqLoginData.setMemId(loginId);
		reqLoginData.setMemPw(loginPw);
		MemberDTO loginData = dao.getLoginData(reqLoginData);
		return loginData;
	}


	/**
	 *  DAO에 id와 일치하는 member_id를 요청하는 메서드
	 * @param id DB에서 찾을 id
	 * @return DAO에서 받은 member_id 반환
	 */
	public String getMemId(String id) {
		String data = dao.getMemId(id);
		return data;
	}

	/**
	 *  phone 중복 체크 메서드
	 * @param phoneData 중복 체크할 phone
	 * @return 중복이면 true 아니면 false 반환
	 */
	public Boolean chkPhoneDup(Map<String, String> phoneData) {
		int result = dao.chkPhoneDup(phoneData);
		return result == 0 ? false : true;
	}

	/**
	 *  ID 중복 체크 메서드
	 * @param id 중복 체크할 id
	 * @return 중복이면 true 아니면 false 반환
	 */
	public boolean chkIdDup(String id) {
		boolean result = false;
		if(getMemId(id) != null) {
			result = getMemId(id).equals(id) ? true : false;
		}
		return result;
	}

	/**
	 *  회원가입 요청 메서드
	 * @param newMem 회원가입 요청헌 회원정보
	 * @return 회원가입 성공시 true, 실패시 false 반환
	 */
	public boolean addMemData(MemberDTO newMem) {
		int result = dao.addMemData(newMem);
		return result == 1 ? true : false;
	}


}
