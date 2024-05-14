package com.lend.shareservice.domain.report;

import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.report.dto.ReportDTO;

import java.util.List;

public interface ReportService {

    List<ReportDTO> reports(PagingDTO page);

    List<ReportDTO> reportWriters(String writer,PagingDTO page);

    int getReportCount();

    int getReportWriterCount(String writer);

}
