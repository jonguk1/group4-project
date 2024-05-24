package com.lend.shareservice.domain.report;

import com.lend.shareservice.entity.Report;
import com.lend.shareservice.web.report.dto.ReportDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReportMapper {

    List<ReportDTO> reports(Map<String, Object> map);

    List<ReportDTO> reportWriters(Map<String, Object> map);

    int getReportCount();

    int getReportWriterCount(String writer);

    int updateBanUser(String writer);

    int insertReport(Report report);
}
