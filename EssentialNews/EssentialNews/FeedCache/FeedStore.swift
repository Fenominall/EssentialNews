//
//  ArticlesFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/14/24.
//

import Foundation

public typealias CachedFeed = (feed: [LocalArticle], timestamp: Date)

public protocol FeedStore {
    typealias DeletionCompletion = Swift.Result<Void, Error>
    typealias InsertionCompletion = Swift.Result<Void, Error>
    
    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (FeedStore.RetrievalResult) -> Void
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCachedFeed(completion: @escaping (DeletionCompletion) -> Void)
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ articles: [LocalArticle], timestamp: Date, completion: @escaping (InsertionCompletion) -> Void)
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}
