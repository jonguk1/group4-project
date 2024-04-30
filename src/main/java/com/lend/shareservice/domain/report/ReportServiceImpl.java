package com.lend.shareservice.domain.report;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService{

    private final ReportMapper reportMapper;
}
