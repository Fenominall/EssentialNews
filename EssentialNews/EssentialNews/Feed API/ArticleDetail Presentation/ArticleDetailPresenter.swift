//
//  ArticleDetailPresenter.swift
//  EssentialNews
//
//  Created by Fenominall on 8/3/24.
//

import Foundation

public final class ArticleDetailPresenter {
    public static func map(_ article: Article) -> ArticleDetailViewModel {
        ArticleDetailViewModel(
            source: article.source,
            author: article.author,
            title: article.title,
            description: article.description,
            publishedAt: article.publishedAt,
            content: article.content
        )
    }
}
