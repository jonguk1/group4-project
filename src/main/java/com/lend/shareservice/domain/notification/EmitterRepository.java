package com.lend.shareservice.domain.notification;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Repository
@RequiredArgsConstructor
@Slf4j
public class EmitterRepository {

    private final Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();

    public void save(String id, SseEmitter emitter) {
        emitters.put(id, emitter);
    }

    public void deleteById(String id) {
        emitters.remove(id);
    }

    public SseEmitter get(String id) {
        log.info("size = {}", emitters.size());
        return emitters.get(id);
    }

}
