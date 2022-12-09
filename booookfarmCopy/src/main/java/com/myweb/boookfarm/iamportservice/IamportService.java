package com.myweb.boookfarm.iamportservice;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
/*
@Service
public class IamportService {
	private final String imp_key="7336595505277037";
    private final String imp_secret="19412b4bca453060662162083d1ccc8ee7c53bd98a2f33faedd7ebc3e6ad4c359c36f899ebd6ddec";
    private RestTemplate restTemplate=new RestTemplate();
    private HttpHeaders headers=new HttpHeaders();
    private JSONObject body=new JSONObject();

    private IamportDTO getToken() {
        headers.setContentType(MediaType.APPLICATION_JSON);
        body.put("imp_key", imp_key);
        body.put("imp_secret", imp_secret);
        try {  
            HttpEntity<JSONObject>entity=new HttpEntity<>(body,headers);
            
            IamportDTO token=restTemplate.postForObject("https://api.iamport.kr/users/getToken",entity,IamportDTO.class);
            System.out.println(token+" FULLtoken");
    
            return token;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("gettoken에서 오류가 발생");
        }finally{
            headerAndBodyClear();
        }
        return null;
    }
    public boolean confrimBuyerInfor(String imp_uid,int price,String email) {
    	IamportDTO iamprotDto=getToken();
        try {
            if(iamprotDto==null){
                throw new Exception();
            }
            headers.add("Authorization",(String) iamprotDto.getResponse().get("access_token"));
            HttpEntity<JSONObject>entity=new HttpEntity<JSONObject>(headers);

            BuyerInforDto buyerInfor =restTemplate.postForObject("https://api.iamport.kr/payments/"+imp_uid+"",entity,BuyerInforDto.class);
            System.out.println(buyerInfor+" fullinfor");

            if(price==(int)buyerInfor.getResponse().get("amount")&&email.equals(buyerInfor.getResponse().get("buyer_email"))){
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getBuyerInfor 검증 실패"); 
        }finally{
            headerAndBodyClear();
        }
        return false;
    }
    public void cancleBuy(String imp_uid,int returnPrice) {
        try {
        	IamportDTO iamprotDto=getToken();
            if(iamprotDto==null){
                throw new Exception();
            }

            headers.add("Authorization",(String) iamprotDto.getResponse().get("access_token"));
            body.put("imp_uid", imp_uid);
            
            if(returnPrice!=0){
                body.put("amount", returnPrice);
            }

            HttpEntity<JSONObject>entity=new HttpEntity<JSONObject>(body, headers);
            cancleBuyDto cancle =restTemplate.postForObject("https://api.iamport.kr/payments/cancel",entity,cancleBuyDto.class);

            System.out.println(cancle+" full cancle");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("cancleBuy가 실패 했습니다 직접 환불 바랍니다");
            throw new RuntimeException("환불에 실패 했습니다 다시시도 바랍니다");
        }finally{
            headerAndBodyClear();
        }
    }
    private void headerAndBodyClear(){
        headers.clear();
        body.clear();
    }
}
 */  
