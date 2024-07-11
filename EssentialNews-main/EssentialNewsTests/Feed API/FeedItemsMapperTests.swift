//
//  FeedItemsMapperTests.swift
//  EssentialNewsTests
//
//  Created by Fenominall on 7/7/24.
//

import XCTest
import EssentialNews

final class FeedItemsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        
        let samples = [199, 201, 300, 400, 404, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedItemsMapper
                    .map(json,
                         from: HTTPURLResponse(statusCode: code)))
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalidJSON".utf8)
        
        XCTAssertThrowsError(
            try FeedItemsMapper
                .map(invalidJSON,
                     from: HTTPURLResponse(statusCode: 200)))
    }
    
    // MARK: Checking Success Courses for VALID JSON
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyList() throws {
        let emptyJSON = makeItemsJSON([])
        
        let result =
        try FeedItemsMapper
            .map(emptyJSON,
                 from: HTTPURLResponse(statusCode: 200))
        
        print("HERE IS THE RESULT \(result)")
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliverFeedItemsOn200HTTPResponseWithValidJSONItems() throws {
        let item1 = makeItem(
            author: "Auther1",
            title: "title1",
            description: "desc1",
            url: URL(string: "http://a-url.com")!,
            urlToImage: URL(string: "http://a-url1.com")!,
            publishedAt: ISO8601DateFormatter().date(from: "2024-07-06T10:38:44Z")!,
            content: "content1",
            sourceID: "ID1",
            sourceName: "NAme1"
        )
        
        
        let item2 = makeItem(
            author: "Auther2",
            title: "title2",
            description: "desc2",
            url: URL(string: "http://another-url1.com")!,
            urlToImage: URL(string: "http://another-url.com")!,
            publishedAt: ISO8601DateFormatter().date(from: "2024-07-06T10:39:44Z")!,
            content: "content2",
            sourceID: "ID2",
            sourceName: "NAme2"
        )
        
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        let result = try FeedItemsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [item1.model, item2.model])
    }
}

