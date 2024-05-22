package com.lend.shareservice;

import com.lend.shareservice.domain.auction.AuctionService;
import com.lend.shareservice.domain.auction.AuctionServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class AuctionServiceConcurrencyTest {

    @Autowired
    private AuctionService auctionService = new AuctionServiceImpl(); // 테스트할 서비스 객체

    @Test
    public void testConcurrentUpdates() throws InterruptedException {
        int numThreads = 10; // 동시에 실행할 스레드 수

        ExecutorService executorService = Executors.newFixedThreadPool(numThreads);

        // 동시에 실행할 작업 정의
        Runnable task = () -> {
            // 경매 ID, 사용자 ID, 가격 등을 랜덤하게 설정하여 메서드 호출
            int auctionId = getRandomAuctionId();
            String userId = getRandomUserId();
            int currentPrice = getRandomPrice();
            String result = auctionService.updateCurrentPrice(auctionId, currentPrice, userId);
            System.out.println("Result: " + result);
        };

        // 동시에 작업 실행
        for (int i = 0; i < numThreads; i++) {
            executorService.submit(task);
        }

        // 작업 완료를 기다림
        executorService.shutdown();
        executorService.awaitTermination(10, TimeUnit.SECONDS);
    }

    // 테스트에 필요한 랜덤한 값 생성 메서드들
    private int getRandomAuctionId() {
        // Implement this
        return 1; // 예시용으로 1을 리턴
    }

    private String getRandomUserId() {
        // Implement this
        return "user" + Math.random(); // 예시용으로 랜덤한 문자열을 리턴
    }

    private int getRandomPrice() {
        // Implement this
        return (int) (Math.random() * 1000); // 예시용으로 0에서 1000 사이의 랜덤한 가격을 리턴
    }
}
