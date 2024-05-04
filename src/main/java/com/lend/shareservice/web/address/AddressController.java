package com.lend.shareservice.web.address;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lend.shareservice.domain.address.AddressService;
import com.lend.shareservice.web.board.dto.LatiLongDTO;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;
@Controller
public class AddressController {



    @GetMapping(value = "/address", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String getFullAddress(@RequestBody LatiLongDTO latiLongDTO) {

        String address = AddressService.getAddressFromLatLng(latiLongDTO.getLatitude(), latiLongDTO.getLongitude());
        ObjectMapper mapper = new ObjectMapper();
        String jsonAddress = "";
        try {
            jsonAddress = mapper.writeValueAsString(address);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return jsonAddress;
    }

}
