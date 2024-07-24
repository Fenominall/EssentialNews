//
//  FeedImagePresenter.swift
//  EssentialNews
//
//  Created by Fenominall on 7/24/24.
//

import Foundation

public final class FeedArticlesPresenter {
    public static func map(_ article: Article) -> FeedArticleViewModel {
        FeedArticleViewModel(
            title: article.title,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt
        )
    }
}
