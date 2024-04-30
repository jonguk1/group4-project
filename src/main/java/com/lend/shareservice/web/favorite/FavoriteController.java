package com.lend.shareservice.web.favorite;

import com.lend.shareservice.domain.favorite.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class FavoriteController {

    private final FavoriteService favoriteService;
}
