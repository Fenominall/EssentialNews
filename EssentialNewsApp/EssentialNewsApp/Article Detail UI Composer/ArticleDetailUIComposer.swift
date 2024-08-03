//
//  ArticleDetailUIComposer.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 8/3/24.
//

import EssentialNews
import EssentialNewsiOS

public final class ArticleDetailsUIComposer {
    private init() {}
    
    static func articleDetailsComposedWith(
        feedLoader: FeedLoader,
        imageLoader: FeedImageDataLoader,
        selection: Article
    ) -> ArticleDetailsViewController {
        let articleDetailVC = ArticleDetailsViewController()
        articleDetailVC.bind(FeedArticleDetailsViewModel(viewModel: ArticleDetailPresenter.map(selection, Data())))
        return articleDetailVC
    }
}
