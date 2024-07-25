//
//  SharedTestHelpers.swift
//  EssentialNewsAppTests
//
//  Created by Fenominall on 7/25/24.
//

import Foundation
import EssentialNews

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func uniqueFeed() -> [Article] {
    return [Article(
        source: Source(id: "anyId", name: "anyName"),
        author: "author",
        title: "title",
        description: "description",
        url: anyURL(),
        urlToImage: anyURL(),
        publishedAt: Date(),
        content: "a content"
    )
    ]
}
