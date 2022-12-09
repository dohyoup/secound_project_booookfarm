package com.myweb.boookfarm;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.myweb.boookfarm.basket.model.BookBasketDTO;
import com.myweb.boookfarm.bookmanage.service.BookManageService;
import com.myweb.boookfarm.detail.model.BookDetailDTO;
import com.myweb.boookfarm.locker.model.BookLockerDTO;
import com.myweb.boookfarm.member.model.MemberDTO;
import com.myweb.boookfarm.payment.model.OrderDTO;

@Controller
public class BookManageController {
	
	@Autowired
	private BookManageService service;
	
	@GetMapping(value="/detail", produces="application/json; charset=utf-8")
	public String detailView(@RequestParam("bookcode") String bookCode, Model model) {
		BookDetailDTO data = service.getData(bookCode);
		model.addAttribute("book_code", bookCode);
		model.addAttribute("book_info", data);
		return "detail/detail";
	}
	
	@GetMapping(value = "/view",produces="application/json; charset=utf-8")
	@ResponseBody
	public String detail(@RequestParam("bookCode") String bookCode) {
		BookDetailDTO data = service.getData(bookCode);
		JSONObject json = new JSONObject();
			json.put("bookCode", data.getBookCode());
			json.put("bookTitle", data.getBookTitle());
			json.put("bookAuthor", data.getBookAuthor());
			json.put("bookInfo", data.getBookInfo());
			json.put("bookPrice", data.getBookPrice());
			json.put("bookDiscount", data.getBookDiscount());
			json.put("isbn", data.getIsbn());
			json.put("bookCategory", data.getBookCategory());
			json.put("stock", data.getStock());
			json.put("publisher", data.getPublisher());
			json.put("bookCondition", data.getBookCondition());
			json.put("bookConditionInfo", data.getBookConditionInfo());
			json.put("bookImgPath", data.getBookImgPath());
			json.put("createDate", data.getCreateDate());
		
		return json.toString();
	}
	
	@GetMapping(value = "/detail-list",produces="application/json; charset=utf-8")
	@ResponseBody
	public String detailList() {
		List<BookDetailDTO> dataList = service.getDatas();
		JSONArray data_arr = new JSONArray();
		JSONObject list_data = new JSONObject();
		for(BookDetailDTO bookList : (List<BookDetailDTO>) dataList) {
			JSONObject json = new JSONObject();
			json.put("bookCode", bookList.getBookCode());
			json.put("bookTitle", bookList.getBookTitle());
			json.put("bookAuthor", bookList.getBookAuthor());
			json.put("bookInfo", bookList.getBookInfo());
			json.put("bookPrice", bookList.getBookPrice());
			json.put("bookDiscount", bookList.getBookDiscount());
			json.put("isbn", bookList.getIsbn());
			json.put("bookCategory", bookList.getBookCategory());
			json.put("stock", bookList.getStock());
			json.put("publisher", bookList.getPublisher());
			json.put("bookCondition", bookList.getBookCondition());
			json.put("bookConditionInfo", bookList.getBookConditionInfo());
			json.put("bookImgPath", bookList.getBookImgPath());
			data_arr.add(json);
		}
		
		list_data.put("dataList", data_arr);
		return list_data.toString();
	}
	
	//장바구니 기능 부분
	@RequestMapping(value = "/basket", method = RequestMethod.GET)
	public String basketView(Model model) {

		return "basket/basket";
	}
	
	@PostMapping(value = "/basket-info",produces="application/json; charset=utf-8")
	@ResponseBody
	public String basketAddList (@RequestBody BookDetailDTO parm
			,HttpSession httpSession) throws Exception {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		JSONObject json = new JSONObject();
		Map id_bookcode_data = new HashMap();
		id_bookcode_data.put("memberId", memData.getMemId());
		id_bookcode_data.put("bookCode", parm.getBookCode());
		BookBasketDTO bookBasketData = service.getBasketData(id_bookcode_data); //북코드로 책정보가 장바구니에 존재하는지 확인
		BookBasketDTO basket_add_data = new BookBasketDTO();
		basket_add_data.setMemberId(memData.getMemId()); // 로그인 데이타에서 받아와야함
		basket_add_data.setBookCode(parm.getBookCode());
		basket_add_data.setQuantity(parm.getStock()); 
		basket_add_data.setDeliveryFee(3000); // 배달비는 3천원 고정 산간지역은 추후 추가
		if(bookBasketData == null) {//장바구니에 존재하지 않는 책정보면 INSERT작업
			boolean add_result = service.bookAddData(basket_add_data);
			json.put("code", "success");
			return json.toString();
		}else {
			json.put("code", "fail");
			return json.toString();
		}
	}
	
	@GetMapping(value = "/basket-info",produces="application/json; charset=utf-8")
	@ResponseBody
	public String basketSelectList(HttpSession httpSession)  {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		List<BookDetailDTO> Basket_all_book_Data = service.getBasketAllData(memData.getMemId());// 로그인 아이디에 맞는 모든 장바구니 리스트
		JSONArray data_arr = new JSONArray();
		JSONObject list_data = new JSONObject();
		for(BookDetailDTO bookList : (List<BookDetailDTO>) Basket_all_book_Data) {
			JSONObject json = new JSONObject();
			json.put("bookCode", bookList.getBookCode());
			json.put("bookTitle", bookList.getBookTitle());
			json.put("bookAuthor", bookList.getBookAuthor());
			json.put("bookInfo", bookList.getBookInfo());
			json.put("bookPrice", bookList.getBookPrice());
			json.put("bookDiscount", bookList.getBookDiscount());
			json.put("isbn", bookList.getIsbn());
			json.put("bookCategory", bookList.getBookCategory());
			json.put("stock", bookList.getStock());
			json.put("publisher", bookList.getPublisher());
			json.put("bookCondition", bookList.getBookCondition());
			json.put("bookConditionInfo", bookList.getBookConditionInfo());
			json.put("bookImgPath", bookList.getBookImgPath());
			data_arr.add(json);
		}
		list_data.put("dataList", data_arr);
		return list_data.toString();
	}

	@PostMapping(value = "/basket-remove-list" ,produces="application/json; charset=utf-8")
	@ResponseBody
	public String basketRemoveList(@RequestBody String bookCode
			, HttpSession httpSession) {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		Map id_bookcode_data = new HashMap();
		id_bookcode_data.put("memberId", memData.getMemId());
		id_bookcode_data.put("bookCode", bookCode);
		JSONObject json = new JSONObject();
		boolean remove_result = service.basketRemoveData(id_bookcode_data);
		if(remove_result == true) {
			json.put("code", "success");
			return json.toString();
		}else {
			json.put("code", "fail");
			return json.toString();
		}
	}

	@PostMapping(value = "/basket-remove-selection" ,produces="application/json; charset=utf-8")
	@ResponseBody
	public String basketRemoveSelection(@RequestBody Map<String, Object> id_bookcode_data
			, HttpSession httpSession)throws Exception {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		id_bookcode_data.put("memberId", memData.getMemId());
		JSONObject json = new JSONObject();
		boolean remove_result = service.basketRemoveSelectData(id_bookcode_data);
		if(remove_result == true) {
			json.put("code", "success");
			return json.toString();
		}else {
			json.put("code", "fail");
			return json.toString();
		}
	}

	@PostMapping(value ="/locker-add-list" , produces="application/json; charset=utf-8")
	@ResponseBody
	public String lockerAddList(@RequestBody Map<String, String> parm, HttpSession httpSession) {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		Map id_bookcode_data = new HashMap();
		JSONObject json = new JSONObject();
		id_bookcode_data.put("memberId", memData.getMemId());
		id_bookcode_data.put("bookCode", parm.get("bookCode"));
		BookLockerDTO bookLockerData = service.getLockerData(id_bookcode_data);
		BookLockerDTO locker_add_data = new BookLockerDTO();
		locker_add_data.setMemberId( memData.getMemId());
		locker_add_data.setBookCode(parm.get("bookCode"));
		locker_add_data.setQuantity(Integer.parseInt(parm.get("stock")));
		locker_add_data.setDeliveryFee(3000);
		if(bookLockerData == null) {
			boolean add_result = service.lockerAddData(locker_add_data);
			json.put("code", "success");
			return json.toString();
		}else{
			json.put("code", "fail");
			return json.toString();
		}
	}

	//보관함 부분
	@RequestMapping(value = "/locker", method = RequestMethod.GET)
	public String lockerView(Locale locale, Model model) {
		
		return "basket/locker";
	}

	//여기서부터 구현
	@PostMapping(value = "/locker-info",produces="application/json; charset=utf-8")
	@ResponseBody
	public String lockerSelectList(HttpSession httpSession)  {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		List<BookDetailDTO> user_locker_data = service.getAllLockerData(memData.getMemId());
		JSONArray data_arr = new JSONArray();
		JSONObject list_data = new JSONObject();
		for(BookDetailDTO bookList : (List<BookDetailDTO>) user_locker_data) {
			JSONObject json = new JSONObject();
			json.put("bookCode", bookList.getBookCode());
			json.put("bookTitle", bookList.getBookTitle());
			json.put("bookAuthor", bookList.getBookAuthor());
			json.put("bookInfo", bookList.getBookInfo());
			json.put("bookPrice", bookList.getBookPrice());
			json.put("bookDiscount", bookList.getBookDiscount());
			json.put("isbn", bookList.getIsbn());
			json.put("bookCategory", bookList.getBookCategory());
			json.put("stock", bookList.getStock());
			json.put("publisher", bookList.getPublisher());
			json.put("bookCondition", bookList.getBookCondition());
			json.put("bookConditionInfo", bookList.getBookConditionInfo());
			json.put("bookImgPath", bookList.getBookImgPath());
			data_arr.add(json);
		}
		list_data.put("dataList", data_arr);
		return list_data.toString();
	}

	@PostMapping(value = "/locker-remove-list" ,produces="application/json; charset=utf-8")
	@ResponseBody
	public String lockerRemoveList(@RequestBody String bookCode, HttpSession httpSession) {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		Map id_bookcode_data = new HashMap();
		id_bookcode_data.put("memberId", memData.getMemId());
		id_bookcode_data.put("bookCode", bookCode);
		JSONObject json = new JSONObject();
		boolean remove_result = service.lockerRemoveData(id_bookcode_data);
		if(remove_result == true) {
			json.put("code", "success");
			return json.toString();
		}else {
			json.put("code", "fail");
			return json.toString();
		}
	}

	@PostMapping(value = "/locker-remove-selection" ,produces="application/json; charset=utf-8")
	@ResponseBody
	public String lockerRemoveSelection(@RequestBody Map<String, Object> id_bookcode_data
			, HttpSession httpSession)throws Exception {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		id_bookcode_data.put("memberId",  memData.getMemId());
		JSONObject json = new JSONObject();
		boolean remove_result = service.lockerRemoveSelectData(id_bookcode_data);
		if(remove_result == true) {
			json.put("code", "success");
			return json.toString();
		}else {
			json.put("code", "fail");
			return json.toString();
		}
	}

	//결제페이지 부분
	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String payment(Locale locale, Model model) {
	
		return "basket/payment";
	}
	
	//결제페이지 부분
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String payment_post(HttpServletRequest request, Model model, HttpSession httpSession ) {
		MemberDTO memData = (MemberDTO) httpSession.getAttribute("loginData");
		MemberDTO userData = service.getUserData(memData.getMemId());
		String[] bookCheck = request.getParameterValues("bookCheck[]");
		String[] sctockCheck = request.getParameterValues("stockCheck[]");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0; i < bookCheck.length; i++) {
			if(bookCheck[i].length() > 1) {
				Map<String, Object> temp = new HashMap<String, Object>();
				temp.put("bookCode", bookCheck[i]);
				temp.put("stock", sctockCheck[i]);
				list.add(temp);
			}
		}
		HashMap<String, Object> bookCode = new HashMap<String, Object>();
		bookCode.put("bookCode", bookCheck);
		List<BookDetailDTO> bookDatas = service.orderBookDatas(bookCode);
		JSONArray json_arr = new JSONArray();
		JSONArray stock_arr = new JSONArray();
		JSONObject list_data = new JSONObject();
		for(BookDetailDTO bookList : (List<BookDetailDTO>)bookDatas) {
			JSONObject json = new JSONObject();
			for(int i = 0 ; i < list.size() ; i++) {
				if (list.get(i).get("bookCode").equals(bookList.getBookCode())) {
					json.put("sel_stock", list.get(i).get("stock"));
				}
			}
			json.put("bookCode", bookList.getBookCode());
			json.put("bookTitle", bookList.getBookTitle());
			json.put("bookAuthor", bookList.getBookAuthor());
			json.put("bookInfo", bookList.getBookInfo());
			json.put("bookPrice", bookList.getBookPrice());
			json.put("bookDiscount", bookList.getBookDiscount());
			json.put("isbn", bookList.getIsbn());
			json.put("bookCategory", bookList.getBookCategory());
			json.put("stock", bookList.getStock());
			json.put("publisher", bookList.getPublisher());
			json.put("bookCondition", bookList.getBookCondition());
			json.put("bookConditionInfo", bookList.getBookConditionInfo());
			json.put("bookImgPath", bookList.getBookImgPath());
			json_arr.add(json);
		}
		list_data.put("dataList", json_arr);
		model.addAttribute("bookCode", list_data);
		model.addAttribute("userData", userData);
		return "basket/payment";
	}
	
	@RequestMapping(value = "/order-info", method = RequestMethod.POST)
	@ResponseBody
	public String orderData(@RequestBody Map<String, String> parm) {
		//결제시 로그인 계정에 마일리지 적립
		Map mileageData = new HashMap();
			mileageData.put("mileage",parm.get("mileage"));
			mileageData.put("memberId",parm.get("memId"));
		boolean result = service.addMileage(mileageData);
		//주문정보 테이블에 결제 정보 저장
		OrderDTO orderData = new OrderDTO();
			orderData.setOrderCode(parm.get("orderNum"));
			orderData.setBookCode(parm.get("bookCode"));
			orderData.setBookTitle(parm.get("bookTitle"));
			orderData.setQuantity(parm.get("quantity"));
			orderData.setUseMileage(Integer.valueOf(parm.get("useMileage")));
			orderData.setSaveMileage(Integer.valueOf(parm.get("mileage")));
			orderData.setOrderPrice(Integer.valueOf(parm.get("price")));
			orderData.setMemId(parm.get("memId"));
			orderData.setPostalCode(parm.get("postCode"));
			orderData.setAddress(parm.get("addr"));
			orderData.setDetailAddress(parm.get("detailAddr"));
			orderData.setPhone(parm.get("phone"));
			orderData.setDeliveryFee(3000);
		boolean add_result = service.addOrderData(orderData);
		//주문한 상품 수량만큼 재고 차감 후 다시 업데이트
		List<String> bookCodeArr =Arrays.asList(parm.get("bookCode").split(","));
		List<String> stockArr = Arrays.asList(parm.get("quantity").split(","));
		List<Map<String, Object>> bookcode_stock_arr = new ArrayList<Map<String,Object>>();
		for(int i = 0 ; i < bookCodeArr.size() ; i++) {
			Map<String, Object> stock_obj = new HashMap<String, Object>();
			stock_obj.put("bookcode", bookCodeArr.get(i));
			stock_obj.put("stock", stockArr.get(i));
			bookcode_stock_arr.add(stock_obj);
		}
		HashMap<String, Object> bookCode = new HashMap<String, Object>();
		bookCode.put("bookCodes", bookCodeArr);
		List<BookDetailDTO> bookStockDatas = service.bookStockData(bookCode);
		int bookStock = 0;
		for(BookDetailDTO bookDatas : bookStockDatas) {
			//디비에서 가져온값 - 프론트에서 온값
			for(Map<String, Object> bookcode_stock : bookcode_stock_arr) {
				if (bookDatas.getBookCode().equals(bookcode_stock.get("bookcode"))) {
					bookStock = bookDatas.getStock() - Integer.valueOf((String)bookcode_stock.get("stock"));
					bookcode_stock.replace("stock", bookStock);
				}
			}
		}
		boolean update_result = service.updateQuantity(bookcode_stock_arr);
		
		return "basket/payment";
	}
	
	//결제완료 페이지 부분
	@RequestMapping(value = "/cancle", method = RequestMethod.POST)
	public String cancle(HttpServletRequest request, Model model, HttpSession httpSession ) {
		return "";	
	}
}