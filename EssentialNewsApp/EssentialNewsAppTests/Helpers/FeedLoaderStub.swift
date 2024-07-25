//
//  FeedLoaderStub.swift
//  EssentialNewsAppTests
//
//  Created by Fenominall on 7/25/24.
//

import EssentialNews

class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.LoadFeedResult

    init(result: FeedLoader.LoadFeedResult) {
        self.result = result
    }

    func load(completion: @escaping (FeedLoader.LoadFeedResult) -> Void) {
        completion(result)
    }
}
