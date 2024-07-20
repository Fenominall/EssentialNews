//
//  Mapper.swift
//  EssentialNews
//
//  Created by Fenominall on 7/20/24.
//

import Foundation

protocol Mapper {
    associatedtype Output
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> Output
}
