package com.lend.shareservice.domain.address;

import org.json.JSONArray;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class AddressService {

    public static String getAddressFromLatLng(double latitude, double longitude) {
        String clientId = "k495h0yzln";
        String clientSecret = "qg4NUZDPlCS6il7dN76afkJkmFwdORhkHWsyZ1OH";
        try {

            String encodedClientId = URLEncoder.encode(clientId, "UTF-8");
            String encodedClientSecret = URLEncoder.encode(clientSecret, "UTF-8");
            String apiURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=" + longitude + "," + latitude + "&sourcecrs=epsg:4326&output=json";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();


                JSONObject jsonObject = new JSONObject(response.toString());
                JSONArray results = jsonObject.getJSONArray("results");
                if (results.length() > 0) {
                    JSONObject firstResult = results.getJSONObject(0);
                    String address = firstResult.getJSONObject("region").getJSONObject("area1").getString("name"); // 도 주소
                    address += " " + firstResult.getJSONObject("region").getJSONObject("area2").getString("name"); // 시/군/구 주소
                    address += " " + firstResult.getJSONObject("region").getJSONObject("area3").getString("name"); // 읍/면/동 주소

                    return address;
                } else {
                    return "주소를 찾을 수 없습니다.";
                }
            } else {
                return "HTTP 응답 코드: " + responseCode;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "주소를 가져오는 중 오류가 발생했습니다.";
        }
    }
}
