package com.lend.shareservice.domain.chat;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

    private final ChatMapper chatMapper;
}
