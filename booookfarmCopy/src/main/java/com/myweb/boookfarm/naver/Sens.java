package com.myweb.boookfarm.naver;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class Sens {
    /**
     *  NaverCloudAPI 이용시 필요한 시그니쳐 생성 메서드
     * @param url 요청 URL
     * @param timestamp 현재 timestamp
     * @param method 요청 메서드
     * @param accessKey 개인 인증키
     * @param secretKey 2차 인증을 위한 secret key
     * @return 시그니쳐 반환
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeyException
     */
    private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
        String space = " ";					// 한 칸 공백
        String newLine = "\n";					// 줄 바꿈

        String message = new StringBuilder()    // 인코딩할 시그니쳐 String 생성
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        String encodeBase64String;  // 반환할 시그니쳐를 담을 String 생성
        try {
            SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");    // secret key HMAC 인코딩
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);   // 지정된 키를 사용해 Mac 객체를 초기화

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));    // 시그니쳐 HMAC 인코딩
            encodeBase64String = Base64.encodeBase64String(rawHmac);    // 반환할 시그니쳐를 base64로 인코딩
        } catch (UnsupportedEncodingException e) {
            encodeBase64String = e.toString();
        }
        return encodeBase64String;
    }

    /**
     *  SMS 발송 메서드
     * @param pNum 수신 받을 핸드폰 번호
     * @param cNum 발신할 난수 인증번호 5자리
     */
    private Boolean sendSMS(String pNum, String cNum) {
        String hostNameUrl = "https://sens.apigw.ntruss.com";            // 호스트 URL
        String requestUrl = "/sms/v2/services/";                        // 요청 URL
        String requestUrlType = "/messages";                            // 요청 URL
        String accessKey = "PHIId5YKIqFuUHJqXAM7";                        // 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키			// Access Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
        String secretKey = "bRD1bcdVUUfP737bEr0mTXgurenqclyvrvK4sB2j";  // 2차 인증을 위해 서비스마다 할당되는 service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
        String serviceId = "ncp:sms:kr:295399930641:booookfarm";       // 프로젝트에 할당된 SMS 서비스 ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > 서비스 ID
        String method = "POST";                                            // 요청 method
        String timestamp = Long.toString(System.currentTimeMillis());    // current timestamp (epoch)
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;   // 요청할 최종 URL
        boolean result = false;

        // JSON 을 활용한 body data 생성
        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray toArr = new JSONArray();

        //toJson.put("subject","");							// Optional, messages.subject	개별 메시지 제목, LMS, MMS에서만 사용 가능
        toJson.put("content", "[BooookFarm] 인증번호 [" + cNum + "]를 입력해주세요.");    // Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
        toJson.put("to", pNum);                        // Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
        toArr.put(toJson);

        bodyJson.put("type", "SMS");                            // Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
        bodyJson.put("contentType", "COMM");                    // Optional, 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
        bodyJson.put("countryCode", "82");                    // Optional, 국가 전화번호, (default: 82)
        bodyJson.put("from", "01038085972");                    // Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능
        //bodyJson.put("subject","");						// Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
        bodyJson.put("content", "[BooookFarm]");    // Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
        bodyJson.put("messages", toArr);                    // Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개

        //String body = bodyJson.toJSONString();
        String body = bodyJson.toString();

        System.out.println(body);

        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());

            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" + " " + responseCode);
            if (responseCode == 202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                result = true;
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    /**
     *  외부에서 발송 요청하기 위한 메서드
     * @param pNum 수신받을 핸드폰 번호
     * @return 생성한 난수 인증번호 5자리 반환
     */
    public String callSendSMS(String pNum) {
        Random random = new Random();
        String cNum = new String();     //
        for(int i = 0; i < 5; i++) {    // 난수 인증번호 5자리 생성
            cNum += random.nextInt(10);
        }
        boolean sendResult = sendSMS(pNum, cNum);
        if(sendResult){
            return cNum;
        }

        return "sendFail";
    }
}
