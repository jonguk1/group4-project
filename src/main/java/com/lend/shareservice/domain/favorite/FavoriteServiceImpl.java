package com.lend.shareservice.domain.favorite;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FavoriteServiceImpl implements FavoriteService{

    private final FavoriteMapper favoriteMapper;
}
