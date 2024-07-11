//
//  HTTPClient.swift
//  EssentialNews
//
//  Created by Fenominall on 7/6/24.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}
