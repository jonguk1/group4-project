package com.lend.shareservice.domain.report;

import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.report.dto.ReportDTO;
import com.lend.shareservice.web.report.dto.ReportRegDTO;

import java.util.List;

public interface ReportService {

    List<ReportDTO> reports(PagingDTO page);

    List<ReportDTO> reportWriters(String writer,PagingDTO page);

    int getReportCount();

    int getReportWriterCount(String writer);

    int updateBanUser(String writer);

    int registerReport(ReportRegDTO reportRegDTO);
}
