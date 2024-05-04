package com.lend.shareservice.web.paging.dto;

import lombok.Data;

@Data
public class PagingDTO {
    //페이징 관련 프로퍼티
    private int pageNum;
    private int oneRecordPage;
    private int totalCount;
    private int pageCount;

    //DB에서 레코드 끊어오기 위한 프로퍼티
    private int offset;
    private int limit;

    //페이징 블럭처리 위한 프로퍼티
    private int pagingBlock;
    private int prevBlock;
    private int nextBlock;

    public void init() {
        if(pageNum<1) {
            pageNum=1;//1페이지를 디폴트로
        }

        //페이지 수 구하기
        pageCount=(totalCount-1)/oneRecordPage+1;


        if(pageNum>pageCount) {
            pageNum=pageCount;//마지막 페이지로 설정
        }

        offset=(pageNum-1) * oneRecordPage;
        limit= oneRecordPage;

        prevBlock=(pageNum-1)/pagingBlock*pagingBlock;
        nextBlock=prevBlock+(pagingBlock+1);

    }

    public String getPageNavi(String loc) {

        StringBuilder buf=new StringBuilder();
        buf.append("<ul class='pagination'>");

        if(prevBlock>0) {
            buf.append("<li class='page-item'>")
                    .append("<a class='page-link' href='"+loc+"?pageNum="+prevBlock+"'>")
                    .append("Previous")
                    .append("</a>")
                    .append("</li>");
        }
        for(int i=prevBlock+1;i<=nextBlock-1 && i<=pageCount  ;i++) {
            String css=(i==pageNum)?"active":"";
            buf.append("<li class='page-item "+css+"'>")
                    .append("<a class='page-link' href='"+loc+"?pageNum="+i+"'>")
                    .append(i)
                    .append("</a>")
                    .append("</li>");

        }//for------
        if(nextBlock <= pageCount) {
            buf.append("<li class='page-item'>")
                    .append("<a class='page-link' href='"+loc+"?pageNum="+nextBlock+"'>")
                    .append("Next")
                    .append("</a>")
                    .append("</li>");
        }
        buf.append("</ul>");
        return buf.toString();
    }

}
