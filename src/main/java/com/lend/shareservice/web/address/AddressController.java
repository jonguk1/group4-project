package com.lend.shareservice.web.address;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.web.board.dto.LatiLongDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;
@Controller
@RequiredArgsConstructor
public class AddressController {

    private final AddressService addressService;

    @GetMapping(value = "/address", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String getFullAddress(@RequestParam("latitude") double latitude, @RequestParam("longitude") double longitude) {
        String address = addressService.getAddressFromLatLng(latitude, longitude);
        ObjectMapper mapper = new ObjectMapper();
        String jsonAddress = "";
        try {
            jsonAddress = mapper.writeValueAsString(address);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSON 객체 생성
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("address", jsonAddress);

        return jsonResponse.toString();
    }


}
