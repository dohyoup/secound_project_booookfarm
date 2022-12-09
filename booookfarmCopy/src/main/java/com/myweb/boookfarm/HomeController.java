package com.myweb.boookfarm;

import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.myweb.boookfarm.basket.model.BookBasketDTO;
import com.myweb.boookfarm.bookmanage.service.BookManageService;
import com.myweb.boookfarm.detail.model.BookDetailDTO;
import com.myweb.boookfarm.member.model.MemberDTO;
import com.myweb.boookfarm.model.BookDTO;
import com.myweb.boookfarm.model.PagingDTO;
import com.myweb.boookfarm.service.BookfarmService;


@Controller
public class HomeController {
	
	@Autowired
	private BookfarmService service;
	
	@Autowired
	private BookManageService ManageService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "standard/standard";
	}
	
	@GetMapping(value="/main-detail", produces="application/json; charset=utf-8")
	public String detailView(@RequestParam("bookcode") String bookCode, Model model
			 ) {
		BookDetailDTO data = ManageService.getData(bookCode);
		service.increaseHitCount(bookCode);
		
		model.addAttribute("book_code", bookCode);
		model.addAttribute("book_info", data);
		return "detail/detail";
	}
	
	@GetMapping(value = "/list",produces="application/json; charset=utf-8")
	@ResponseBody
	public String bookList( Model model,
			@RequestParam(defaultValue = "1", required = false) int page //현재페이지
			,@RequestParam("page_count")int pagecount
			,@RequestParam("page_sort")String listSort
			,@RequestParam("search_data")String searchBook
			,@RequestParam("search_sort")String searchType
			,@RequestParam("category_select")String categoryId) {
		//등록된 모든 책 리스트
		Map res_data = service.getAll(page, pagecount,listSort,searchBook,searchType,categoryId);
		List datas = (List) res_data.get("datas"); // 가져온 데이터 리스트
		PagingDTO pager = (PagingDTO) res_data.get("page_data"); // 가져온 페이징 객체
		JSONArray data_arr = new JSONArray(); // 가져온 데이터 리스트를 넣는 배열
		JSONObject page_obj = new JSONObject(); // 가져온 페이징 데이터를 넣는 객체
		JSONObject rtn_data = new JSONObject(); // 결과값
		for (BookDTO bfarm : (List<BookDTO>) datas) {
			JSONObject json = new JSONObject();
			json.put("bookCode", bfarm.getBookCode());
			json.put("bookTitle", bfarm.getBookTitle());
			json.put("bookAuthor", bfarm.getBookAuthor());
			json.put("bookPrice", bfarm.getBookPrice());
			json.put("bookDiscount", bfarm.getBookDiscount());
			json.put("isbn", bfarm.getIsbn());
			json.put("bookCategory", bfarm.getBookCategory());
			json.put("publisher", bfarm.getPublisher());
			json.put("bookCondition", bfarm.getBookCondition());
			json.put("bookConditionInfo", bfarm.getBookConditionInfo());
			json.put("bookImgPath", bfarm.getBookImgPath());
			json.put("bookInfo", bfarm.getBookInfo());
			json.put("hitCount", bfarm.getHitCount());
			json.put("createDate", bfarm.getCreateDate());
			data_arr.add(json);
		}
		page_obj.put("c_page", pager.getCurrentPageNumber());
		page_obj.put("pagelist", pager.getPageList());
		page_obj.put("n_page", pager.getNextPageNumber());
		page_obj.put("p_page", pager.getPrevPageNumber());
		page_obj.put("is_npage", pager.isNextPage());
		page_obj.put("is_ppage", pager.isPrevPage());
		rtn_data.put("datas", data_arr);
		rtn_data.put("pager", page_obj);
		model.addAttribute("book__infos",data_arr);
		
		
		
		return rtn_data.toJSONString();
	}

	
	@PostMapping(value = "/basket-main-infoo",produces="application/json; charset=utf-8")
	@ResponseBody
	public String basketAddList (@RequestBody BookDTO BCode) throws Exception {
		JSONObject json = new JSONObject();
		BookDTO datas = service.getData(BCode.getBookCode());
		Map m_id_bookcode_data = new HashMap();
		m_id_bookcode_data.put("memberId", "user01");
		m_id_bookcode_data.put("bookCode", datas.getBookCode());
		BookBasketDTO MbookBasketData = ManageService.getBasketData(m_id_bookcode_data); //북코드로 책정보가 장바구니에 존재하는지 확인
		BookBasketDTO Mbasket_add_data = new BookBasketDTO();
		Mbasket_add_data.setMemberId("user01"); // 로그인 데이타에서 받아와야함
		Mbasket_add_data.setBookCode(datas.getBookCode());
		Mbasket_add_data.setQuantity(datas.getStock()); 
		Mbasket_add_data.setDeliveryFee(3000); // 배달비는 3천원 고정 산간지역은 추후 추가
		if(MbookBasketData == null) {//장바구니에 존재하지 않는 책정보면 INSERT작업
			boolean add_result = ManageService.bookAddData(Mbasket_add_data);
			json.put("code", "success");
			return json.toString();
		}else {
			json.put("code", "fail");
			return json.toString();
		}
	}
	
	@PostMapping(value = "/basket-main-info",produces="application/json; charset=utf-8")
	@ResponseBody
	public String basketAddList (@RequestParam(required = false, value="bookCode[]") List<String> bookCode,
			HttpSession httpSession) throws Exception {
		
		MemberDTO mData = (MemberDTO) httpSession.getAttribute("loginData");
		String result = service.selectBookBasketList(bookCode, mData.getMemId());
		JSONObject json = new JSONObject();
		if (result.equals("true")) {
			json.put("code", "success");
		}else {
			
		}
		return json.toString();
		
	}
	
	@GetMapping
	@RequestMapping(value = "/book-add")
	public String bookAdd(Locale locale, Model model) {
		return "/standard/add";
	}
	
	
	@PostMapping(value = "/addbook/ajax")
	@ResponseBody
    public String addBook(BookDTO addtest, HttpServletRequest req,HttpSession session) throws Exception {
		
		UUID uuid = UUID.randomUUID();
		
		
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
        Iterator<String> iterator = multi.getFileNames();     
        MultipartFile multipartFile = null;
		while (iterator.hasNext()) {
			multipartFile = multi.getFile(iterator.next());
		}	

		String savedName = uuid.toString() + "_" + multipartFile.getOriginalFilename();
		MemberDTO membersDTO = (MemberDTO)session.getAttribute("loginData");
		
	    String realPath= req.getServletContext().getRealPath("/resources/img/");
	    addtest.setBookImgPath(req.getContextPath() + "/resources/img/" + savedName);
		
	    boolean res = service.addBook(addtest);
		if(res) {
			multipartFile.transferTo(new File(realPath + savedName));


			JSONObject json = new JSONObject();
			json.put("infoUrl", req.getContextPath() + "/resources/img/" + savedName);

			return json.toJSONString();
		} else {
			return null;
		}
	}
	
	
}
