package com.myweb.boookfarm.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.boookfarm.model.BookDAO;
import com.myweb.boookfarm.model.BookDTO;
import com.myweb.boookfarm.model.PagingDTO;

@Service
public class BookfarmService {
	
	@Autowired
	private BookDAO dao;

	public BookDTO getData(String BCode) {
		BookDTO datas = dao.getData(BCode);
		return datas;
	}


	public Map<String,Object> getAll(int page, int limit, String sortType, String searchBook,String searchType,String categoryId) {
		int countPage = 5;
		int num_start = ((page-1) * limit) + 1;
		int num_end   = (page * limit);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("num_start", num_start);
		map.put("num_end", num_end);
		map.put("sort_Type", sortType);
		map.put("search_Data", searchBook);
		map.put("search_Type", searchType);
		map.put("category_Type", categoryId);
		if (map.get("category_Type").equals("전체보기") ) {
			map.put("category_Type", "");
		}
		List<BookDTO> datas = dao.selectAll(map);
		int total = dao.getDataCnt(map);
		PagingDTO pager = new PagingDTO(total, page, limit);
		Map res_data = new HashMap<String, Object>();
		res_data.put("datas", datas);
		res_data.put("page_data", pager);
		return res_data;
	}


	public String selectBookBasketList(List<String> bookCode, String memberId) {
		String result = dao.selectBookBasketList(bookCode, memberId);
		return result ;
	}


	public boolean addBook(BookDTO addtest) {
		boolean result = dao.addBook(addtest);
		return result;
	}


	public void increaseHitCount(String bookCode) {
		dao.increaseHitCount(bookCode);
	}





	
}
