//
//  RemoteLoader.swift
//  EssentialNews
//
//  Created by Fenominall on 7/20/24.
//

import Foundation

public class RemoteLoader<T, M: Mapper> where M.Output == T {
    private let url: URL
    private let client: HTTPClient
    private let mapper: M.Type
    
    public enum RemoteLoaderError: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient, mapper: M.Type) {
        self.url = url
        self.client = client
        self.mapper = mapper
    }
    
    public typealias LoadResult = Swift.Result<T, Swift.Error>
    
    @discardableResult
    public func load(completion: @escaping (LoadResult) -> Void) -> HTTPClientTaskWrapper<T> {
        let task = HTTPClientTaskWrapper<T>(completion)
        task.wrapped = client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            do {
                switch result {
                case let .success((data, response)):
                    let result = try self?.mapper.map(data, from: response)
                    guard let unwrappedResult = result else { return }
                    task.complete(with: .success(unwrappedResult))
                case .failure:
                    task.complete(with: .failure(RemoteLoaderError.connectivity))
                }
            } catch {
                task.complete(with: .failure(RemoteLoaderError.invalidData))
            }
        }
        return task
    }
}
