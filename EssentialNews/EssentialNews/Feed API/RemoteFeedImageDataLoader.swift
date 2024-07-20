//
//  RemoteFeedImageDataLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/7/24.
//

import Foundation

public final class RemoteFeedImageDataLoader: FeedImageDataLoader {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    @discardableResult
    public func loadImageData(
        from url: URL,
        completion: @escaping (FeedImageDataLoader.Result) -> Void
    ) -> FeedImageDataLoaderTask {
        let task = HTTPClientTaskWrapper(completion)
        task.wrapped = client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            do {
                switch result {
                case let .success((data, response)):
                    let data = try FeedImageDataMapper.map(data, from: response)
                    task.complete(with: .success(data))
                case .failure:
                    task.complete(with: .failure(Error.connectivity))
                }
            } catch {
                task.complete(with: .failure(Error.invalidData))
            }
        }
        return task
    }
}
