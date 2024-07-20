//
//  FeedCachePolicy.swift
//  EssentialNews
//
//  Created by Fenominall on 7/20/24.
//

import Foundation

final class FeedCachePolicy {
    private init() {}
    
    private static let calendar = Calendar(identifier: .gregorian)
    private static var maxCacheAge: Int {
        return 7
    }
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar
            .date(byAdding: .day, value: maxCacheAge, to: timestamp) else {
            return false
        }
        
        return date < maxCacheAge
    }
}
