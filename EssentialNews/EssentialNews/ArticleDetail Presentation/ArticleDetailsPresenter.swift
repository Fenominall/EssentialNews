//
//  ArticleDetailPresenter.swift
//  EssentialNews
//
//  Created by Fenominall on 8/3/24.
//

import Foundation

public final class ArticleDetailsPresenter {
    public static func map(_ article: Article) -> ArticleDetailsViewModel {
        ArticleDetailsViewModel(
            source: article.source,
            author: article.author,
            title: article.title,
            description: article.description,
            publishedAt: article.publishedAt,
            content: article.content
        )
    }
}
