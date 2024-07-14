//
//  FeedImageDataMapperTests.swift
//  EssentialNewsTests
//
//  Created by Fenominall on 7/7/24.
//

import XCTest
import EssentialNews

class FeedImageDataMapperTest: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        
        let samples = [199, 201, 300, 400, 404, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedImageDataMapper
                    .map(json,
                         from: HTTPURLResponse(statusCode: code)))
        }
    }
    
    func test_map_deliversInvalidDataErrorOn200HTTPResponseWithEmptyData() {
        let emptyData = Data()
        
        XCTAssertThrowsError(
            try FeedImageDataMapper
                .map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversReceivedNonEmptyDataOn200HTTPResponse() throws {
        let nonEmptyData = Data("non-empty-data".utf8)
        
        let result = try FeedImageDataMapper
            .map(nonEmptyData, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, nonEmptyData)
    }
}
