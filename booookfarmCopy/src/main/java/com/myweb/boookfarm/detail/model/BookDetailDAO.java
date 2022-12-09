package com.myweb.boookfarm.detail.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myweb.boookfarm.basket.model.BookBasketDTO;

@Repository
public class BookDetailDAO {
	@Autowired
	private SqlSession session;
	
	private String mapper = "bookManageMapper.%s";
	
	
	public BookDetailDTO getData(String bookCode) {
		String mapperId = String.format(mapper, "selectData");
		BookDetailDTO data = session.selectOne(mapperId, bookCode);
		return data;
	}
	
	public List<BookDetailDTO> getDatas(){
		String mapperId = String.format(mapper, "selectSort");
		List<BookDetailDTO> datas = session.selectList(mapperId);
		return datas;
	}

	public List<BookDetailDTO> orderBookDatas(HashMap<String, Object> bookCode) {
		String mapperId = String.format(mapper, "selectOrderBookData");
		List<BookDetailDTO> orderBookData = session.selectList(mapperId, bookCode);
		return orderBookData;
	}

	public List<BookDetailDTO> bookStockData(HashMap<String, Object> bookCodes) {
		String mapperId = String.format(mapper, "selectBookStocksData");
		List<BookDetailDTO> bookStockDatas = session.selectList(mapperId, bookCodes);
		return bookStockDatas;
	}

	public boolean updateQuantity(List<Map<String, Object>> bookcode_stock_arr) {
		String mapperId = String.format(mapper, "updateQuantity");
		int update_result = session.update(mapperId, bookcode_stock_arr);
		return update_result >= 1 ? true : false;
	}

}
