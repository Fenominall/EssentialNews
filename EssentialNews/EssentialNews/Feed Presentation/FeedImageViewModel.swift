//
//  FeedImageViewModel.swift
//  EssentialNews
//
//  Created by Fenominall on 7/22/24.
//

import Foundation

public struct FeedImageViewModel {
    public let title: String
    public let urlToImage: URL?
    public let publishedAt: Date
    
    public init(
        title: String,
        urlToImage: URL?,
        publishedAt: Date
    ) {
        self.title = title
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
