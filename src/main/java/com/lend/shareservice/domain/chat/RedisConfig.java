package com.lend.shareservice.domain.chat;

import com.lend.shareservice.web.chat.dto.ChatDTO;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.time.Duration;

@Configuration
public class RedisConfig {

    @Bean
    //application.properties 에서 spring.redis 접두사로 시작하는 모든 속성을 매핑하기 위함
    @ConfigurationProperties(prefix = "spring.redis")
    public RedisConnectionFactory redisConnectionFactory() {
        return new LettuceConnectionFactory();
    }

    // redis 연결, redis 의 pub/sub 기능을 이용하기 위해 pub/sub 메시지를 처리하는 MessageListener 설정(등록)
    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(RedisConnectionFactory connectionFactory){
        //Redis 서버와의 연결을 생성하고 관리하는데 사용
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        //RedisMessageListenerContainer 에 사용할 Redis 연결 팩토리(RedisConnectionFactory)를 설정
        container.setConnectionFactory(connectionFactory);

        return container;
    }

    //Redis를 사용하기 위한 RedisTemplete 빈 설정
    @Bean
    @Primary
    // Redis 데이터베이스와의 상호작용을 위한 RedisTemplate 을 설정. JSON 형식으로 담기 위해 직렬화
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        //Redis 는 key, value형식의 데이터 저장소임
        //하기 클래스는 Redis에 데이터를 저장하고 조회하는데 사용하는 일종의 템플릿 클래스임
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        //Redis연결에 사용할 connectionFactory를 설정
        redisTemplate.setConnectionFactory(connectionFactory);
        //redis는 데이터를 바이트 배열로 저장하므로, 키와 값이 문자열인 경우
        //하기 하기 클래스 사용해서 문자열을 직렬화, 역직렬화 하는데 사용
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<>(String.class));
        return redisTemplate;
    }

    @Bean
    public RedisTemplate<String, ChatDTO> redisTemplateMessage(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, ChatDTO> redisTemplateMessage = new RedisTemplate<>();
        redisTemplateMessage.setConnectionFactory(connectionFactory);
        redisTemplateMessage.setKeySerializer(new StringRedisSerializer());
        redisTemplateMessage.setValueSerializer(new GenericJackson2JsonRedisSerializer());
        return redisTemplateMessage;
    }

    @Bean
    //Redis를 사용하여 캐시 관리를 위한 'CacheManager'를 설정하는 메서드
    //Redis를 사용하여 스프링 애플리케이션에서 캐시를 관리하기 위한 설정을 제공
    //이를 통해 캐시된 데이터를 Redis에 저장하고, 캐시된 데이터의 만료 시간을 설정하여 메모리를 효울적으로 관리 가능
    public CacheManager cacheManager() {
        //RedisCacheManager를 생성하는 빌더를 만든다   redisConnectionFactory()->Redis와의 연결을 설정하는데 사용된다.
        RedisCacheManager.RedisCacheManagerBuilder builder = RedisCacheManager.RedisCacheManagerBuilder.fromConnectionFactory(redisConnectionFactory());
        //Redis 캐시 구성을 설정
        RedisCacheConfiguration configuration = RedisCacheConfiguration.defaultCacheConfig()
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(new GenericJackson2JsonRedisSerializer())) // Value Serializer 변경
                //캐시 항목의 만료 시간 설정
                .entryTtl(Duration.ofMinutes(5)); // 캐시 수명 5분
        builder.cacheDefaults(configuration);
        return builder.build();
    }

}
