//
//  CoreDataFeedStore+FeedImageDataStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/23/24.
//

import CoreData
import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    public func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void) {
        performAsync { context in
            completion(Result {
                try ManagedArticle.first(with: url, in: context)
                    .map { $0.data = data }
                    .map(context.save)
            })
        }
    }
    
    public func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        performAsync { context in
            completion(Result {
                try ManagedArticle.data(with: url, in: context)
            })
        }
    }
}
