package com.myweb.boookfarm.model;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;




@Repository
public class BookDAO {
	
	@Autowired
	private SqlSession session;
	
	private String mapper = "bookTestMapper.%s";

	public BookDTO getData(String BCode) {
		String mapperId = String.format(mapper, "selectData");
		BookDTO datas = session.selectOne(mapperId,BCode);
		return datas;
	}

	public int getDataCnt(Map<String, Object> map) {
		String mapperId = String.format(mapper, "selectCnt");
		int datas = session.selectOne(mapperId,map);
		return datas;
	}

	public List<BookDTO> selectAll(Map<String, Object> map) {
		String mapperId = String.format(mapper, "selectAll");
		List<BookDTO> datas = session.selectList(mapperId, map); 
		return datas;
	}

	public String selectBookBasketList(List<String> bookCode, String memberId) {
		
		 String result = "";
		 
		  String mapperId = String.format(mapper, "selectBookList"); 
		  String addMapperId =String.format(mapper, "insertBook");
		  
		  if (bookCode == null) {
			return "false";
		}
		  
		  for(String m : bookCode) {
		  
		  Map<String, Object> map = new HashMap<String, Object>();
		  
		  map.put("bookCode", m);
		  map.put("memberId", memberId); 
		  
		 String param = session.selectOne(mapperId, map);
		  
		  if(param == null) { 
			  session.insert(addMapperId, map); 
			  result = "true";
			  }else {
				  result = "false"; 
				  } 
		  }
		return "true";

	}

	public boolean addBook(BookDTO addtest) {
		String mapperId = String.format(mapper, "addBookInfo");
		int res = session.insert(mapperId,addtest);

		if(res == 1) {
			return true;
		}
		return false;
	}

	public void increaseHitCount(String bookCode) {
		String mapperId = String.format(mapper, "increaseHitCount");
		session.update(mapperId,bookCode);
	}

}
