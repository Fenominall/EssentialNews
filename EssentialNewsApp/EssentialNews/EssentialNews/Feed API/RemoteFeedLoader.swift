//
//  RemoteFeedLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/6/24.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(
        url: URL,
        client: HTTPClient
    ) {
        self.url = url
        self.client = client
    }
    
    public typealias LoadResult = FeedLoader.LoadFeedResult
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private final class HTTPClientTaskWrapper: FeedLoaderTask {
        private var completion: ((RemoteFeedLoader.LoadResult) -> Void)?
        
        var wrapped: HTTPClientTask?
        
        init(_ completion: @escaping (RemoteFeedLoader.LoadResult) -> Void) {
            self.completion = completion
        }
        
        func complete(with result: RemoteFeedLoader.LoadResult) {
            completion?(result)
        }
        
        func cancel() {
            preventFurtherCompletions()
            wrapped?.cancel()
        }
        
        private func preventFurtherCompletions() {
            completion = nil
        }
    }
    
    @discardableResult
    public func load(completion: @escaping (LoadResult) -> Void) -> FeedLoaderTask {
        let task = HTTPClientTaskWrapper(completion)
        task.wrapped = client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            do {
                switch result {
                case let .success((data, response)):
                    let articles = try FeedItemsMapper.map(data, from: response)
                    completion(.success(articles))
                case .failure:
                    completion(.failure(Error.connectivity))
                }
            } catch {
                completion(.failure(Error.invalidData))
            }
        }
        return task
    }
}

