//
//  HTTPClientTaskWrapper.swift
//  EssentialNews
//
//  Created by Fenominall on 7/20/24.
//

import Foundation

public final class HTTPClientTaskWrapper<T>: FeedLoaderTask, FeedImageDataLoaderTask {
    private var completion: ((Swift.Result<T, Swift.Error>) -> Void)?
    
    var wrapped: HTTPClientTask?
    
    init(_ completion: @escaping (Swift.Result<T, Swift.Error>) -> Void) {
        self.completion = completion
    }
    
    func complete(with result: Swift.Result<T, Swift.Error>) {
        completion?(result)
    }
    
    public func cancel() {
        preventFurtherCompletions()
        wrapped?.cancel()
    }
    
    private func preventFurtherCompletions() {
        completion = nil
    }
}
