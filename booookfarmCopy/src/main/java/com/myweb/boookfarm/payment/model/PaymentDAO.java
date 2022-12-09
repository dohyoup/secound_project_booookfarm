package com.myweb.boookfarm.payment.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAO {

	@Autowired
	private SqlSession session;
	
	private String mapper = "bookManageMapper.%s";

	public boolean addMileage(Map mileageData) {
		String mapperId = String.format(mapper, "updateMileage");
		int add_result = session.update(mapperId,mileageData);
		return add_result >= 1 ? true : false;
	}

	public boolean addOrderData(OrderDTO orderData) {
		String mapperId = String.format(mapper, "insertOrderData");
		int add_result = session.insert(mapperId, orderData);
		return add_result >= 1 ? true : false;
	}

}
