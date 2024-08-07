//
//  LocalFeedLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/11/24.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

// MARK: - Loading Feed
extension LocalFeedLoader: FeedLoader {
    public typealias LoadResult = FeedLoader.LoadFeedResult
    private struct EmptyCacheError: Error {}
    
    public func load(
        completion: @escaping (LoadFeedResult) -> Void
    ) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(.some(savedCategories)):
                let articles = savedCategories.feed.toModels()
                completion(.success(articles))
            case let .failure(error):
                self.store.deleteCachedFeed { _ in }
                completion(.failure(error))
            case .success(.none):
                completion(.failure(EmptyCacheError()))
            }
        }
    }
}

// MARK: - Saving Feed
extension LocalFeedLoader: FeedCache {
    public typealias SaveResult = FeedCache.SaveResult
    
    public func save(
        _ feed: [Article],
        completion: @escaping (SaveResult) -> Void
    ) {
        store.deleteCachedFeed { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.cache(feed, with: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func cache(_ articles: [Article], with completion: @escaping (SaveResult) -> Void) {
        store.insert(articles.toLocale(), timestamp: currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

// MARK: - Cache Validation
extension LocalFeedLoader {
    public typealias ValidationResult = Result<Void, Error>
    private struct InvalidCache: Error {}
    
    public func validateCache(completion: @escaping (ValidationResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure:
                self.store.deleteCachedFeed(completion: completion)
            case let .success(.some(cahce))
                where !FeedCachePolicy
                    .validate(cahce.timestamp, against: self.currentDate()):
                self.store.deleteCachedFeed(completion: completion)
            case .success:
                completion(.success(()))
            }
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

