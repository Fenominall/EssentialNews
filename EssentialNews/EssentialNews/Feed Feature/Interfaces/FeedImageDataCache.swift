//
//  FeedImageDataCache.swift
//  EssentialNews
//
//  Created by Fenominall on 7/23/24.
//

import Foundation

public protocol FeedImageDataCache {
    typealias SaveResult = Swift.Result<Void, Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void)
}
