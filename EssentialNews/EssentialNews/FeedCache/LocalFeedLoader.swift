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
        
        articlesFeedStore.retrieve { [weak task] result in
            guard let task = task else { return }
            switch result {
            case let .success(.some(savedCategories)):
                let articles = savedCategories.toModels()
                task.complete(with: .success(articles))
            case let .failure(error):
                task.complete(with: .failure(error))
            case .success:
                task.complete(with: .success([]))
            }
        }
        return task
    }
}

private extension Array where Element == LocalArticle {
    func toModels() -> [Article] {
        return map {
            Article(
                source: $0.source.toSourceModel(),
                author: $0.author,
                title: $0.title,
                description: $0.description,
                url: $0.url,
                urlToImage: $0.urlToImage,
                publishedAt: $0.publishedAt,
                content: $0.content
            )
        }
    }
}

public extension LocalSource {
    func toSourceModel() -> Source {
        return Source(id: self.id, name: self.name)
    }
}


