package com.kdis.demo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/order/*")
public class OrderController {

    private static Logger log = LoggerFactory.getLogger(OrderController.class);

    @ResponseBody
    @RequestMapping(value="/executePayment")
    public Map<String,String> executePayment(HttpServletRequest request,HttpServletResponse response) throws Exception {
        String orderId = request.getParameter("orderId");
        log.debug("orderId : " + orderId);

        // TODO : 토큰 계속 생성하지 않게 DB 또는 캐싱 처리 나중에
        String accessToken = getAccessToken();

        Map<String,String> resultMap = new HashMap<String,String>();
        String result = "";

        Map<String, Object> attrMap = new HashMap<String, Object>();
        Map<String, String> headerMap = new HashMap<String, String>();
        Map<String, String> subParamMap = new HashMap<String, String>();

        String url = "https://api-m.sandbox.paypal.com/v2/checkout/orders/" + orderId + "/capture";

        try{
            // 해더 정보 세팅
            /* headerMap.put("accept", "application/json"); */
            attrMap.put("Method", "POST");

            headerMap.put("Authorization", "Bearer " + accessToken);
            headerMap.put("content-type", "application/json");

            result = sendPostHttpsRequestNew(url, attrMap, headerMap, subParamMap, null);

            JSONParser jsonParse = new JSONParser();
            JSONObject obj = (JSONObject)jsonParse.parse(result);

            /* result = (String) obj.get("access_token"); */
            log.info(result);
        }catch(Exception e){
            // TODO
        }

        resultMap.put("result", "success");
        resultMap.put("data", result);
        return resultMap;
    }

    /**
     * https 통신
     *
     * @author kdh
     * @since 2021.03.28
     * @param argCallUrl
     * @param argSettAttr
     * @param argHeaderAttr
     * @param params
     * @param argSslContext
     * @return String
     * @throws IOException
     *
     */
    public String sendPostHttpsRequestNew(String argCallUrl, Map<String, Object> argSettAttr, Map<String, String> argHeaderAttr, Map<String, String> params, SSLContext argSslContext)
            throws IOException {

        HttpsURLConnection httpsConn = null;
        URL objUrl = null;
        StringBuffer requestParams = new StringBuffer();
        StringBuffer sbResponse	 = new StringBuffer();
        BufferedReader objBr 		= null;
        OutputStreamWriter writer = null;
        String strResult 				= null;
        String strGetParam			= ""; //GET방식일 경우, parameter 변
        int defaultTimeOut = 5000;
        try {
            if (argSslContext != null) {
                HttpsURLConnection.setDefaultSSLSocketFactory(argSslContext.getSocketFactory());
            }else {
                // TODO
            }

            log.debug("sendPostHttpsRequestNew-- argCallUrl-->" + argCallUrl);

            // GET 값 셋팅.
            if ((params != null && params.size() > 0) && (argSettAttr != null && "GET".equals(argSettAttr.get("Method"))) ) {
                Iterator<String> paramIterator = params.keySet().iterator();
                requestParams.append("?");
                while (paramIterator.hasNext()) {
                    String key = paramIterator.next();
                    String value = params.get(key);
                    requestParams.append(URLEncoder.encode(key, "UTF-8"));
                    requestParams.append("=").append(URLEncoder.encode(value, "UTF-8"));
                    requestParams.append("&");
                }
                strGetParam = requestParams.toString();
                strGetParam = strGetParam.substring(0, strGetParam.length() -1);
            }

            objUrl 		= new URL(argCallUrl + strGetParam);
            httpsConn 	= (HttpsURLConnection) objUrl.openConnection();

            log.debug("sendPostHttpsRequestNew-- httpsConn-->" + httpsConn);
            // 응답 헤더와 메시지를 읽어들이겠다는 옵션 설정(서버통신에서 입력 가능한 상태로 설정.)
            httpsConn.setDoInput(true);
            // outputstream으로 POST데이터를 넘겨주겠다는 옵션 설정(서버통신에서 출력 가능한 상태로 설정.)
            httpsConn.setDoOutput(true);
            // 동적으로 결과를 읽도록 설정.
            httpsConn.setUseCaches(false);

            // 타임아웃 설정.
            if (argSettAttr != null && argSettAttr.get("ReadTimeout") != null) {
                log.debug("sendPostHttpsRequestNew-- ReadTimeout-->" + argSettAttr.get("ReadTimeout"));
                httpsConn.setReadTimeout(Integer.parseInt(argSettAttr.get("ReadTimeout").toString()));
            } else {
                httpsConn.setReadTimeout(defaultTimeOut);
            }
            if (argSettAttr != null && argSettAttr.get("ConnTimeout") != null) {
                log.debug("sendPostHttpsRequestNew-- ConnTimeout-->" + argSettAttr.get("ConnTimeout"));
                httpsConn.setConnectTimeout(Integer.parseInt(argSettAttr.get("ConnTimeout").toString()));
            } else {
                httpsConn.setConnectTimeout(defaultTimeOut);
            }

            // 값이 null 이면 기본 POST
            if (argSettAttr != null && argSettAttr.get("Method") != null) {
                log.debug("sendPostHttpsRequestNew-- Method-->" + argSettAttr.get("Method"));
                httpsConn.setRequestMethod(argSettAttr.get("Method").toString());
            } else {
                httpsConn.setRequestMethod("POST");
            }

            // 헤더에 들어갈 값을 셋팅.
            if (argHeaderAttr != null) {
                Iterator<String> propIterator = argHeaderAttr.keySet().iterator();
                while (propIterator.hasNext()) {
                    String key = propIterator.next();
                    String value = argHeaderAttr.get(key);
                    httpsConn.setRequestProperty(key, value); // Authorization
                }
            }

            // POST 값 셋팅.
            if (params != null) {
                if (params != null && params.size() > 0  && (argSettAttr != null && "POST".equals(argSettAttr.get("Method"))) ) {
                    Iterator<String> paramIterator = params.keySet().iterator();
                    while (paramIterator.hasNext()) {
                        String key = paramIterator.next();
                        String value = params.get(key);
                        requestParams.append(URLEncoder.encode(key, "UTF-8"));
                        requestParams.append("=").append(URLEncoder.encode(value, "UTF-8"));
                        requestParams.append("&");
                    }
                    writer = new OutputStreamWriter(httpsConn.getOutputStream());

                    String reStr = "";
                    reStr = requestParams.toString();
                    reStr = reStr.substring(0, reStr.length() -1);

                    log.debug("sendPostHttpsRequestNew requestParams.toString()=>" + requestParams.toString());
                    log.debug("sendPostHttpsRequestNew requestParams.toString()=>" + reStr);
                    writer.write(reStr);
                    writer.flush();
                }
            }

            int responseCode = httpsConn.getResponseCode();
            log.debug("sendPostHttpsRequestNew responseCode : " + responseCode);

            if (responseCode == HttpsURLConnection.HTTP_OK || responseCode == HttpsURLConnection.HTTP_CREATED) { // 정상 호출 200 | 201
                objBr = new BufferedReader(new InputStreamReader(httpsConn.getInputStream()));
            } else { // 에러 발생
                objBr = new BufferedReader(new InputStreamReader(httpsConn.getErrorStream()));
            }
            String inputLine;
            while ((inputLine = objBr.readLine()) != null) {
                sbResponse.append(inputLine);
            }
            objBr.close();

            if (sbResponse != null && sbResponse.length() > 0) {
                strResult = sbResponse.toString();
            }
            log.debug("sendPostHttpsRequestNew sbResponse : " + sbResponse);

        } catch (UnknownHostException e) {
            log.error("UnknownHostException e==>"+e);
        } catch (IOException e) {
            log.error("IOException e==>"+e);
        } catch (Exception e) {
            log.error("e==>"+e);
        } finally {
            if (objBr != null) {
                objBr.close();
            }
            if (httpsConn != null) {
                httpsConn.disconnect();
            }
            if (writer != null) {
                writer.close();
            }
        }
        return strResult;
    }


    /**
     * Get Aceess Token
     *
     * @author kdh
     * @since 2021.03.28
     * @return String
     *
     */
    private String getAccessToken() {
        Map<String,String> resultMap = new HashMap<String,String>();
        String result = "";

        Map<String, Object> attrMap = new HashMap<String, Object>();
        Map<String, String> headerMap = new HashMap<String, String>();
        Map<String, String> subParamMap = new HashMap<String, String>();
        String url = "https://api.sandbox.paypal.com/v1/oauth2/token";

        String strRtnData		= null;
        String strFingerPrint 	= null;
        long timestamp = 0L;


        try{

            // 해더 정보 세팅
            headerMap.put("accept", "application/json");
            headerMap.put("accept-language", "en_US");
            headerMap.put("authorization", "Basic QVExeXVBYzRPbUY0YS1tRXhpbnQyVXNHOWdESzFMMHdYWlZOaHB6ZHFWYnZYUXk0THhrZlBGWlpjcEJPNzJVTGRaZ3Z4N24zM3RIV0NrdGY6RUl2Ykx5cG5KYjB5eTVUZGxBUGNJT2cwMzFRNmxaMFFEd1BkOUZyYXZET2E3XzluZFJMR2pnNk16RFlaeHNrUFNIWkRKVlBQa1hwcllfNDg=");
            headerMap.put("content-type", "application/x-www-form-urlencoded");

            // Parameter 정보 세팅
            subParamMap.put("grant_type", "client_credentials");

            attrMap.put("Method", "POST");

            strRtnData = sendPostHttpsRequestNew(url, attrMap, headerMap, subParamMap, null);

            JSONParser jsonParse = new JSONParser();
            JSONObject obj =  (JSONObject)jsonParse.parse(strRtnData);

            result = (String) obj.get("access_token");
            log.info(result);
        }catch(Exception e){
            // TODO
        }

        return result;
    }

}
