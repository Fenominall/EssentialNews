//
//  FeedItemsMapper.swift
//  EssentialNews
//
//  Created by Fenominall on 7/6/24.
//

import Foundation

public final class FeedItemsMapper {
    private struct Root: Decodable {
        let articles: [Item]
        
        var feed: [Article] {
            return articles.map { $0.item }
        }
    }
    
    private struct Item: Decodable {
        let source: RemoteSource
        let author: String?
        let title: String
        let description: String?
        let url: URL
        let urlToImage: URL?
        let publishedAt: String
        let content: String?
        
        
        var item: Article {
            return createArticle()
        }
        
        private func createArticle() -> Article {
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: publishedAt) ?? Date()
            return Article(
                source: Source(id: source.id, name: source.name),
                author: author,
                title: title,
                description: description,
                url: url,
                urlToImage: urlToImage,
                publishedAt: date,
                content: content
            )
        }
    }
    
    private struct RemoteSource: Decodable {
        let id: String?
        let name: String
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private static let jsonDecoder = JSONDecoder()
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Article] {
        guard response.isOK else {
            throw Error.invalidData
        }
        
        let root = try jsonDecoder.decode(Root.self, from: data)
        return root.feed
    }
    
}
