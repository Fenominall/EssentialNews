//
//  SharedTestHelpers.swift
//  EssentialNewsTests
//
//  Created by Fenominall on 7/6/24.
//

import Foundation
import EssentialNews

func anyURL() -> URL {
    return URL(string: "https:any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error",
                   code: 1)
}

func anyData() -> Data {
    return Data("invalid json".utf8)
}


extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(
            url: anyURL(),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil)!
    }
}

//Function to group items into a payloud contract

func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    let json = ["articles": items]
    return try! JSONSerialization.data(withJSONObject: json)
}


func makeItem(
    author: String? = nil,
    title: String,
    description: String? = nil,
    url: URL,
    urlToImage: URL? = nil,
    publishedAt: Date,
    content: String? = nil,
    sourceID: String? = nil,
    sourceName: String
) -> (model: Article, json: [String: Any]) {
    
    let source = Source(id: sourceID, name: sourceName)
    let article = Article(
        source: source,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content
    )
    
    var json: [String: Any] = [
        "source": [
            "id": sourceID as Any,
            "name": sourceName
        ],
        "title": title,
        "url": url.absoluteString,
        "publishedAt": ISO8601DateFormatter().string(from: publishedAt)
    ]
    
    if let author = author {
        json["author"] = author
    }
    if let description = description {
        json["description"] = description
    }
    if let urlToImage = urlToImage {
        json["urlToImage"] = urlToImage.absoluteString
    }
    if let content = content {
        json["content"] = content
    }
    
    return (article, json)
}


extension Date {
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
    
    func adding(minutes: Int,
                calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar
            .date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(days: Int,
                calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar
            .date(byAdding: .day, value: days, to: self)!
    }
}
