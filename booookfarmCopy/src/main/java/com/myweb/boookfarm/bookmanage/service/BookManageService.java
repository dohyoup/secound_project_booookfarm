package com.myweb.boookfarm.bookmanage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.boookfarm.basket.model.BookBasketDAO;
import com.myweb.boookfarm.basket.model.BookBasketDTO;
import com.myweb.boookfarm.detail.model.BookDetailDAO;
import com.myweb.boookfarm.detail.model.BookDetailDTO;
import com.myweb.boookfarm.locker.model.BookLockerDAO;
import com.myweb.boookfarm.locker.model.BookLockerDTO;
import com.myweb.boookfarm.member.model.MemberDAO;
import com.myweb.boookfarm.member.model.MemberDTO;
import com.myweb.boookfarm.payment.model.OrderDTO;
import com.myweb.boookfarm.payment.model.PaymentDAO;

@Service
public class BookManageService {
	
	@Autowired
	private BookDetailDAO dao;
	
	@Autowired
	private BookBasketDAO basketDao;
	
	@Autowired
	private BookLockerDAO lockerDao;
	
	@Autowired
	private MemberDAO memDao;
	
	@Autowired
	private PaymentDAO paymentDao;
	
	// bookTable 관련
	public BookDetailDTO getData(String bookCode) {
		BookDetailDTO data = dao.getData(bookCode);
		return data;
	}
	
	public List<BookDetailDTO> getDatas() {
		List<BookDetailDTO> datas = dao.getDatas();
		return datas;
	}
	// basketTable 관련
	public BookBasketDTO getBasketData(Map m_id_bookcode_data) {
		BookBasketDTO basketData = basketDao.getBasketData(m_id_bookcode_data);
		return basketData;
	}

	public boolean bookAddData(BookBasketDTO basket_add_data) {
		boolean add_result = basketDao.bookAddData(basket_add_data);
		return add_result;
	}

	public List<BookDetailDTO> getBasketAllData(String memberId) {
		List<BookDetailDTO> BasketAllData = basketDao.getBasketAllData(memberId);
		return BasketAllData;
	}
	
	public boolean basketRemoveData(Map id_bookcode_data) {
		boolean remove_result = basketDao.basketRemoveData(id_bookcode_data);
		return remove_result;
	}

	public boolean basketRemoveSelectData(Map id_bookcode_data) {
		boolean remove_result = basketDao.basketRemoveSelectData(id_bookcode_data);
		return remove_result;
	}
	// lockerTable 관련
	public BookLockerDTO getLockerData(Map id_bookcode_data) {
		BookLockerDTO bookLockerData = lockerDao.getLockerData(id_bookcode_data);
		return bookLockerData;
	}

	public boolean lockerAddData(BookLockerDTO locker_add_data) {
		boolean add_result = lockerDao.lockerAddData(locker_add_data);
		return add_result;
	}

	public List<BookDetailDTO> getAllLockerData(String memberId) {
		List<BookDetailDTO> userLockerData = lockerDao.getAllLockerData(memberId);
		return userLockerData;
	}

	public boolean lockerRemoveData(Map id_bookcode_data) {
		boolean remove_result = lockerDao.lockerRemoveData(id_bookcode_data);
		return remove_result;
	}

	public boolean lockerRemoveSelectData(Map<String, Object> id_bookcode_data) {
		boolean remove_result = lockerDao.lockerRemoveSelectData(id_bookcode_data);
		return remove_result;
	}
	// paymentTable관련

	public List<BookDetailDTO> orderBookDatas(HashMap<String, Object> bookCode) {
		List<BookDetailDTO> bookDatas = dao.orderBookDatas(bookCode);
		return bookDatas;
	}

	public MemberDTO getUserData(String memId) {
		MemberDTO userData = memDao.getMemData(memId);
		return userData;
	}

	public boolean addMileage(Map mileageData) {
		boolean add_result = paymentDao.addMileage(mileageData); 
		return add_result;
	}

	public boolean addOrderData(OrderDTO orderData) {
		boolean add_result = paymentDao.addOrderData(orderData);
		return add_result;
	}

	public List<BookDetailDTO> bookStockData(HashMap<String, Object> bookCodes) {
		List<BookDetailDTO> bookStockDatas = dao.bookStockData(bookCodes);
		return bookStockDatas;
	}

	public boolean updateQuantity(List<Map<String, Object>> bookcode_stock_arr) {
		boolean update_result = dao.updateQuantity(bookcode_stock_arr);
		return update_result;
	}

}
