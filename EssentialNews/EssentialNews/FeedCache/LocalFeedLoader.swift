//
//  LocalFeedLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/11/24.
//

import Foundation

public final class LocalFeedLoader {
    private let store: ArticlesFeedStore
    
    init(articlesFeedStore: ArticlesFeedStore) {
        self.store = articlesFeedStore
    }
}

// MARK: - Loading Feed
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
        
        store.retrieve { [weak task] result in
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

// MARK: - Saving Feed
extension LocalFeedLoader: FeedCache {
    public typealias SaveResult = FeedCache.SaveResult
    
    public func save(
        _ feed: [Article],
        completion: @escaping (SaveResult) -> Void
    ) {
        store.delete { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.store.insert(feed.toLocale(), completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func cache(_ articles: [Article], with completion: @escaping (SaveResult) -> Void) {
        store.insert(articles.toLocale()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
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

private extension Array where Element == Article {
    func toLocale() -> [LocalArticle] {
        return map {
            LocalArticle(
                source: $0.source.toLocalSource(),
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

public extension Source {
    func toLocalSource() -> LocalSource {
        return LocalSource(id: self.id, name: self.name)
    }
}

