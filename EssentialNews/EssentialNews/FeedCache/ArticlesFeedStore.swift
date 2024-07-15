//
//  ArticlesFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/14/24.
//

import Foundation

import Foundation

public struct LocalArticle {
    
}

public protocol ArticlesFeedStore {
    typealias DeletionCompletion = ((Error?) -> Void)
    typealias InsertionCompletion = ((Error?) -> Void)
    
    typealias RetrievalResult = Swift.Result<[LocalArticle]?, Error>
    typealias RetrievalCompletion = (ArticlesFeedStore.RetrievalResult) -> Void
}
