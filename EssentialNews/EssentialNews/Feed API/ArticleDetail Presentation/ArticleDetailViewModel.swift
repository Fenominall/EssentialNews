//
//  ArticleDetailViewModel.swift
//  EssentialNews
//
//  Created by Fenominall on 8/3/24.
//

import Foundation

public struct ArticleDetailViewModel {
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String?
    public let imageData: Data?
    public let publishedAt: Date
    public let content: String?
    
    public init(
        source: Source,
        author: String?,
        title: String,
        description: String?,
        imageData: Data?,
        publishedAt: Date,
        content: String?
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.imageData = imageData
        self.publishedAt = publishedAt
        self.content = content
    }
}