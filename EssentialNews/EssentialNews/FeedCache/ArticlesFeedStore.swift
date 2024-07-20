//
//  ArticlesFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/14/24.
//

import Foundation

public protocol ArticlesFeedStore {
    typealias DeletionCompletion = Swift.Result<Void, Error>
    typealias InsertionCompletion = Swift.Result<Void, Error>
    
    typealias RetrievalResult = Swift.Result<[LocalArticle]?, Error>
    typealias RetrievalCompletion = (ArticlesFeedStore.RetrievalResult) -> Void
    
    func delete(completion: @escaping (DeletionCompletion) -> Void)
    func insert(_ articles: [LocalArticle], completion: @escaping (InsertionCompletion) -> Void)
    func retrieve(completion: @escaping RetrievalCompletion)
}
