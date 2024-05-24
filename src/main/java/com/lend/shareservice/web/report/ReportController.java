package com.lend.shareservice.web.report;

import com.lend.shareservice.domain.report.ReportService;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.report.dto.ReportDTO;
import com.lend.shareservice.web.report.dto.ReportRegDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ReportController {

    private final ReportService reportService;
    private Map<String, Long> requestTimestamps = new HashMap<>();
    private static final long REQUEST_EXPIRY_TIME = 60000 * 60 * 24 * 3;

    @GetMapping("/report")
    public String reportList(Model model,
                             PagingDTO page,
                             @RequestParam(defaultValue = "1") int pageNum){

        int totalCount = reportService.getReportCount();

        page.setTotalCount(totalCount);
        page.setOneRecordPage(3);
        page.setPagingBlock(5);

        page.init();

        List<ReportDTO> reports= reportService.reports(page);

        String loc ="/report";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("reports",reports);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/reportList";
    }

    @GetMapping(value="/report/{writer}",produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public ModelMap reportWriterAjaxList(PagingDTO page,
                                     @PathVariable("writer") String writer,
                                     @RequestParam(defaultValue = "1") int pageNum){

        int totalCount = reportService.getReportWriterCount(writer);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(3);
        page.setPagingBlock(5);

        page.init();

        List<ReportDTO> reportsWriter= reportService.reportWriters(writer,page);

        String loc ="/report/"+writer;

        String pageNavi=page.getPageNavi(loc);

        ModelMap map = new ModelMap();
        map.addAttribute("reportsWriter",reportsWriter);
        map.addAttribute("page",page);
        map.addAttribute("pageNavi",pageNavi);
        map.addAttribute("writer",writer);
        return map;
    }

    @PutMapping("/report/{writer}/ban")
    public ResponseEntity<String> updateBanUser(@PathVariable("writer") String writer) {

        int n = reportService.updateBanUser(writer);

        System.out.println(n);

        if(n > 0){
            return ResponseEntity.ok("ok");
        }else{
            return ResponseEntity.ok("no");
        }
    }

    // 신고글 등록
    @PostMapping("/report")
    public ResponseEntity<?> registerReport(HttpServletRequest request, @Valid @RequestBody ReportRegDTO reportRegDTO, BindingResult bindingResult) {

        // 바인딩 에러 발생
        if (bindingResult.hasErrors()) {
            log.info("bindingResult = {}", bindingResult);
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }

        // 신고글 중복체크 (3일내 동일 유저 같은 글 신고 방지)
        long currentTime = System.currentTimeMillis();

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (requestTimestamps.containsKey(userId)) {
            long lastRequestTime = requestTimestamps.get(userId);

            long requestInterval = currentTime - lastRequestTime;

            if (requestInterval < REQUEST_EXPIRY_TIME) {
                return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS).body("3일 이내 같은 글에 대해 신고가 불가능합니다.");
            }
        }

        requestTimestamps.put(userId, currentTime);

        // 신고글 등록
        if (reportService.registerReport(reportRegDTO) > 0) {
            return ResponseEntity.ok("ok");
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
    }

}
