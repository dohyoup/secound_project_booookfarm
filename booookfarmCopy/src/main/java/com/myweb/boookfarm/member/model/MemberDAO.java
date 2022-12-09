package com.myweb.boookfarm.member.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSession session;
	
	private String mapper = "memberMapper.%s";

	public MemberDTO getMemData(String memId) {
		String mapperId = String.format(mapper, "selectMemData");
		MemberDTO memData = session.selectOne(mapperId, memId);

		return memData;
	}

	/**
	 * DB에서 요청한 로그인 정보와 일치하는 회원 정보를 찾는 메서드
	 * @param reqLoginData	요청한 로그인 정보
	 * @return DB에서 찾은 회원 정보 반환
	 */
	public MemberDTO getLoginData(MemberDTO reqLoginData) {
		String mapperId = String.format(mapper, "selectLoginData");
		MemberDTO loginData = session.selectOne(mapperId, reqLoginData);

		return loginData;
	}

	/**
	 *  DB에서 id와 일치하는 member_id를 찾는 메서드
	 * @param id DB에서 찾을 id
	 * @return DB에서 찾은 member_id 반환
	 */
    public String getMemId(String id) {
		String mapperId = String.format(mapper, "selectMemId");
		String memId = session.selectOne(mapperId, id);

		return memId;
    }

	/**
	 *  DB에서 phone과 일치하는 phone을 찾는 메서드
	 * @param phoneData DB에서 찾을 phone
	 * @return DB에 phone이 없으면 0 반환 있을 경우 갯수 반환
	 */
	public int chkPhoneDup(Map<String, String> phoneData) {
		String mapperId = String.format(mapper, "chkPhoneDup");
		int result = session.selectOne(mapperId, phoneData);

		return result;
	}

	/**
	 * DB에 회원정보를 추가하는 메서드
	 * @param newMem 요청한 회원정보
	 * @return 요청 결과(성공시 1) 반환
	 */
	public int addMemData(MemberDTO newMem) {
		String mapperId = String.format(mapper, "insertMemData");
		int result = session.insert(mapperId, newMem);
		return result;
	}


}
