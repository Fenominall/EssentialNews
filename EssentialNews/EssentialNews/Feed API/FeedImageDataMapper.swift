//
//  FeedImageDataMapper.swift
//  EssentialNews
//
//  Created by Fenominall on 7/7/24.
//

import Foundation

public final class FeedImageDataMapper {
    private enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.isOK, !data.isEmpty else {
            throw Error.invalidData
        }
        return data
    }
}
