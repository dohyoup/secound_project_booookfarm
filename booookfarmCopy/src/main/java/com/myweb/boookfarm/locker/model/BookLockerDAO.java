package com.myweb.boookfarm.locker.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myweb.boookfarm.detail.model.BookDetailDTO;

@Repository
public class BookLockerDAO {
	@Autowired
	private SqlSession session;
	
	private String mapper = "bookManageMapper.%s";

	public BookLockerDTO getLockerData(Map id_bookcode_data) {
		String mapperId = String.format(mapper, "selectLockerData");
		BookLockerDTO bookLockerData = session.selectOne(mapperId, id_bookcode_data);
		return bookLockerData;
	}

	public boolean lockerAddData(BookLockerDTO locker_add_data) {
		String mapperId = String.format(mapper, "insertLockerData");
		int add_result = session.insert(mapperId, locker_add_data);
		return add_result == 1 ? true : false;
	}

	public List<BookDetailDTO> getAllLockerData(String memberId) {
		String mapperId = String.format(mapper, "selectAllLockerData");
		List<BookDetailDTO> userLockerData = session.selectList(mapperId, memberId);
		return userLockerData;
	}

	public boolean lockerRemoveData(Map id_bookcode_data) {
		String mapperId = String.format(mapper, "removeLockerData");
		int remove_result = session.delete(mapperId, id_bookcode_data);
		return remove_result == 1 ? true : false;
	}

	public boolean lockerRemoveSelectData(Map<String, Object> id_bookcode_data) {
		String mapperId = String.format(mapper, "removeLockerCheckData");
		int remove_result = session.delete(mapperId, id_bookcode_data);
		return remove_result >= 1 ? true : false;
	}

}
