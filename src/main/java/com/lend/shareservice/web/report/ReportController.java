package com.lend.shareservice.web.report;

import com.lend.shareservice.domain.report.ReportService;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.report.dto.ReportDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
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
}
