package com.myweb.boookfarm.member.controller;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.myweb.boookfarm.member.model.MemberDTO;
import com.myweb.boookfarm.member.service.MemberService;
import com.myweb.boookfarm.naver.NaverLoginBO;
import com.myweb.boookfarm.naver.Sens;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@Controller
public class MemberController {

    @Autowired
    private MemberService memServ;

    /* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;

    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    /**
     * 로그인 페이지 요청 메서드
     * @return 로그인 페이지 반환
     */
    @GetMapping(value = "/login")
    public String getLoginView(Model model, HttpSession httpSession) {
        /* 네아로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메서드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(httpSession);
        /* 객체 바인딩 */
        model.addAttribute("urlNaver", naverAuthUrl);

        return "login";
    }

    /**
     * 로그인 요청 메서드
     * @param param 요청 로그인 정보
     * @param httpSession
     * @return 로그인 성공 여부 반환
     */
    @PostMapping(value = "/login")
    @ResponseBody
    public String login(@RequestBody Map<String, String> param
                      , HttpSession httpSession) {
        if(httpSession.getAttribute("loginData") != null) {
            httpSession.removeAttribute("loginData");
        }
        String loginId = param.get("id");
        String loginPw = param.get("pw");
        JSONObject jsonObject = new JSONObject();

        MemberDTO loginData = memServ.getLoginData(loginId, loginPw);
        if(loginData == null) {
            jsonObject.put("chkLogin", false);
        } else {
            jsonObject.put("chkLogin", true);
            httpSession.setAttribute("loginData", loginData);
        }

        return jsonObject.toJSONString();
    }

    /**
     *  네이버 로그인 성공시 callback호출 메서드
     * @param httpSession
     * @param code
     * @param state
     * @return 소셜 로그인 성공 메서드 호출
     * @throws Exception
     */
    @RequestMapping(value = "/callbackNaver", method = { RequestMethod.GET, RequestMethod.POST })
    public String callbackNaver(HttpSession httpSession
                              , @RequestParam String code
                              , @RequestParam String state)
            throws Exception {
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(httpSession, code, state);
        //로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);

        JSONParser jsonParser = new JSONParser();
        JSONObject naverLoginData;

        naverLoginData = (JSONObject) jsonParser.parse(apiResult);
        JSONObject response_obj = (JSONObject) naverLoginData.get("response");
        String naverId = (String) response_obj.get("id");
        MemberDTO memData = memServ.getMemData(naverId);

        if(memData == null) {   // 네이버 로그인으로 가입한 정보가 없으면
            httpSession.setAttribute("naverLoginData", naverLoginData);
        } else {    // 네이버 로그인으로 가입한 정보가 있을 때
            httpSession.setAttribute("loginData", memData);
        }

        return "redirect:/loginSuccess";
    }

    /**
     * 카카오 로그인 페이지 요청 메서드
     * @return 카카오 로그인 페이지 url 반환
     * @throws Exception
     */
    @RequestMapping(value = "/login/getKakaoAuthUrl")
    public @ResponseBody String getKakaoAuthUrl() throws Exception {
        String reqUrl =
                "https://kauth.kakao.com/oauth/authorize"
                        + "?client_id=56c706ffeb53e993ee47c22f62cd7540"
                        + "&redirect_uri=http://localhost:8080/boookfarm/login/oauth_kakao"
                        + "&response_type=code";

        return reqUrl;
    }

    /**
     * 카카오 연동정보 조회 메서드
     * @param code 승인 코드
     * @param httpSession
     * @return 소셜 로그인 성공 메서드 호출
     * @throws Exception
     */
    @RequestMapping(value = "/login/oauth_kakao")
    public String oauthKakao(
            @RequestParam(value = "code", required = false) String code
            , HttpSession httpSession) throws Exception {

        String access_Token = getAccessToken(code);

        HashMap<String, Object> kakaoInfo = getKakaoInfo(access_Token);

        JSONObject kakaoLoginData =  new JSONObject(kakaoInfo);
        String kakaoId = (String) kakaoLoginData.get("id");

        MemberDTO memData = memServ.getMemData(kakaoId);

        if(memData == null) {   // 네이버 로그인으로 가입한 정보가 없으면
            httpSession.setAttribute("kakaoLoginData", kakaoLoginData);
        } else {    // 네이버 로그인으로 가입한 정보가 있을 때
            httpSession.setAttribute("loginData", memData);
        }

        return "redirect:/loginSuccess"; //본인 원하는 경로 설정
    }

    /**
     * 카카오 access 토큰 발급 메서드
     * @param authorize_code 승인코드
     * @return access 토큰 반환
     */
    public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=56c706ffeb53e993ee47c22f62cd7540");  //본인이 발급받은 key
            sb.append("&redirect_uri=http://localhost:8080/boookfarm/login/oauth_kakao");     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }

    /**
     * 카카오 유저 정보 조회 메서드
     * @param access_Token
     * @return 유저 정보 반환
     */
    public HashMap<String, Object> getKakaoInfo (String access_Token) {

        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> kakaoInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String id = "kakao_" + element.getAsJsonObject().get("id").getAsString();
            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();

            kakaoInfo.put("accessToken", access_Token);
            kakaoInfo.put("id", id);
            kakaoInfo.put("nickname", nickname);
            kakaoInfo.put("email", email);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return kakaoInfo;
    }

    /**
     * 소셜 로그인 성공 페이지
     * @param httpSession
     * @return 회원정보 유무에 따라 추가정보 입력 페이지 또는 메인 페이지 리다이렉트
     */
    @RequestMapping("/loginSuccess")
    public String loginSuccess(HttpSession httpSession) {
        if(httpSession.getAttribute("loginData") == null)
            return "redirect:/join";
        return "redirect:/";
    }

    @GetMapping(value = "/logout")
    public String logout(HttpSession httpSession) {
        MemberDTO loginData = (MemberDTO) httpSession.getAttribute("loginData");
        if(loginData == null) {
        } else {
            httpSession.removeAttribute("loginData");
        }
        return "redirect:/";
    }

    /**
     * 회원가입 페이지 요청 메서드
     * @return 회원가입 페이지 반환
     */
    @GetMapping(value = "/join")
    public String join() {
        return "join";
    }

    @PostMapping(value = "/join")
    @ResponseBody
    public String joinMem(@RequestBody Map<String, String> joinData
                        , HttpSession httpSession) {
        MemberDTO newMem = new MemberDTO();
        String name = joinData.get("name");
        String id = joinData.get("id");
        String pw = joinData.get("pw");
        String phone = joinData.get("phone");
        String email = joinData.get("email");
        String postCode = joinData.get("postCode");
        String addr = joinData.get("addr");
        String detailAddr = joinData.get("detailAddr");
        String joinType = joinData.get("joinType");

        newMem.setMemName(name);
        newMem.setMemId(id);
        newMem.setMemPw(pw);
        newMem.setPhone(phone);
        newMem.setEmail(email);
        newMem.setPostCode(postCode);
        newMem.setAddr(addr);
        newMem.setDetailAddr(detailAddr);
        newMem.setMileage("0");
        newMem.setSocialType(joinType);
        newMem.setMemPos("com");

        JSONObject jsonObject = new JSONObject();
        boolean result = memServ.addMemData(newMem);
        jsonObject.put("joinRes", result);

        if(!joinType.equals("com")){    // 소셜 로그인 요청이면 세션에 로그인 정보 저장
            MemberDTO memData = memServ.getMemData(id);
            httpSession.setAttribute("loginData", memData);
        }

        return jsonObject.toJSONString();
    }

    /**
     *  인증번호 발송 요청 받는 메서드
     * @param phoneData 수신 받을 핸드폰 번호와 회원가입 타입을 담은 JSON 객체 (key : pNum, joinType)
     * @return 인증번호 5자리를 담은 JSON 객체 반환
     */
    @PostMapping(value = "/phoneChk")
    @ResponseBody
    public String phoneChk(@RequestBody Map<String, String> phoneData) {
        String phoneNum = phoneData.get("pNum");
        System.out.println(phoneData);
        JSONObject jsonObject = new JSONObject();

        boolean dupChk = memServ.chkPhoneDup(phoneData);
        jsonObject.put("phoneDupChk", dupChk);
        if(dupChk) {
            return jsonObject.toJSONString();
        }
        Sens sens = new Sens();

        String cNum = sens.callSendSMS(phoneNum);  // 인증번호 발송과 함께 난수 인증번호 저장
        boolean sendResult = cNum.equals("sendFail");
        if(sendResult) {
            jsonObject.put("result", "sendFail");
            return jsonObject.toJSONString();
        } else {
            jsonObject.put("result", "sendSuccess");
            jsonObject.put("cNum", cNum);   // 클라이언트로 보낼 인증번호 JSON 객체 생성

            return jsonObject.toJSONString();
        }
    }

    /**
     *  아이디 중복 체크하는 메서드
     * @param param
     * @return
     */
    @PostMapping(value = "/idDupChk")
    @ResponseBody
    public String idDupChk(@RequestBody Map<String, String> param) {
        String memId = param.get("id");
        boolean dupChk = memServ.chkIdDup(memId);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("dupChk", dupChk);
        return jsonObject.toJSONString();
    }

    @GetMapping(value = "/find")
    public String find() { return "find"; }

}
