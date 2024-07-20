//
//  LocalFeedLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/11/24.
//

import Foundation

public final class LocalFeedLoader {
    private let articlesFeedStore: ArticlesFeedStore
    
    init(articlesFeedStore: ArticlesFeedStore) {
        self.articlesFeedStore = articlesFeedStore
    }
}

// MARK: Loading Feed
extension LocalFeedLoader: FeedLoader {
    public typealias LoadResult = FeedLoader.LoadFeedResult
    
    private final class FeedLoaderTaskWrapper: FeedLoaderTask {
        private var completion: ((LoadResult) -> Void)?
                
        init(_ completion: @escaping (LoadResult) -> Void) {
            self.completion = completion
        }
        
        func complete(with result: LoadResult) {
            completion?(result)
        }
        
        func cancel() {
            preventFurtherCompletions()
        }
        
        private func preventFurtherCompletions() {
            completion = nil
        }
    }
    
    public func load(
        completion: @escaping (LoadFeedResult) -> Void
    ) -> any FeedLoaderTask {
        let task = FeedLoaderTaskWrapper(completion)
        
        return task
    }
}
