//
//  NullStore.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/24/24.
//

import Foundation
import EssentialNews

class NullStore: FeedStore {
    func deleteCachedFeed(completion: @escaping (DeletionCompletion) -> Void) {
        completion(.success(()))
    }
    
    func insert(_ articles: [EssentialNews.LocalArticle], timestamp: Date, completion: @escaping (InsertionCompletion) -> Void) {
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(.none))
    }
}

extension NullStore: FeedImageDataStore {
    func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void) {
        completion(.success(()))
    }
    
    func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        completion(.success(.none))
    }
}
