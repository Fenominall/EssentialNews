//
//  ArticlesFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/14/24.
//

import Foundation

public typealias CachedFeed  = (feed: [LocalArticle], timestamp: Date)

public protocol ArticlesFeedStore {
    typealias DeletionCompletion = Swift.Result<Void, Error>
    typealias InsertionCompletion = Swift.Result<Void, Error>
    
    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (ArticlesFeedStore.RetrievalResult) -> Void
    
    func deleteCachedFeed(completion: @escaping (DeletionCompletion) -> Void)
    func insert(_ articles: [LocalArticle], timestamp: Date, completion: @escaping (InsertionCompletion) -> Void)
    func retrieve(completion: @escaping RetrievalCompletion)
}
