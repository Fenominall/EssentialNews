//
//  FeedLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/5/24.
//

import Foundation

public protocol FeedLoaderTask {
    func cancel()
}

public protocol FeedLoader {
    typealias LoadFeedResult = Swift.Result<[Article], Error>
    
    func load(completion: @escaping (LoadFeedResult) -> Void) -> FeedLoaderTask
}
