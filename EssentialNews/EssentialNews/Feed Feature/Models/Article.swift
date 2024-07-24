//
//  Article.swift
//  EssentialNews
//
//  Created by Fenominall on 7/5/24.
//

import Foundation

public struct Article: Hashable {
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String?
    public let url: URL
    public let urlToImage: URL?
    public let publishedAt: Date
    public let content: String?
    
    public init(
        source: Source,
        author: String?,
        title: String,
        description: String?,
        url: URL,
        urlToImage: URL?,
        publishedAt: Date,
        content: String?
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

extension Article {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(author)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(url)
        hasher.combine(urlToImage)
        hasher.combine(publishedAt)
        hasher.combine(content)
    }
}
