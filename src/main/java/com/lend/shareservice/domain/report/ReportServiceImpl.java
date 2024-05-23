package com.lend.shareservice.domain.report;

import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.report.dto.ReportDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService{

    private final ReportMapper reportMapper;

    @Override
    public List<ReportDTO> reports(PagingDTO page) {
        Map<String,Object> map=new HashMap<>();
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return reportMapper.reports(map);
    }

    @Override
    public List<ReportDTO> reportWriters(String writer, PagingDTO page) {
        Map<String,Object> map=new HashMap<>();
        map.put("writer",writer);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return reportMapper.reportWriters(map);
    }

    @Override
    public int getReportCount() {
        return reportMapper.getReportCount();
    }

    @Override
    public int getReportWriterCount(String writer) {
        return reportMapper.getReportWriterCount(writer);
    }

    @Override
    public int updateBanUser(String writer) {
        return reportMapper.updateBanUser(writer);
    }

}
