//
//  RemoteFeedLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/6/24.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
    private let loader: RemoteLoader<[Article], FeedItemsMapper>
    
    public init(loader: RemoteLoader<[Article], FeedItemsMapper>) {
        self.loader = loader
    }
        
    @discardableResult
    public func load(completion: @escaping (LoadFeedResult) -> Void) -> any FeedLoaderTask {
        return loader.load(completion: completion)
    }
}

