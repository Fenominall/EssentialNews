//
//  FeedLoaderWithFallbackCompositeTests.swift
//  EssentialNewsAppTests
//
//  Created by Fenominall on 7/25/24.
//

import XCTest
import EssentialNews

class FeedLoaderWithFallbackComposite: FeedLoader {
    private let primary: FeedLoader
    
    init(primary: FeedLoader, fallback: FeedLoader) {
        self.primary = primary
    }
    
    func load(completion: @escaping (FeedLoader.LoadFeedResult) -> Void) {
        primary.load(completion: completion)
    }
}

class FeedLoaderWithFallbackCompositeTests: XCTestCase {
    
    func test_load_deliversPrimaryFeedOnPrimaryLoaderSuccess() {
        let primaryFeed = uniqueFeed()
        let fallbackFeed = uniqueFeed()
        let primaryLoader = LoaderStub(result: .success(primaryFeed))
        let fallbackLoader = LoaderStub(result: .success(fallbackFeed))
        let sut = FeedLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(receivedFeed):
                XCTAssertEqual(receivedFeed, primaryFeed)
                
            case .failure:
                XCTFail("Expected successful load feed result, got \(result) instead")
            }
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    private func uniqueFeed() -> [Article] {
        return [Article(
            source: Source(id: "anyId", name: "anyName"),
            author: "author",
            title: "title",
            description: "description",
            url: anyURL(),
            urlToImage: anyURL(),
            publishedAt: Date(),
            content: "a content"
        )
        ]
    }
    
    private class LoaderStub: FeedLoader {
        private let result: FeedLoader.LoadFeedResult
        
        init(result: FeedLoader.LoadFeedResult) {
            self.result = result
        }
        
        func load(completion: @escaping (FeedLoader.LoadFeedResult) -> Void) {
            completion(result)
        }
    }
    
    
    func anyURL() -> URL {
        return URL(string: "https:any-url.com")!
    }
    
}
