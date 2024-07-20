//
//  FeedCache.swift
//  EssentialNews
//
//  Created by Fenominall on 7/20/24.
//

import Foundation

public protocol FeedCache {
    typealias SaveResult = Swift.Result<Void, Error>
    
    func save(_ feed: [Article], completion: @escaping (SaveResult) -> Void)
}
