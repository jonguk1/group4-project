package com.lend.shareservice.web.report;

import com.lend.shareservice.domain.report.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class ReportController {

    private final ReportService reportService;
}
