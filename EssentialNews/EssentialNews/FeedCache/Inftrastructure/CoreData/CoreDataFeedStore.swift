//
//  CoreDataFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/21/24.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    public init() {}
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
    }
    
    public func deleteCachedFeed(completion: @escaping (DeletionCompletion) -> Void) {
        
    }
    
    public func insert(_ articles: [LocalArticle], timestamp: Date, completion: @escaping (InsertionCompletion) -> Void) {
        
    }
    
}
