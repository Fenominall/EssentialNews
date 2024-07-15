//
//  LocalSource.swift
//  EssentialNews
//
//  Created by Fenominall on 7/15/24.
//

import Foundation

public struct LocalSource: Equatable {
    public let id: String?
    public let name: String
    
    public init(id: String?, name: String) {
        self.id = id
        self.name = name
    }
}
