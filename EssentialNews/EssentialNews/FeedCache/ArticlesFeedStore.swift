//
//  ArticlesFeedStore.swift
//  EssentialNews
//
//  Created by Fenominall on 7/14/24.
//

import Foundation

public protocol ArticlesFeedStore {
    typealias DeletionCompletion = ((Error?) -> Void)
    typealias InsertionCompletion = ((Error?) -> Void)
    
    typealias RetrievalResult = Swift.Result<[LocalArticle]?, Error>
    typealias RetrievalCompletion = (ArticlesFeedStore.RetrievalResult) -> Void
}
