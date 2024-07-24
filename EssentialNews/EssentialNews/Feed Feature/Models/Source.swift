//
//  Source.swift
//  EssentialNews
//
//  Created by Fenominall on 7/6/24.
//

import Foundation

public struct Source: Hashable {
    public let id: String?
    public let name: String
    
    public init(id: String?, name: String) {
        self.id = id
        self.name = name
    }
}
