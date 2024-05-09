package com.lend.shareservice.web.report;

import com.lend.shareservice.domain.report.ReportService;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.report.dto.ReportDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ReportController {

    private final ReportService reportService;

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




}
