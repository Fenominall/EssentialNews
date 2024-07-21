//
//  CoreDataFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/21/24.
//

import Foundation

extension CoreDataFeedStore: FeedStore {
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        performAsync { context in
            completion(Result {
                try ManagedCache.find(in: context).map {
                    CachedFeed(
                        feed: $0.localFeed,
                        timestamp: $0.timestamp)
                }
            })
        }
    }
    
    public func insert(
        _ articles: [LocalArticle],
        timestamp: Date,
        completion: @escaping (InsertionCompletion) -> Void
    ) {
        performAsync { context in
            completion(Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache?.timestamp = timestamp
                managedCache?.feed = ManagedArticle.articles(from: articles, in: context)
                try context.save()
            })
        }
    }
    
    public func deleteCachedFeed(completion: @escaping (DeletionCompletion) -> Void) {
        performAsync { context in
            completion(Result {
                try ManagedCache
                    .deleteCache(in: context)
            })
        }
    }
}
